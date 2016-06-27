Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Alex Coplan <alex.coplan@starleaf.com>
Content-Type: text/plain; charset=utf-8
Subject: Problems with LE Advertising using GDBus API
Message-Id: <567E72EE-8264-4BCF-ABFC-925BF62725ED@starleaf.com>
Date: Mon, 27 Jun 2016 13:25:05 +0100
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

I’m having issues getting LE Advertising to work using the GDBus API. I’ve managed to get my chip to advertise using the direct HCI socket API with e.g. this code (https://github.com/carsonmcdonald/bluez-ibeacon).

However, for writing my own code I’d prefer to use the higher-level (G)DBus API. I thought that tools/gap-tester might be a good place to start, since this appears to be written using the more modern, higher-level GDBus API. However, if I run this program, e.g. with:
$ sudo ./gap-tester
it just hangs, after printing:

Adapter setup - init
Adapter setup - setup

To give a bit of background, this is on a clean Ubuntu 16.04 install (Kernel 4.4.0) with BlueZ 5.40 compiled from the source repository (but not installed). The unit tests (invoked with `make check`) pass fine. The chip I’m using is an ASUS USB-BT400. hciconfig gives:

hci0:	Type: BR/EDR  Bus: USB
	BD Address: 5C:F3:70:77:DE:0D  ACL MTU: 1021:8  SCO MTU: 64:1
	DOWN
	RX bytes:2142 acl:0 sco:0 events:65 errors:0
	TX bytes:988 acl:0 sco:0 commands:133 errors:14

On further investigation, I decided to run some of the tests in the tools directory. Running hci-tester gives the following summary:

Test Summary
------------
Reset                                                Passed       0.025 seconds
Read Local Version Information                       Passed       0.012 seconds
Read Local Supported Commands                        Passed       0.023 seconds
Read Local Supported Features                        Passed       0.012 seconds
Read Local Extended Features                         Passed       0.015 seconds
Read Buffer Size                                     Passed       0.012 seconds
Read Country Code                                    Failed       0.012 seconds
Read BD_ADDR                                         Passed       0.014 seconds
Read Local Supported Codecs                          Failed       0.015 seconds
LE Read White List Size                              Passed       0.014 seconds
LE Clear White List                                  Passed       0.012 seconds
LE Encrypt                                           Passed       0.015 seconds
LE Rand                                              Passed       0.012 seconds
LE Read Local PK                                     Failed       0.013 seconds
LE Generate DHKey                                    Not Run
Inquiry (LIAC)                                       Passed      10.255 seconds
Create Connection                                    Not Run
TP/DSU/BV-02-C Reset in Advertising State            Not Run

The first three failures are 0x01 failures so these are presumably not of concern, as they are simply not implemented on the chip. The first “Not Run” test also encounters a 0x01 error, so this can presumably be ignored (?). Finally, the last two tests fail in the pre setup; unfortunately, even running with the debug flag gives no more information than the following:

Create Connection - init
  Failed to setup lower tester user channel
Create Connection - pre setup failed
Create Connection - done

TP/DSU/BV-02-C Reset in Advertising State - init
  Failed to setup upper tester user channel
TP/DSU/BV-02-C Reset in Advertising State - pre setup failed
TP/DSU/BV-02-C Reset in Advertising State - done

In an attempt to investigate further, I ran the mgmt-tester test suite, since it makes sense to test the management interface given that I intend on using it in my application. Running this test suite results in just one failure, namely the “Set powered on - Privacy and Advertising” test. This was particularly concerning since advertising is one of the features that I need to work! The (relevant) output from the test suite is as follows:

$ sudo ./mgmt-tester -p "Set powered on - Privacy"

Set powered on - Privacy and Advertising - init
  Read Version callback
    Status: Success (0x00)
    Version 1.10
  Read Commands callback
    Status: Success (0x00)
  Read Index List callback
    Status: Success (0x00)
  Index Added callback
    Index: 0x0001
  Read Info callback
    Status: Success (0x00)
    Address: 00:AA:01:00:00:00
    Version: 0x08
    Manufacturer: 0x003f
    Supported settings: 0x0000be1b
    Current settings: 0x00000200
    Class: 0x000000
    Name:
    Short name:
Set powered on - Privacy and Advertising - setup
  Initial settings completed
  Client set connectable: Success (0x00)
Set powered on - Privacy and Advertising - setup complete
Set powered on - Privacy and Advertising - run
  Sending Set Advertising (0x0029)
  Test condition added, total 1
  Set Advertising (0x0029): Busy (0x0a)
Set powered on - Privacy and Advertising - test failed
Set powered on - Privacy and Advertising - teardown
  Index Removed callback
    Index: 0x0001
Set powered on - Privacy and Advertising - teardown complete
Set powered on - Privacy and Advertising - done


Test Summary
------------
Set powered on - Privacy and Advertising             Failed       0.009 seconds

Total: 1, Passed: 0 (0.0%), Failed: 1, Not Run: 0
Overall execution time: 0.00931 seconds

This test was the most informative one that I ran, since it gave the 0x0a (Busy) error code from the device. The spec says the following about this error code:

The Synchronous Connection Limit to a Device Exceeded error code indicates that the Controller has reached the limit to the number of synchronous connections that can be achieved to a device. The number of synchronous connections a device can support is implementation dependent.

What I would really like to know is whether this is an issue with the chip itself, or whether this is an issue in BlueZ? I don’t know why there would be too many connections open to the device; I don’t have bluetooth installed on the system, and this problem occurs even when running the test in isolation (with -p).

I tried searching for further clues by running the l2cap-tester. Again, exactly one test fails; in this case it is the test named "L2CAP LE Client, Direct Advertising - Success”. Running this test in isolation gives the following output:

$ sudo ./l2cap-tester -p "L2CAP LE Client, Direct"

L2CAP LE Client, Direct Advertising - Success - init
  Read Index List callback
    Status: 0x00
  New hciemu instance created
  Index Added callback
    Index: 0x0001
  Read Info callback
    Status: 0x00
    Address: 00:AA:01:00:00:00
    Version: 0x08
    Manufacturer: 0x003f
    Supported settings: 0x0000be1b
    Current settings: 0x00000200
    Class: 0x000000
    Name:
    Short name:
L2CAP LE Client, Direct Advertising - Success - setup
  Powering on controller
  Controller powered on
  Client set connectable status 0x00
L2CAP LE Client, Direct Advertising - Success - setup complete
L2CAP LE Client, Direct Advertising - Success - run
  Connect in progress
L2CAP LE Client, Direct Advertising - Success - test timed out
L2CAP LE Client, Direct Advertising - Success - teardown
  Index Removed callback
    Index: 0x0001
L2CAP LE Client, Direct Advertising - Success - teardown complete
L2CAP LE Client, Direct Advertising - Success - done


Test Summary
------------
L2CAP LE Client, Direct Advertising - Success        Timed out    1.934 seconds

Total: 1, Passed: 0 (0.0%), Failed: 1, Not Run: 0
Overall execution time: 1.93 seconds

Here, the test just times out, so we don’t really gain any more information about the problem.

I would really appreciate it if anyone has any advice. In particular, I’d like to know whether the chip might be faulty. Somehow, though, I doubt this, since I managed to get advertising to work using the HCI socket API. Apologies if I’m missing something obvious.

Thanks,
Alex
Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 20 Oct 2015 23:26:42 +0100
Message-ID: <CAAu3APbFYSQBpwy72Niq-d-A8e9TM_vd2SJb1iifAOUzhbzWAA@mail.gmail.com>
Subject: Python reading Eddystone beacons
From: Barry Byford <31baz66@gmail.com>
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I’m looking to use a Raspberry Pi running the latest Raspbian Jessie operation
system with Bluez 5.23.

I’m trying to create a workshop for schools to interact with Eddystone
BLE beacons.
The workshop will show students the basics of reading the beacon data
and then it will
be up to the students to build applications from this using the Python
programming language.
The Raspberry Pi allows us to use them as the development platform and
to run the
final application also.
Python is the chosen language as this is what schools seem to be using the most.

The way that I’m currently doing the scanning for the beacon data is
with this bash
script:
#!/bin/bash
sudo hcitool lescan --duplicates 1>/dev/null &
trap "sudo kill $!" EXIT
sudo hcidump --raw

The output is then be parsed with a Python library that would be what
the students
called to get the data.

While I’m making some progress with the above shell script it doesn’t seem very
elegant. It looks like there should be a better way using the D-Bus API.
I’ve been looking in
https://git.kernel.org/cgit/bluetooth/bluez.git/tree/test?id=5.23
for inspiration but don’t seem to have anything that is showing me the beacon
advertisement.

Should I be able to get the Eddystone beacon payload using Python with
the D-Bus API
in Bluez 5.23?
Is there a good tutorial/example that I could look at?

Thanks in advance for any help or advice.

Regards,
Barry


$ uname -a
Linux raspberrypi 4.1.7+ #817 PREEMPT Sat Sep 19 15:25:36 BST 2015
armv6l GNU/Linux

$ bluetoothd -v
5.23

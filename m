Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: David Narvaez <david.narvaez@computer.org>
Date: Thu, 19 Jun 2014 21:17:05 -0400
Message-ID: <CACFh1D5A64SVvKU7FfsMRr8Yz31=-g92Z6k8=NgQjPE1SxsxEg@mail.gmail.com>
Subject: SSH Shell Over Bluetooth
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have an RPi with a bluetooth dongle and my ultimate goal is to be
able to SSH into the RPi over bluetooth from my laptop. Back in the
days, PAND was the way to do this, but now that it is gone I don't see
any documentation explaining how to set up TPC/IP over bluetooth.

>From reading API docs, mailing list archives and a lot of guessing,
these are the steps I have so far:

1) I copied tests/test-nap to the RPi

# python2 test-nap
Server for nap registered for tether
Press CTRL-C to disconnect

2) I now can see NAP being offered from the RPi

[bluetooth]# show
Controller 00:02:5B:05:2D:85
        Name: alarmpi
        Alias: alarmpi
        Class: 0x020000
        Powered: yes
        Discoverable: yes
        Pairable: yes
        UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
        UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
        UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
        UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
        UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
        UUID: NAP                       (00001116-0000-1000-8000-00805f9b34fb)
        Modalias: usb:v1D6Bp0246d0513
        Discovering: no

3) I added a bridge called tether in the RPi

# brctl addbr tether
# brctl show
bridge name     bridge id               STP enabled     interfaces
tether          8000.000000000000       no

4) I use the test-device script in my laptop to connect to the NAP
service. Unlike the example in the archives[0], I use the UUID of the
service

$ ./test-device connect 00:02:5B:05:2D:85 00001116-0000-1000-8000-00805f9b34fb

5) Now I have bnep0 in both the RPi and the host, so I configure them
with ifconfig
6) I try to ping but I get "Destination Host Unreachable"

I'm using Bluez 5.19 in both my RPi and my laptop, and the test
scripts are all from git. What am I missing?

Thanks.

David E. Narvaez

[0] http://www.spinics.net/lists/linux-bluetooth/msg46846.html

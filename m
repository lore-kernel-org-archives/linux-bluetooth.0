Return-Path: <cyrus@holtmann.org>
Message-ID: <5a14e9b50811161416u2b0934dcje2c5085c8b1037a6@mail.gmail.com>
Date: Sun, 16 Nov 2008 23:16:51 +0100
From: "XazZ XazZ" <xazz.xazz@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: Problem with bluez and a bluetooth headset
In-Reply-To: <5a14e9b50811151841i3d84eae3i6c11068cfad1ac01@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <5a14e9b50811111229l2addf4aega6e1107320a83026@mail.gmail.com>
	 <5a14e9b50811151841i3d84eae3i6c11068cfad1ac01@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

> So BlueZ is trying to connect to A2DP. No wonder recording doesn't work (you
> need HSP/HFP for that). You can force HSP/HFP by adding a "profile voice"
> line to your .asoundrc entry.

Okay, I tried this again.
As soon as I change "profile hifi" to "profile voice" sound playback
stops working

[XazZ@darklight ~]$ hciconfig hci0
hci0:   Type: USB
       BD Address: 00:11:67:8F:29:0E ACL MTU: 1021:8 SCO MTU: 48:10
       UP RUNNING PSCAN
       RX bytes:2487 acl:33 sco:0 events:110 errors:0
       TX bytes:2126 acl:36 sco:0 commands:65 errors:0

That suggests that no sco packets have been sent (although there
should have been one)
I also get two hci_cmd_task: hci0 command tx timeout in my dmesg as
Brian Rogers said

Again the output of bluetoothd -nd:
http://nopaste.ch/502c8ee33709a6d.html (I hope it helps)
Maybe my device needs some quirk?

Oh, and I'm using the btusb driver which comes with 2.6.28 rc3 (Brian
Rogers uses the same driver)

XazZ

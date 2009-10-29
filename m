Return-Path: <cyrus@holtmann.org>
Message-ID: <4AE98D04.50505@gmail.com>
Date: Thu, 29 Oct 2009 13:39:32 +0100
From: Herwig Hochleitner <hhochleitner@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: apple bluetooth keyboard; bug #13104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello!

I recently bought the apple aluminium bluetooth keyboard, which is 
supported in the kernel by drivers/hid/hid-apple.c
I get the same behaviour as described in 
http://bugzilla.kernel.org/show_bug.cgi?id=13104

Ubuntu 9.04; 2.6.30-020630-generic x86_64 (mainline kernel)

First time connect dmesg output:

 > apple 0005:05AC:022D.0002: parse failed
 > apple: probe of 0005:05AC:022D.0002 failed with error -14

Power cycle the keyboard:

 > input: Apple Wireless Keyboard as 
/devices/pci0000:00/0000:00:1d.2/usb8/8-1/8-1:1.0/bluetooth/hci0/hci0:48/input10
 > apple 0005:05AC:022D.0003: input,hidraw1: BLUETOOTH HID v1.40 
Keyboard [Apple Wireless Keyboard] on 00:0D:F0:58:04:49

then it works.


I have tracked down the issue to the function hidp_parse() in 
net/bluetooth/hidp/core.c
More specifically it tries to read from

hidp_connadd_req *req->rd_data

via copy_from_user() and fails with -EFAULT.

Thoughts:
Why does it only fail the first time?
Where does hid->session->req come from?

Since I have no experience with kernel development yet, I don't know how 
to track this further. Any help will be much appreciated.

kind regards

Herwig Hochleitner

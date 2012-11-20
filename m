Return-Path: <cyrus@holtmann.org>
Message-ID: <50AB6B96.20209@ahsoftware.de>
Date: Tue, 20 Nov 2012 12:37:58 +0100
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: udev rule for hid2hci and Logitech dongles doesn't work with kernels
 >= 3.6
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I've recently noticed that the udev rule for hid2hci with Logitech 
dongles doesn't work anymore. The reason is commit 
7e97243c2080ecae7129e83635227fdebd4feef6 which changes the class 
(subsystem) for those dongles from usb to usbmisc. I've already filed a 
bug for Fedora (https://bugzilla.redhat.com/show_bug.cgi?id=877998) but 
I thought I should write a note here too, to inform non-Fedora users too.

My suggestion is to use "usb*" instead of "usb" for the subsystem, this 
works with all kernels regardless if the subsystem is "usb" or "usbmisc".

Regards,

Alexander

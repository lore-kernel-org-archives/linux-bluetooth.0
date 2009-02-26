Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Feb 2009 01:17:07 -0800
From: Derek Chan <dwc+lkml@OCF.Berkeley.EDU>
To: marcel@holtmann.org, maxk@qualcomm.com, linux-bluetooth@vger.kernel.org
Subject: another "blacklist" device for hci_usb
Message-ID: <20090226091707.GG9042@OCF.Berkeley.EDU>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I've got a USB bluetooth adapter that needed some of those handy module
params to get SCO working.

Bus 001 Device 004: ID 0a5c:2121 Broadcom Corp. BCM2210 Bluetooth

I'm running on 2.6.26-13 from debian lenny, with an sco.ko with an ESCO
disabling patch, but I also tried it on 2.6.28.7 (with disable_esco=1).
It seems to be required that force_scofix=1 be on, but I noticed none of the
IDs only contain the SCO fix (http://git.kernel.org/?p=linux/kernel/git/holtmann/bluetooth-2.6.git;a=blob;f=drivers/bluetooth/hci_usb.c;h=3c453924f8386c9b92050ae978967d188ec3b4da;hb=57f8f7b60db6f1ed2c6918ab9230c4623a9dbe37#l105) so I added
the reset=1 as well.

Let me know if you need more information about the bluetooth adapter or the
headset that I am using.

 - Derek

-- 
Be the change you want to see in the world
        -- Mahatma Gandhi

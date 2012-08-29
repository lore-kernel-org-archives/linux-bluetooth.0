Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Which software is responsible for bringing the devices (hci0 .. hcix) up ?
Date: Wed, 29 Aug 2012 08:58:12 +0200
Message-ID: <1531E53627F1F749B4FE809BF2A4EB67036F2F97@WETMEX10.loepfe.com>
From: "Vellemans, Noel" <Noel.Vellemans@visionBMS.com>
To: <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
 
 
I have a simple question, I think, But I do not manage to find the
answer into the old mailing-list-posts.
 
I'm using bluez-4.99 and Linux kernel 2.6.35.3. 
 
When plugging in a device (CSR-device) the device is recognized but it
is not 'UP'.
 
Can someone tell me what piece of software is NORMALLY setting the
device into the 'UP' state?
(so that I do not have to type hciconfig hci0 up)
 
 
 
# plug in the device ... results in ...
usb wakeup is here
usb 2-1: new full speed USB device using fsl-ehci and address 3
usb 2-1: New USB device found, idVendor=0a12, idProduct=0001
usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
 
# hciconfig
hci0: Type: BR/EDR Bus: USB
BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
DOWN 
RX bytes:0 acl:0 sco:0 events:0 errors:0
TX bytes:0 acl:0 sco:0 commands:0 errors:0

After manually executing hciconfig hci0 up the device is working fine.
 
# hciconfig hci0 up
# hciconfig
hci0:   Type: BR/EDR  Bus: USB
        BD Address: 00:07:80:85:39:07  ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING 
        RX bytes:340 acl:0 sco:0 events:11 errors:0
        TX bytes:38 acl:0 sco:0 commands:11 errors:0
 
Regards,
Noel
 
 
 

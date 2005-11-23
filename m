Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <000f01c5efcb$c4258540$6201a8c0@hujie>
From: "lcstudio@gmail" <lcstudio@gmail.com>
To: <bluez-devel@lists.sourceforge.net>
References: <20051122195412.F2DBC88BC7@sc8-sf-spam1.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Subject: [Bluez-devel] sco link problem
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 23 Nov 2005 09:18:05 +0800

I've problem by make SCO link using the dongle with BCM2035 chip.It's seemed
SCO link up,but NO any of data responsed.:(
hci_usb.c file, I found some piece like:
    {USB_DEVICE(0x0a5c, 0x200a), .driver_info = HCI_RESET |
HCI_BROKEN_ISOC }
it's disabled all of BCM2035 dongle SCO driver with id by 0x0a5c &
0x200a,what's idea about this? My dongle matchs this id.
Is Broadcom makes chip abnormally behavior with 0x0a5c,0x200a ?

Thanks

Luchine
2005.11



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

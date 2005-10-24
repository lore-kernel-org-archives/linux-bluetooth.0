Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Link Quality between 2 Bluetooth USB Dongles
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <94e407f00510240944k24a3f4f1re75377a1bffb8a7@mail.gmail.com>
References: <94e407f00510240734x12c64714qc791a991ddcd1426@mail.gmail.com>
	 <1130164983.19317.54.camel@blade>
	 <94e407f00510240944k24a3f4f1re75377a1bffb8a7@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1130174344.7840.2.camel@blade>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 24 Oct 2005 19:19:04 +0200

Hi Arpit,
 
> [root@174-242 ~]# hciconfig hci0 version
> hci0:   Type: USB
>        BD Address: 00:10:60:B3:2C:F7 ACL MTU: 377:10 SCO MTU: 16:0
>        HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver:
> 0x309
>        Manufacturer: Broadcom Corporation (15) 

these chips are Broadcom based. So you must ask them how they
implemented the link quality value.

Check "hciconfig hci0 features" if they support "Inquiry with RSSI".

> What is the HCI build version in this case?And how does this help me?

The build id is only valid for CSR chips. It is not fully clear how
Broadcom encodes this.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

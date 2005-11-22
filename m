Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Everything seems normal yet...
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <200511221106.42566.arthur.breitman@gmail.com>
References: <200511211803.35723.arthur.breitman@gmail.com>
	 <200511221106.42566.arthur.breitman@gmail.com>
Content-Type: text/plain
Message-Id: <1132675914.20713.18.camel@blade>
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
Date: Tue, 22 Nov 2005 17:11:54 +0100

Hi Arthur,

> trying to find the mobile phone:
> 
> root@coin:/home/arthurb# hcidump -X -V
> HCI sniffer - Bluetooth packet analyzer ver 1.23
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Inquiry (0x01|0x0001) plen 5
>     lap 0x9e8b33 len 8 num 0
> > HCI Event: Command Status (0x0f) plen 4
>     Inquiry (0x01|0x0001) status 0x00 ncmd 1
> > HCI Event: Vendor (0xff) plen 7
>   0000: cd 03 00 04 00 00 00
>      .......
> > HCI Event: Vendor (0xff) plen 7
>   0000: cd 03 00 04 00 00 00
>      .......
> > HCI Event: Vendor (0xff) plen 7
>   0000: cd 03 00 04 00 00 
> 00                                                                                           .......
> > HCI Event: Vendor (0xff) plen 7
>   0000: cd 03 00 04 00 00 
> 00                                                                                           .......
> > HCI Event: Vendor (0xff) plen 7
>   0000: cd 03 00 04 00 00 
> 00                                                                                           .......
> > HCI Event: Vendor (0xff) plen 7
>   0000: cd 03 00 04 00 00 
> 00                                                                                           .......
> > HCI Event: Vendor (0xff) plen 7
>   0000: cd 03 00 04 00 00 
> 00                                                                                           .......
> > HCI Event: Vendor (0xff) plen 7
>   0000: cd 03 00 04 00 00 00                              .......
> > HCI Event: Vendor (0xff) plen 7
>   0000: cd 03 00 04 00 00 00                              .......
> > HCI Event: Vendor (0xff) plen 7
>   0000: cd 03 00 04 00 00 00                              .......
> > HCI Event: Inquiry Complete (0x01) plen 1
>     status 0x00
> 
> 
> Mobile phone trying to see the laptop:
> nothing special except for 
> > HCI Event: Vendor (0xff) plen 7
>   0000: cd 03 00 04 00 00 00                              .......
> but this seems to be going on all the time

since this is a CSR chip, use "-m 10" as additional parameter to hcidump
to enable the decoding of CSR vendor events.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

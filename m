Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sco link problem
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <000f01c5efcb$c4258540$6201a8c0@hujie>
References: <20051122195412.F2DBC88BC7@sc8-sf-spam1.sourceforge.net>
	 <000f01c5efcb$c4258540$6201a8c0@hujie>
Content-Type: text/plain
Message-Id: <1132806217.5982.22.camel@blade>
Mime-Version: 1.0
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
Date: Thu, 24 Nov 2005 05:23:37 +0100

Hi Luchine,

> I've problem by make SCO link using the dongle with BCM2035 chip.It's seemed
> SCO link up,but NO any of data responsed.:(
> hci_usb.c file, I found some piece like:
>     {USB_DEVICE(0x0a5c, 0x200a), .driver_info = HCI_RESET |
> HCI_BROKEN_ISOC }
> it's disabled all of BCM2035 dongle SCO driver with id by 0x0a5c &
> 0x200a,what's idea about this? My dongle matchs this id.
> Is Broadcom makes chip abnormally behavior with 0x0a5c,0x200a ?

last time I check one of these devices, the ISOC transfers were broken
and they were making this device unusable. So I flagged it. Remove the
quirk identify and try if it works.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

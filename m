Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <000a01c54527$eaaec310$0100a8c0@hppav>
From: "Oliver" <urnenfel@tiscali.es>
To: <bluez-devel@lists.sourceforge.net>
References: <006a01c544a7$30c262c0$89fe650a@ZBOX> <1113907225.16233.164.camel@pegasus>
Subject: Re: [Bluez-devel] BCM2035 BROKEN_ISOC?
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
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
Date: Tue, 19 Apr 2005 23:36:53 +0200

BTW this device is commented in the list.

Does it needs also to load firmware as BCM203x ?

I saw the product and vendor ID for bcm2035 in the hci_usb driver but not in 
the complent bcm203x.

thanks



----- Original Message ----- 
From: "Marcel Holtmann" <marcel@holtmann.org>
To: <bluez-devel@lists.sourceforge.net>
Sent: Tuesday, April 19, 2005 12:40 PM
Subject: Re: [Bluez-devel] BCM2035 BROKEN_ISOC?


> Hi Suriyan,
>
>> Does anyone known what is the source for problems that make Broadcom 
>> BCM2035
>> (VID=0x0a5c, PID=0x200a) based Bluetooth USB adapter was added to
>> HCI_BROKEN_ISOC blacklist?
>
> it was not working with ISOC transfers (or our way of using them) and so
> I blacklisted it.
>
>> Have the way to work-around?
>
> Try to get information from Broadcom ;)
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: New Crystal Reports XI.
> Version 11 adds new functionality designed to reduce time involved in
> creating, integrating, and deploying reporting solutions. Free runtime 
> info,
> new features, or free trial, at: http://www.businessobjects.com/devxi/728
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel 





-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

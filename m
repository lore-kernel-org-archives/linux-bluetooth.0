Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] TECOM BT3035
From: Marcel Holtmann <marcel@holtmann.org>
To: Roman K <papa@rbcmail.ru>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200407260936.55023.papa@rbcmail.ru>
References: <200407231440.i6NEeI5l048844@www1.pochta.ru>
	 <200407232245.46776.papa@rbcmail.ru> <1090659888.4791.68.camel@pegasus>
	 <200407260936.55023.papa@rbcmail.ru>
Content-Type: text/plain
Message-Id: <1090825950.31693.55.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 26 Jul 2004 09:12:31 +0200

Hi Roman,

> I have only one last question. Have you tested your patch with THIS device (I 
> mean 3035 not it's family).

I don't know if it was from Tecom, but it was the Broadcom version of
HID proxy. The hci_usb drivers states it as BCM2035 with the USB vendor
and product id of 0a5c:200a. Check for yourself.

> It looks like SuSE kernel uses you patches (when your patch trying to create a 
> file it reports that file already exists and most hunk are rejected because 
> of they are previously applied).

Of course they do. Everyone uses my patches, because I send them back to
mainline if I know that they are working. The -mh patches are against a
vanilla kernel and you couldn't expect that they apply cleanly to any of
the vendor kernel out there. No matter if it is SuSE or RedHat.

> SuSE usually uses a lot of patches (MUCH more then vanilla) and It usually  
> supports MUCH more hardware then RedHat..
> But  in this case something wrong...

Maybe they haven't picked up that patch. So what? Use the latest vanilla
2.4 kernel or extract that hunk that I told you from the kernel tree and
apply it by hand. Or simply update to SuSE 9.1 with a 2.6 kernel.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

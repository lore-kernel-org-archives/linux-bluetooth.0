Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41DBF5F3.8020004@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: Re: multi rfcomm/sco connection
References: <005e01c4f320$e16dd0b0$6f04a8c0@ZBOX> <1104930047.4299.11.camel@pegasus>
In-Reply-To: <1104930047.4299.11.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Wed, 05 Jan 2005 15:13:07 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I looked into this problem back "than", but due to a shortage of time I
never had a chance to really fix this (Marcel stated that the best thing
would be a complete rewrite of hci_usb anyway).

There should be plenty of discussion in the mailing list archive about
how to fix the stuff and how it might be done (main problem was the
interrupt context in the notify function and the not-send urbs (queue
must be empty before setting the new alternate setting...)

would be great if you could fix it, as I don't think I'll have time for
this in the next... months... :(

regards,
~  Lars

Marcel Holtmann wrote:
| Hi Suriyan,
|
|
|>I just found lastest patch in hci_usb.c that pass alternate setting
|>(isoc) as kernel module parameter but it's still static solution to
|>support more than one SCO connection over single
|>bluetooth adapter. Are you working on dynamically support? I have try
|>to do this a few week ago but I stuck on usb_set_interface() function
|>since I cannot meet it's pre-conditions.
|
|
| actually I am not working on this, but now you have everything you need
| to let hci_usb do the right job.
|
| Regards
|
| Marcel
|
|
|
|
| -------------------------------------------------------
| The SF.Net email is sponsored by: Beat the post-holiday blues
| Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
| It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
| _______________________________________________
| Bluez-devel mailing list
| Bluez-devel@lists.sourceforge.net
| https://lists.sourceforge.net/lists/listinfo/bluez-devel
|

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB2/XzQWC6DTWkDAoRAt26AJ4nKYM9GzCyd3R9t7uXEbGB+YGpkgCgmvjR
/7nikwrC+v+bXbQA25Cr2pk=
=5Eno
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

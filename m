Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcid crashes with "buffer overflow detected"
	when pairing
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1126981781.14893.27.camel@yeti>
References: <1126981781.14893.27.camel@yeti>
Content-Type: text/plain
Message-Id: <1127216630.5168.22.camel@localhost.localdomain>
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
Date: Tue, 20 Sep 2005 13:43:50 +0200

Hi Fredrik,

> I'm trying out the following packages on Fedora Core 4, x86_64:
> 
>     bluez-pin-0.24-2
>     bluez-libs-2.20-1
>     bluez-utils-2.20-1
>     dbus-0.33-3
> 
> Unfortunately hcid crashes with "buffer overflow detected" when pairing.
> Is this a known problem?

try bluez-utils-2.21 or the latest CVS. I fixed some possible buffer
overflows lately.

> Marcel, I'm happy you decided on moving to ASCII based storage. Is there
> any documentation on this? Perhaps I can update the man pages if I can
> get this working.

I did this some time ago and no, it is not documented at the moment.
Feel free to update all the manual pages. The hidd also now caches the
device information.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

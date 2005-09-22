Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcid D-Bus patch
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb05092106526cd16196@mail.gmail.com>
References: <e1effdeb05091607426f824afa@mail.gmail.com>
	 <1127292701.495.11.camel@localhost.localdomain>
	 <e1effdeb05092105492fce2ff2@mail.gmail.com>
	 <9307f5f205092106191197c374@mail.gmail.com>
	 <e1effdeb05092106526cd16196@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1127398388.5344.20.camel@blade>
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
Date: Thu, 22 Sep 2005 16:13:08 +0200

Hi Claudio,

> An ERROR may have any arguments, but if the first argument is a 
> STRING(error message). Therefore, the signature should be sq (string
> +uint16).
> In my opinion the error message string is not relevant, the client
> applications
> can use it or not. If we consider internationalization, this string
> will not
> the useful.

the Bluetooth status is always uint8_t and I think it is a good idea to
map these error codes directly. We can define our own codes from 0xff
onwards if we use a uint16. However we should try to use the Bluetooth
defined errors whenever possible.

A string would be nice, but in generell these are useless. However for
application that doesn't consider internationalization it will be easy
for them to display the errors in clear text.

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

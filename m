Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] new 1.2 dongles
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <4257BCCF.9060703@gmx.ch>
References: <4257BCCF.9060703@gmx.ch>
Content-Type: text/plain
Message-Id: <1113048226.9783.44.camel@pegasus>
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
Date: Sat, 09 Apr 2005 14:03:46 +0200

Hi Marco,

> I just bought these dongles:
> - ednet btVer 1.2 (class2, 40 meters) Firmware 20.3.009
> - acer btVer 1.2 (class1, 100 meters) Firmware 10.3.009
> 
> Both work just fine with bluez and are from Broadcom Corporation.
> 
> Marcel, as much as i've seen, you no longer have a list of supported 
> devices... so i think you don't need any data, right?

I still maintain the features document and I think about moving
everything into a database. So please send in "hciconfig -a" and the
content of /proc/bus/usb/devices.

> I actually do have a question: I read much more about csr dongles than 
> broadcom's in the list. Are broadcom's known to be bader or are there other 
> disadvantages?

I think that Broadcom/Zeevo is catching up, but actually at the moment
the CSR chips are way ahead of everything else.

> Is the firmware updateable too? I'm a little bit worried that there's such 
> a big version-difference of the firmware...

It maybe is upgradeable, but I don't know how. Don't worry so much about
the version thing. I still don't know what these values actually mean,
because the decoding is derived from the Widcomm stack version display.
Broadcom was never helpful when it comes to Linux support while CSR
always helped out.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] OT: SonyEricsson K700i addressbook and OBEX over
	Bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: Charles Bueche <charles@bueche.ch>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040817123228.2d896a07@bluez.bueche.ch>
References: <20040817123228.2d896a07@bluez.bueche.ch>
Content-Type: text/plain
Message-Id: <1092818433.31651.60.camel@pegasus>
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
Date: Wed, 18 Aug 2004 10:40:33 +0200

Hi Charles,

> sorry if this a bit off-topic, but I didn't find help elsewhere and I
> thought someone here might have seen the same problems.
> 
> I just got my SonyEricsson K700i from Swisscom, and I'm experimenting
> with bluez and user-space tools (kde-bluetooth).
> 
> It works quite well, I can send VCARD's using the OBEX Object Push, and
> the phone gets them well. The only glitch is that the file must me named
> *.vcf for the phone to consider it as address records.

this is some kind of stupid, but normal for most phones.

> 1. OBEX File Transfer (eg to get pictures from the pone) : in Konqueror,
> using kde-buetooth, the selection of "obex://[btaddr]:7/" brings up
> "Authentication Required". From my analysis of the source code, it might
> be caused by the transport layer (bluez), but not sure.

Check the hcidump and ask the KDE-Bluetooth developers.

> 2. UID field in VCARD's : if I send a single VCARD in a file for a
> record already present in the phone, it asks "overwrite y/n ?". If I
> send a file containing two or more VCARD's for records already present
> in the phone, it duplicate them. I added a UID fields as recommended by
> the Vcard spec, the phone seem to ignore it.

Sounds like a bug in the phone. Tell SE about it ;)

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

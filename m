Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Charles Bueche <charles@bueche.ch>
To: bluez-users@lists.sourceforge.net
Message-Id: <20040817123228.2d896a07@bluez.bueche.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] OT: SonyEricsson K700i addressbook and OBEX over Bluetooth
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
Date: Tue, 17 Aug 2004 12:32:28 +0200

Hi,

sorry if this a bit off-topic, but I didn't find help elsewhere and I
thought someone here might have seen the same problems.

I just got my SonyEricsson K700i from Swisscom, and I'm experimenting
with bluez and user-space tools (kde-bluetooth).

It works quite well, I can send VCARD's using the OBEX Object Push, and
the phone gets them well. The only glitch is that the file must me named
*.vcf for the phone to consider it as address records.

I have two problems left : 

1. OBEX File Transfer (eg to get pictures from the pone) : in Konqueror,
using kde-buetooth, the selection of "obex://[btaddr]:7/" brings up
"Authentication Required". From my analysis of the source code, it might
be caused by the transport layer (bluez), but not sure.

2. UID field in VCARD's : if I send a single VCARD in a file for a
record already present in the phone, it asks "overwrite y/n ?". If I
send a file containing two or more VCARD's for records already present
in the phone, it duplicate them. I added a UID fields as recommended by
the Vcard spec, the phone seem to ignore it.

Hints welcome, regards,
Charles


-- 
Charles Bueche <charles@bueche.ch>
sand, snow, wave, wind and net -surfer


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

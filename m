Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Peter Bergmann" <bergmann.peter@gmx.net>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <30847.1065160235@www33.gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Subject: [Bluez-users] bluetooth and wireless lan horror
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 3 Oct 2003 07:50:35 +0200 (MEST)

hi,

this question/problem is (maybe) not directly related with bluez .
i use bluez with a class 2 usb dongle together with a wireless lan
pcmcia card.  bluez is used for a rfcomm connection to a bluetooth
input device and works really great!  actually data is beeing 
transmitted not very often and only a few bytes, but the rfcomm 
connection has to be open all the time.

i knew that bluetooth and wireless lan use the same frequenzy band
and that this may lead to problems but for me it's  totally unuseable!

as soosn as i move more than 10 feet away from the wlan accesspoint
i get a packetloss from more than 30 percent even if no data is
being transmitted via the rfcomm connection.

i dont' understand why wlan transmission is affected even if no data 
goes over the bluez rfcomm connection!?

is there anything i can do about this?
thanks a lot for any hints.

cheers, pet

-- 
NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService

Jetzt kostenlos anmelden unter http://www.gmx.net

+++ GMX - die erste Adresse für Mail, Message, More! +++



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Sebastian =?iso-8859-15?q?Clau=DF?= <sc2@inf.tu-dresden.de>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-Id: <200502141659.45030.sc2@inf.tu-dresden.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Subject: [Bluez-users] Encrypted and unencrypted connections at the same time
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
Date: Mon, 14 Feb 2005 16:59:43 +0100

Hi,

I have a MS optical desktop elite (mouse and keyboard).
The keyboard supports an encrypted connection, but the mouse doesn't.
So, I want to enable encryption and authentication by default,
but want to disable it for the mouse.
When I enable authentication/encryption, the laptop wants to make a secure=
=20
connection also to the mouse, but obviously this does not work. So, I have =
to=20
switch authentication/encryption off temporarily to connect to the mouse, a=
nd=20
then enable it again.

Is there a way configure hcid or hidd in a way, e.g. by hcid.conf,
so that this setting is recognized automatically (i.e. a special configurat=
ion=20
for the mouse)?

Sebastian


=2D-=20
=2D---------------------------------------------------
Sebastian Clau=DF
E-Mail: sc2@inf.tu-dresden.de
=2D---------------------------------------------------


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

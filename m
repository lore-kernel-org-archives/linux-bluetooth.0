Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45F40969.7020201@yahoo.com.au>
Date: Sun, 11 Mar 2007 14:51:37 +0100
From: bluez.mexon@spamgourmet.com
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Adventures with a class 1 dongle
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Since I was asked to report my experiences with my new Digitus DN-3008M1...

The reason I was after a class 1 dongle is because I have a pair of
Plantronics 590A headphones, which come with their own audio-only
dongle, and the range is rather less than I would like.  They probably
reach to around 7 metres, but at that range you have to hold your head
in exactly the right position to hear anything.  I was hoping that a
class 1 dongle would have a longer range.

Of course, Bluez's A2DP support is still experimental, and the whole
field of audio under Linux is such a horrible broken mess anyway, I was
under no illusions that this would be any kind of good solution.  This
was just to future-proof myself.  Maybe one day the various warring
tribes that comprise audio development under Linux will wipe each other
out in a nuclear holocaust and a new civilisation will arise from the
ashes, at which point my class 1 USB dongle might start to be useful.

In the meantime, I was interested to know exactly what range I could get
out of my headset.  Everyone knows that class 2 devices can talk to each
other over a range of "10 metres" (a "metre" being a unit of length used
only by radio equipment manufacturers, measuring about a foot), and that
class 1 devices can talk to each over a range of "100 metres".  But
what's the range between a class 2 device and a class 1 device?  If my
class 1 device is sending the bulk of the data, should I be getting
class 1 range?  What about the ACK packets?  It seemed worth experimenting.

So, the results.  As I say, the dongle that comes with the Plantronics
590A achieved about 7m (real metres, not radio-equipment-manufacturer
fluffy pink fantasy metres).

My old DBT-120 (revision B2), of which I had high hopes, performed
atrociously, getting maybe 3m.  I bought two of these dongles years ago,
back when I thought bluetooth might compete with wifi for home
networking.  I got similar terrible results then as well, making them
useless for their intended purpose.  I now use a DBT-120 with my
bluetooth mouse, which obviously can happily stay within range.

And my new Digitus DN-3008M1 class 1 dongle got... drum roll please...
about 10m.  That is, the actual distance depended heavily on how many
intervening walls and things were in the way.  Between my computer and
bedroom, about 9m and a few intervening walls, it performed OK, although
would still cut out if I had my head facing in the wrong direction.  It
managed to broadcast through two intervening floors, but cut out when I
went into the cellar.

So the conclusion:

* Don't believe the lies about "10m" and "100m".

* A class 2 dongle is adequate when the devices are in the same room.

* A class 1 dongle is adequate when the devices are in the same house.
Assuming it's a fairly small house.

* Anything more than that, you need the class 0 dongle, which glows
white-hot during operation and knocks migrating birds out of the sky.

All in all, I'd consider that a good result.  Now if only there was a 
class 1 dongle that supported HID proxy...

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

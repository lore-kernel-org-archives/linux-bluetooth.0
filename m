Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 22 Feb 2007 18:26:43 -0500
From: Walt Shekrota <penguinacity@yahoo.com>
To: bluez-users@lists.sourceforge.net
Message-id: <200702221826.44078.penguinacity@yahoo.com>
MIME-version: 1.0
Subject: [Bluez-users] Blunt observation
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

This list doesn't see many bytes does it?

/usr/share/doc/bluez*
the info here is rather useless .... no templates?
Man pages? for anything?

I have been beating myself blind I guess the only option is the source?
When I execute btsco I have to do it twice ...... why???????????????
I also note the device named in rfcomm doesn't seem too important. I tried it 
with either address or the line commented out all generate this...

<snip>-------------------------------------------------------
btsco -v 00:03:89:F7:A9:78
btsco v0.42
Device is 1:0
Voice setting: 0x0060
Can't connect RFCOMM channel: Connection refused

then on retry

btsco -v 00:03:89:F7:A9:78
btsco v0.42
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected
Using interface hci0
<snip>------------------------------------------------------

:78 is the address of my headset.

Thanks for aaaaaaaaaaaaaaaaaaaaaaaaaaaaanything.
Just a small lead. I could just code the command twice in the menu but that is 
rather crappy :)

-Walt Shekrota

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

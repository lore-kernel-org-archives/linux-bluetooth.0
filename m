Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 4 Oct 2006 14:19:16 -0700
From: bb.bluez@magitech.org
Message-ID: <4910207664.20061004141916@magitech.org>
To: Bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Automatic Object Pushing when Devices Enter Range
Reply-To: bb.bluez@magitech.org,
        BlueZ users <bluez-users@lists.sourceforge.net>
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

Hello all!

I'm trying to determine if there's a better way then polling "hcitool scan"
every few seconds to receive notification when a new device is connectable.

The goal is to automatically push a file to each device as it comes within
range without requiring any user intervention (on the server side, of course).
Naturally a certain amount of accounting will need to be done to avoid
duplication and spammage, but I'm primarily curious if there's any event
system or rc.d script system similar to some things I've seen on the FreeBSD
side to enable this behavior.

I'd really like is a way to register or specify a script to be called
whenever a device comes within range.  I'd expect the script to be passed the
address of the device, allowing me to interrogate it regarding it's
capabilities, and so forth.

The alternative is, of course, to call "hcitool scan" every few seconds,
compare with a log of the known or seen ID's, and process from there, but as
we were all taught in grammar school CS, polling is bad mm'kay.

Comments?  Suggestions?
--B


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

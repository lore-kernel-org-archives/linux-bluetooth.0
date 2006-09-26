Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <7d3798db0609260723y34fe4dcam37b9d9a9264ba282@mail.gmail.com>
Date: Tue, 26 Sep 2006 16:23:11 +0200
From: "=?ISO-8859-1?Q?Robert_Dahlstr=F6m?=" <robert.dahlstrom.4007@student.uu.se>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] rfcomm device names
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

Hello all, I'm currently trying to make bluez work with a Maxell
Digital Pen (the DP-201 for interested parties)...

The question to make this happen is if it is possible to have generic
rfcomm device names? I.e. can rfcomm be configured to use any device
name that I can choose? (These pens only supply data via bluetooth to
a specifically named port so for them to work with linux I need to be
able to set this device/port name somehow)

Specifically the pen works ok out of the box with the obex transfer
protocol but I'm trying to enable the pens streaming protocol with
connects using the serial interface and expects to find a commport
with a specific name. (I'm aware that this is quite bad programming in
the pens but I cannot change that)

I'd appreciate any hints/ideas that would take me in the right
direction. Sadly I failed to find any information in the archives for
this issue.

Thanks in advance for your help!

Regards
-- 
Robert

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

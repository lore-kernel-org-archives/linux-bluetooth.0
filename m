Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <a481fbf0701231319m5987a96cwe8ae5723cfb51091@mail.gmail.com>
Date: Tue, 23 Jan 2007 16:19:24 -0500
From: "Raymond Ingles" <sorceror171@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] PAN vs. RFCOMM/PPP speeds?
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

I've got my Treo 650 connecting to my computer over Bluetooth by
following guides like: http://www.linuxjournal.com/article/8185

 It works and the speed is acceptable. However, from what I understand
it's basically using PPP over RFCOMM over Bluetooth - which seems like
a bit much in terms of overhead - and appears to be limited to
115,200Kbps. I wonder if trying to use a PAN connection (perhaps the
NAP configuration in the PAN HOWTO) would bypass some of the overhead?

 I couldn't find anything directly commenting on this. My tinkering
time is limited (three kids, one on the way, etc.) so I'm reluctant to
play with PAN unless I was reasonably sure it would be worth it.

 Thanks in advance for any information y'all can provide.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Neil MacLeod <gmane@nmacleod.com>
Date: Sat, 16 Dec 2006 02:25:00 +0000
Message-ID: <elvlcl$drg$1@sea.gmane.org>
Mime-Version: 1.0
Subject: [Bluez-users] Nokia 770 / Sony Ericsson UIQ3 pairing / DUN problems
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

Hi

I've got a problem pairing (sometimes) and establishing a DUN connection (sometimes) between a Nokia 770 (OS 2006 v2 - ie. Nov 06 RTM firmware) and Sony Ericsson W950i smartphone (Symbian UIQ 3). I've also tried to establish a connection using the very latest "Sardine" pre-release firmware but the behaviour is the same.

I've raised a bug entry in the Nokia 770 bugzilla (https://maemo.org/bugzilla/show_bug.cgi?id=865) and received some assitance from Johan Hedberg (for which I'm very grateful) but as is the way with the Nokia Bugzilla it's pretty much one-way traffic :(

I'd be really grateful if anyone could suggest what could be done to improve the BT connectivity between W950i and Nokia 770. Pairing fails sometimes, but once paired the phone may or may not accept a connection from the 770. It looks like it might be an issue on the 770, as executing "hciconfig hci0 reset" normally results in a successful connection however Johan suggests the problem could be on both ends.

The Nokia bugzilla entry is https://maemo.org/bugzilla/show_bug.cgi?id=865 - this entry contains output from hcidump, sdp-query and syslog. My biggest concern is that this bug is never addressed by Nokia, in which case I've got a quite expensive but useless (for internet connectivity!) phone.

Many (many!) thanks in advance! :)

Neil


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

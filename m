Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4587BB0E.2070909@glidos.net>
Date: Tue, 19 Dec 2006 10:12:30 +0000
From: Paul Gardiner <osronline@glidos.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] hcid.conf seemingly ignored
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

I had my server (running SuSE 10.1) set up as a gateway for my PDA
following the advice in: 
http://wiki.xda-developers.com/index.php?pagename=bluetoothnetworking

I've just swapped over to SuSE 10.2 which has bluesz 3.7-14 and
the set up no longer works.

hciconfig says:

hci0:   Type: USB
         BD Address: 00:09:DD:50:47:BB ACL MTU: 384:8 SCO MTU: 64:8
         UP RUNNING PSCAN
         RX bytes:401 acl:0 sco:0 events:18 errors:0
         TX bytes:317 acl:0 sco:0 commands:17 errors:0

with ISCAN missing, although my hcid.conf file has  "iscan enable".

I can use "hciconfig hci0 iscan" to fix that, but this all makes
me think I'm doing something wrong.  If I change hcid.conf to have
"pscan disable" that has no effect: still PSCAN is listed in
the report from hciconfig. Its as though hcid.conf is being ignored.

Any ideas?

Cheers,
	Paul.




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

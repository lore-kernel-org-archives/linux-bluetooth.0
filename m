Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4587F855.303@glidos.net>
Date: Tue, 19 Dec 2006 14:33:57 +0000
From: Paul Gardiner <osronline@glidos.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] No longer possibke to convince my PDA that my linux
 box is a bluetooth modem
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

I used to access the internet via my PDA via my opensuse 10.1 based
server. The set up of bluez was copied from here:
http://wiki.xda-developers.com/index.php?pagename=bluetoothnetworking

No that I've upgraded to opensuse 10.2, I've run into various problems.
The one that I'm stuck on now is getting dund to respond.

The instructions above say to expect the following to appear
in the logs while connecting:

Apr  4 21:57:14 systol hcid?5633: link_key_request 
(sba=XX:XX:XX:XX:XX:XX, dba=XX:XX:XX:XX:XX:XX)
Apr  4 21:57:15 systol dund?13797: New connection from XX:XX:XX:XX:XX:XX
Apr  4 21:57:15 systol pppd?13802: pppd 2.4.1 started by root, uid 0
Apr  4 21:57:16 systol /etc/ppp/at-cmd.pl?13806: got: ATZ
Apr  4 21:57:16 systol /etc/ppp/at-cmd.pl?13806: send: OK
Apr  4 21:57:16 systol /etc/ppp/at-cmd.pl?13806: got: AT
Apr  4 21:57:16 systol /etc/ppp/at-cmd.pl?13806: send: OK
Apr  4 21:57:17 systol /etc/ppp/at-cmd.pl?13806: got: ATE0V1&C1&D2
Apr  4 21:57:17 systol /etc/ppp/at-cmd.pl?13806: send: OK


I used to get that, but now I just get the first line, saying
link_key_request. Nothing appears from dund.  I have no
idea how to track this down. I tried hcidump, and there is
certainly some traffic, but nothing I can understand.

Any thoughts what might be up?

Cheers,
	Paul

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

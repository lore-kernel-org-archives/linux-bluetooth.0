Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: CIJOML <cijoml@volny.cz>
To: bluez-users@lists.sf.net
Date: Fri, 1 Dec 2006 11:13:57 +0100
MIME-Version: 1.0
Message-Id: <200612011113.57351.cijoml@volny.cz>
Subject: [Bluez-users] iptraf doesn't list / gathers statistics for bnep0
	interface
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-2"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Marcel,

I just noticed, that bnep0 doesn't gathers bnep0 statistics.

bnep0     Zapouzd=F8en=ED:Ethernet  HWadr 00:0D:88:XX:XX:XX
          inet adr:192.168.56.1  V=B9esm=ECr:192.168.56.255 Maska:255.255.2=
55.0
          AKTIVOV=C1NO V=A9ESM=CCROV=C9_VYS=CDL=C1N=CD B=CC=AE=CD MULTICAST=
  MTU:1500  Metrika:1
          RX packets:2767 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4494 errors:0 dropped:0 overruns:0 carrier:0
          koliz=ED:0 d=E9lka odchoz=ED fronty:1000
          RX bytes:164767 (160.9 KiB)  TX bytes:6557844 (6.2 MiB)

Should this be fixed?

thanks a lot

Michal

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45E6F4C2.2030608@xmission.com>
Date: Thu, 01 Mar 2007 08:44:02 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] dun performance
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

Guys

I think this is useful to bluez users since bluez can uncover problems
in other stacks.

fwiw, I've switched from using a verizon treo 700p to get mobile
internet to a cingular/att razr v3xx. All you need to know to set this
up: the dial string is *99# and you can leave the "access point" blank
if you are using this with a Nokia 770/n800. Leave the auth settings
blank too.

It's interesting to review the kinds of data rates I've seen using
bluetooth dun from a linux laptop as I go from phone to phone and
carrier to carrier:

    * moto razr v3xx (cingular, umts) 550kbps
    * treo 700p (verizon, evdo) 400kbps
    * moto e815 (verizon, evdo) >600kbps
    * ppc 6700 (sprint, evdo) phone crashed hard when starting DUN
    * samsung i730 (verizon, evdo) ~130kbps randomly drops connection
    * samsung i730 (verizon, 1xrtt) ~130kbps
    * moto v710 (verizon, 1xrtt) ~130kbps
    * nokia ngage (tmobile, gprs) ~45kbps

The e815 is the only phone that might have been hitting the ceiling for
bluetooth throughput. Don't listen to salespeople who say bluetooth
dialup cannot perform well. This myth is in part fueled by the fact that
MS has such poor performance in its stack. Apparently MS has not
addressed its bluetooth performance problems in any WM5 devices either.
Stay away from those things if you need DUN.

Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <459B947A.30803@glidos.net>
Date: Wed, 03 Jan 2007 11:33:14 +0000
From: Paul Gardiner <osronline@glidos.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <57c68ddc0701012354u4137d1d3s93b28cafaa53f849@mail.gmail.com>	<1167725398.30886.32.camel@violet>	<57c68ddc0701020016y29fafa8duf77494bb50ac6d75@mail.gmail.com>	<20070102081813.6a264b0e.ml133@netpole.com.br>	<57c68ddc0701020229w6ddfaab3yf989a8e3999cbd1@mail.gmail.com>	<20070102094414.f7b9cef1.ml133@netpole.com.br>	<57c68ddc0701020446y3a7e70edh74f6ea5e0b05d07f@mail.gmail.com>	<1167743069.30886.54.camel@violet>
	<459A60A1.80906@glidos.net>	<1167745840.30886.77.camel@violet>
	<459AC8B4.7090407@glidos.net> <1167772692.30886.117.camel@violet>
In-Reply-To: <1167772692.30886.117.camel@violet>
Subject: [Bluez-users] Problems fooling my S100 into using Bluez as a modem
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

Marcel Holtmann wrote:
> Check /sys/class/bluetooth/rfcomm that you really have a listening
> RFCOMM socket on the right channel after starting dund.

How do I check this?  In that directory I have "hci0", which is a soft
link, and three other files "l2cap", "rfcomm", "rfcomm_dlc".  How
do I check they are correct?

Also, I have to own up to something silly: when some of your
statements seemed to imply that most of this should work
without special configuration, I put the original config
files in place, but didn't notice that dund was off by
default.  I'll post some new dumps with that corrected.

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

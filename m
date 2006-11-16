Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: CIJOML <cijoml@volny.cz>
To: bluez-users@lists.sf.net
Date: Thu, 16 Nov 2006 16:07:27 +0100
MIME-Version: 1.0
Message-Id: <200611161607.27656.cijoml@volny.cz>
Subject: [Bluez-users] hcidump returns no events pressing multimedia keys
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

Hi Marcel,

I have problem with my Microsoft Keyboard for Bluetooth. It returns no events 
when I am trying press multimedia keys.

I have tested xev and if no reply I was trying hcidump, but no events goes 
through.

kernel 2.6.18.2

I: Bus=0005 Vendor=045e Product=007b Version=0039
N: Name="Bluetooth HID Boot Protocol Device"
P: Phys=
S: Sysfs=/class/input/input9
H: Handlers=kbd event4
B: EV=120003
B: KEY=7 ff87207a c14057ff febeffdf ffefffff ffffffff fffffffe
B: LED=1f


What can I do?

Thanks a lot for help

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michael Mauch <michael.mauch@gmx.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20040104192319.GB2787@elmicha.333200002251-0001.dialin.t-online.de>
References: <1073239248.2928.18.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1073239248.2928.18.camel@localhost>
Subject: [Bluez-users] Re: Problem "coldplugging"
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 4 Jan 2004 20:23:19 +0100

Oguzhan Eris wrote:

> Hi, I was wondering if someone could help me out with a problem using
> the IOGEAR GBU301 device which requires bluefw.

I have two Tecom BT-3030 here, and the same problem, both with a desktop
and with a laptop. It worked in the past, but at the moment it's rather
flaky. Alas I changed too much in between, so I can't tell when the
problems started.

> When I do modprobe hci_usb however, it doesn't work.  I've added a lot
> of debugging to bluefw and found that "sometimes" it thinks the vendor
> id of the dongle is  0x2000  instead of  0x2033  I can confirm this
> right now even.  Here's the lines from /proc/bus/usb/devices

Same here. Sometimes it's even 0x2001.
 
> T:  Bus=02 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
> D:  Ver= 1.01 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0a5c ProdID=2000 Rev= 0.a0
> S:  Manufacturer=Broadcom Corp.
> S:  Product=BCM2033
> S:  SerialNumber=2033B1100001

On the desktop:

T:  Bus=01 Lev=02 Prnt=02 Port=03 Cnt=02 Dev#=  5 Spd=12  MxCh= 0
D:  Ver= 1.01 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0a5c ProdID=2000 Rev= 0.a0
S:  Manufacturer=Broadcom Corp.??????
S:  Product=BCM2033?????????????
S:  SerialNumber=2033B1100001????

On the laptop:

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.01 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0a5c ProdID=2001 Rev= 0.a0
S:  Manufacturer=Broadcom Corp.
S:  Product=BCM2033
S:  SerialNumber=20330003C92AB320

> This second usb port is handled via uhci-hcd

I'm using usb-ohci on the desktop, and uhci or usb-uhci on the laptop
(both with vanilla 2.4.23). 

Regards...
		Michael


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

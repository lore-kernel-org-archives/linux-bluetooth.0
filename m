Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Oguzhan Eris <eris3@ekls.com>
To: bluez-users@lists.sourceforge.net
Message-id: <1073239248.2928.18.camel@localhost>
MIME-version: 1.0
Content-type: text/plain
Subject: [Bluez-users] Problem "coldplugging"
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
Date: Sun, 04 Jan 2004 13:00:49 -0500

Hi, I was wondering if someone could help me out with a problem using
the IOGEAR GBU301 device which requires bluefw.

Everything works fine if I hotplug the device with the device matching
bluefw.usermap and running the appropriate bluefw command.  

I have kernel 2.6.0   (now upto  rc1-mm1)  with the bluetooth matches
from patch-2.6.0-mh1   (it applied cleanly to 2.6.0-rc1)  I have tried
ALL combinations.

I also tried ALL combinations of having bluetooth as modules vs. kernel
built in.

My problem is that nomatter what I've tried, I cannot get the device to
work fine when it is simply plugged in  (the place where this machine
will be put will not allow me to hotplug, so that isn't an option)

I can provide logs from any which combination, so if you think one way
is to go, please tell me, I'll setup the configuration and send over the
logs.

My question is as follows.   If all bluetooth kernel options are
modules, which ones do I need installed before I run bluefw?  I edited
/etc/hotplug/usb/bluefw  to output the state of lsmod before it ran
bluefw and it showed that hci_usb was installed before running bluefw.
So I figured I add the following to my modprobe.conf

alias net-pf-31 bluetooth
alias bt-proto-0 l2cap
alias bt-proto-2 sco
alias bt-proto-3 rfcomm
alias bt-proto-4 bnep
                                                                                                                                                                install hci_usb /sbin/modprobe --ignore-install hci_usb; /sbin/bluefw usb /proc/bus/usb/002/002

I haven't figured out howto know which bus/device the dongle is
connected to, but I know for sure it's 002/002  at this time.  

When I do modprobe hci_usb however, it doesn't work.  I've added a lot
of debugging to bluefw and found that "sometimes" it thinks the vendor
id of the dongle is  0x2000  instead of  0x2033  I can confirm this
right now even.  Here's the lines from /proc/bus/usb/devices

T:  Bus=02 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.01 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0a5c ProdID=2000 Rev= 0.a0
S:  Manufacturer=Broadcom Corp.
S:  Product=BCM2033
S:  SerialNumber=2033B1100001
C:* #Ifs= 3 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  16 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  16 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  32 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  32 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  32 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  32 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms

This second usb port is handled via uhci-hcd

But sometimes after enough modprobe'ing and rmmod'ing and definitely
after hotplugging,  the vendorid goes to 0x2033 and things work fine.

Sorry for the really long post, but I've been at this for two solid days
and I have not been able to get anywhere.  Does anyone have a working
"coldplugged" solution to a usb dongle that needs the firmware?  Am I
just out of luck?  I can't see why I cannot replicate what
hotplug/usb.agent does when I plug in the object.  

(any other pertinent info,  I'm running kernel 2.6.1-rc1-mm1 at the
moment but can got vanilla 2.6.0  though that hasn't worked either)  I
do not have devfs installed, and I also haven't installed udev)

This is a Fedora Core 1 box, with the necessary upgrades for kernel 2.6
Hotplug (which is now deinstalled, was 2003_08_05)

Thanks in advance.



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

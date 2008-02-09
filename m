Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Feb 2008 23:38:00 -0500
From: jayjwa <jayjwa@atr2.ath.cx>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200802081658.m18GwrGX006241@fizban.dyndns.org>
Message-ID: <alpine.LNX.1.00.0802082311470.12621@nge2.ngu.pk>
References: <200802081658.m18GwrGX006241@fizban.dyndns.org>
MIME-Version: 1.0
Subject: Re: [Bluez-users] No output from hciconfig
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


On Fri, 8 Feb 2008, montef@bellsouth.net wrote:


->  I bought the same D-Link DBT-120 Bluetooth dongle that Patrick M.
-> Davila references using in his article.

I hope it has support in-kernel, else you'll be looking for external 
drivers/kmods?


->  I've tried the DBT-120 in all 4 of the USB connectors on the
-> motherboard.

Mine uses a USB 2.0 interface.



->  Following Patrick's article, I've done:
-> 
->  lsmod |grep blue
-> bluetooth              52708  2 hci_usb,rfcomm,hidp,l2cap

These commands just check that various supporting modules are loaded. They 
could be compiled in too, in while case you'd not see the above.

->  dmesg |grep Blue
-> Bluetooth: Core ver 2.11
-> Bluetooth: HCI device and connection manager initialized
-> Bluetooth: HCI socket layer initialized
-> Bluetooth: L2CAP ver 2.8
-> Bluetooth: L2CAP socket layer initialized
-> Bluetooth: RFCOMM socket layer initialized
-> Bluetooth: RFCOMM TTY layer initialized
-> Bluetooth: RFCOMM ver 1.8
-> Bluetooth: Core ver 2.11
-> Bluetooth: HCI device and connection manager initialized
-> Bluetooth: HCI socket layer initialized
-> Bluetooth: L2CAP ver 2.8
-> Bluetooth: L2CAP socket layer initialized
-> Bluetooth: HIDP (Human Interface Emulation) ver 1.2
-> Bluetooth: RFCOMM socket layer initialized
-> Bluetooth: RFCOMM TTY layer initialized
-> Bluetooth: RFCOMM ver 1.8
-> Bluetooth: HCI USB driver ver 2.9

The same modules' output in the logs.


->  hciconfig -a
-> 
->  This is where I'm having problems. I can't get any output at all from
-> hciconfig. Searching the mailing list archives as well as Google,
-> haven't turned up much with what to do to debug this.  I have tried:

It seems your Bluetooth adapter isn't being recognized. When I first started, 
I had this question too.


->   hciconfig hci0 up

As far as I've seen, this command isn't needed anymore unless you've downed 
the device for some reason. I've never done it, but prehaps there's setups 
I've not taking into account here.

-> Can't get device info: No such device

As far as it sees, there's no device.

->  Anyone have any suggestions on what to try to debug this?


You said USB? What does 'lsusb' say about it?

You should see the adapter:

Bus 004 Device 001: ID 0000:0000
Bus 003 Device 001: ID 0000:0000
Bus 002 Device 005: ID 050d:0121 Belkin Components F5D5050 100Mbps Ethernet
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 001: ID 0000:0000

Poke around in /proc:

cd /proc/bus/usb
ls

001/  002/  003/  004/  devices


cat devices



If your adapter is being recognized, it will be listed in that file with the 
'Driver= ' end of the line showing the module it is using.

T:  Bus=02 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  5 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=050d ProdID=0121 Rev= 1.00
S:  Manufacturer=Broadcom Corp
S:  Product=BELKIN BLUETOOTH USB ADAPTER CL. 1
C:* #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:* If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)


If you didn't get even that far, I'd check the search engines to see if your 
device is usable under Linux with the kernel and setup you have. You say it 
came from a Linux example, so it should likely be, but prehaps it has some 
3rd-party driver, or needs firmware of some sort. These things might turn up 
in search of Linux hardware compatibility lists. Other than that, check your 
USB subsystem is OK.

If you did get that far, which version of the Bluez tools are you using? I 
posted an example of using a headset a few list issues ago, but the order in 
which you start the Bluetooth daemons and setup is the same here. Basically, 
start dbus, sdpd, hcid, passkey-agent --default <pin> <addr>, auth-agent. From 
that point on, if your config files are all installed and OK, you should see 
something with just 'hciconfig -a'- your adapter. 'sdptool browse local' 
should show what it's advertising as far as services.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

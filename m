Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Sebastian Roth <sebastian.roth@esk.fhg.de>
Message-ID: <cp3rr7$1vv$1@sea.gmane.org>
References: <20041206225609.GA1177@zeus.galaxy.org.uk>	 <cp3mkk$m7t$1@sea.gmane.org> <1102407664.8447.20.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <1102407664.8447.20.camel@pegasus>
Subject: [Bluez-devel] Problems with anycom usb dongle (was: snd-bt-sco problem)
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 07 Dec 2004 10:06:47 +0100

Hi Marcel,


> what does "/proc/bus/usb/device" show for the Anycom dongle?

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  4 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=16 #Cfgs=  1
P:  Vendor=0f4d ProdID=1000 Rev= 4.01
C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr= 26mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=00(>ifc ) Sub=00 Prot=00 Driver=hci_usb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=00(>ifc ) Sub=00 Prot=00 Driver=hci_usb
E:  Ad=84(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=05(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=00(>ifc ) Sub=00 Prot=00 Driver=hci_usb
E:  Ad=84(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=05(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=00(>ifc ) Sub=00 Prot=00 Driver=hci_usb
E:  Ad=84(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=05(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=00(>ifc ) Sub=00 Prot=00 Driver=hci_usb
E:  Ad=84(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=05(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=00(>ifc ) Sub=00 Prot=00 Driver=hci_usb
E:  Ad=84(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=05(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=00(>ifc ) Sub=00 Prot=00 Driver=hci_usb
E:  Ad=84(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=05(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms


With the anycom dongle I can see SCO data using hcidump but no sound
is playing. When btsco is stopped it seems to me the connection isn't
really closed.
hcidump:
...
 > SCO data: handle 0x0000 dlen 0
 > SCO data: handle 0x0000 dlen 0
...

syslog:
...
kernel: cket: hci0 SCO packet for unknown connection handle 0
kernel: hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
last message repeated 229 times
...

I have to stop hcid shutdown hic0 and unload all the modules to stop it
flooding my syslog!

Best regards,
Sebastian



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

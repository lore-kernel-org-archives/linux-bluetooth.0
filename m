Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Am stuck; HP laptop, Fedora
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4215A788.9070205@yahoo-inc.com>
References: <4215A788.9070205@yahoo-inc.com>
Content-Type: text/plain
Message-Id: <1109027434.7626.28.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 22 Feb 2005 00:10:34 +0100

Hi Vegard,

> Hello, I've spent some time getting BT to work on my HP NC6000 laptop, 
> now looking for any clues. To put it shortly, I think I have everything 
> installed right, but when I for instance fire up gnome-obex-send, it 
> will hang when I scan for devices.
> 
> More detail:
> 
> I have FC2 with the 2.6.9-1.11_FC2 kernel. I got the latest bluez-libs 
> and bluez-utils compiled fine:
> 
> -rw-r--r--  1 root root 55116 Feb 17 22:17 /usr/lib/libbluetooth.a
> -rwxr-xr-x  1 root root   835 Feb 17 22:17 /usr/lib/libbluetooth.la
> lrwxrwxrwx  1 root root    22 Feb 17 22:17 /usr/lib/libbluetooth.so -> 
> libbluetooth.so.1.0.15
> lrwxrwxrwx  1 root root    22 Feb 17 22:17 /usr/lib/libbluetooth.so.1 -> 
> libbluetooth.so.1.0.15
> -rwxr-xr-x  1 root root 59773 Feb 17 22:17 /usr/lib/libbluetooth.so.1.0.15
> [vegardh@dhcp-244 vegardh]$
> 
> The kernel module is the one that was in the kernel in the first place, 
> I haven't compiled that:
> 
> author:         Maxim Krasnyansky <maxk@qualcomm.com>, Marcel Holtmann 
> <marcel@holtmann.org>
> description:    Bluetooth Core ver 2.6
> version:        2.6 21CCA1EA2920D6252535138
> license:        GPL
> alias:          net-pf-31
> vermagic:       2.6.9-1.11_FC2 686 REGPARM 4KSTACKS gcc-3.3
> depends:
> 
> And the device itself is on the USB:
> 
> T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=049f ProdID=0086 Rev= 8.02
> S:  Manufacturer=ACTIONTEC
> S:  Product=Bluetooth by hp
> 
> The BT works from Windows.
> 
> With obex_test I get this, can't get more debug or something from it:
> 
> [vegardh@dhcp-244 vegardh]$ obex_test -b
> Using Bluetooth RFCOMM transport
> OBEX Interactive test client/server.
>  > s
> Server register error! (Bluetooth)
> 
> I'd appreciate any clues, either from someone with experience with this 
> laptop and linux, or if I've overlooked something.

from this report I can't tell you anything, but the Bluetooth device
inside my NC4000 is working prefect and actually it is the same as in
your laptop. What does "hciconfig -a" tells you?

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

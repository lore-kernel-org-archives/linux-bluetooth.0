Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Linux-2.6, Zaapa USB Dongle - can't find near
	devices
From: Marcel Holtmann <marcel@holtmann.org>
To: Filipe Veloza <fmvel@rnl.ist.utl.pt>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1086434351.6274.2.camel@castle.budism.pt>
References: <1086372047.8985.14.camel@castle.budism.pt>
	 <200406042022.58589.cijoml@volny.cz>  <1086374092.4424.24.camel@pegasus>
	 <1086434351.6274.2.camel@castle.budism.pt>
Content-Type: text/plain
Message-Id: <1086434730.16316.82.camel@pegasus>
Mime-Version: 1.0
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
Date: Sat, 05 Jun 2004 13:25:30 +0200

Hi Filipe,

> here goes anyway :P
> 
> [~]hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
>         DOWN
>         RX bytes:0 acl:0 sco:0 events:0 errors:0
>         TX bytes:0 acl:0 sco:0 commands:0 errors:0
>         Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DH1 HV1
>         Link policy:
>         Link mode: SLAVE ACCEPT

you said you've tried to bring up the device. Try again, because
"hciconfig hci0 up" should bring it at least up.

If it still fails look at dmesg or the syslog for any errors.

> T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS= 8 #Cfgs=  1
> P:  Vendor=0b7a ProdID=07d0 Rev= 1.34
> S:  SerialNumber=3E402C78
> C:* #Ifs= 2 Cfg#= 1 Atr=c0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=00(>ifc ) Sub=00 Prot=00 Driver=hci_usb
> E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=1ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:  If#= 1 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)

You are right this is a Zeevo chip, but it is the old TC2001. I don't
know if it helps, but try 2.6.6-mh3 or at 2.6.7-rc2-bk5.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

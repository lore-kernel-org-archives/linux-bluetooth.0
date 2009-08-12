Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2d5a2c100908120559h1a3ed5acn26b8a07ab41cd95@mail.gmail.com>
References: <4A82B32E.3020903@gmail.com>
	 <2d5a2c100908120559h1a3ed5acn26b8a07ab41cd95@mail.gmail.com>
Date: Wed, 12 Aug 2009 17:10:09 +0300
Message-ID: <4a221c10908120710y1ad31540ib5b16f27d2af4751@mail.gmail.com>
Subject: Re: NAP/GN with bluez-4
From: "Dmitry A. Yanko" <y.dmitry@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Aug 12, 2009 at 3:59 PM, Luiz Augusto von
Dentz<luiz.dentz@gmail.com> wrote:
> The service registration is done by network plugin, you can edit
> network.conf to configure which script/interface name to be used. Also
All done here:
bluetoothd[10470]: Config options: InterfacePrefix=bnep0,
PANU_Script=(null), GN_Script=(null), NAP_Script=(null),
GN_Interface=pan1, NAP_Interface=pan2, Security=false
bluetoothd[10470]: bridge pan1 created
bluetoothd[10470]: HCI dev 0 registered
bluetoothd[10470]: child 10472 forked
bluetoothd[10470]: Entering main loop
bluetoothd[10470]: child 10472 exited
bluetoothd[10470]: HCI dev 0 up


> check if they are enabled by calling
> org.bluez.NetworkRouter.GetProperties(), if not enabled enable it by
> calling org.bluez.NetworkRouter.SetProperty("Enabled", True). Another
Values, extracted from dbus with python script:
...
router = dbus.Interface(bus.get_object("org.bluez", manager.DefaultAdapter()),
                "org.bluez.NetworkRouter")
...
print router.dbus_interface
props = router.GetProperties()
for pname in props.keys():
        print pname,props[pname]
...

Output:

org.bluez.NetworkRouter
Enabled 1
Name BlueZ NAP service
Uuid 00001116-0000-1000-8000-00805f9b34fb

org.bluez.NetworkHub
Enabled 1
Name BlueZ GN service
Uuid 00001117-0000-1000-8000-00805f9b34fb

org.bluez.NetworkPeer
Enabled 1
Name BlueZ PANU service
Uuid 00001115-0000-1000-8000-00805f9b34fb

All enabled.

> detail is that you should configure NAP bridge to be used since if you
> follow the spec it needs to enable dhcp server and configure the
> routes while GN is just a simple bridge.
I configured GN as pan1 and NAP as pan2. Only pan1 exists after
bluetoothd started (why I can't see pan2?).
# ifconfig pan1 inet 10.7.7.1 netmask 255.255.255.0 up
dhcp started on pan1

When I start discovery from my phone (or netbook) I can see in logs:
bluetoothd[11235]: adapter_get_device(00:0E:F6:01:00:98)
And with 'monitor-bluetooth' script:
{Device.PropertyChanged} [/org/bluez/11235/hci0/dev_00_0E_F6_01_00_98]
Connected = 1
{Device.PropertyChanged} [/org/bluez/11235/hci0/dev_00_0E_F6_01_00_98]
Connected = 0

hcidump shows me a lot of traffic, but no any records about NAP/GN in
a dump (as i understand, something similar to service xml record must
present. With 'simple-service' script there is SrvRecHndl about serial
service.). And, as result, no any services on 'bluez' blootooth device
shown.

BTW: 2.6.30-gentoo-r4
# zcat /proc/config.gz|grep CONFIG_BT
CONFIG_BT=m
CONFIG_BT_L2CAP=m
CONFIG_BT_SCO=m
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=m
CONFIG_BT_HCIBTUSB=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_LL=y
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
# lsmod
Module                  Size  Used by
rfcomm                 36196  0
bridge                 47816  0
bnep                   11732  2
sco                     9912  0
l2cap                  22708  8 rfcomm,bnep
btusb                  11592  2
bluetooth              54084  9 rfcomm,bnep,sco,l2cap,btusb
nvidia               7229892  26
fuse                   53136  2
r8169                  31896  0
e100                   31420  0
intel_agp              26172  0
pl2303                 16888  1
usbserial              29736  3 pl2303
processor              33864  0
i2c_i801                8420  0
thermal                12688  0
button                  5092  0


-- 
#include <regards.h>

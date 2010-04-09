Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Zhu Yanhai <zhu.yanhai@gmail.com>
Date: Fri, 9 Apr 2010 16:35:56 +0800
Message-ID: <o2p977a2be21004090135u225590edn39c803c9d201b308@mail.gmail.com>
Subject: Is hsp code in BlueZ and pulseaudio broken?
To: linux-bluetooth@vger.kernel.org,
	pulseaudio-discuss@mail.0pointer.de
Cc: vivian.zhang@intel.com, guannan.ou@intel.com,
	Zheng Huan <huan.zheng@intel.com>,
	Zhu Yanhai <yanhai.zhu@linux.intel.com>,
	"Zhu, Yanhai" <yanhai.zhu@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi list,
I can't make hsp profile work with the latest bluez and pulseaudio,
does anyone here know
whether the hsp code in bluez and pulseaudio still can work?

I used a DELL BH200 headset, which has both A2DP, Headset and
Headsfree profile support.
The code of BlueZ and Pulseaudio are both directly cloned from their git repos.

BlueZ configure:
 $ ./configure --enable-maintainer-mode --enable-debug --prefix=/usr
--mandir=/usr/share/man --sysconfdir=/etc --localstatedir=/var
--libexecdir=/lib --enable-netlink --disable-capng --enable-tracer
--enable-tools --enable-bccmd --enable-dfutool --enable-hid2hci
--enable-hidd --enable-pand --enable-dund --enable-test --enable-cups
--disable-pcmcia --disable-udevrules --with-telephony=ofono
--disable-configfiles

To make the testing steps clear, I unloaded module-bluetooth-discover
before connecting the
headset.

After starting bluez with the option -n and -d, I called to
org.bluez.Headset/Connect() using d-feet.
BlueZ printed:

bluetoothd[10791]: State changed
/org/bluez/10791/hci0/dev_00_16_44_FD_84_CB:
HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECTING
bluetoothd[10791]: link_key_request (sba=00:26:5E:A5:A8:65,
dba=00:16:44:FD:84:CB)
bluetoothd[10791]: kernel auth requirements = 0x00
bluetoothd[10791]: stored link key type = 0x00
bluetoothd[10791]: adapter_get_device(00:16:44:FD:84:CB)
bluetoothd[10791]: Discovered Headset service on channel 8
bluetoothd[10791]: /org/bluez/10791/hci0/dev_00_16_44_FD_84_CB:
Connecting to 00:16:44:FD:84:CB channel 8
bluetoothd[10791]: link_key_request (sba=00:26:5E:A5:A8:65,
dba=00:16:44:FD:84:CB)
bluetoothd[10791]: kernel auth requirements = 0x04
bluetoothd[10791]: stored link key type = 0x00
bluetoothd[10791]: hcid_dbus_bonding_process_complete: status=00
bluetoothd[10791]: adapter_get_device(00:16:44:FD:84:CB)
bluetoothd[10791]: hcid_dbus_bonding_process_complete: no pending auth request
bluetoothd[10791]: /org/bluez/10791/hci0/dev_00_16_44_FD_84_CB:
Connected to 00:16:44:FD:84:CB
bluetoothd[10791]: telephony-ofono: device 0xb793c4d8 connected
bluetoothd[10791]: State changed
/org/bluez/10791/hci0/dev_00_16_44_FD_84_CB: HEADSET_STATE_CONNECTING
-> HEADSET_STATE_CONNECTED

And then  'load-module module-bluetooth-discover' using pacmd. As soon
as the module was loaded, BlueZ printed:

bluetoothd[10791]: Accepted new client connection on unix socket (fd=22)
bluetoothd[10791]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[10791]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[10791]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[10791]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[10791]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[10791]: open sco -
object=/org/bluez/10791/hci0/dev_00_16_44_FD_84_CB source=ANY
destination=ANY lock=readwrite
bluetoothd[10791]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[10791]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[10791]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[10791]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[10791]: State changed
/org/bluez/10791/hci0/dev_00_16_44_FD_84_CB: HEADSET_STATE_CONNECTED
-> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[10791]: SCO socket opened for headset
/org/bluez/10791/hci0/dev_00_16_44_FD_84_CB
bluetoothd[10791]: SCO fd=24
bluetoothd[10791]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[10791]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[10791]: State changed
/org/bluez/10791/hci0/dev_00_16_44_FD_84_CB:
HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING

Then, after waiting about 3-4 seconds, BlueZ printed:

bluetoothd[10791]: No matching connection found for handle 6
bluetoothd[10791]: Audio connection got disconnected
bluetoothd[10791]: State changed
/org/bluez/10791/hci0/dev_00_16_44_FD_84_CB: HEADSET_STATE_PLAYING ->
HEADSET_STATE_CONNECTED
bluetoothd[10791]: ERR or HUP on RFCOMM socket
bluetoothd[10791]: telephony-ofono: device 0xb793c4d8 disconnected
bluetoothd[10791]: State changed
/org/bluez/10791/hci0/dev_00_16_44_FD_84_CB: HEADSET_STATE_CONNECTED
-> HEADSET_STATE_DISCONNECTED
bluetoothd[10791]: Unix client disconnected (fd=22)
bluetoothd[10791]: client_free(0xb79330d0)

'hcitool con' reported there was no connections after that, and the
headset was power off automatically. And of course I can't see this
headset by
'ilst-cards' or 'list-sinks' in pacmd.

Is it because there is anything broken in the latest BlueZ +
Pulseaudio, or am I doing something wrong?

Thanks,
Zhu Yanhai

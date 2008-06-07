Return-Path: <cyrus@holtmann.org>
Message-ID: <78f7ab620806070154h7ddbbec2o928fab039d3c6381@mail.gmail.com>
Date: Sat, 7 Jun 2008 10:54:29 +0200
From: "=?ISO-8859-1?Q?S=E9bastien_Barth=E9lemy?=" <barthelemy@crans.org>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] "SCO packet for unknown connection" trouble with
	Motorla H500 headset
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello,

I'm trying to use a  Motorola H500 headset (SCO) on an ubuntu hardy
heron computer with
 - bluez-utils version 3.26-0ubuntu6.
 - linux 2.6.24-18-generic
 - my dell latitude integrated bluetooth;

$ lsusb
Bus 001 Device 008: ID 413c:8103 Dell Computer Corp. Wireless 350 Bluetooth

I followed instructions there http://wiki.bluez.org/wiki/HOWTO/AudioDevices
$ cat ~/.asoundrc
pcm.bluetooth {
   type bluetooth
   device 00:19:1F:33:7E:58
}

Then I associate the headset and try it
mplayer -ao alsa:device=3Dbluetooth "/usr/share/example-content/ubuntu Sax.=
ogg"

However, it does not work (no sound), and syslog is flooded by
 thinbox kernel: [ 5830.621543] hci_scodata_packet: hci0 SCO packet
for unknown connection handle 46
messages

When I ctrl+c mplayer, I can hear a "biip"

Thus I have two problems
 - the headset is not working
 - syslog is flooded

What is the root of these problems ? What is their status ?

I read Jawya messages
http://sourceforge.net/mailarchive/message.php?msg_name=3Dalpine.LNX.1.00.0=
806021644270.9709%40nge2.ngu.pk
and I'm not sure this is fixed in new kernel/bluez versions, is it the
case ?

I'll try to keep https://bugs.launchpad.net/ubuntu/+bug/39414 up to date.

Best regards,

-- =

Sebastien




PS, in case it helps, my/var/log/syslog:

Jun  7 09:44:10 thinbox NetworkManager: <debug> [1212824650.290425]
nm_hal_device_added(): New device added (hal udi is
'/org/freedesktop/Hal/devices/bluetooth_acl_191f337e58').
Jun  7 09:44:10 thinbox hcid[5466]: link_key_request
(sba=3D00:16:41:91:54:6F, dba=3D00:19:1F:33:7E:58)
Jun  7 09:44:10 thinbox hcid[5466]: pin_code_request
(sba=3D00:16:41:91:54:6F, dba=3D00:19:1F:33:7E:58)
Jun  7 09:44:25 thinbox hcid[5466]: link_key_notify
(sba=3D00:16:41:91:54:6F, dba=3D00:19:1F:33:7E:58)
Jun  7 09:44:26 thinbox NetworkManager: <debug> [1212824666.400180]
nm_hal_device_removed(): Device removed (hal udi is
'/org/freedesktop/Hal/devices/bluetooth_acl_191f337e58').
Jun  7 09:44:26 thinbox NetworkManager: <debug> [1212824666.850472]
nm_hal_device_added(): New device added (hal udi is
'/org/freedesktop/Hal/devices/bluetooth_acl_191f337e58').
Jun  7 09:44:26 thinbox hcid[5466]: link_key_request
(sba=3D00:16:41:91:54:6F, dba=3D00:19:1F:33:7E:58)
Jun  7 09:44:27 thinbox audio[5474]: Requesting authorization for
device 00:19:1F:33:7E:58, UUID 00001112-0000-1000-8000-00805F9B34FB
Jun  7 09:44:27 thinbox audio[5474]: State changed
/org/bluez/audio/device0: HEADSET_STATE_DISCONNECTED ->
HEADSET_STATE_CONNECT_IN_PROGRESS
Jun  7 09:44:27 thinbox audio[5474]: State changed
/org/bluez/audio/device0: HEADSET_STATE_CONNECT_IN_PROGRESS ->
HEADSET_STATE_CONNECTED
Jun  7 09:44:27 thinbox audio[5474]: Accepted headset connection from
00:19:1F:33:7E:58 for /org/bluez/audio/device0
Jun  7 09:44:27 thinbox hcid[5466]: link_key_notify
(sba=3D00:16:41:91:54:6F, dba=3D00:19:1F:33:7E:58)
Jun  7 09:49:12 thinbox audio[5474]: Accepted new client connection on
unix socket (fd=3D10)
Jun  7 09:49:12 thinbox audio[5474]: Audio API: received BT_GETCAPABILITIES=
_REQ
Jun  7 09:49:12 thinbox audio[5474]: Audio API: sending BT_GETCAPABILITIES_=
RSP
Jun  7 09:49:12 thinbox audio[5474]: Audio API: received BT_SETCONFIGURATIO=
N_REQ
Jun  7 09:49:12 thinbox audio[5474]: config sco - device =3D
00:19:1F:33:7E:58 access_mode =3D 2
Jun  7 09:49:12 thinbox kernel: [ 5829.326791] Bluetooth: SCO (Voice
Link) ver 0.6
Jun  7 09:49:12 thinbox kernel: [ 5829.326799] Bluetooth: SCO socket
layer initialized
Jun  7 09:49:12 thinbox audio[5474]: State changed
/org/bluez/audio/device0: HEADSET_STATE_CONNECTED ->
HEADSET_STATE_PLAY_IN_PROGRESS
Jun  7 09:49:12 thinbox NetworkManager: <debug> [1212824952.681155]
nm_hal_device_added(): New device added (hal udi is
'/org/freedesktop/Hal/devices/bluetooth_acl_ffffffffffffffff').
Jun  7 09:49:13 thinbox kernel: [ 5830.621543] hci_scodata_packet:
hci0 SCO packet for unknown connection handle 46
Jun  7 09:49:13 thinbox kernel: [ 5830.621557] hci_scodata_packet:
hci0 SCO packet for unknown connection handle 46
Jun  7 09:49:13 thinbox kernel: [ 5830.621563] hci_scodata_packet:
hci0 SCO packet for unknown connection handle 46
J

-- =

S=E9bastien Barth=E9lemy

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

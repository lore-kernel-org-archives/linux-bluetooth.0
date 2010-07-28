Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4C505806.3040508@aircable.net>
References: <4C46324D.5070800@aircable.net>
	<20100721101934.GA12188@jh-x301>
	<4C470E2D.7000607@aircable.net>
	<AANLkTi=8=BUThjVdc4EN_8uupGKmdgHQzGOe560Cv+pm@mail.gmail.com>
	<AANLkTi=jzZScnCK6rFpKjBJesnw=71y5hNG3kDBhxv1u@mail.gmail.com>
	<4C505806.3040508@aircable.net>
Date: Wed, 28 Jul 2010 15:46:21 -0300
Message-ID: <AANLkTikRQfhAKm-UW+on+ZeEp709z_ku_NDjeVD_US1b@mail.gmail.com>
Subject: Re: [PATCH][RFC] Fix SDP resolving segfault
From: Manuel Naranjo <manuel@aircable.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Luiz,

Bad news it doesn't work, it keeps doing the same. This is the output
of bluetoothd -n -d:
bluetoothd[3572]: audio/manager.c:handle_uuid() server not enabled for
0000110a-0000-1000-8000-00805f9b34fb (0x110a)
bluetoothd[3572]: audio/manager.c:handle_uuid() Found AV Target
bluetoothd[3572]: audio/control.c:control_init() Registered interface
org.bluez.Control on path /org/bluez/3572/hci0/dev_00_24_91_E4_E9_05
bluetoothd[3572]: audio/manager.c:handle_uuid() Found AV Target
bluetoothd[3572]: src/device.c:btd_device_unref() 0x90f9e08: ref=2
bluetoothd[3572]: src/device.c:btd_device_ref() 0x90f9e08: ref=3
bluetoothd[3572]: src/device.c:search_cb()
/org/bluez/3572/hci0/dev_00_24_91_E4_E9_05: No service update
bluetoothd[3572]: src/device.c:btd_device_unref() 0x90f9e08: ref=2
bluetoothd[3572]: src/adapter.c:session_unref() 0x90b2790: ref=0
bluetoothd[3572]: src/adapter.c:session_remove() Discovery session
0x90b2790 with :1.81 deactivated
bluetoothd[3572]: src/adapter.c:session_remove() Stopping discovery
bluetoothd[3572]: Stopping discovery
bluetoothd[3572]: src/device.c:btd_device_ref() 0x90adfd0: ref=2
bluetoothd[3572]: Discovery session 0x90fe178 with :1.81 activated
bluetoothd[3572]: src/adapter.c:session_ref() 0x90fe178: ref=1
bluetoothd[3572]: src/adapter.c:adapter_remove_connection() Removing
temporary device /org/bluez/3572/hci0/dev_C8_7E_75_DC_1E_86
bluetoothd[3572]: src/device.c:device_remove() Removing device
/org/bluez/3572/hci0/dev_C8_7E_75_DC_1E_86
bluetoothd[3572]: src/device.c:btd_device_unref() 0x90fc080: ref=1
bluetoothd[3572]: src/device.c:btd_device_unref() 0x90fc080: ref=0
bluetoothd[3572]: src/device.c:device_free() 0x90fc080
bluetoothd[3572]: src/adapter.c:adapter_get_device() 00:05:4F:63:5A:E0
bluetoothd[3572]: src/adapter.c:session_unref() 0x90fe178: ref=0
bluetoothd[3572]: src/adapter.c:session_remove() Discovery session
0x90fe178 with :1.81 deactivated
bluetoothd[3572]: src/adapter.c:session_remove() Stopping discovery
bluetoothd[3572]: Stopping discovery
bluetoothd[3572]: Discovery session 0x90b1e00 with :1.81 activated
bluetoothd[3572]: src/adapter.c:session_ref() 0x90b1e00: ref=1
bluetoothd[3572]: <27>Jul 28 14:26:36 bluetoothd[3572]: : error
updating services: Host is down (112)


And this is the call trace during the crash:
	+  4 0x80ac636 (from 0x80a9a28)      device_remove_connection():
/home/manuel/bluez/src/device.c:908
	+  5 0x80ac4ca (from 0x80ac753)       device_set_connected():
/home/manuel/bluez/src/device.c:875
	+  6 0x80b0d08 (from 0x80ac517)        emit_property_changed():
/home/manuel/bluez/src/dbus-common.c:266
	+  7 0x80b0a31 (from 0x80b0da4)         append_variant():
/home/manuel/bluez/src/dbus-common.c:195
	+  7 0x805005d (from 0x80b0db6)         g_dbus_send_message():
/home/manuel/bluez/gdbus/object.c:615
	+  4 0x80ae60e (from 0x80a9a55)      device_get_address():
/home/manuel/bluez/src/device.c:1654
	+  5 0x80aa5a4 (from 0x80ae639)       bacpy():
/home/manuel/bluez/./lib/bluetooth/bluetooth.h:132
	+  4 0x808a77f (from 0x80a9a6d)      hci_req_queue_remove():
/home/manuel/bluez/src/security.c:169
	+  4 0x80affea (from 0x80a9a78)      device_is_authenticating():
/home/manuel/bluez/src/device.c:2339
	+  4 0x80ae749 (from 0x80a9a9a)      device_is_temporary():
/home/manuel/bluez/src/device.c:1683
	+  1 0x808a82f (from 0x808cdb4)   check_pending_hci_req():
/home/manuel/bluez/src/security.c:186
	+  0 0x8094781 (from 0x2cddab)  connect_cb(): /home/manuel/bluez/src/btio.c:138
	+  1 0x8094628 (from 0x80947be)   check_nval():
/home/manuel/bluez/src/btio.c:103
	+  1 0x8097b6e (from 0x8094849)   bt_io_error_quark():
/home/manuel/bluez/src/btio.c:1296
	+  1 0x8099523 (from 0x80948c1)   connect_watch():
/home/manuel/bluez/src/glib-helper.c:283
	+  2 0x80ae1c5 (from 0x809966f)    browse_cb():
/home/manuel/bluez/src/device.c:1540
	+  3 0x80adf2f (from 0x80ae312)     search_cb():
/home/manuel/bluez/src/device.c:1476
	+  4 0x8089ef6 (from 0x80adf90)      error(): /home/manuel/bluez/src/log.c:47


If you go through the code it fails in the line:
static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
{
	struct browse_req *req = user_data;
	struct btd_device *device = req->device;

	if (err < 0) {
		error("%s: error updating services: %s (%d)",
				device->path, strerror(-err), -err);
		goto send_reply;
	}


It fails because device->path is not valid.

My patch even though than ugly it worked. I know this is not the best
for upstream, but at least is something to start with. For some reason
either user_data or device is invalid when that callback gets.

Manuel

-- 
Manuel Francisco Naranjo
Software Department Argentina
Wireless Cables Inc
www.aircable.net
cel: +5493412010019
skype: naranjomanuelfrancisco

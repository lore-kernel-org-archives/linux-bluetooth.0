Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Date: Wed, 29 Jun 2016 08:59:28 +0200
Message-ID: <CAEZxfGPM1-3+4CP5zeNT7yEkp+8BNeaq6oFBroPX2YLdKpy3DA@mail.gmail.com>
Subject: LE ControllerMode fails with Google Chrome
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When setting "ControllerMode = le" in /etc/bluetooth/main.conf file,
starting a dual scan from Google Chrome fails as you can see below.

Run ./chrome --enable-web-bluetooth
Go to https://googlechrome.github.io/samples/web-bluetooth/automatic-reconnect.html
Click "Scan button"
Bluetooth chooser should show nearby Bluetooth devices. Sadly it only
returns the ones in cache.with "ControllerMode = dual"

According to logs below, it looks like the scan stopped immediately.
For info, it works great

// Click Scan Web button
bluetoothd[26766]: src/adapter.c:set_discovery_filter() sender :1.11
bluetoothd[26766]: src/adapter.c:parse_discovery_filter_dict()
filtered discovery params: transport: 7 rssi: 32767 pathloss: 32767
bluetoothd[26766]: src/adapter.c:set_discovery_filter() successfully
pre-set filter
bluetoothd[26766]: src/adapter.c:start_discovery() sender :1.11
bluetoothd[26766]: src/adapter.c:update_discovery_filter()
bluetoothd[26766]: src/adapter.c:discovery_filter_to_mgmt_cp()
bluetoothd[26766]: src/adapter.c:trigger_start_discovery()
bluetoothd[26766]: src/adapter.c:cancel_passive_scanning()
bluetoothd[26766]: src/adapter.c:start_discovery_timeout()
bluetoothd[26766]: src/adapter.c:start_discovery_timeout()
adapter->current_discovery_filter == 1
bluetoothd[26766]: src/adapter.c:start_discovery_timeout() sending
MGMT_OP_START_SERVICE_DISCOVERY 127, 7, 0
bluetoothd[26766]: src/adapter.c:start_discovery_complete() status 0x0b
bluetoothd[26766]: src/adapter.c:trigger_start_discovery()
bluetoothd[26766]: src/adapter.c:cancel_passive_scanning()

// Click "Cancel" button from Chrome Bluetooth chooser
bluetoothd[26766]: src/adapter.c:stop_discovery() sender :1.11
bluetoothd[26766]: src/adapter.c:discovery_destroy() owner :1.11
bluetoothd[26766]: src/adapter.c:trigger_passive_scanning()

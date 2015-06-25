Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 25 Jun 2015 16:53:19 -0500
Message-ID: <CABKPALpbGG8vXj+10MuG97wZaHoDJBhj5MtrKjfJQhQ_xbpp1Q@mail.gmail.com>
Subject: Another PropertiesChanged observation
From: Neil Martin <neil@vnp.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I've noticed that the bluetoothd console output shows a steady stream
of RSSI updates, yet only a fraction of these seem to translate into a
DBus PropertiesChanged signal.

I've just seen 50 or so messages from bluetoothd of the form:

bluetoothd[3867]: src/adapter.c:device_found_callback() hci0 addr
D0:4F:7E:2B:74:31, rssi -91 flags 0x0000 eir_len 15

while only seeing a single PropertiesChanged signal from dbus-monitor
with an RSSI update.

Neil

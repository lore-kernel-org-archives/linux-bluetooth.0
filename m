Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Alfonso Acosta <alfonso.acosta@gmail.com>
Date: Fri, 5 Jan 2018 20:41:11 +0100
Message-ID: <CAFmMashE1ReOhQFe9OD2BrXooNGz_Gxa9gHLYfB+BgHLQsT5HA@mail.gmail.com>
Subject: Overhead reduction in LE connection establishment
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi there,

TL;DR: I have observed that BlueZ does some operations which incur in
extra latency when connecting to a bonded peripheral. I would like to
know if it's possible to remove those operations through configuration
or, if maintainers are open for it, provide some patches to remove
them.

I have a BLE peripheral with a button. The button state (key pressed /
key released) is associated to a custom characteristic (i.e. it's not
HID). The state is conveyed through ATT notifications to a central
running BlueZ (5.47, using dbus gatt api) with which it=E2=80=99s bonded.

In order to save battery, the peripheral is normally disconnected and
only starts advertising when the key is pressed. The central is always
attempting to connect. Once the connection is established, the
key-press in conveyed to the central as a notification (the central
calls StartNotify() as soon as a connection is established).

For the application=E2=80=99s purpose, it=E2=80=99s critical that the notif=
ication is
recieved with the minimum latency.

However, between the connection establishment and the notification, I
see that BlueZ does some operations which incur in extra latency.

To guide the conversation, here is a btmon dump showing what happens
in the central right after a connection is established with the
peripheral: https://pastebin.com/tQMgwK7v

My goal is to minimize the time between #6 and #18

At #7 there is an MTU exchange request, which, for this particular
peripheral is not really necessary since I know it only supports 23
bytes. Is there a way to disable that? After reading the gatt client
initialization code, it seems that no exchange is attempted if the MTU
of the central is also 23 bytes, but I don=E2=80=99t know if the default MT=
U
is configurable. Is it?

At #9 and #12 there are reads for the device name and device
appearance. I have managed to disable those by lanching bluetoothd
with --noplugin=3Ddeviceinfo,gap . So, it's not an issue anymore.

At #14 there is an ATT write to the CCC descriptor of the
button-status attribute, in order to enable notifications (maybe as a
consequence of invoking StartNotify() in the central). But, why is
this needed for a bonded peripheral? If I interpret the standard
properly, CCC descriptor values should be cached and restored across
connections among bonded devices (section "3.3.3.3 Client
Characteristic Configuration" "The Client Characteristic Configuration
descriptor value shall be persistent across connections for bonded
devices."). I, however, can't find a ccc file in the peripheral cache,
as described here
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/settings-storag=
e.txt?h=3D5.47#n46
.

At #17 the central starts discovering the primary services. Why is
this necessary? Shouldn=E2=80=99t they be simply recovered from the cache?
(According to the standard "For clients that have a trusted
relationship (i.e. bond) with the server, the attribute cache is valid
across connections."). I have verified that the cache already
contained all the primary services. However, after looking at the code
(shared/gatt-client.c ) it seems primary service discovery
(bt_gatt_discover_all_primary_services()) is always invoked :S

Finally, at #18, I get the notification from the peripheral.

 I am happy to try to provide some patches if we agree that at least
some of these operations are not necessary and there is no way to
disable them through configuration.

Thanks in advance,

Alfonso Acosta

Return-Path: <cyrus@holtmann.org>
Date: Fri, 20 Feb 2009 20:00:25 +0530 (IST)
From: pavan_savoy@indiatimes.com
To: linux-bluetooth@vger.kernel.org
Message-ID: <329084811.343481235140225987.JavaMail.root@mbv7.indiatimes.com>
Subject: bluetooth send to error - dbus - obex data server
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am unable to send files over bluetooth with my obex data server & bluetooth send to applet,
following is the error message & dbus monitor message, I doubt it could have something to do with DBUS...

Please suggest....

bluetooth-sendto
Xlib:  extension "Generic Event Extension" missing on display ":0.0".
Xlib:  extension "Generic Event Extension" missing on display ":0.0".
Xlib:  extension "Generic Event Extension" missing on display ":0.0".

(bluetooth-sendto:1098): GLib-GObject-CRITICAL **: g_cclosure_new: assertion `ca
llback_func != NULL' failed

(bluetooth-sendto:1098): GLib-GObject-CRITICAL **: g_cclosure_new: assertion `ca
llback_func != NULL' failed
signal sender=org.freedesktop.DBus -> dest=(null destination) path=/org/freedesk
top/DBus; interface=org.freedesktop.DBus; member=NameOwnerChanged
   string ":1.17"
   string ""
   string ":1.17"
signal sender=:1.12 -> dest=(null destination) path=/org/bluez/hci0; interface=o
rg.bluez.Adapter; member=DiscoveryStarted

(bluetooth-sendto:1098): Gtk-WARNING **: could not load image: Icon 'stock_cell-
phone' not present in theme


(bluetooth-sendto:1098): Gtk-WARNING **: could not load image: Icon 'stock_cell-
phone' not present in theme

signal sender=:1.12 -> dest=(null destination) path=/org/bluez/hci0; interface=o
rg.bluez.Adapter; member=RemoteDeviceFound
   string "00:1E:45:A8:48:AF"
   uint32 5898756
   int16 0
signal sender=:1.12 -> dest=(null destination) path=/org/bluez/hci0; interface=o
rg.bluez.Adapter; member=RemoteNameUpdated
   string "00:1E:45:A8:48:AF"
   string "SE"

(bluetooth-sendto:1098): Gtk-WARNING **: could not load image: Icon 'stock_cell-
phone' not present in theme


(bluetooth-sendto:1098): Gtk-WARNING **: could not load image: Icon 'stock_cell-
phone' not present in theme


(bluetooth-sendto:1098): Gtk-WARNING **: could not load image: Icon 'stock_cell-
phone' not present in theme

signal sender=:1.12 -> dest=(null destination) path=/org/bluez/hci0; interface=o
rg.bluez.Adapter; member=DiscoveryCompleted
signal sender=org.freedesktop.DBus -> dest=(null destination) path=/org/freedesk
top/DBus; interface=org.freedesktop.DBus; member=NameOwnerChanged
   string ":1.18"
   string ""
   string ":1.18"
signal sender=:1.12 -> dest=(null destination) path=/org/bluez/hci0; interface=o
rg.bluez.Adapter; member=RemoteDeviceConnected
   string "00:1E:45:A8:48:AF"
signal sender=:1.12 -> dest=(null destination) path=/org/bluez/hci0; interface=o
rg.bluez.Adapter; member=RemoteNameUpdated
   string "00:1E:45:A8:48:AF"
   string "SE"
FIlename = /dspbridge/cexec.outBasename = cexec.out
text = Sending cexec.out
signal sender=org.freedesktop.DBus -> dest=(null destination) path=/org/freedesk
top/DBus; interface=org.freedesktop.DBus; member=NameOwnerChanged
   string ":1.18"
   string ":1.18"
   string ""
Sending of file /dspbridge/cexec.out failed: Message did not receive a reply (ti
meout by message bus)
signal sender=org.freedesktop.DBus -> dest=(null destination) path=/org/freedesk
top/DBus; interface=org.freedesktop.DBus; member=NameOwnerChanged
   string ":1.17"
   string ":1.17"
   string ""
root@omap-3430sdp:~# signal sender=:1.12 -> dest=(null destination) path=/org/bl
uez/hci0; interface=org.bluez.Adapter; member=RemoteDeviceDisconnected
   string "00:1E:45:A8:48:AF"


--
Check out the Mahindra Xylo inside out with reviews, pictures, video and more.Exclusively on ZigWheels.com
http://www.zigwheels.com/b2cam/mahindra-xylo.html

Return-Path: <cyrus@holtmann.org>
Message-ID: <00f801c899a1$946db020$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Cc: "Marcel Holtmann" <marcel@holtmann.org>
References: <00bd01c89901$26af9f80$6701a8c0@freqonedev> <2B4A186F-49DD-4131-ABB7-46E79D1A9DE8@holtmann.org>
Subject: Re: [Bluez-devel] UPDATE: org.bluez.Adapter Methods/Signals
Date: Tue, 8 Apr 2008 12:54:21 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-ID: <bluez-devel.lists.sourceforge.net>

To be clear, I have registered the RemoteDeviceFound and RemoteNameUpdated signals against both "/org/bluez/hci0" AND "/hci0" (both 
with "org.bluez.Adapter" interface).  Signals for these signals always come back against "/org/bluez/hci0", and NOT against "/hci0" 
(path retrieved with dbus_g_proxy_get_path).

DS
----- Original Message ----- 
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Sent: Monday, April 07, 2008 5:58 PM
Subject: Re: [Bluez-devel] UPDATE: org.bluez.Adapter Methods/Signals


Hi David,

> After installing *-3.30, when calling DiscoverDevices, with path "/
> hci0", RemoteDeviceFound and RemoteNameUpdated are STILL returned
> against path "/org/bluez/hci0", and not the originating path, "/hci0".

that is fine. On /hci0 you should see DeviceFound signals.

Regards

Marcel

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 11 Sep 2018 10:45:20 -0700
From: Mike Ryan <mikeryan@lacklustre.net>
To: linux-bluetooth@vger.kernel.org
Subject: Automatically connect via DBUS Device API
Message-ID: <20180911174520.g6mw2low6tcm7cvx@lacklustre.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It would be useful to have a way to automatically connect to previously
discovered devices via the DBUS Device API.

Current use case: I have BLE devices that become discoverable once they
have a measurement available. Upon connecting, the measurement is
notified/indicated and then the connection drops. Some of the devices
with this behavior support/require pairing, and some do not support
pairing/encryption.

At present, the only options are to manually connect via DBUS or set the
device to auto connect via the management API (using Add Device with
Action set to 2). Since management is root-only, it would be useful to
move this into DBUS.

Possible workflow:

 1. Discover devices as usual using StartDiscovery() on the adapter
 2. Pair (if necessary)
 3. Set new property AutoConnect = true
 4. bluetoothd scans in background, connects when device becomes
    available

One concern: a binary AutoConnect may not be sufficient considering the
management API has three defined actions: background scan (generates an
event, could be handled via a new Connectable property that generates a
ProptertiesChanged event), allow incoming connection (connects on
directed advertising), and auto-connect (connects even on indirect
advertising).

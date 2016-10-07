Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Reply-To: aaron.hamilton@atlaslabs.io
From: Aaron Hamilton <aaron.hamilton@atlaslabs.io>
Date: Thu, 6 Oct 2016 19:10:13 -0700
Message-ID: <CAFjWW+aPVE4EMbsgem4MesotaXugE+=v5oYvLtT7n9KV5EQwpQ@mail.gmail.com>
Subject: Auto-Add Serial Port Profile?
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm looking for direction on the best way of automatically adding a
serial port profile when bluetoothd starts up (from any peer/device,
not a specified one). Currently I'm having to do the following:

1. launch bluetoothd via OpenWrt procd script with "bluetoothd -d -n -C"
2. Execute "sdptool add --channel=2 SP". This is problematic in that
it must be executed again if bluetoothd or the adapter is restarted,
or it fails if run before bluetoothd is up.
3. Start rfcomm listener/watch: "rfcomm watch /dev/rfcomm0 2
launcher.sh -c /dev/rfcomm0" (this is a custom process for accepting
files from any client that connects).

I'm open to suggestion for a more reliable method if there is one.
Otherwise, I'd like to eliminate the need for executing the "sdptool
add ..." command since this is creating reliability issues. I
initially tried creating a profile based off bluez5.42 SAP, but it
locks up my machine when a peer tries to pair.

Ultimately, I need a robust method for allowing legacy devices to pair
with the adapter and transfer files. The adapter is a server, so it
accepts connections from any device that pairs successfully.

Also, I don't have control over the other end, so all I can do is open
up the RFCOMM port and accept files over it.

Thanks in advance for any assistance.

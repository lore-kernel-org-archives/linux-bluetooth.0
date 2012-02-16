Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Feb 2012 16:59:02 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
To: Marcel Holtmann <marcel@holtmann.org>, "Gustavo F. Padovan"
 <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: No scan results when using internal laptop USB
Message-ID: <20120215165902.29c0427d@s6510.linuxnetplumber.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

Tried to use Bluetooth on Fujisu S6510 without success.
It can't see any of the devices in the office.
The software is Debian Wheezy.
Any idea where to start looking.


# uname -r
3.2.0-1-amd64
# lsusb | grep Blue
Bus 003 Device 002: ID 0c24:000f Taiyo Yuden Bluetooth Device (V2.0+EDR)
# grep blue /var/log/syslog | tail
Feb 15 16:53:07 s6510 bluetoothd[3585]: Failed to init proximity plugin
Feb 15 16:53:07 s6510 bluetoothd[3585]: Failed to init gatt_example plugin
Feb 15 16:53:07 s6510 NetworkManager[1661]: <warn> bluez error getting default adapter: No such adapter
Feb 15 16:53:07 s6510 dbus[1652]: [system] Activating service name='org.blueman.Mechanism' (using servicehelper)
Feb 15 16:53:07 s6510 bluetoothd[3585]: Listening for HCI events on hci0
Feb 15 16:53:07 s6510 blueman-mechanism: Starting blueman-mechanism 
Feb 15 16:53:07 s6510 dbus[1652]: [system] Successfully activated service 'org.blueman.Mechanism'
Feb 15 16:53:07 s6510 bluetoothd[3585]: HCI dev 0 up
Feb 15 16:53:07 s6510 bluetoothd[3585]: Adapter /org/bluez/3585/hci0 has been enabled
Feb 15 16:53:37 s6510 blueman-mechanism: Exiting 
# hcitool scan
Scanning ...
# hcitool dev
Devices:
	hci0	00:03:7A:BC:AA:B7

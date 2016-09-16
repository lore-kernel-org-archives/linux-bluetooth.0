Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Wilson <griscruf@comcast.net>
Content-Type: text/plain; charset=us-ascii
Subject: Android 7.0 not discovering LE services
Message-Id: <6874A094-FC92-47DD-B624-3CADAE801D27@comcast.net>
Date: Fri, 16 Sep 2016 07:02:38 -0400
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello, I have found a problem using Android 7.0 to connect to a bluez =
device over BLE.  Android 6.0.1 is working.  Android 7 definitely =
changed some things, but it is working with other (embedded) stacks like =
Wicentric and Searan.  I first found the problem on bluez 5.37 and linux =
3.14, but I still see it on bluez 5.41 and linux 4.4.0 (Ubuntu 16.04 on =
a Mac mini).  I also tried the latest bluez in git.=20

I'm running nRF Connect on the Android devices.  I captured (latest) =
bluetoothd and btmon logs for both cases:

Android6 bluetoothd: https://paste.gnome.org/pfkliqrqw
Android6 btmon:        https://paste.gnome.org/pcyxvla79

Android7 bluetoothd: https://paste.gnome.org/pk4qj6wp8
Android7 btmon:        https://paste.gnome.org/p5e4fgoua

Using Android 6 I'm able to connect and "Refresh device cache" as much =
as I want and then disconnect.  All the logs are shown clean in =
bluetoothd and nRF Connect is fast.  However, using Android 7, I'm only =
able to connect and the cached services come up.  If I refresh services, =
bluetoothd logs show them read:

	bluetoothd[2346]: src/device.c:gatt_debug() Read By Type - =
start: 0x0001 end: 0x0005
	bluetoothd[2346]: src/device.c:gatt_debug() Read By Type - =
start: 0x0001 end: 0x0005
	bluetoothd[2346]: src/device.c:gatt_debug() Read By Type - =
start: 0x0005 end: 0x0005
	bluetoothd[2346]: src/device.c:gatt_debug() Read By Type - =
start: 0x0006 end: 0x0009
	bluetoothd[2346]: src/device.c:gatt_debug() Read By Type - =
start: 0x0006 end: 0x0009
	bluetoothd[2346]: src/device.c:gatt_debug() Read By Type - =
start: 0x0008 end: 0x0009
	bluetoothd[2346]: src/device.c:gatt_debug() Find Info - start: =
0x0009 end: 0x0009

but then nRF Connect is hung spinning.  Disconnect does nothing.  There =
are some differences in the logs but one major thing of note is at the =
end of the initial connection by Android 7 there is this:

	src/gatt-database.c:gatt_ccc_write_cb() CCC write called for =
handle: 0x0009

Is this a problem?

Is a problem like this likely a bluetoothd problem or something in the =
linux driver?

One thing I've noticed in OTA captures is that bluez, which is the =
slave, is requesting services from the master.  In my application I do =
not have the need for this.  It might help (might not) if I could =
disable this, and it would make the capture more clear.  Is it possible =
to disable this?

Thanks, Wilson=

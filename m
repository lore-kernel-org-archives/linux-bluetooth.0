Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 19 Mar 2012 17:19:34 -0500
Message-ID: <CAB7rCTg4YLsE7uNbR8mRH_cubtMmBnTZUnJ3U4vL_AsyjA7xzA@mail.gmail.com>
Subject: reverse SDP issue
From: Mike <puffy.taco@gmail.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I notice a change in commit d2920be715974795b51f9cc3279947104da3647b
[1] that changes the "reverse" variable for an SDP query:

 -       device_browse_sdp(device, NULL, NULL, NULL, TRUE);
+       if (device_is_bredr(device))
+               device_browse_sdp(device, NULL, NULL, NULL, FALSE);
+       else
+               device_browse_primary(device, NULL, NULL, FALSE);

You can see the original had reverse as TRUE, but the patch may have
inadvertently changed it to FALSE.  The only reason I notice this is
that for some reason I get a debug output that BlueZ is removing
"0000110d-0000-1000-8000-00805f9b34fb" (ADVANCED_AUDIO_UUID) which
then knocks out my HFP and A2DP profiles.

bluetoothd[766]: src/device.c:device_remove_drivers() UUID
0000110d-0000-1000-8000-00805f9b34fb was removed from device
00:17:E3:3B:4F:DD
bluetoothd[766]: audio/unix.c:unix_device_removed()
unix_device_removed(0x2a0d0358)
bluetoothd[766]: audio/gateway.c:path_unregister() Unregistered
interface org.bluez.HandsfreeGateway on path
/org/bluez/766/hci0/dev_00_17_E3_3B_4F_DD
bluetoothd[766]: audio/source.c:path_unregister() Unregistered
interface org.bluez.AudioSource on path
/org/bluez/766/hci0/dev_00_17_E3_3B_4F_DD

There may be another subtle bug that is the real culprit here (e.g.,
why does removing 0x110d knock out the other profiles), but I thought
I'd check on this first.

Mike

[1] http://git.kernel.org/?p=bluetooth/bluez.git;a=commitdiff;h=d2920be715974795b51f9cc3279947104da3647b

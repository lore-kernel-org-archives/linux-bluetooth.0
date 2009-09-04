Return-Path: <cyrus@holtmann.org>
Message-ID: <4AA08357.7050903@charter.net>
Date: Thu, 03 Sep 2009 23:02:47 -0400
From: Peter Hurley <phurley@charter.net>
MIME-Version: 1.0
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: [4.48] SDP Discovery not reset on error
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I believe that SDP Discovery initiated during rfcomm_connect is left in 
an inconsistent state when there is an error (such as when the remote 
device is off).

In the log capture below, an attempt to connect (via 
gnome-bluetooth/bluetooth-applet) to the headset fails because the 
device is off.  When the device is turned back on, and another attempt 
is made to connect, SDP discovery fails again (Operation already in 
progress).

> Sep  3 21:21:52 dev-wkstn bluetoothd[2724]: State changed /org/bluez/2724/hci0/dev_00_0D_FD_1E_99_30: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
> Sep  3 21:21:57 dev-wkstn bluetoothd[2724]: adapter_get_device(00:0D:FD:1E:99:30)
> Sep  3 21:21:57 dev-wkstn bluetoothd[2724]: Unable to get service record: Host is down (112)
> Sep  3 21:21:57 dev-wkstn bluetoothd[2724]: telephony-dummy: device 0x7f71751e8230 disconnected
> Sep  3 21:21:57 dev-wkstn bluetoothd[2724]: State changed /org/bluez/2724/hci0/dev_00_0D_FD_1E_99_30: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
> Sep  3 21:23:00 dev-wkstn bluetoothd[2724]: State changed /org/bluez/2724/hci0/dev_00_0D_FD_1E_99_30: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
> Sep  3 21:23:00 dev-wkstn bluetoothd[2724]: Unable to get service record: Operation already in progress (114)
> Sep  3 21:23:00 dev-wkstn bluetoothd[2724]: telephony-dummy: device 0x7f71751e8230 disconnected
> Sep  3 21:23:00 dev-wkstn bluetoothd[2724]: State changed /org/bluez/2724/hci0/dev_00_0D_FD_1E_99_30: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED

Initially I was thinking that bt_cancel_discovery() needed to be called 
or that cleanup in one of the failed: targets in the series of functions 
and callbacks in common/glib_helper.c was the problem, but after a quick 
scan perhaps the problem lies on the SDP server side? Suggestions?

Regards,
Peter Hurley

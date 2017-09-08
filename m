Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1504857308.4780.12.camel@hadess.net>
Subject: Headset fails to reconnect input 1st connection after pairing
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Fri, 08 Sep 2017 09:55:08 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey,

I'm trying to connect an old Bluetooth headset to my desktop machine,
and it only manages to connect and create the input device to proxy
button presses when I first connect to the device, after pairing with
it.

The device is a Sony DR-BT21G (yes, ancient enough that behind the neck
headphones were still in fashion), the adapter is an Intel something
something (USB 8087:0a2b, lsusb just says "Intel Corp."), kernel is the
just released 4.13, bluez is git master (plus my battery patches).

This is the init for the adapter:
[    3.538272] Bluetooth: hci0: Bootloader revision 0.0 build 2 week 52 2014
[    3.543278] Bluetooth: hci0: Device revision is 5
[    3.543279] Bluetooth: hci0: Secure boot is enabled
[    3.543280] Bluetooth: hci0: OTP lock is enabled
[    3.543280] Bluetooth: hci0: API lock is enabled
[    3.543281] Bluetooth: hci0: Debug lock is disabled
[    3.543282] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[    3.547512] Bluetooth: hci0: Found device firmware: intel/ibt-11-5.sfi

Info about the device:
[bluetooth]# info 00:13:A9:B2:06:2C
Device 00:13:A9:B2:06:2C
	Name: DR-BT21G
	Alias: DR-BT21G
	Class: 0x240408
	Icon: audio-card
	Paired: yes
	Trusted: yes
	Blocked: no
	Connected: no
	LegacyPairing: yes
	UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb)
	UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
	UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
	UUID: Handsfree                 (0000111e-0000-1000-8000-00805f9b34fb)

This is the journal when trying to connect a second time. I don't know
what handle 0 is supposed to be but I'm guessing it's pretty important
because I haven't been able to get any sound out of the device
(PulseAudio is also the just released 11.0, but that's another
problem).

When pairing I don't see the error about handle 257, and the input
proxy is created. When it fails, it isn't.

Sep 08 09:22:58 classic bluetoothd[5568]: src/adapter.c:connected_callback() hci0 device 00:13:A9:B2:06:2C connected eir_len 15
Sep 08 09:22:59 classic bluetoothd[5568]: src/profile.c:ext_confirm() incoming connect from 00:13:A9:B2:06:2C
Sep 08 09:22:59 classic bluetoothd[5568]: src/service.c:btd_service_ref() 0x55739708fad0: ref=3
Sep 08 09:22:59 classic audit[677]: AVC avc:  denied  { read write } for  pid=677 comm="dbus-daemon" path="socket:[80302]" dev="sockfs" ino=80302 scontext=system_u:system_r:system_dbusd_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=socket permissive=1
Sep 08 09:22:59 classic bluetoothd[5568]: src/profile.c:ext_confirm() Headset Voice gateway authorizing connection from 00:13:A9:B2:06:2C
Sep 08 09:22:59 classic bluetoothd[5568]: src/profile.c:ext_auth() 00:13:A9:B2:06:2C authorized to connect to Headset Voice gateway
Sep 08 09:22:59 classic bluetoothd[5568]: src/profile.c:ext_connect() Headset Voice gateway connected to 00:13:A9:B2:06:2C
Sep 08 09:22:59 classic bluetoothd[5568]: src/service.c:change_state() 0x55739708fad0: device 00:13:A9:B2:06:2C profile Headset Voice gateway state changed: disconnected -> connecting (0)
Sep 08 09:22:59 classic bluetoothd[5568]: src/service.c:change_state() 0x55739708fad0: device 00:13:A9:B2:06:2C profile Headset Voice gateway state changed: connecting -> connected (0)
Sep 08 09:22:59 classic bluetoothd[5568]: src/device.c:device_profile_connected() Headset Voice gateway Success (0)
Sep 08 09:22:59 classic bluetoothd[5568]: plugins/policy.c:service_cb() Added Headset Voice gateway reconnect 0
Sep 08 09:23:02 classic dbus-daemon[677]: [system] Activating service name='org.fedoraproject.Setroubleshootd' requested by ':1.44' (uid=0 pid=643 comm="/usr/sbin/sedispatch " label="system_u:system_r:audisp_t:s0") (using servicehelper)
Sep 08 09:23:02 classic rtkit-daemon[770]: Supervising 11 threads of 2 processes of 2 users.
Sep 08 09:23:02 classic kernel: Bluetooth: hci0 SCO packet for unknown connection handle 0
Sep 08 09:23:02 classic kernel: Bluetooth: hci0 SCO packet for unknown connection handle 0
Sep 08 09:23:02 classic kernel: Bluetooth: hci0 SCO packet for unknown connection handle 0
Sep 08 09:23:02 classic rtkit-daemon[770]: Successfully made thread 5631 of process 1592 (/usr/bin/pulseaudio) owned by '1000' RT at priority 5.
Sep 08 09:23:02 classic rtkit-daemon[770]: Supervising 12 threads of 2 processes of 2 users.
Sep 08 09:23:02 classic gsd-media-keys[1949]: Unable to get default source
Sep 08 09:23:02 classic dbus-daemon[677]: [system] Successfully activated service 'org.fedoraproject.Setroubleshootd'
Sep 08 09:23:03 classic setroubleshoot[5630]: SELinux is preventing dbus-daemon from 'read, write' accesses on the socket socket. For complete SELinux messages run: sealert -l 8a93b723-af8b-4e45-b2c6-2cca6c4fa51e
Sep 08 09:23:03 classic python3[5630]: SELinux is preventing dbus-daemon from 'read, write' accesses on the socket socket.
                                       
                                       *****  Plugin catchall (100. confidence) suggests   **************************
                                       
                                       If you believe that dbus-daemon should be allowed read write access on the socket socket by default.
                                       Then you should report this as a bug.
                                       You can generate a local policy module to allow this access.
                                       Do
                                       allow this access for now by executing:
                                       # ausearch -c 'dbus-daemon' --raw | audit2allow -M my-dbusdaemon
                                       # semodule -X 300 -i my-dbusdaemon.pp
                                       
Sep 08 09:23:07 classic kernel: Bluetooth: hci0 SCO packet for unknown connection handle 257

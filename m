Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrea <mariofutire@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: partial success with PS3 sixaxis
Date: Fri, 28 Feb 2014 11:47:27 +0100
Message-ID: <4617658.ClQmBLQ0NT@uw000953>
In-Reply-To: <52FF593F.30007@gmail.com>
References: <52FBE820.6050701@gmail.com> <2534491.XllyezJg3g@uw000953> <52FF593F.30007@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrea,

On Saturday 15 of February 2014 12:10:39 Andrea wrote:
> On 13/02/14 09:25, Szymon Janc wrote:
> > Hi Andrea,
> > 
> 
> > This should "just work". Since 5.14 there is authorization needed when DS3 is
> > connecting (device is not marked as trusted when connected on USB) so please
> > make sure you have default agent registered.
> > 
> > I assume you are using bluetoothctl so do:
> > agent on
> > default-agent
> > 
> > Then you should get authorization request in bluetoothctl when DS3 is connecting.
> > 
> 
> I think the problem is not authorisation (I do not get such a request, by I did use the trust
> command, so maybe it is not necessary any more). It gets connected, it creates /dev/input/js0 but it
> deletes it shortly after.
> 
> I run bluetoothd in debug mode and this is what it prints
> 
> bluetoothd[13678]: src/adapter.c:connected_callback() hci0 device 00:1B:FB:63:F2:64 connected eir_len 5
> bluetoothd[13678]: profiles/input/server.c:connect_event_cb() Incoming connection from
> 00:1B:FB:63:F2:64 on PSM 17
> bluetoothd[13678]: profiles/input/device.c:input_device_set_channel() idev 0x1dec160 psm 17
> bluetoothd[13678]: profiles/input/server.c:confirm_event_cb()
> bluetoothd[13678]: profiles/input/server.c:connect_event_cb() Incoming connection from
> 00:1B:FB:63:F2:64 on PSM 19
> bluetoothd[13678]: profiles/input/device.c:input_device_set_channel() idev 0x1dec160 psm 19
> bluetoothd[13678]: src/service.c:change_state() 0x1deb1c0: device 00:1B:FB:63:F2:64 profile
> input-hid state changed: disconnected -> connected (0)
> bluetoothd[13678]: sixaxis: compatible device connected: PLAYSTATION(R)3 Controller (054C:0268)
> 
> < ===================================== here I disconnect manually, as /dev/input/js0 has already
> been deleted>
> 
> bluetoothd[13678]: src/service.c:change_state() 0x1deb1c0: device 00:1B:FB:63:F2:64 profile
> input-hid state changed: connected -> disconnecting (0)
> bluetoothd[13678]: profiles/input/device.c:input_device_disconnect()
> bluetoothd[13678]: Input: disconnect /org/bluez/hci0/dev_00_1B_FB_63_F2_64
> bluetoothd[13678]: profiles/input/device.c:ctrl_watch_cb() Device 00:1B:FB:63:F2:64 disconnected
> bluetoothd[13678]: profiles/input/device.c:intr_watch_cb() Device 00:1B:FB:63:F2:64 disconnected
> bluetoothd[13678]: src/service.c:change_state() 0x1deb1c0: device 00:1B:FB:63:F2:64 profile
> input-hid state changed: disconnecting -> disconnected (0)
> bluetoothd[13678]: profiles/input/device.c:input_device_enter_reconnect_mode()
> path=/org/bluez/hci0/dev_00_1B_FB_63_F2_64 reconnect_mode=device
> bluetoothd[13678]: src/adapter.c:dev_disconnected() Device 00:1B:FB:63:F2:64 disconnected, reason 2
> bluetoothd[13678]: src/adapter.c:adapter_remove_connection()
> bluetoothd[13678]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr 00:1B:FB:63:F2:64 type 0
> status 0xe
> bluetoothd[13678]: src/device.c:device_bonding_complete() bonding (nil) status 0x0e
> bluetoothd[13678]: src/device.c:device_bonding_failed() status 14
> bluetoothd[13678]: src/adapter.c:resume_discovery()
> 
> Halfway through I disconnected the controller with
> 
> disconnect XX:XX:XX:XX:XX in bluetoothtcl
> 
> at the same time in the kernel log I can see
> 
> Feb 15 12:08:29 alarmpi kernel: sony 0005:054C:0268.0010: Fixing up Sony Sixaxis report descriptor
> Feb 15 12:08:29 alarmpi kernel: sony 0005:054C:0268.0010: unknown main item tag 0x0
> Feb 15 12:08:29 alarmpi kernel: input: PLAYSTATION(R)3 Controller as
> /devices/platform/bcm2708_usb/usb1/1-1/1-1.3/1-1.3.1/1-1.3.1:1.0/blu
> Feb 15 12:08:29 alarmpi kernel: sony 0005:054C:0268.0010: input,hidraw0: BLUETOOTH HID v1.00
> Joystick [PLAYSTATION(R)3 Controller] on 00:
> Feb 15 12:08:39 alarmpi kernel: sony: probe of 0005:054C:0268.0010 failed with error -5
> 
> which mention some issues with descriptor, tag and probe.

Failing probe is a problem here. Do you use same dongle on RaspPi as on Fedora?
I've seen that DS3 is not playing well with some controllers i.e. it doesn't work
with one on my CSR 2.0 USB dongle.

> I am not too familiar with whom is responsible for /dev/input/js0? kernel? bluez? the sixaxis plugin?

Kernel. sixaxis plugin is used only to associate DS3 with host controller (and to set LEDs).

> Since this controller always works with the alternative sixad daemon, can I log the traffic and
> compare it? or maybe post it here so some of you guys can help me?

Yeap, btmon logs could give us some more info what is going on.

-- 
Best regards, 
Szymon Janc

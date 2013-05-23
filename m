Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAGd9gwiBE8sf4tnnyrCFemFiDOH_WaLdRzHKJkyf7ORd+AeBDg@mail.gmail.com>
References: <CAGd9gwgFnuqiYMkYgb=2Ssh8ScoR45H=PZWG-BOXb8kwjnMMNg@mail.gmail.com>
	<CAGd9gwgfGHo0EtXWE2eM=sYVCx58JG9Kc8LGO9NgPVbBL2hstA@mail.gmail.com>
	<CANT-zCXKK=O1zmUc8Oh71F_4wioFS+vgdDnYN3_Z5_9NT-EVwQ@mail.gmail.com>
	<CAGd9gwiBE8sf4tnnyrCFemFiDOH_WaLdRzHKJkyf7ORd+AeBDg@mail.gmail.com>
Date: Thu, 23 May 2013 11:06:45 +0200
Message-ID: <CANT-zCWD-ScDP3s51vhvqGea6vmgpFsz5LhGgJyM_AWx3UYurQ@mail.gmail.com>
Subject: Re: audio: Connect doesn't return when audio device is off.
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	keybuk <keybuk@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Thu, May 23, 2013 at 1:52 AM, Alex Deymo <deymo@chromium.org> wrote:
> Hi Mikel,
>
> On Wed, May 22, 2013 at 2:19 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
>> Hi Alex,
>>
>> If you confirm the issue is present in 5.4, it's probably unrelated to
>> btd_service.
> Yes, I can confirm it in both 5.4 and 5.5. It looks like the problem
> is in the profile implementation.
>
>>>> The problem is easy to reproduce. Again I'm using the Bose SoundLink
>>>> model 404600 but it should work with any audio device. The steps are
>>>> as follow:
>>>> 1. power on the adapter, scan and pair to the device.
>>>> 2. trust the device.
>>
>> Is trusting in any way relevant in this procedure?
>
> There are two ways to hit this problem:
> * One is to attempt a connection when the device is off,
> * the other one is to attempt a connection from the host right after
> you short press the button with the bluetooth logo on the speakers.
> This button normally reconnects the speakers to the host, but if you
> attempt a connection while the device is also doing that, you end up
> in the same situation.
>
> These two other scenarios don't hit the problem:
> * Attempt a connection from the host while the device is on and paired
> (but disconnected).
> * Attempt a connection from the device with this "bluetooth logo"
> button. I think that trusting the device is important in this case.
>
>>>> 3. turn off the device (short-press once the power button)
>>>> 4. attempt to connect to the device from the bluetoothctl.
>>>> The D-Bus Connect call doesn't return. I think that in general the
>>>> Connect call doesn't return on failure, it only returns when it
>>>> succeeds.
>>
>> I followed the steps above but I can't reproduce the issue. Can you
>> retest with the latest master and send the full logs?
>
> I can always reproduce it. You can find here the logs for 5.4 and 5.5,
> running bluetoothd with valgrind, with some comments between the lines
> about what I did. The common steps before those logs are: power on,
> agent on, scan on, wait for the device to appear, scan off. I ran
> "./bootstrap && ./configure --disable-systemd && make" between
> checkouts.
> * 5.5 (commit 3b60c35) --> http://ix.io/5L7
> * 5.4 (commit 4a9ce2e)  --> http://ix.io/5L8
> At some point dbus timeouts and I get a "Failed to connect:
> org.freedesktop.DBus.Error.NoReply" on the client.

I could finally reproduce the first issue you describe and I'll soon
submit a proposal to fix it. Please give it a try and see if any of
the described issues get fixed.

Cheers,
Mikel

>
>> Most likely there is an issue in some profile implementation so it'd
>> be interesting to isolate the problem by for example disabling AVRCP
>> (i.e. removing the btd_profile_register() calls for avrcp in
>> audio_manager_init()).
>
> disabling avrcp_target_profile does solve the problem. I see a
> "device_profile_connected() returning response" right after the
> "device_profile_connected() audio-sink Input/output error (5)". (See
> the log at the end of this email, it starts when I send the "connect"
> command that doesn't return).
>
>>>> I can also run into this same issue attempting to connect from the
>>>> device (short-press the bluetooth button on this device) and running
>>>> the "connect" command from bluetoothctl immediately after. In this
>>>> case the device successfully connects to the host, but the attempt to
>>>> connect from the host fails and Connect doesn't return. The funny
>>>> thing is that the device works and you can play music to it.
>>
>> This might be a different issue, but I couldn't reproduce it either.
>> Which device are you using?
> I'm using the Bose SoundLink model 404600, it shows on the bluetooth
> scan as "Bose SoundLink Wireless Mobile speaker". There's a second
> version of it, I'm using the first one here, but I also saw the same
> issue with the second version ("SoundLink Bluetooth Mobile speaker
> II").
>
> Cheers,
> Alex.
>
> bluetoothd[22493]: src/device.c:connect_profiles()
> /org/bluez/hci0/dev_00_0C_8A_XX_XX_XX (all), client :1.642
> bluetoothd[22493]: src/service.c:change_state() 0x632cde0: device
> 00:0C:8A:XX:XX:XX profile audio-sink state changed: disconnected ->
> connecting (0)
> bluetoothd[22493]: profiles/audio/manager.c:a2dp_sink_connect() path
> /org/bluez/hci0/dev_00_0C_8A_XX_XX_XX
> bluetoothd[22493]: profiles/audio/avdtp.c:avdtp_ref() 0x64e0f00: ref=1
> bluetoothd[22493]: profiles/audio/sink.c:sink_set_state() State
> changed /org/bluez/hci0/dev_00_0C_8A_XX_XX_XX: SINK_STATE_DISCONNECTED
> -> SINK_STATE_CONNECTING
> bluetoothd[22493]: profiles/audio/sink.c:sink_connect() stream
> creation in progress
> bluetoothd[22493]: src/adapter.c:connect_failed_callback() hci0
> 00:0C:8A:XX:XX:XX status 4
> bluetoothd[22493]: src/adapter.c:bonding_attempt_complete() hci0
> bdaddr 00:0C:8A:XX:XX:XX type 0 status 0x4
> bluetoothd[22493]: src/device.c:device_bonding_complete() bonding
> (nil) status 0x04
> bluetoothd[22493]: src/device.c:device_bonding_failed() status 4
> bluetoothd[22493]: src/adapter.c:resume_discovery()
> bluetoothd[22493]: connect error: Host is down (112)
> bluetoothd[22493]: profiles/audio/avdtp.c:connection_lost()
> Disconnected from 00:0C:8A:XX:XX:XX
> bluetoothd[22493]: profiles/audio/avdtp.c:avdtp_unref() 0x64e0f00: ref=0
> bluetoothd[22493]: src/service.c:change_state() 0x632cde0: device
> 00:0C:8A:XX:XX:XX profile audio-sink state changed: connecting ->
> disconnected (-5)
> bluetoothd[22493]: src/device.c:device_profile_connected() audio-sink
> Input/output error (5)
> bluetoothd[22493]: src/device.c:device_profile_connected() returning
> response to :1.642
> bluetoothd[22493]: profiles/audio/sink.c:sink_set_state() State
> changed /org/bluez/hci0/dev_00_0C_8A_XX_XX_XX: SINK_STATE_CONNECTING
> -> SINK_STATE_DISCONNECTED
> bluetoothd[22493]: profiles/audio/avdtp.c:avdtp_free() 0x64e0f00

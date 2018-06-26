Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CA+A7VXVJkGaZA3ZOb4F3dD1i1h9PQXXMpL2St+kRQdRJSq9g-A@mail.gmail.com>
References: <CA+A7VXVEBULPWJpxMeED-QxxG25Az1ckWdL+cudqE0RL7he9Xg@mail.gmail.com>
 <5a3c473313387957bac050067857e22e62d544f5.camel@iki.fi> <CA+A7VXVy=1RjvaQgSyE5M9Hw=QRuy8Ejc0A=pFhtxn1=06ZC3Q@mail.gmail.com>
 <5731aaabb375e5b82945cabff8c315a2ef827cbe.camel@iki.fi> <CA+A7VXU30H_=aZw_Xi2S2iOkPp=nQxfMRTE9msAAX+oh7v1Qvw@mail.gmail.com>
 <CABBYNZ+w=iC=OYz8y=NyLuvdEXfWprDoMuZiqTs+SijU7med9w@mail.gmail.com>
 <CABBYNZKpB5FLDxu2PrAV4P+HGDY1=jWJU_3YjTmgcDjoj36ijg@mail.gmail.com> <CA+A7VXVJkGaZA3ZOb4F3dD1i1h9PQXXMpL2St+kRQdRJSq9g-A@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 26 Jun 2018 13:55:22 +0300
Message-ID: <CABBYNZ+FD1sJ7SwS1SP7qoQ-W4PMfYQoWvHZ0_TCbVyCpzKasw@mail.gmail.com>
Subject: Re: Failure to connect Sony headsets
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Cc: Tanu Kaskinen <tanuk@iki.fi>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        General PulseAudio Discussion
        <pulseaudio-discuss@lists.freedesktop.org>,
        =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joao,

On Thu, Jun 21, 2018 at 10:21 PM, Jo=C3=A3o Paulo Rechi Vita
<jprvita@gmail.com> wrote:
> Hello Luiz,
>
> On Thu, Jun 21, 2018 at 3:27 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>>
>>> Im trying to reproduce this with sony sbh50 but apparently it doesn't
>>> have the same problem as it worked just fine, one thing I notice
>>> though is that HFP does not connect:
>>>
>>> https://gist.github.com/Vudentz/6f385ededcb00d1d0f4403f06923fd1a
>>>
>>> As you can see locally we only support HSP which means there is no
>>> match for MFP, but perhaps you are running with oFono? Anyway I should
>>> have an mw600 somewhere but that is quite old already, but you
>>> mentioned it did not work with MDR-XB950N1 which is quite new model?
>
> Sorry, I forgot to mention: I was not running oFono, so only
> PulseAudio's HSP implementation was registered with bluetoothd. I
> personally have only been able to reproduce this problem on the Sony
> MW-600, from the headsets I have access to. Our QA team at Endless
> have seen similar symptoms on the Sony MDR-XB950N1, AMP Pulse BXH-300,
> Intopic HM-BT001, and The Coopidea CP-TW-01. I have not able to
> confirm 100% whether that is the exact same problem on all of them, as
> I'm focusing on the MW-600 which is the one I have access to.
>
>>> Anyway if you can gather some logs of bluetoothd that would be useful
>>> to identify where is the problem.
>>
>
> I've actually was not able to reproduce the exact same symptoms
> yesterday: instead of the headset disconnecting A2DP and the card
> being destroyed, the OFF profile ended up being selected. The
> transport for HSP got available first, the card was created 3s
> afterwards (due to WAIT_FOR_PROFILES_TIMEOUT_USEC being reached), but
> a2dp actually got connected about 50s afterwards. Then after looking
> into it for a while I realized a few extra things that I had not
> noticed befofe. PulseAudio logs for this case can be seen right
> bellow, and for the "disconnecting case" afterwards. I can still
> collect bluetoothd logs if needed.
>
> Notice that the "module-card-restore.c: Restoring profile X for card
> Y" message is wrong, as this is from PulseAudio 11 plus some
> backported patches, but it does not contain "card-restore: log the
> correct profile name". I marked it on the logs bellow for attention.
>
> 1. OFF CASE
>
> - org.bluez.Profile1.NewConnection() is called on PulseAudio's
> HSPAGProfile object path:
>
> Jun 20 17:09:11 endless pulseaudio[899]: [pulseaudio] bluez5-util.c:
> Properties changed in device /org/bluez/hci0/dev_58_17_0C_EA_02_89
> Jun 20 17:09:12 endless pulseaudio[899]: [pulseaudio]
> backend-native.c: dbus: path=3D/Profile/HSPAGProfile,
> interface=3Dorg.bluez.Profile1, member=3DNewConnection
> Jun 20 17:09:12 endless pulseaudio[899]: [pulseaudio]
> backend-native.c: dbus: NewConnection
> path=3D/org/bluez/hci0/dev_58_17_0C_EA_02_89, fd=3D23, profile
> headset_head_unit
> Jun 20 17:09:12 endless pulseaudio[899]: [pulseaudio]
> backend-native.c: doing listen
> Jun 20 17:09:12 endless pulseaudio[899]: [pulseaudio] bluez5-util.c:
> Transport /org/bluez/hci0/dev_58_17_0C_EA_02_89/fd23 state:
> disconnected -> idle
> Jun 20 17:09:12 endless pulseaudio[899]: [pulseaudio]
> backend-native.c: Transport /org/bluez/hci0/dev_58_17_0C_EA_02_89/fd23
> available for profile headset_head_unit
> Jun 20 17:09:12 endless pulseaudio[899]: [pulseaudio]
> backend-native.c: RFCOMM << AT+CLIP=3D1
>
> - WAIT_FOR_PROFILES_TIMEOUT_USEC expires:
>
> Jun 20 17:09:15 endless pulseaudio[899]: [pulseaudio] bluez5-util.c:
> Timeout expired, and device /org/bluez/hci0/dev_58_17_0C_EA_02_89
> still has disconnected profiles: a2dp_sink
> Jun 20 17:09:15 endless pulseaudio[899]: [pulseaudio]
> module-bluez5-discover.c: Loading module-bluez5-device
> path=3D/org/bluez/hci0/dev_58_17_0C_EA_02_89 autodetect_mtu=3D0
> Jun 20 17:09:15 endless pulseaudio[899]: [pulseaudio]
> module-card-restore.c: Restoring port latency offsets for card
> bluez_card.58_17_0C_EA_02_89.
> ** wrong message here --> Jun 20 17:09:15 endless pulseaudio[899]:
> [pulseaudio] module-card-restore.c: Restoring profile
> 'headset_head_unit' for card bluez_card.58_17_0C_EA_02_89.
> Jun 20 17:09:15 endless pulseaudio[899]: [pulseaudio] card.c: Created
> 1 "bluez_card.58_17_0C_EA_02_89"
> ** and the following message indicates module-card-restore was trying
> to restore a2dp_sink instead
> Jun 20 17:09:15 endless pulseaudio[899]: [pulseaudio]
> module-bluez5-device.c: Profile a2dp_sink has no transport
> Jun 20 17:09:15 endless pulseaudio[899]: [pulseaudio] card.c: Changed
> profile of card 1 "bluez_card.58_17_0C_EA_02_89" to off
> Jun 20 17:09:15 endless pulseaudio[899]: [pulseaudio]
> core-subscribe.c: Dropped redundant event due to change event.
> Jun 20 17:09:15 endless pulseaudio[899]: [pulseaudio] module.c: Loaded
> "module-bluez5-device" (index: #25; argument:
> "path=3D/org/bluez/hci0/dev_58_17_0C_EA_02_89 autodetect_mtu=3D0").
>
> - Now the card remains created and idle for a while, since its profile
> has been set to OFF, except for some boring RFCOMM chat.
>
> Jun 20 17:09:22 endless pulseaudio[899]: [pulseaudio]
> backend-native.c: RFCOMM << AT+CSCS=3D"UTF-8"
> Jun 20 17:09:32 endless pulseaudio[899]: [pulseaudio]
> backend-native.c: RFCOMM << AT*SEAM=3D"MW600",13
> Jun 20 17:09:42 endless pulseaudio[899]: [pulseaudio]
> backend-native.c: RFCOMM << AT+CLAN?
> Jun 20 17:09:52 endless pulseaudio[899]: [pulseaudio]
> backend-native.c: RFCOMM << AT+COLP=3D1
> Jun 20 17:10:02 endless pulseaudio[899]: [pulseaudio]
> backend-native.c: RFCOMM << AT+CCLK?
>
> - Exact 50s after the NewConnection() call there is a
> org.bluez.MediaTransport1.SetConfiguration() call on PulseAudio's
> A2DPSource object path:
>
> Jun 20 17:10:02 endless pulseaudio[899]: [pulseaudio] bluez5-util.c:
> Unknown interface org.freedesktop.DBus.Introspectable found, skipping
> Jun 20 17:10:02 endless pulseaudio[899]: [pulseaudio] bluez5-util.c:
> Unknown interface org.bluez.MediaTransport1 found, skippingJun 20
> 17:10:02 endless pulseaudio[899]: [pulseaudio] bluez5-util.c: Unknown
> interface org.freedesktop.DBus.Properties found, skipping
> Jun 20 17:10:02 endless pulseaudio[899]: [pulseaudio] bluez5-util.c:
> dbus: path=3D/MediaEndpoint/A2DPSource,
> interface=3Dorg.bluez.MediaEndpoint1, member=3DSetConfiguration
> Jun 20 17:10:02 endless pulseaudio[899]: [pulseaudio] bluez5-util.c:
> Transport /org/bluez/hci0/dev_58_17_0C_EA_02_89/fd0 state:
> disconnected -> idle
> Jun 20 17:10:02 endless pulseaudio[899]: [pulseaudio] card.c: Setting
> card bluez_card.58_17_0C_EA_02_89 profile a2dp_sink to availability
> status unknown
> Jun 20 17:10:02 endless pulseaudio[899]: [pulseaudio] bluez5-util.c:
> Transport /org/bluez/hci0/dev_58_17_0C_EA_02_89/fd0 available for
> profile a2dp_sink
> Jun 20 17:10:02 endless pulseaudio[899]: [pulseaudio] bluez5-util.c:
> Properties changed in transport
> /org/bluez/hci0/dev_58_17_0C_EA_02_89/fd0
> Jun 20 17:10:02 endless pulseaudio[899]: [pulseaudio] bluez5-util.c:
> Transport /org/bluez/hci0/dev_58_17_0C_EA_02_89/fd0 state: idle ->
> playing
> Jun 20 17:10:02 endless pulseaudio[899]: [pulseaudio] card.c: Setting
> card bluez_card.58_17_0C_EA_02_89 profile a2dp_sink to availability
> status yes
> Jun 20 17:10:02 endless pulseaudio[899]: [pulseaudio] device-port.c:
> Setting port headset-output to status yes
> Jun 20 17:10:02 endless pulseaudio[899]: [pulseaudio]
> core-subscribe.c: Dropped redundant event due to change event.
> Jun 20 17:10:08 endless pulseaudio[899]: [pulseaudio] bluez5-util.c:
> Properties changed in transport
> /org/bluez/hci0/dev_58_17_0C_EA_02_89/fd0
> Jun 20 17:10:08 endless pulseaudio[899]: [pulseaudio] bluez5-util.c:
> Transport /org/bluez/hci0/dev_58_17_0C_EA_02_89/fd0 state: playing ->
> idle
> Jun 20 17:10:08 endless pulseaudio[899]: [pulseaudio] card.c: Setting
> card bluez_card.58_17_0C_EA_02_89 profile a2dp_sink to availability
> status unknown
> Jun 20 17:10:08 endless pulseaudio[899]: [pulseaudio] device-port.c:
> Setting port headset-output to status unknown
> Jun 20 17:10:08 endless pulseaudio[899]: [pulseaudio]
> core-subscribe.c: Dropped redundant event due to change event.
>
> 2. DISCONNECTING CASE (here I had WAIT_FOR_PROFILES_TIMEOUT_USEC=3D60s,
> so it does not expire):
>
> - org.bluez.Profile1.NewConnection() is called on PulseAudio's
> HSPAGProfile object path:
>
> Jun 13 15:22:10 endless pulseaudio[809]: [pulseaudio] bluez5-util.c:
> Properties changed in device /org/bluez/hci0/dev_58_17_0C_EA_02_89
> Jun 13 15:22:10 endless pulseaudio[809]: [pulseaudio]
> backend-native.c: dbus: path=3D/Profile/HSPAGProfile,
> interface=3Dorg.bluez.Profile1, member=3DNewConnection
> Jun 13 15:22:10 endless pulseaudio[809]: [pulseaudio]
> backend-native.c: dbus: NewConnection
> path=3D/org/bluez/hci0/dev_58_17_0C_EA_02_89, fd=3D23, profile
> headset_head_unit
> Jun 13 15:22:10 endless pulseaudio[809]: [pulseaudio]
> backend-native.c: doing listen
> Jun 13 15:22:10 endless pulseaudio[809]: [pulseaudio] bluez5-util.c:
> Transport /org/bluez/hci0/dev_58_17_0C_EA_02_89/fd23 state:
> disconnected -> idle
> Jun 13 15:22:10 endless pulseaudio[809]: [pulseaudio]
> backend-native.c: Transport /org/bluez/hci0/dev_58_17_0C_EA_02_89/fd23
> available for profile headset_head_unit
> Jun 13 15:22:10 endless pulseaudio[809]: [pulseaudio]
> backend-native.c: RFCOMM << AT+CLIP=3D1
> Jun 13 15:22:20 endless pulseaudio[809]: [pulseaudio]
> backend-native.c: RFCOMM << AT+CSCS=3D"UTF-8"
> Jun 13 15:22:30 endless pulseaudio[809]: [pulseaudio]
> backend-native.c: RFCOMM << AT*SEAM=3D"MW600",13
> Jun 13 15:22:40 endless pulseaudio[809]: [pulseaudio]
> backend-native.c: RFCOMM << AT+CLAN?
> Jun 13 15:22:50 endless pulseaudio[809]: [pulseaudio]
> backend-native.c: RFCOMM << AT+COLP=3D1
> Jun 13 15:23:00 endless pulseaudio[809]: [pulseaudio]
> backend-native.c: RFCOMM << AT+CCLK?
>
> - Exact 51s after the NewConnection() call there is a
> org.bluez.MediaTransport1.SetConfiguration() call on PulseAudio's
> A2DPSource object path:
>
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] bluez5-util.c:
> dbus: path=3D/MediaEndpoint/A2DPSource,
> interface=3Dorg.bluez.MediaEndpoint1, member=3DSetConfiguration
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] bluez5-util.c:
> Transport /org/bluez/hci0/dev_58_17_0C_EA_02_89/fd1 state:
> disconnected -> idle
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio]
> module-bluez5-discover.c: Loading module-bluez5-device
> path=3D/org/bluez/hci0/dev_58_17_0C_EA_02_89 autodetect_mtu=3D0
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio]
> module-card-restore.c: Restoring port latency offsets for card
> bluez_card.58_17_0C_EA_02_89.
> ** wrong message, it is restoring headset_head_unit --> Jun 13
> 15:23:01 endless pulseaudio[809]: [pulseaudio] module-card-restore.c:
> Restoring profile 'a2dp_sink' for card bluez_card.58_17_0C_EA_02_89.
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] card.c: Created
> 2 "bluez_card.58_17_0C_EA_02_89"
>
> - SCO is established
>
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio]
> module-bluez5-device.c: Acquiring transport
> /org/bluez/hci0/dev_58_17_0C_EA_02_89/fd23
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio]
> backend-native.c: doing connect
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio]
> module-bluez5-device.c: Transport
> /org/bluez/hci0/dev_58_17_0C_EA_02_89/fd23 acquired: fd 13
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] bluez5-util.c:
> Transport /org/bluez/hci0/dev_58_17_0C_EA_02_89/fd23 state: idle ->
> playing
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] card.c: Setting
> card bluez_card.58_17_0C_EA_02_89 profile headset_head_unit to
> availability status yes
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio]
> core-subscribe.c: Dropped redundant event due to change event.
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] device-port.c:
> Setting port headset-output to status yes
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio]
> core-subscribe.c: Dropped redundant event due to change event.
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] device-port.c:
> Setting port headset-input to status yes
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio]
> core-subscribe.c: Dropped redundant event due to change event.
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] sink.c: Created
> sink 2 "bluez_sink.58_17_0C_EA_02_89.headset_head_unit" with sample
> spec s16le 1ch 8000Hz and channel map mono
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] sink.c:
> bluetooth.protocol =3D "headset_head_unit"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] sink.c:
> device.intended_roles =3D "phone"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] sink.c:
> device.description =3D "MW600"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] sink.c:
> device.string =3D "58:17:0C:EA:02:89"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] sink.c:
> device.api =3D "bluez"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] sink.c:
> device.class =3D "sound"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] sink.c:
> device.bus =3D "bluetooth"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] sink.c:
> device.form_factor =3D "headset"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] sink.c:
> bluez.path =3D "/org/bluez/hci0/dev_58_17_0C_EA_02_89"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] sink.c:
> bluez.class =3D "0x240404"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] sink.c:
> bluez.alias =3D "MW600"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] sink.c:
> device.icon_name =3D "audio-headset-bluetooth"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] source.c:
> Created source 3
> "bluez_sink.58_17_0C_EA_02_89.headset_head_unit.monitor" with sample
> spec s16le 1ch 8000Hz and channel map mono
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] source.c:
> device.description =3D "Monitor of MW600"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] source.c:
> device.class =3D "monitor"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] source.c:
> device.string =3D "58:17:0C:EA:02:89"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] source.c:
> device.api =3D "bluez"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] source.c:
> device.bus =3D "bluetooth"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] source.c:
> device.form_factor =3D "headset"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] source.c:
> bluez.path =3D "/org/bluez/hci0/dev_58_17_0C_EA_02_89"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] source.c:
> bluez.class =3D "0x240404"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] source.c:
> bluez.alias =3D "MW600"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] source.c:
> device.icon_name =3D "audio-headset-bluetooth"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] source.c:
> device.intended_roles =3D "phone"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] source.c:
> Created source 4 "bluez_source.58_17_0C_EA_02_89.headset_head_unit"
> with sample spec s16le 1ch 8000Hz and channel map mono
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] source.c:
> bluetooth.protocol =3D "headset_head_unit"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] source.c:
> device.intended_roles =3D "phone"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] source.c:
> device.description =3D "MW600"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] source.c:
> device.string =3D "58:17:0C:EA:02:89"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] source.c:
> device.api =3D "bluez"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] source.c:
> device.class =3D "sound"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] source.c:
> device.bus =3D "bluetooth"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] source.c:
> device.form_factor =3D "headset"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] source.c:
> bluez.path =3D "/org/bluez/hci0/dev_58_17_0C_EA_02_89"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] source.c:
> bluez.class =3D "0x240404"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] source.c:
> bluez.alias =3D "MW600"
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] source.c:
> device.icon_name =3D "audio-headset-bluetooth"
> Jun 13 15:23:01 endless pulseaudio[809]: [bluetooth]
> module-bluez5-device.c: IO Thread starting up
> Jun 13 15:23:01 endless pulseaudio[809]: [bluetooth] core-util.c:
> RealtimeKit worked.
> Jun 13 15:23:01 endless pulseaudio[809]: [bluetooth] core-util.c:
> Successfully enabled SCHED_RR scheduling for thread, with priority 5.
> Jun 13 15:23:01 endless pulseaudio[809]: [bluetooth]
> module-bluez5-device.c: Transport
> /org/bluez/hci0/dev_58_17_0C_EA_02_89/fd23 resuming
> Jun 13 15:23:01 endless pulseaudio[809]: [bluetooth]
> module-bluez5-device.c: Stream properly set up, we're ready to roll!
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio]
> module-device-restore.c: Could not set format on sink
> bluez_sink.58_17_0C_EA_02_89.headset_head_unit
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio]
> module-bluetooth-policy.c: Profile headset_head_unit cannot be
> selected for loopback
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio]
> module-suspend-on-idle.c: Sink
> bluez_sink.58_17_0C_EA_02_89.headset_head_unit becomes idle, timeout
> in 5 seconds.
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] core.c:
> default_sink: alsa_output.pci-0000_00_1f.3.analog-stereo ->
> bluez_sink.58_17_0C_EA_02_89.headset_head_unit
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio]
> backend-native.c: RFCOMM >> +VGS=3D15
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio]
> module-bluetooth-policy.c: Profile headset_head_unit cannot be
> selected for loopback
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio]
> module-suspend-on-idle.c: Source
> bluez_source.58_17_0C_EA_02_89.headset_head_unit becomes idle, timeout
> in 5 seconds.
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] core.c:
> default_source: alsa_input.pci-0000_00_1f.3.analog-stereo ->
> bluez_source.58_17_0C_EA_02_89.headset_head_unit
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio]
> core-subscribe.c: Dropped redundant event due to change event.
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio]
> backend-native.c: RFCOMM >> +VGM=3D15
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] module.c: Loaded
> "module-bluez5-device" (index: #27; argument:
> "path=3D/org/bluez/hci0/dev_58_17_0C_EA_02_89 autodetect_mtu=3D0").
>
> - org.bluez.MediaTransport1.ClearConfiguration() call on PulseAudio's
> A2DPSource object path, makes a2dp_sink unavailable:
>
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] bluez5-util.c:
> Transport /org/bluez/hci0/dev_58_17_0C_EA_02_89/fd1 available for
> profile a2dp_sink
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] bluez5-util.c:
> dbus: path=3D/MediaEndpoint/A2DPSource,
> interface=3Dorg.bluez.MediaEndpoint1, member=3DClearConfiguration
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] bluez5-util.c:
> Clearing transport /org/bluez/hci0/dev_58_17_0C_EA_02_89/fd1 profile
> a2dp_sink
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] bluez5-util.c:
> Transport /org/bluez/hci0/dev_58_17_0C_EA_02_89/fd1 state: idle ->
> disconnected
> Jun 13 15:23:01 endless pulseaudio[809]: [pulseaudio] card.c: Setting
> card bluez_card.58_17_0C_EA_02_89 profile a2dp_sink to availability
> status no
> Jun 13 15:23:06 endless pulseaudio[809]: [pulseaudio]
> module-suspend-on-idle.c: Source
> bluez_source.58_17_0C_EA_02_89.headset_head_unit idle for too long,
> suspending ...
> Jun 13 15:23:06 endless pulseaudio[809]: [pulseaudio] source.c:
> Suspend cause of source
> bluez_source.58_17_0C_EA_02_89.headset_head_unit is 0x0004, suspending
> Jun 13 15:23:06 endless pulseaudio[809]: [pulseaudio] core.c: Hmm, no
> streams around, trying to vacuum.
> Jun 13 15:23:06 endless pulseaudio[809]: [pulseaudio]
> module-suspend-on-idle.c: Sink
> bluez_sink.58_17_0C_EA_02_89.headset_head_unit idle for too long,
> suspending ...
> Jun 13 15:23:06 endless pulseaudio[809]: [pulseaudio] sink.c: Suspend
> cause of sink bluez_sink.58_17_0C_EA_02_89.headset_head_unit is
> 0x0004, suspending
> Jun 13 15:23:06 endless pulseaudio[809]: [bluetooth]
> module-bluez5-device.c: Releasing transport
> /org/bluez/hci0/dev_58_17_0C_EA_02_89/fd23
> Jun 13 15:23:06 endless pulseaudio[809]: [bluetooth] backend-native.c:
> Transport /org/bluez/hci0/dev_58_17_0C_EA_02_89/fd23 released
> Jun 13 15:23:06 endless pulseaudio[809]: [bluetooth]
> module-bluez5-device.c: Audio stream torn down
> Jun 13 15:23:06 endless pulseaudio[809]: [pulseaudio] core.c: Hmm, no
> streams around, trying to vacuum.
> Jun 13 15:23:06 endless pulseaudio[809]: [pulseaudio] bluez5-util.c:
> Transport /org/bluez/hci0/dev_58_17_0C_EA_02_89/fd23 state: playing ->
> idle
> Jun 13 15:23:06 endless pulseaudio[809]: [pulseaudio] card.c: Setting
> card bluez_card.58_17_0C_EA_02_89 profile headset_head_unit to
> availability status unknown
> Jun 13 15:23:06 endless pulseaudio[809]: [pulseaudio] device-port.c:
> Setting port headset-output to status unknown
> Jun 13 15:23:06 endless pulseaudio[809]: [pulseaudio]
> core-subscribe.c: Dropped redundant event due to change event.
> Jun 13 15:23:06 endless pulseaudio[809]: [pulseaudio] device-port.c:
> Setting port headset-input to status unknown
> Jun 13 15:23:06 endless pulseaudio[809]: [pulseaudio]
> core-subscribe.c: Dropped redundant event due to change event.
> Jun 13 15:23:10 endless pulseaudio[809]: [pulseaudio]
> backend-native.c: RFCOMM << AT+VGS=3D15
> Jun 13 15:23:10 endless pulseaudio[809]: [pulseaudio]
> backend-native.c: RFCOMM >> OK
>
> There was still another situation I've seen, which is the RFCOMM
> getting disconnected at this point with
> WAIT_FOR_PROFILES_TIMEOUT_USEC=3D3s (which makes we create the card
> without all profiles connected), but I don't have logs for it atm.
>
>> Managed to reproduce the issue, if I recall correctly MW600 don't like
>> that SCO is open before A2DP is configured which is caused by:
>>
>
> That is aligned with my observations when debugging this over the past
> few days, and with I've seen on the logs above.
>
>>
>>    /* Ignore card if has already set other initial profile than a2dp */
>>     if (card->active_profile &&
>>         !pa_streq(card->active_profile->name, "a2dp") &&
>>         !pa_streq(card->active_profile->name, "a2dp_sink"))
>>         return PA_HOOK_OK;
>>
>>     /* Set initial profile to hsp */
>>     card_set_profile(u, card, false);
>>
>> If I get it correctly the first if statement will not return in case
>> of A2DP, which basically negates restored profile?, and then it sets
>> HSP which I find to be the opposite of what we should be doing except
>> if there already an stream tagged with voice otherwise we shall really
>> prefer A2DP.
>>
>
> I'm reading this correctly, this code path is reached only when there
> is a source-output which is tagged with media.role=3Dphone (unless some
> extra heuristic is enabled by passing "auto_switch=3D2" to
> module-bluetooth-policy, which is not the case here), which is
> controlled by the "if (source_output_count(c, userdata) =3D=3D 0)" branch
> about 8 lines above the ones you pasted.
>
> I'm adding some extra debug around the initial profile selection to
> have a clear picture of what is going on there and will keep analyzing
> this further. I'll get back when I have something, now that I have a
> better idea of what to look for, but any insights are welcome in the
> meantime.

Just a heads up Ive sent a patch for BlueZ that shoud fix this for
MW600, it turns out the device did not reconnect A2DP after HFP and
would only do that is SCO is connected which is too late. Anyway I
briefly discussed with Tanu about the ordering of initial profile
shall be bluetooth-policy first than restore since that means restore
is run last overriding any profile set by bluetooth-policy in case the
user has set anything as preference.

--=20
Luiz Augusto von Dentz

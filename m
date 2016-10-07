Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7D498A2F2F79AE4DBE2DF69CA72B3B55388EC338@US-EVT-EXM03-P.global.tektronix.net>
References: <7D498A2F2F79AE4DBE2DF69CA72B3B55388EC338@US-EVT-EXM03-P.global.tektronix.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 7 Oct 2016 10:01:30 +0300
Message-ID: <CABBYNZJRY=qhaVxTzTFRrFSyLCiaWY+GtUHvMpsTwOEYLeZ8rw@mail.gmail.com>
Subject: Re: Headset profile no audio; works with a2dp
To: "Schaefer, Brandon" <brandon.schaefer@flukenetworks.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brandon,

On Thu, Oct 6, 2016 at 11:20 PM, Schaefer, Brandon
<brandon.schaefer@flukenetworks.com> wrote:
> Bluez version: 5.40
> Pulseaudio: 6.0
>
> I have headset that I am able to pair, connect, and play audio via the a2=
dp_sink profile of pulseaudio. When I switch to headset_head_unit profile, =
I can no longer send audio to the headset. I first went to pulseaudio to se=
e if they had any suggestions as I found a very similar case to mine (https=
://bugs.freedesktop.org/show_bug.cgi?id=3D97064).
>
> Tanu kindly pointed out that there seemed to be missing a dbus signal fro=
m bluetoothd, specifically "PropertiesChanged" signal on MediaTransport1 in=
terface. I did some inspection, and transport_update_playing() in profiles/=
audio/transport.c shows Playing =3D 0 and not 1, which is the case when usi=
ng a2dp_sink profile.
>
> Headset_head_unit:
> bluetoothd[756]: profiles/audio/transport.c:transport_update_playing() /o=
rg/bluez/hci0/dev_00_11_C2_08_15_F6/fd0 State=3DTRANSPORT_STATE_IDLE Playin=
g=3D0
>
> a2dp_sink:
> bluetoothd[756]: profiles/audio/transport.c:transport_update_playing() /o=
rg/bluez/hci0/dev_00_11_C2_08_15_F6/fd0 State=3DTRANSPORT_STATE_ACTIVE Play=
ing=3D1
>
> Any recommendation on what might be the issue? Happy to provide any logs =
that could be useful.

Ever since we move HFP to be an external profile it no longer uses the
transport API, instead you either use the native PA backend or oFono
which has a dedicated interface for HFP, perhaps your controller is
not set for HCI routing?

--=20
Luiz Augusto von Dentz

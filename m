Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <26467B30-3820-4CBF-98DB-DC7CAF669A73@icloud.com>
References: <26467B30-3820-4CBF-98DB-DC7CAF669A73@icloud.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 13 Nov 2017 17:36:07 +0200
Message-ID: <CABBYNZKUj4n=_6bFdmNVxbL7pNQx5iSXKND6H120rDWc8R7q4g@mail.gmail.com>
Subject: Re: How connect two headphones two Bluez5
To: =?UTF-8?B?0KDRg9GB0LvQsNC9INCa0YPQt9GM0LzQuNC9?=
        <kuzminruslan@icloud.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ruslan,

On Mon, Nov 13, 2017 at 10:44 AM, =D0=A0=D1=83=D1=81=D0=BB=D0=B0=D0=BD =D0=
=9A=D1=83=D0=B7=D1=8C=D0=BC=D0=B8=D0=BD
<kuzminruslan@icloud.com> wrote:
> Excuse me for my English.I am developer.My task connect two Bluetooth hea=
dphones to one Bluetooth adapter.I know in Windows and in bluez4 this featu=
re worked.In bluez5 in connection with pulseaudio created only one virtual =
A2DP speaker.
> Long time I am searched reason in pulseaudio (more precisely in pulseaudi=
o sources) but how I knowed what dbus send from bluez to pulseaudio command=
 ClearConfiguration when I am trying connect second headphone. I want to kn=
ow where in sources of bluez5 limited count of working A2DP profiles.May I =
am write self hook for pulseaudio for two Bluetooth A2DP headphones?

PulseAudio is currently registering only one source, you will probably
need to introduce an option in default.pa in order to add more
endpoints to connect multiple devices.

--=20
Luiz Augusto von Dentz

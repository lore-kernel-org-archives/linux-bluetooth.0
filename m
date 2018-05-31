Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8ae38491-75b4-b230-2232-fd12a4bd7b7a@interia.pl>
References: <8ae38491-75b4-b230-2232-fd12a4bd7b7a@interia.pl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 31 May 2018 15:15:52 +0300
Message-ID: <CABBYNZKBMp_6EPAH8D50w99NMYg9tGySuyHTJrB3+pqdSagBag@mail.gmail.com>
Subject: Re: [PATCH] Allow bluetoothd to call methods on dbus' system bus
To: =?UTF-8?Q?Rafa=C5=82_Bilski?= <rafalbilski@interia.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Thu, May 31, 2018 at 1:26 AM, Rafa=C5=82 Bilski <rafalbilski@interia.pl>=
 wrote:
> Default dbus configuration doesn't allow calling methods on system bus. O=
nly
> sending signals is allowed.
> If "mpris-proxy" isn't running "/usr/lib/gsd-media-keys" translates
> keystrokes from "profiles/audio/avctp.c:handle_panel_passthrough()"
> to dbus method calls on session bus. This is allowed on dbus by default.
> If "mpris-proxy" is running "bluetoothd" executes dbus' method calls on
> system bus.  These apparently are rejected by default.
>
> diff --git a/src/bluetooth.conf b/src/bluetooth.conf
> index 0c0b221bb..1cafab631 100644
> --- a/src/bluetooth.conf
> +++ b/src/bluetooth.conf
> @@ -8,6 +8,7 @@
>    <!-- ../system.conf have denied everything, so we just punch some hole=
s
> -->
>     <policy user=3D"root">
> +    <allow send_type=3D"method_call"/>
>      <allow own=3D"org.bluez"/>
>      <allow send_destination=3D"org.bluez"/>
>      <allow send_interface=3D"org.bluez.Agent1"/>
>

I think the correct fix would be to add the interface
(org.mpris.MediaPlayer2.Player) we are using to communicate with the
player.

--=20
Luiz Augusto von Dentz

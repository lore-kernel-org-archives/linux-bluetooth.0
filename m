Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1365806064-12052-1-git-send-email-jprvita@gmail.com>
References: <1365806064-12052-1-git-send-email-jprvita@gmail.com>
Date: Mon, 15 Apr 2013 17:20:49 +0300
Message-ID: <CABBYNZKpCGDmAfkPZ7Cm0SThL4arCZWfvH_KL_fCHmPjm=y7cw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] audio: Remove unused constant
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joao,

On Sat, Apr 13, 2013 at 1:34 AM,  <jprvita@gmail.com> wrote:
> From: João Paulo Rechi Vita <jprvita@gmail.com>
>
> Removes the never used constant AUDIO_INTERFACE which is defined to
> "org.bluez.Audio".
> ---
>  profiles/audio/device.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/profiles/audio/device.c b/profiles/audio/device.c
> index 907221d..b9d1dde 100644
> --- a/profiles/audio/device.c
> +++ b/profiles/audio/device.c
> @@ -56,8 +56,6 @@
>  #include "sink.h"
>  #include "source.h"
>
> -#define AUDIO_INTERFACE "org.bluez.Audio"
> -
>  #define CONTROL_CONNECT_TIMEOUT 2
>  #define AVDTP_CONNECT_TIMEOUT 1
>  #define AVDTP_CONNECT_TIMEOUT_BOOST 1
> --
> 1.7.11.7

All 3 patches pushed upstream, thanks.


--
Luiz Augusto von Dentz

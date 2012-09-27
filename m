Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1348584946-13895-3-git-send-email-mikel.astiz.oss@gmail.com>
References: <1348584946-13895-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1348584946-13895-3-git-send-email-mikel.astiz.oss@gmail.com>
Date: Thu, 27 Sep 2012 11:00:01 +0300
Message-ID: <CABBYNZJuk0=C0V99UbJdGXiey1YpDdefdZpOYzfwwajCGxsvdA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] audio: Fix crash on gateway close
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Sep 25, 2012 at 5:55 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> gateway_close() can be called multiple times and thus the code must
> handle the case where device->gateway is already NULL.
>
> This issue can be easily reproduced if a device is removed (unpaired)
> while HFP gateway is connected.
> ---
>  audio/gateway.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/audio/gateway.c b/audio/gateway.c
> index 45b25a1..93a70ba 100644
> --- a/audio/gateway.c
> +++ b/audio/gateway.c
> @@ -566,6 +566,9 @@ int gateway_close(struct audio_device *device)
>         struct gateway *gw = device->gateway;
>         int sock;
>
> +       if (gw == NULL)
> +               return 0;
> +
>         if (gw->rfcomm) {
>                 sock = g_io_channel_unix_get_fd(gw->rfcomm);
>                 shutdown(sock, SHUT_RDWR);
> --
> 1.7.11.4

There is something wrong if this is being called multiple times, so we
need to find the root cause of this happening and fix there.


-- 
Luiz Augusto von Dentz

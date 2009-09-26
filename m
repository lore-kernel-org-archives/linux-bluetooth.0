Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <200909251636.06774.sgrubb@redhat.com>
References: <200909251636.06774.sgrubb@redhat.com>
Date: Sat, 26 Sep 2009 19:29:14 -0300
Message-ID: <2d5a2c100909261529j700b78a6p12fdfc27f81f1015@mail.gmail.com>
Subject: Re: [PATCH] misc fixups
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Steve Grubb <sgrubb@redhat.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Sep 25, 2009 at 5:36 PM, Steve Grubb <sgrubb@redhat.com> wrote:
> Hello,
>
> I was doing some code reviews of the 4.54 release and found a couple
> things that should be fixed up. The first is that in audio/pcm_bluetooth.c,
> a data structure is being overrun. Because the underlying buffer is 512
> bytes, no overflow really occurs. What appears to happen is too much
> data gets copied.
>
> The other issue is in  cups/main.c, error is a stack variable and its address
> cannot be NULL. So, no need to check its value.
>
> Signed-off-by: Steve Grubb <sgrubb@redhat.com>
>
>
> diff -urp bluez-4.54.orig/audio/pcm_bluetooth.c bluez-4.54/audio/pcm_bluetooth.c
> --- bluez-4.54.orig/audio/pcm_bluetooth.c       2009-09-25 11:33:47.000000000 -0400
> +++ bluez-4.54/audio/pcm_bluetooth.c    2009-09-25 14:35:35.000000000 -0400
> @@ -729,7 +729,7 @@ static int bluetooth_a2dp_hw_params(snd_
>        req->h.length = sizeof(*req);
>
>        memcpy(&req->codec, &a2dp->sbc_capabilities,
> -                       sizeof(a2dp->sbc_capabilities));
> +                       sizeof(req->codec));

Be careful that this structs are different, we really want to copy sbc
codec capabilities which is used to configure latter.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação

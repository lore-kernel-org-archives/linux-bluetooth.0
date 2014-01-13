Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1389617627-4617-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1389617627-4617-1-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Mon, 13 Jan 2014 15:11:22 +0200
Message-ID: <CABBYNZJ85MppC0Uob5ENnt9VmTthVWaWZ9-xy3cO_Xr1T5nBYw@mail.gmail.com>
Subject: Re: [PATCH] android/a2dp: Fix buffer size calculation for codec caps
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Mon, Jan 13, 2014 at 2:53 PM, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
> ---
>  android/a2dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/android/a2dp.c b/android/a2dp.c
> index 05edd71..1f7678a 100644
> --- a/android/a2dp.c
> +++ b/android/a2dp.c
> @@ -415,7 +415,7 @@ static gboolean sep_getcap_ind(struct avdtp *session,
>         service = avdtp_service_cap_new(AVDTP_MEDIA_TRANSPORT, NULL, 0);
>         *caps = g_slist_append(*caps, service);
>
> -       codec = g_malloc0(sizeof(*codec) + sizeof(cap->len));
> +       codec = g_malloc0(sizeof(*codec) + cap->len);
>         codec->media_type = AVDTP_MEDIA_TYPE_AUDIO;
>         codec->media_codec_type = endpoint->codec;
>         memcpy(codec->data, cap->data, cap->len);
> --
> 1.8.5.2

Applied, thanks.


-- 
Luiz Augusto von Dentz

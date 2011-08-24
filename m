Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1314027047-5476-5-git-send-email-frederic.dalleau@linux.intel.com>
References: <1314027047-5476-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1314027047-5476-5-git-send-email-frederic.dalleau@linux.intel.com>
Date: Wed, 24 Aug 2011 13:53:31 +0300
Message-ID: <CABBYNZLsX7B=f4YUzcv8LY5ZiWP1JNCTaeucdH6p=KRn5BPdzQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] Update g_strcmp0 to strcasecmp
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

2011/8/22 Frédéric Dalleau <frederic.dalleau@linux.intel.com>:
> ---
>  audio/media.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/audio/media.c b/audio/media.c
> index ae2b471..5ab3eab 100644
> --- a/audio/media.c
> +++ b/audio/media.c
> @@ -639,7 +639,7 @@ static struct media_endpoint *media_endpoint_create(struct media_adapter *adapte
>                if (endpoint->sep == NULL)
>                        goto failed;
>        } else if (strcasecmp(uuid, HFP_AG_UUID) == 0 ||
> -                                       g_strcmp0(uuid, HSP_AG_UUID) == 0) {
> +                                       strcasecmp(uuid, HSP_AG_UUID) == 0) {
>                struct audio_device *dev;
>
>                endpoint->hs_watch = headset_add_state_cb(headset_state_changed,
> --
> 1.7.1
>
> --

Ack

-- 
Luiz Augusto von Dentz

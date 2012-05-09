Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1336560327-20483-1-git-send-email-joohi.rastogi@stericsson.com>
References: <1336560327-20483-1-git-send-email-joohi.rastogi@stericsson.com>
Date: Wed, 9 May 2012 10:04:28 -0700
Message-ID: <CABBYNZLxAUATMf3H9ZwdP1FU0aG34fS_PP69nD0KB6t37pCz_g@mail.gmail.com>
Subject: Re: [PATCH] AVRCP: Add missing Player Setting feature in TG record
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: joohi.rastogi@stericsson.com
Cc: User Name <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, May 9, 2012 at 3:45 AM,  <joohi.rastogi@stericsson.com> wrote:
> From: Joohi Rastogi <joohi.rastogi@stericsson.com>
>
> ---
>  audio/avrcp.c |   15 +++++++++++++--
>  1 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index df39d04..22cc933 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -89,6 +89,12 @@
>  #define CAP_COMPANY_ID         0x02
>  #define CAP_EVENTS_SUPPORTED   0x03
>
> +#define AVRCP_FEATURE_CATEGORY_1               0x0001
> +#define AVRCP_FEATURE_CATEGORY_2               0x0002
> +#define AVRCP_FEATURE_CATEGORY_3               0x0004
> +#define AVRCP_FEATURE_CATEGORY_4               0x0008
> +#define AVRCP_FEATURE_PLAYER_SETTINGS          0x0010
> +

There seems to be 2 different things, first it adds defines to
category features and second it adds  player settings feature support,
can you split them?


-- 
Luiz Augusto von Dentz

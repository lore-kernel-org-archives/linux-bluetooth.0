Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1337600889-23515-1-git-send-email-joohi.rastogi@stericsson.com>
References: <1337600889-23515-1-git-send-email-joohi.rastogi@stericsson.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 21 May 2012 11:55:07 -0300
Message-ID: <CAMOw1v7sOOOiP9-wTGs-_HuLEJoWZKGKQxY59Y-n3JGPHpjyWw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2 v2] AVRCP: Refactor the code using constants
To: joohi.rastogi@stericsson.com
Cc: User Name <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, May 21, 2012 at 8:48 AM,  <joohi.rastogi@stericsson.com> wrote:
> From: Joohi Rastogi <joohi.rastogi@stericsson.com>
>
> ---
>  audio/avrcp.c |   17 +++++++++++++++--
>  1 files changed, 15 insertions(+), 2 deletions(-)
>  mode change 100644 => 100755 audio/avrcp.c
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> old mode 100644
> new mode 100755
> index d278d4e..356fd76
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -94,6 +94,11 @@
>
>  #define AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH 5
>
> +#define AVRCP_FEATURE_CATEGORY_1       0x0001
> +#define AVRCP_FEATURE_CATEGORY_2       0x0002
> +#define AVRCP_FEATURE_CATEGORY_3       0x0004
> +#define AVRCP_FEATURE_CATEGORY_4       0x0008
> +
>  enum battery_status {
>        BATTERY_STATUS_NORMAL =         0,
>        BATTERY_STATUS_WARNING =        1,
> @@ -179,7 +184,11 @@ static sdp_record_t *avrcp_ct_record(void)
>        sdp_record_t *record;
>        sdp_data_t *psm, *version, *features;
>        uint16_t lp = AVCTP_PSM;
> -       uint16_t avrcp_ver = 0x0100, avctp_ver = 0x0103, feat = 0x000f;
> +       uint16_t avrcp_ver = 0x0100, avctp_ver = 0x0103;
> +       uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
> +                                               AVRCP_FEATURE_CATEGORY_2 |
> +                                               AVRCP_FEATURE_CATEGORY_3 |
> +                                               AVRCP_FEATURE_CATEGORY_4 );
>
>        record = sdp_record_alloc();
>        if (!record)
> @@ -243,7 +252,11 @@ static sdp_record_t *avrcp_tg_record(void)
>        sdp_record_t *record;
>        sdp_data_t *psm, *version, *features;
>        uint16_t lp = AVCTP_PSM;
> -       uint16_t avrcp_ver = 0x0104, avctp_ver = 0x0103, feat = 0x000f;
> +       uint16_t avrcp_ver = 0x0104, avctp_ver = 0x0103;
> +       uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
> +                                               AVRCP_FEATURE_CATEGORY_2 |
> +                                               AVRCP_FEATURE_CATEGORY_3 |
> +                                               AVRCP_FEATURE_CATEGORY_4 );


Ack


Lucas De Marchi

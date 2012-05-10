Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1336631204-25794-1-git-send-email-joohi.rastogi@stericsson.com>
References: <1336631204-25794-1-git-send-email-joohi.rastogi@stericsson.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Thu, 10 May 2012 12:40:28 -0300
Message-ID: <CAMOw1v4uBEcFL5wKiz7VumK_+69y7SVHgaQSjXkK5bdm1oM4uA@mail.gmail.com>
Subject: Re: [PATCH 1/2] AVRCP: Refactor the code using constants
To: joohi.rastogi@stericsson.com
Cc: User Name <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, May 10, 2012 at 3:26 AM,  <joohi.rastogi@stericsson.com> wrote:
> From: Joohi Rastogi <joohi.rastogi@stericsson.com>
>
> Adds macros for category features
> ---
>  audio/avrcp.c |   13 +++++++++++--
>  1 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/audio/avrcp.c b/audio/avrcp.c
> index df39d04..1b35c3f 100644
> --- a/audio/avrcp.c
> +++ b/audio/avrcp.c
> @@ -89,6 +89,11 @@
>  #define CAP_COMPANY_ID         0x02
>  #define CAP_EVENTS_SUPPORTED   0x03
>
> +#define AVRCP_FEATURE_CATEGORY_1       0x0001
> +#define AVRCP_FEATURE_CATEGORY_2       0x0002
> +#define AVRCP_FEATURE_CATEGORY_3       0x0004
> +#define AVRCP_FEATURE_CATEGORY_4       0x0008
> +
>  enum battery_status {
>        BATTERY_STATUS_NORMAL =         0,
>        BATTERY_STATUS_WARNING =        1,
> @@ -174,7 +179,9 @@ static sdp_record_t *avrcp_ct_record(void)
>        sdp_record_t *record;
>        sdp_data_t *psm, *version, *features;
>        uint16_t lp = AVCTP_PSM;
> -       uint16_t avrcp_ver = 0x0100, avctp_ver = 0x0103, feat = 0x000f;
> +       uint16_t avrcp_ver = 0x0100, avctp_ver = 0x0103;
> +       uint16_t feat = (AVRCP_FEATURE_CATEGORY_1 | AVRCP_FEATURE_CATEGORY_2
> +               | AVRCP_FEATURE_CATEGORY_3 | AVRCP_FEATURE_CATEGORY_4);
>
>        record = sdp_record_alloc();
>        if (!record)
> @@ -238,7 +245,9 @@ static sdp_record_t *avrcp_tg_record(void)
>        sdp_record_t *record;
>        sdp_data_t *psm, *version, *features;
>        uint16_t lp = AVCTP_PSM;
> -       uint16_t avrcp_ver = 0x0103, avctp_ver = 0x0103, feat = 0x000f;
> +       uint16_t avrcp_ver = 0x0103, avctp_ver = 0x0103;
> +       uint16_t feat = (AVRCP_FEATURE_CATEGORY_1 | AVRCP_FEATURE_CATEGORY_2
> +               | AVRCP_FEATURE_CATEGORY_3 | AVRCP_FEATURE_CATEGORY_4);

Humn... just a matter of taste, I'm ok with it


Ack

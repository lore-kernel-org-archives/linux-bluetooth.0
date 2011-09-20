Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1316540841-14713-10-git-send-email-sancane@gmail.com>
References: <1316540841-14713-1-git-send-email-sancane@gmail.com>
	<1316540841-14713-2-git-send-email-sancane@gmail.com>
	<1316540841-14713-3-git-send-email-sancane@gmail.com>
	<1316540841-14713-4-git-send-email-sancane@gmail.com>
	<1316540841-14713-5-git-send-email-sancane@gmail.com>
	<1316540841-14713-6-git-send-email-sancane@gmail.com>
	<1316540841-14713-7-git-send-email-sancane@gmail.com>
	<1316540841-14713-8-git-send-email-sancane@gmail.com>
	<1316540841-14713-9-git-send-email-sancane@gmail.com>
	<1316540841-14713-10-git-send-email-sancane@gmail.com>
Date: Tue, 20 Sep 2011 22:28:39 +0200
Message-ID: <CACLukzLcLmbmPwXX6OOM4RLFc4BfAaAWJibVssxtm8aqgud4zQ@mail.gmail.com>
Subject: Re: [PATCH 09/19] Set Intermediate property if intermediate temp.
 characteristic is supported
From: Santiago Carot <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is only a set  of 9 patches. Subject should seem as [PATCH X/09].
In any case, patches are valid.

Sorry for the mess.

Regards

2011/9/20 Santiago Carot-Nemesio <sancane@gmail.com>:
> ---
>  thermometer/thermometer.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
> index 0178e99..fdf459e 100644
> --- a/thermometer/thermometer.c
> +++ b/thermometer/thermometer.c
> @@ -258,7 +258,8 @@ static void process_thermometer_char(struct characteristic *ch)
>        GAttribResultFunc func;
>
>        if (g_strcmp0(ch->attr.uuid, INTERMEDIATE_TEMPERATURE_UUID) == 0) {
> -               /* TODO: Change intermediate property and emit signal */
> +               gboolean intermediate = TRUE;
> +               change_property(ch->t, "Intermediate", &intermediate);
>                return;
>        } else if (g_strcmp0(ch->attr.uuid, TEMPERATURE_TYPE_UUID) == 0)
>                func = read_temp_type_cb;
> --
> 1.7.6.1
>
>

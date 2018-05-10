Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1524045561-14167-1-git-send-email-ankit.p.navik@intel.com>
References: <1524045561-14167-1-git-send-email-ankit.p.navik@intel.com>
From: bharat panda <bharat22bhusan@gmail.com>
Date: Thu, 10 May 2018 09:50:40 +0530
Message-ID: <CANBo3n-hV2ZCXV6xpg3HNqGpzZLDB=Ed8ZM-o4ugWquMomw0aw@mail.gmail.com>
Subject: Re: [PATCH] src/profile: Updates HFP version to 1.7
To: Ankit Navik <ankit.p.navik@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ankit,

Is this to upgrade BlueZ HFP version to 1.7 so that oFono can get this
version to proceed with 1.7 specific commands?
If so, then please update the commit message in detail and the patch
looks good to me, someone should approve.

On Wed, Apr 18, 2018 at 3:29 PM, Ankit Navik <ankit.p.navik@intel.com> wrote:
> Add changes to update HFP version to 0x0107 for HFP_HS_UUID and
> HFP_AG_UUID.
> ---
>  src/profile.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/src/profile.c b/src/profile.c
> index 7c5318c..1e9c585 100644
> --- a/src/profile.c
> +++ b/src/profile.c
> @@ -1971,7 +1971,7 @@ static struct default_settings {
>                 .authorize      = true,
>                 .auto_connect   = true,
>                 .get_record     = get_hfp_hf_record,
> -               .version        = 0x0105,
> +               .version        = 0x0107,
>         }, {
>                 .uuid           = HFP_AG_UUID,
>                 .name           = "Hands-Free Voice gateway",
> @@ -1981,7 +1981,7 @@ static struct default_settings {
>                 .authorize      = true,
>                 .auto_connect   = true,
>                 .get_record     = get_hfp_ag_record,
> -               .version        = 0x0105,
> +               .version        = 0x0107,
>         }, {
>                 .uuid           = HSP_AG_UUID,
>                 .name           = "Headset Voice gateway",
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Bharat

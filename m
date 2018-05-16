Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
References: <1525944723-2238-1-git-send-email-ankit.p.navik@intel.com>
In-Reply-To: <1525944723-2238-1-git-send-email-ankit.p.navik@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 16 May 2018 15:48:27 +0300
Message-ID: <CABBYNZL_p=59CUAnR+n9Ef3w9MOX5ApNFf149LeC-MQNsKtjig@mail.gmail.com>
Subject: Re: [PATCH] src/profile: Updates HFP version to 1.7
To: ankit.p.navik@intel.com
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        bharat panda <bharat22bhusan@gmail.com>,
        ankit.p.navik.intel.com@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ankit,

On Thu, May 10, 2018 at 12:33 PM Ankit Navik <ankit.p.navik@intel.com>
wrote:

> Add changes to update HFP version to 0x0107 for HFP_HS_UUID and
> HFP_AG_UUID. Ofono get this version from bluez and enable HFP 1.7
> specific commands.
> ---
>   src/profile.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/src/profile.c b/src/profile.c
> index 7c5318c..1e9c585 100644
> --- a/src/profile.c
> +++ b/src/profile.c
> @@ -1971,7 +1971,7 @@ static struct default_settings {
>                  .authorize      = true,
>                  .auto_connect   = true,
>                  .get_record     = get_hfp_hf_record,
> -               .version        = 0x0105,
> +               .version        = 0x0107,
>          }, {
>                  .uuid           = HFP_AG_UUID,
>                  .name           = "Hands-Free Voice gateway",
> @@ -1981,7 +1981,7 @@ static struct default_settings {
>                  .authorize      = true,
>                  .auto_connect   = true,
>                  .get_record     = get_hfp_ag_record,
> -               .version        = 0x0105,
> +               .version        = 0x0107,
>          }, {
>                  .uuid           = HSP_AG_UUID,
>                  .name           = "Headset Voice gateway",
> --
> 2.7.4

Applied, thanks.

-- 
Luiz Augusto von Dentz

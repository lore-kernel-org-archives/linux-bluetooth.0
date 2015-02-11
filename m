Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] tools/mcaptest: Minor style fix
Date: Wed, 11 Feb 2015 11:36:30 +0100
Message-ID: <2328160.N5DTzQFa17@leonov>
In-Reply-To: <1423588650-12191-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1423588650-12191-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Tuesday 10 of February 2015 18:17:26 Grzegorz Kolodziejczyk wrote:
> This patch add white lines between neighbouring bodys.
> ---
>  tools/mcaptest.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/mcaptest.c b/tools/mcaptest.c
> index 42734eb..980d21a 100644
> --- a/tools/mcaptest.c
> +++ b/tools/mcaptest.c
> @@ -286,6 +286,7 @@ static void create_mcl_cb(struct mcap_mcl *mcap_mcl,
> GError *err, gpointer data) mcl = mcap_mcl_ref(mcap_mcl);
>  	trigger_mdl_action(data_mode);
>  }
> +
>  static void usage(void)
>  {
>  	printf("mcaptest - MCAP testing ver %s\n", VERSION);
> @@ -320,6 +321,7 @@ static struct option main_options[] = {
>  	{ "data_ch",		1, 0, 'D' },
>  	{ 0, 0, 0, 0 }
>  };
> +
>  int main(int argc, char *argv[])
>  {
>  	GError *err = NULL;

All patches applied, thanks.

-- 
BR
Szymon Janc

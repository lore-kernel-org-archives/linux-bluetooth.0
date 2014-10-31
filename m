Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tools/mcaptest: Add missing MCL connected log
Date: Fri, 31 Oct 2014 20:15:43 +0100
Message-ID: <1712504.q1dkamJFpZ@leonov>
In-Reply-To: <1414667707-2640-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1414667707-2640-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Thursday 30 of October 2014 12:15:06 Grzegorz Kolodziejczyk wrote:
> Loging state of MCAP channels is very helpful while analyzing
> connection.
> ---
>  tools/mcaptest.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/mcaptest.c b/tools/mcaptest.c
> index dd638c9..6d50544 100644
> --- a/tools/mcaptest.c
> +++ b/tools/mcaptest.c
> @@ -257,6 +257,8 @@ static void mcl_connected(struct mcap_mcl *mcap_mcl,
> gpointer data)
> 
>  static void create_mcl_cb(struct mcap_mcl *mcap_mcl, GError *err, gpointer
> data) {
> +	printf("%s\n", __func__);
> +
>  	if (err) {
>  		printf("Could not connect MCL: %s\n", err->message);

Applied, thanks.

-- 
BR
Szymon Janc

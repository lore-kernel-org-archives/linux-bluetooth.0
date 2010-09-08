Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 Sep 2010 19:48:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix closing stream of locked sep when reconfiguring
Message-ID: <20100908164822.GA7655@jh-x301>
References: <1283958823-4811-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1283958823-4811-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Sep 08, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> Stream should only be closed if sep is unlocked otherwise there is a
> possibility that sep reconfiguration is triggered although the sep is in
> use by the user application.
> ---
>  audio/a2dp.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/audio/a2dp.c b/audio/a2dp.c
> index b062aed..ef0df17 100644
> --- a/audio/a2dp.c
> +++ b/audio/a2dp.c
> @@ -1393,6 +1393,8 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
>  		}
>  
>  		if (l != NULL) {
> +			if (a2dp_sep_get_lock(tmp))
> +				goto failed;
>  			setup->reconfigure = TRUE;
>  			if (avdtp_close(session, tmp->stream, FALSE) < 0) {
>  				error("avdtp_close failed");

Thanks for the patch! It's now in the upstream tree.

Johan

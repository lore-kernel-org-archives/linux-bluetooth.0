Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Nov 2010 12:26:30 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] Code clean up: pbap->params = params removed
Message-ID: <20101111102629.GJ4132@jh-x301>
References: <1289460972-2971-1-git-send-email-dmitriy.paliy@nokia.com>
 <1289460972-2971-2-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289460972-2971-2-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Thu, Nov 11, 2010, Dmitriy Paliy wrote:
> pbap->params = params; removed due to the fact that this assignment is
> already used in the same function.
> ---
>  plugins/pbap.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/plugins/pbap.c b/plugins/pbap.c
> index 7b9f1ff..af60741 100644
> --- a/plugins/pbap.c
> +++ b/plugins/pbap.c
> @@ -617,7 +617,6 @@ static int pbap_get(struct obex_session *os, obex_object_t *obj,
>  	if (path == NULL)
>  		return -EBADR;
>  
> -	pbap->params = params;
>  	ret = obex_get_stream_start(os, path);
>  
>  	g_free(path);

Pushed upstream. Thanks.

Johan

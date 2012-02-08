Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 Feb 2012 10:21:25 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] attrib-server: Fix memory leak attaching attribute
 channels
Message-ID: <20120208082123.GA5917@aemeltch-MOBL1>
References: <1328621205-14440-1-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328621205-14440-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Tue, Feb 07, 2012 at 02:26:44PM +0100, Santiago Carot-Nemesio wrote:
> Channel is not being released when the channel is attached over
> an uninitialized GATT server.
> ---
>  src/attrib-server.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/src/attrib-server.c b/src/attrib-server.c
> index 2995167..e51f695 100644
> --- a/src/attrib-server.c
> +++ b/src/attrib-server.c
> @@ -1020,8 +1020,14 @@ guint attrib_channel_attach(GAttrib *attrib, gboolean out)
>  	}
>  
>  	server = find_gatt_server(&channel->src);
> -	if (server == NULL)
> +	if (server == NULL) {
> +		char src[18];

Don't we have a good define for this magic number? I saw it in several
places.

Best regards 
Andrei Emeltchenko 



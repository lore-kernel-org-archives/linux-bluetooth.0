Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Jan 2011 15:03:33 +0530
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, vinicius.gomes@openbossa.org,
	claudio.takahasi@openbossa.org, padovan@profusion.mobi,
	rshaffer@codeaurora.org
Subject: Re: [PATCH 2/3] Fix Handle range if Pri/Sec Service is Empty
Message-ID: <20110120093333.GC540@jh-x301>
References: <1295474453-8495-1-git-send-email-bgix@codeaurora.org>
 <1295474453-8495-3-git-send-email-bgix@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1295474453-8495-3-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Wed, Jan 19, 2011, Brian Gix wrote:
> ---
>  src/attrib-server.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/src/attrib-server.c b/src/attrib-server.c
> index 04bc1ec..f38d61a 100644
> --- a/src/attrib-server.c
> +++ b/src/attrib-server.c
> @@ -242,6 +242,7 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
>  
>  		last_size = a->len;
>  		old = cur;
> +		last_handle = cur->handle;
>  	}
>  
>  	if (groups == NULL)

Pushed upstream. Thanks.

Johan

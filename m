Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 May 2011 22:31:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Change append to prepend in media_transport_add
Message-ID: <20110529193142.GA4687@dell.Elisa>
References: <1306499060-10415-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306499060-10415-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Fri, May 27, 2011, Dmitriy Paliy wrote:
> ---
>  audio/transport.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/audio/transport.c b/audio/transport.c
> index 702bef2..85358c7 100644
> --- a/audio/transport.c
> +++ b/audio/transport.c
> @@ -487,7 +487,7 @@ static void media_transport_add(struct media_transport *transport,
>  					struct media_owner *owner)
>  {
>  	DBG("Transport %s Owner %s", transport->path, owner->name);
> -	transport->owners = g_slist_append(transport->owners, owner);
> +	transport->owners = g_slist_prepend(transport->owners, owner);
>  	owner->transport = transport;
>  }

Since this is an optimization you should include proper justification
for it in the commit message body (it's ok for the summary to answer the
question "what?" but the body should answer the "why?"). I.e. something
along the lines of "This is a performance critical part of the code and
the ordering of elements doesn't matter, so use prepend instead of
append". Btw, if this *isn't* a performance critical part of the code
I'm not sure it's worth going about doing patches like this.

Johan

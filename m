Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Oct 2010 23:34:36 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	Par-Gunnar.p.HJALMDAHL@stericsson.com
Subject: Re: [PATCH] Unref pending call in fallback scenario.
Message-ID: <20101014203436.GA9279@jh-x301>
References: <1287069227-4076-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1287069227-4076-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Thu, Oct 14, 2010, Lukasz Rymanowski wrote:
> Drop the reference to pending call in fallback scenario.
> Otherwise, dbus will assert once timer expires.
> ---
>  src/agent.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/src/agent.c b/src/agent.c
> index c7fdbd4..b65a550 100644
> --- a/src/agent.c
> +++ b/src/agent.c
> @@ -706,6 +706,7 @@ static int request_fallback(struct agent_request *req,
>  		return -EINVAL;
>  
>  	dbus_pending_call_cancel(req->call);
> +	dbus_pending_call_unref(req->call);
>  
>  	msg = dbus_message_copy(req->msg);
>  

Good catch. The patch has been pushed upstream. Over the last few years
I've bumped into this libdbus issue several times but it seems this
particular code path (request_fallback) gets triggered seldom enough for
it to not have surfaced earlier. I also vaguely remember that this got
fixed in newer D-Bus versions so those might not assert in this case
anymore.

Johan

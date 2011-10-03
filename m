Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Oct 2011 11:55:34 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix Unref message after it was sent
Message-ID: <20111003085534.GE8956@fusion.localdomain>
References: <1317392251-13576-1-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1317392251-13576-1-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Fri, Sep 30, 2011, Frédéric Danis wrote:
> ---
>  audio/gateway.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/audio/gateway.c b/audio/gateway.c
> index 19c7ee3..1a1c035 100644
> --- a/audio/gateway.c
> +++ b/audio/gateway.c
> @@ -186,6 +186,7 @@ static gboolean agent_sendfd(struct hf_agent *agent, int fd,
>  
>  	dbus_pending_call_set_notify(call, notify, dev, NULL);
>  	dbus_pending_call_unref(call);
> +	dbus_message_unref(msg);
>  
>  	return TRUE;
>  }

Applied. Thanks.

Johan

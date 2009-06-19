Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Kill session whenever VIRTUAL_CABLE_UNPLUG
 is passed.
From: Marcel Holtmann <marcel@holtmann.org>
To: Vikram Kandukuri <vkandukuri@atheros.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20090620061927.GC9947@atheros-laptop>
References: <20090620061927.GC9947@atheros-laptop>
Content-Type: text/plain
Date: Fri, 19 Jun 2009 11:36:02 +0200
Message-Id: <1245404162.15367.44.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vikram,

> Whenever the remote device sends VIRTUAL CABLE UNPLUG, the device should
> be disconnected.
> 
> Signed-off-by: Jothikumar Mothilal <jothikumar.mothilal@atheros.com>
> ---
>  net/bluetooth/hidp/core.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> index b186768..a9f7afb 100644
> --- a/net/bluetooth/hidp/core.c
> +++ b/net/bluetooth/hidp/core.c
> @@ -374,6 +374,7 @@ static void hidp_process_hid_control(struct hidp_session *session,
>  
>  		/* Kill session thread */
>  		atomic_inc(&session->terminate);
> +		hidp_schedule(session);
>  	}
>  }

the patch is correct, but the commit message could be a little bit more
verbose. It should explain why this fixes it.

Regards

Marcel



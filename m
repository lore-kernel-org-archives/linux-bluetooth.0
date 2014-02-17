Return-Path: <cyrus@holtmann.org>
Date: Mon, 17 Feb 2014 13:31:03 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/6] emulator/bthost: Add api to handle RFCOMM data on
 bthost
Message-ID: <20140217113103.GD4004@x220.p-661hnu-f1>
References: <1392205301-4204-1-git-send-email-marcin.kraglak@tieto.com>
 <1392205301-4204-2-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392205301-4204-2-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wed, Feb 12, 2014, Marcin Kraglak wrote:
> With this change user can handle data received on RFCOMM connection.
> ---
>  emulator/bthost.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++----
>  emulator/bthost.h |  8 +++++++
>  2 files changed, 74 insertions(+), 4 deletions(-)
> 
> diff --git a/emulator/bthost.c b/emulator/bthost.c
> index 8447817..92ae08a 100644
> --- a/emulator/bthost.c
> +++ b/emulator/bthost.c
> @@ -126,6 +126,13 @@ struct cid_hook {
>  	struct cid_hook *next;
>  };
>  
> +struct channel_hook {

Since this is RFCOMM specific and the concept of channels exists also
with L2CAP I'd include "rfcomm" somewhere in the struct name.

> @@ -232,6 +240,12 @@ static void btconn_free(struct btconn *conn)
>  		conn->cid_hooks = hook->next;
>  		free(hook);
>  	}
> +	while (conn->channel_hooks) {

Coding style: empty line before the while statement.

> +void bthost_add_channel_hook(struct bthost *bthost, uint16_t handle,
> +					uint8_t channel,
> +					bthost_channel_hook_func_t func,
> +					void *user_data);

Here you should also have "rfcomm" somewhere in the name since it's
RFCOMM specific and we don't people to confuse this with L2CAP.

Johan

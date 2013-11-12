Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Nov 2013 15:47:41 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Szymon Janc <szymon.janc@tieto.com>
Subject: Re: [PATCH 1/7] android: Remove bt_adapter structure
Message-ID: <20131112134741.GH22931@x220.p-661hnu-f1>
References: <1384215857-19679-1-git-send-email-szymon.janc@tieto.com>
 <1384215857-19679-2-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384215857-19679-2-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Nov 12, 2013, Szymon Janc wrote:
> Only one controller is used so there is no need to keep extra
> abstraction for it.
> ---
>  android/adapter.c | 271 +++++++++++++++++++++++++-----------------------------
>  1 file changed, 123 insertions(+), 148 deletions(-)
> 
> diff --git a/android/adapter.c b/android/adapter.c
> index 65b3170..e161f9d 100644
> --- a/android/adapter.c
> +++ b/android/adapter.c
> @@ -58,23 +58,17 @@ static int notification_sk = -1;
>  /* This list contains addresses which are asked for records */
>  static GSList *browse_reqs;
>  
> -struct bt_adapter {
> -	uint16_t index;
> -	struct mgmt *mgmt;
> +static uint16_t adapter_index = MGMT_INDEX_NONE;
> +static struct mgmt *mgmt_if = NULL;
> +static bt_adapter_ready adapter_ready = NULL;
> +static bdaddr_t adapter_bdaddr;
> +static uint32_t adapter_dev_class = 0;
> +static char *adapter_name = NULL;
> +static uint32_t current_settings = 0;

To be honest I'm not really liking this loss of some kind of
organization/grouping of these variables. Even if we don't dynamically
allocate a struct I'd rather have these collected up in their own static
struct, something like:

static struct adapter {
	uint16_t index;
	...
	...
} adapter;

and then later e.g.:

{
	if (adapter.index == MGMT_INDEX_NONE)
		return;

	...
}

This way you also get an automatic prefix for all the adapter variables
and don't need to include it explicitly in each variable name.

Things which are not directly tied together with the adapter (like
struct mgmt) you can possibly leave outside of the struct as separate
variables though.

Johan

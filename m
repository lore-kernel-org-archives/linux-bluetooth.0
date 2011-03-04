Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Mar 2011 15:38:26 -0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Subject: Re: [PATCH] Fix adapter reference count in input plugin
Message-ID: <20110304183826.GB21452@jh-x301>
References: <1299059097-24462-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1299059097-24462-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Mar 02, 2011, Szymon Janc wrote:
> Adapter unref was called  on driver removal even if input server
> failed to start on probe and reference was not incremented. This leads
> to segmentation fault while removing adapter.
> ---
>  input/manager.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/input/manager.c b/input/manager.c
> index a98a080..259aef7 100644
> --- a/input/manager.c
> +++ b/input/manager.c
> @@ -143,6 +143,9 @@ static void hid_server_remove(struct btd_adapter *adapter)
>  {
>  	bdaddr_t src;
>  
> +	if (!g_slist_find(adapters, adapter))
> +		return;
> +
>  	adapter_get_address(adapter, &src);
>  
>  	server_stop(&src);

This one looks like it's working around the core issue instead of fixing
it. The _remove function shouldn't get called if _probe failed. I.e. the
issue seems to be somewhere in the core daemon.

Johan

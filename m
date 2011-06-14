Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Jun 2011 16:02:52 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/2] Add function to get default adapter ID
Message-ID: <20110614130252.GA4215@dell.ger.corp.intel.com>
References: <1307627589-25786-1-git-send-email-hadess@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1307627589-25786-1-git-send-email-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Thu, Jun 09, 2011, Bastien Nocera wrote:
> Combined with manager_find_adapter_by_id(), it is now possible
> to get the btd_adapter struct for the default adapter:
> manager_find_adapter_by_id (manager_get_default_adapter_id ());
> ---
>  src/manager.c |    8 ++++++++
>  src/manager.h |    1 +
>  2 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/src/manager.c b/src/manager.c
> index e805e0c..9d0de25 100644
> --- a/src/manager.c
> +++ b/src/manager.c
> @@ -288,6 +288,11 @@ static void manager_remove_adapter(struct btd_adapter *adapter)
>  		btd_start_exit_timer();
>  }
>  
> +int manager_get_default_adapter_id(void)
> +{
> +	return default_adapter_id;
> +}

Would it not make more sense to have something that returns the adapter
object directly? I.e. are there actually any use cases where some plugin
would want the id but *not* want to resolve the matching adapter object?
And even if the plugin still needs the id (which I'd expect to be a
minority use-case if it exists at all) it can always call
adapter_get_dev_id().

Johan

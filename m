Return-Path: <cyrus@holtmann.org>
Date: Fri, 27 Jun 2014 17:13:02 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 5/5] android/health: Implement destroy_channel call
Message-ID: <20140627141224.GB21456@aemeltch-MOBL1>
References: <1403818246-20205-1-git-send-email-ravikumar.veeramally@linux.intel.com>
 <1403818246-20205-6-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403818246-20205-6-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jun 27, 2014 at 12:30:46AM +0300, Ravi kumar Veeramally wrote:
> Delete MDL channel with MDL_DELETE_REQ.
> ---
>  android/health.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/android/health.c b/android/health.c
> index db3ae9c..e464f78 100644
> --- a/android/health.c
> +++ b/android/health.c
> @@ -1637,19 +1637,40 @@ fail:
>  			HAL_OP_HEALTH_CONNECT_CHANNEL, HAL_STATUS_FAILED);
>  }
>  
> +static void channel_delete_cb(GError *gerr, gpointer data)
> +{
> +	struct health_channel *channel = data;
> +
> +	DBG("");
> +
> +	if (!gerr) {
> +		error("health: channel delete failed %s", gerr->message);

I think this one may not work. I have sent a patch for this issue.

Best regards 
Andrei Emeltchenko 


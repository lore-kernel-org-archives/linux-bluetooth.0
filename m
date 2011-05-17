Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 May 2011 09:13:26 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 03/12] Move legacy verification to a new function
Message-ID: <20110517161326.GA20885@dell.ice.intel.com>
References: <1305579001-3019-1-git-send-email-claudio.takahasi@openbossa.org>
 <1305579001-3019-3-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1305579001-3019-3-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Mon, May 16, 2011, Claudio Takahasi wrote:
> ---
>  src/adapter.c |   40 ++++++++++++++++++++++++++++------------
>  1 files changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 3188974..6f85abf 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -3002,6 +3002,31 @@ void adapter_update_device_from_info(struct btd_adapter *adapter,
>  	adapter_emit_device_found(adapter, dev);
>  }
>  
> +static int pairing_is_legacy(bdaddr_t *local, bdaddr_t *peer, gboolean eir,
> +					gboolean name, gboolean *legacy)
> +{

The first two patches in this set have been pushed upstream, however
could you consider the following change to this one: since you just
assume legacy == TRUE if the storage read fails, why not just make this
pairing_is_legacy function return a gboolean instead of returning the
value by reference? (it's look cleaner, especially considering the name
of the function)

Johan

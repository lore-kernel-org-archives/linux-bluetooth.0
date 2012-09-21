Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Sep 2012 13:17:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 06/18] adapter: Handle missing randomizer in
 btd_adapter_add_remote_oob_data
Message-ID: <20120921101723.GA4441@x220>
References: <1348221750-15345-1-git-send-email-szymon.janc@tieto.com>
 <1348221750-15345-7-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348221750-15345-7-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Sep 21, 2012, Szymon Janc wrote:
> Randomizer is optional. Handling missing randomizer in
> btd_adapter_add_remote_oob_data is easy and will simplify caller code.
> 
> ---
>  plugins/dbusoob.c |    7 -------
>  src/adapter.c     |    7 +++++++
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
> index a66c21d..ce9e5d4 100644
> --- a/plugins/dbusoob.c
> +++ b/plugins/dbusoob.c
> @@ -233,13 +233,6 @@ static gboolean store_data(struct btd_adapter *adapter, struct oob_data *data)
>  	adapter_get_address(adapter, &local);
>  
>  	if (data->hash) {
> -		uint8_t empty_randomizer[16];
> -
> -		if (!data->randomizer) {
> -			memset(empty_randomizer, 0, sizeof(empty_randomizer));
> -			data->randomizer = empty_randomizer;
> -		}
> -
>  		if (btd_adapter_add_remote_oob_data(adapter, &bdaddr,
>  					data->hash, data->randomizer) < 0)
>  			return FALSE;
> diff --git a/src/adapter.c b/src/adapter.c
> index d34e966..a00522a 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -3574,6 +3574,13 @@ int btd_adapter_read_local_oob_data(struct btd_adapter *adapter)
>  int btd_adapter_add_remote_oob_data(struct btd_adapter *adapter,
>  			bdaddr_t *bdaddr, uint8_t *hash, uint8_t *randomizer)
>  {
> +	uint8_t empty_randomizer[16];
> +
> +	if (!randomizer) {
> +		memset(empty_randomizer, 0, sizeof(empty_randomizer));
> +		randomizer = empty_randomizer;
> +	}
> +
>  	return mgmt_add_remote_oob_data(adapter->dev_id, bdaddr, hash,
>  								randomizer);

I'd rather have mgmt_add_remote_oob_data accept a NULL pointer and have
the randomizer memcpy behind a NULL test (the code is anyway already
initializing the send buffer to zeros).

Johan

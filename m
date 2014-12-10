Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 3/4] android/bluetooth: Load IRK on adapter start
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1418220974-12287-4-git-send-email-lukasz.rymanowski@tieto.com>
Date: Wed, 10 Dec 2014 16:40:50 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8C9FA303-A444-4849-96F4-E120D2859E6E@holtmann.org>
References: <1418220974-12287-1-git-send-email-lukasz.rymanowski@tieto.com> <1418220974-12287-4-git-send-email-lukasz.rymanowski@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

> If IRK is not found it will be generated
> ---
> android/bluetooth.c | 29 +++++++++++++++++++++++++++++
> 1 file changed, 29 insertions(+)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index 8865eac..1d5d26d 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -294,6 +294,22 @@ static void store_adapter_config(void)
> 	g_key_file_free(key_file);
> }
> 
> +static void generate_irk(void)
> +{
> +	int i;
> +
> +	srand(time(NULL));
> +
> +	/* Need to generate 16 octets */
> +	for (i = 0; i < 16; i =+ 4) {
> +		int a = rand();
> +
> +		memcpy(&adapter.irk[i], &a, 4);
> +	}
> +
> +	store_adapter_config();
> +}

bt_crypto_random_bytes() please.

Regards

Marcel


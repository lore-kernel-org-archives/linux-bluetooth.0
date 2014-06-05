Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH 1/2] android/client: Fix reversing send_response values
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1401985955-13502-1-git-send-email-marcin.kraglak@tieto.com>
Date: Thu, 5 Jun 2014 18:54:51 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <98CCDBAF-AEE9-40C7-AD1D-C8CEC69FDA9A@holtmann.org>
References: <1401985955-13502-1-git-send-email-marcin.kraglak@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

> We don't want to reverse data passed to send_response.
> ---
> android/client/if-gatt.c | 32 +++++++++++++++++++++++++++-----
> 1 file changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
> index 0375126..a9c8644 100644
> --- a/android/client/if-gatt.c
> +++ b/android/client/if-gatt.c
> @@ -1750,6 +1750,30 @@ static void gatts_send_indication_p(int argc, const char *argv[])
> 							len, confirm, data);
> }
> 
> +/*
> + * convert hex string to uint8_t array
> + */
> +static int fill_buffer(const char *str, uint8_t *out, int out_size)
> +{
> +	int len = strlen(str);
> +	int length = 0;
> +	int i;
> +
> +	memset(out, 0, out_size);
> +	if (out_size * 2 > len + 1)
> +		out_size = (len + 1) / 2;
> +
> +	for (i = 0; i < out_size && len > length; ++i) {
> +		if (len >= length)
> +			sscanf(str + length, "%02hhx", &out[i]);
> +		else
> +			sscanf(str, "%1hhx", &out[i]);
> +		length += 2;
> +	}
> +
> +	return len/2;
> +}

it is just the client code, but what is this function doing? My brain seriously takes a core dump trying to understand this.

Has anybody actually looked into decode_hex_own_buf or similar from oFono. Using sscanf seems the most inefficient way of handling this.

Regards

Marcel


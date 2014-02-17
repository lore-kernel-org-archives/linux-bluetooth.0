Return-Path: <cyrus@holtmann.org>
Date: Mon, 17 Feb 2014 13:29:15 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/6] tools/rfcomm-tester: Add RFCOMM client write test
 case
Message-ID: <20140217112915.GC4004@x220.p-661hnu-f1>
References: <1392205301-4204-1-git-send-email-marcin.kraglak@tieto.com>
 <1392205301-4204-3-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392205301-4204-3-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wed, Feb 12, 2014, Marcin Kraglak wrote:
> This will test sending data through RFCOMM socket from client to server.
> ---
>  tools/rfcomm-tester.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
> index 44df7e7..80448cb 100644
> --- a/tools/rfcomm-tester.c
> +++ b/tools/rfcomm-tester.c
> @@ -57,6 +57,9 @@ struct rfcomm_client_data {
>  	uint8_t server_channel;
>  	uint8_t client_channel;
>  	int expected_connect_err;
> +	const uint8_t *send_data;
> +	const uint8_t *read_data;
> +	uint16_t data_len;
>  };
>  
>  struct rfcomm_server_data {
> @@ -294,6 +297,15 @@ const struct rfcomm_client_data connect_success = {
>  	.client_channel = 0x0c
>  };
>  
> +const uint8_t data[] = {0, 1, 2, 3, 4, 5, 6, 7, 8};
> +
> +const struct rfcomm_client_data connect_send_success = {
> +	.server_channel = 0x0c,
> +	.client_channel = 0x0c,
> +	.data_len = sizeof(data),
> +	.send_data = data
> +};
> +
>  const struct rfcomm_client_data connect_nval = {
>  	.server_channel = 0x0c,
>  	.client_channel = 0x0e,
> @@ -389,6 +401,13 @@ static gboolean rc_connect_cb(GIOChannel *io, GIOCondition cond,
>  		return false;
>  	}
>  
> +	if (client_data->send_data) {
> +		if (client_data->data_len != write(sk, client_data->send_data,
> +							client_data->data_len))

I'd rather have a separate ssize_t ret variable before the comparison
here.

> +static void client_hook_func(const void *data, uint16_t len,
> +							void *user_data)
> +{
> +	struct test_data *test_data = tester_get_data();
> +	const struct rfcomm_client_data *client_data = test_data->test_data;
> +
> +	if (memcmp(client_data->send_data, data, len))

Missing check of client_data->data_len == len before the memcmp?

Johan

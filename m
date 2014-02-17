Return-Path: <cyrus@holtmann.org>
Date: Mon, 17 Feb 2014 13:28:12 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/6] tools/rfcomm-tester: Add RFCOMM server write test
 case
Message-ID: <20140217112812.GB4004@x220.p-661hnu-f1>
References: <1392205301-4204-1-git-send-email-marcin.kraglak@tieto.com>
 <1392205301-4204-4-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392205301-4204-4-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wed, Feb 12, 2014, Marcin Kraglak wrote:
> This will check data write from server to client.
> ---
>  tools/rfcomm-tester.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
> index 80448cb..1c2563d 100644
> --- a/tools/rfcomm-tester.c
> +++ b/tools/rfcomm-tester.c
> @@ -66,6 +66,9 @@ struct rfcomm_server_data {
>  	uint8_t server_channel;
>  	uint8_t client_channel;
>  	bool expected_status;
> +	const uint8_t *send_data;
> +	const uint8_t *read_data;
> +	uint16_t data_len;

> +static void server_hook_func(const void *data, uint16_t len,
> +							void *user_data)
> +{
> +	struct test_data *test_data = tester_get_data();
> +	const struct rfcomm_server_data *server_data = test_data->test_data;
> +
> +	if (memcmp(server_data->send_data, data, len))

Don't you have to first check that server_data->data_len == len?

> +	if (server_data->send_data) {
> +		if (server_data->data_len != write(new_sk,
> +							server_data->send_data,
> +							server_data->data_len))

This looks ugly. I'd create a separate ssize_t ret variable, assing the
return value from write to it and then compare with data_len.

Johan

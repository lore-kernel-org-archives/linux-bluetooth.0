Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] unit/test-crypto: Add test based on sample data from errata 4243
Date: Fri, 18 Mar 2016 11:04:21 +0100
Message-ID: <6541356.FQnDKjrX7J@ix>
In-Reply-To: <1457713058-5671-1-git-send-email-szymon.janc@codecoup.pl>
References: <1457713058-5671-1-git-send-email-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 11 March 2016 17:17:38 Szymon Janc wrote:
> ---
>  unit/test-crypto.c | 39 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/unit/test-crypto.c b/unit/test-crypto.c
> index 5fb1c64..8d65707 100644
> --- a/unit/test-crypto.c
> +++ b/unit/test-crypto.c
> @@ -38,6 +38,8 @@ struct test_data {
>  	const uint8_t *msg;
>  	uint16_t msg_len;
>  	const uint8_t *t;
> +	const uint8_t *key;
> +	uint32_t cnt;
>  };
> 
>  static const uint8_t key[] = {
> @@ -54,7 +56,8 @@ static const uint8_t t_msg_1[] = {
>  static const struct test_data test_data_1 = {
>  	.msg = msg_1,
>  	.msg_len = 0,
> -	.t = t_msg_1
> +	.t = t_msg_1,
> +	.key = key,
>  };
> 
>  static const uint8_t msg_2[] = {
> @@ -70,7 +73,8 @@ static const uint8_t t_msg_2[] = {
>  static const struct test_data test_data_2 = {
>  	.msg = msg_2,
>  	.msg_len = 16,
> -	.t = t_msg_2
> +	.t = t_msg_2,
> +	.key = key,
>  };
> 
>  static const uint8_t msg_3[] = {
> @@ -87,7 +91,8 @@ static const uint8_t t_msg_3[12] = {
>  static const struct test_data test_data_3 = {
>  	.msg = msg_3,
>  	.msg_len = 40,
> -	.t = t_msg_3
> +	.t = t_msg_3,
> +	.key = key,
>  };
> 
>  static const uint8_t msg_4[] = {
> @@ -106,7 +111,30 @@ static const uint8_t t_msg_4[12] = {
>  static const struct test_data test_data_4 = {
>  	.msg = msg_4,
>  	.msg_len = 64,
> -	.t = t_msg_4
> +	.t = t_msg_4,
> +	.key = key,
> +};
> +
> +static const uint8_t msg_5[] = {
> +		0xd2, 0x12, 0x00, 0x13, 0x37
> +};
> +
> +static const uint8_t key_5[] = {
> +		0x50, 0x5E, 0x42, 0xDF, 0x96, 0x91, 0xEC, 0x72, 0xD3, 0x1F,
> +		0xCD, 0xFB, 0xEB, 0x64, 0x1B, 0x61
> +};
> +
> +static const uint8_t t_msg_5[] = {
> +		0x01, 0x00, 0x00, 0x00, 0xF1, 0x87, 0x1E, 0x93, 0x3C, 0x90,
> +		0x0F, 0xf2
> +};
> +
> +static const struct test_data test_data_5 = {
> +	.msg = msg_5,
> +	.msg_len = sizeof(msg_5),
> +	.t = t_msg_5,
> +	.cnt = 1,
> +	.key = key_5,
>  };
> 
>  static void print_debug(const char *str, void *user_data)
> @@ -130,7 +158,7 @@ static void test_sign(gconstpointer data)
>  	const struct test_data *d = data;
> 
>  	memset(t, 0, 12);
> -	if (!bt_crypto_sign_att(crypto, key, d->msg, d->msg_len, 0, t))
> +	if (!bt_crypto_sign_att(crypto, d->key, d->msg, d->msg_len, d->cnt, t))
>  		g_assert(true);
> 
>  	tester_debug("Result T:");
> @@ -157,6 +185,7 @@ int main(int argc, char *argv[])
>  	tester_add("/crypto/sign_att_2", &test_data_2, NULL, test_sign, NULL);
>  	tester_add("/crypto/sign_att_3", &test_data_3, NULL, test_sign, NULL);
>  	tester_add("/crypto/sign_att_4", &test_data_4, NULL, test_sign, NULL);
> +	tester_add("/crypto/sign_att_5", &test_data_5, NULL, test_sign, NULL);
> 
>  	exit_status = tester_run();

Applied.

-- 
pozdrawiam
Szymon Janc

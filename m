Return-Path: <cyrus@holtmann.org>
Date: Mon, 9 Sep 2013 11:33:56 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] sco-tester: Introduce adapter features
Message-ID: <20130909083356.GC29399@x220.p-661hnu-f1>
References: <1376062977-1497-1-git-send-email-frederic.dalleau@linux.intel.com>
 <1376062977-1497-2-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1376062977-1497-2-git-send-email-frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

On Fri, Aug 09, 2013, Frédéric Dalleau wrote:
> +struct adapter_features {
> +	bool disable_esco;
> +};
> +
>  struct test_data {
>  	const void *test_data;
>  	struct mgmt *mgmt;
> @@ -50,7 +54,7 @@ struct test_data {
>  	struct hciemu *hciemu;
>  	enum hciemu_type hciemu_type;
>  	unsigned int io_id;
> -	bool disable_esco;
> +	struct adapter_features features;
>  };
>  
>  struct sco_client_data {
> @@ -164,7 +168,7 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
>  
>  	tester_print("New hciemu instance created");
>  
> -	if (data->disable_esco) {
> +	if (data->features.disable_esco) {
>  		uint8_t *features;
>  
>  		tester_print("Disabling eSCO packet type support");
> @@ -211,7 +215,7 @@ static void test_data_free(void *test_data)
>  	free(data);
>  }
>  
> -#define test_sco_full(name, data, setup, func, _disable_esco) \
> +#define test_sco(name, data, setup, func, feat) \
>  	do { \
>  		struct test_data *user; \
>  		user = malloc(sizeof(struct test_data)); \
> @@ -220,17 +224,12 @@ static void test_data_free(void *test_data)
>  		user->hciemu_type = HCIEMU_TYPE_BREDRLE; \
>  		user->io_id = 0; \
>  		user->test_data = data; \
> -		user->disable_esco = _disable_esco; \
> +		user->features = feat; \
>  		tester_add_full(name, data, \
>  				test_pre_setup, setup, func, NULL, \
>  				test_post_teardown, 2, user, test_data_free); \
>  	} while (0)
>  
> -#define test_sco(name, data, setup, func) \
> -	test_sco_full(name, data, setup, func, false)
> -
> -#define test_sco_11(name, data, setup, func) \
> -	test_sco_full(name, data, setup, func, true)
>  
>  static const struct sco_client_data connect_success = {
>  	.expect_err = 0
> @@ -575,31 +574,37 @@ end:
>  
>  int main(int argc, char *argv[])
>  {
> +	static struct adapter_features features;
> +
>  	tester_init(&argc, &argv);
>  
> +	features.disable_esco = 0;

First of all, you should use "false" here instead of "0" (and same for
true vs 1 later).

Secondly, whenever you want to manipulate some parameter of a test case
it should not be done in the main function like that but instead you
should have it as part of the test case data (struct sco_client_data)
and create a separate instance for each test case.

I do realize that the initial sco-tester didn't get this right (having
disable_sco in struct test_data instead of struct sco_client_data), but
it'd be good to get this fixed before adding any new test cases.

Johan

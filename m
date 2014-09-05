Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] android/tester: Init profiles in separate thread
Date: Fri, 05 Sep 2014 11:50:03 +0200
Message-ID: <12480623.xF9C9qG3Tj@uw000953>
In-Reply-To: <1409904596-10254-1-git-send-email-marcin.kraglak@tieto.com>
References: <1409904596-10254-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Friday 05 of September 2014 10:09:54 Marcin Kraglak wrote:
> This is needed to not block mainloop while initializing stack.
> In some cases, bluetooth->init blocks mainloop and bluetoothd
> cannot properly initialize controller, because HCI frames are
> not serviced in hciemu.
> Because pthread_join() is blocking, it is added to mainloop
> from thread right before pthread_exit() is called. Therefore
> this time is extremely short.
> ---
>  android/tester-main.c | 230 +++++++++++++++++++++++++++-----------------------
>  android/tester-main.h |   2 +
>  2 files changed, 127 insertions(+), 105 deletions(-)
> 
> diff --git a/android/tester-main.c b/android/tester-main.c
> index f5f46fb..ce13bf7 100644
> --- a/android/tester-main.c
> +++ b/android/tester-main.c
> @@ -15,8 +15,10 @@
>   *
>   */
>  #include <stdbool.h>
> +#include <pthread.h>
>  
>  #include "emulator/bthost.h"
> +#include "src/shared/util.h"
>  #include "tester-main.h"
>  
>  #include "monitor/bt.h"
> @@ -1332,237 +1334,255 @@ static bool setup_base(struct test_data *data)
>  	return true;
>  }
>  
> -static void setup(const void *test_data)
> +static int init_bluetooth(void)
>  {
>  	struct test_data *data = tester_get_data();
> -	bt_status_t status;
> -
> -	if (!setup_base(data)) {
> -		tester_setup_failed();
> -		return;
> -	}
> -
> -	status = data->if_bluetooth->init(&bt_callbacks);
> -	if (status != BT_STATUS_SUCCESS) {
> -		data->if_bluetooth = NULL;
> -		tester_setup_failed();
> -		return;
> -	}
>  
> -	tester_setup_complete();
> +	return data->if_bluetooth->init(&bt_callbacks);
>  }
>  
> -static void setup_socket(const void *test_data)
> +static int init_socket(void)
>  {
>  	struct test_data *data = tester_get_data();
> -	bt_status_t status;
>  	const void *sock;
> -
> -	if (!setup_base(data)) {
> -		tester_setup_failed();
> -		return;
> -	}
> +	int status;
>  
>  	status = data->if_bluetooth->init(&bt_callbacks);
>  	if (status != BT_STATUS_SUCCESS) {
>  		data->if_bluetooth = NULL;
> -		tester_setup_failed();
> -		return;
> +		return status;
>  	}
>  
>  	sock = data->if_bluetooth->get_profile_interface(BT_PROFILE_SOCKETS_ID);
> -	if (!sock) {
> -		tester_setup_failed();
> -		return;
> -	}
> +	if (!sock)
> +		return BT_STATUS_FAIL;
>  
>  	data->if_sock = sock;
>  
> -	tester_setup_complete();
> +	return BT_STATUS_SUCCESS;
>  }
>  
> -static void setup_hidhost(const void *test_data)
> +static int init_hidhost(void)
>  {
>  	struct test_data *data = tester_get_data();
>  	bt_status_t status;
>  	const void *hid;
>  
> -	if (!setup_base(data)) {
> -		tester_setup_failed();
> -		return;
> -	}
> -
>  	status = data->if_bluetooth->init(&bt_callbacks);
>  	if (status != BT_STATUS_SUCCESS) {
>  		data->if_bluetooth = NULL;
>  		tester_setup_failed();
> -		return;
> +		return status;
>  	}
>  
>  	hid = data->if_bluetooth->get_profile_interface(BT_PROFILE_HIDHOST_ID);
>  	if (!hid) {
>  		tester_setup_failed();
> -		return;
> +		return BT_STATUS_FAIL;
>  	}
>  
>  	data->if_hid = hid;
>  
>  	status = data->if_hid->init(&bthh_callbacks);
> -	if (status != BT_STATUS_SUCCESS) {
> +	if (status != BT_STATUS_SUCCESS)
>  		data->if_hid = NULL;
> -		tester_setup_failed();
> -		return;
> -	}
>  
> -	tester_setup_complete();
> +	return status;
>  }
>  
> -static void setup_pan(const void *test_data)
> +static int init_pan(void)
>  {
>  	struct test_data *data = tester_get_data();
>  	bt_status_t status;
>  	const void *pan;
>  
> -	if (!setup_base(data)) {
> -		tester_setup_failed();
> -		return;
> -	}
> -
>  	status = data->if_bluetooth->init(&bt_callbacks);
>  	if (status != BT_STATUS_SUCCESS) {
>  		data->if_bluetooth = NULL;
> -		tester_setup_failed();
> -		return;
> +		return status;
>  	}
>  
>  	pan = data->if_bluetooth->get_profile_interface(BT_PROFILE_PAN_ID);
>  	if (!pan) {
> -		tester_setup_failed();
> -		return;
> +		return BT_STATUS_FAIL;
>  	}
>  
>  	data->if_pan = pan;
>  
>  	status = data->if_pan->init(&btpan_callbacks);
> -	if (status != BT_STATUS_SUCCESS) {
> +	if (status != BT_STATUS_SUCCESS)
>  		data->if_pan = NULL;
> -		tester_setup_failed();
> -		return;
> -	}
>  
> -	tester_setup_complete();
> +	return status;
>  }
>  
> -static void setup_hdp(const void *test_data)
> +static int init_hdp(void)
>  {
>  	struct test_data *data = tester_get_data();
>  	bt_status_t status;
>  	const void *hdp;
>  
> -	if (!setup_base(data)) {
> -		tester_setup_failed();
> -		return;
> -	}
> -
>  	status = data->if_bluetooth->init(&bt_callbacks);
>  	if (status != BT_STATUS_SUCCESS) {
>  		data->if_bluetooth = NULL;
> -		tester_setup_failed();
> -		return;
> +		return status;
>  	}
>  
>  	hdp = data->if_bluetooth->get_profile_interface(BT_PROFILE_HEALTH_ID);
> -	if (!hdp) {
> -		tester_setup_failed();
> -		return;
> -	}
> +	if (!hdp)
> +		return BT_STATUS_FAIL;
>  
>  	data->if_hdp = hdp;
>  
>  	status = data->if_hdp->init(&bthl_callbacks);
> -	if (status != BT_STATUS_SUCCESS) {
> +	if (status != BT_STATUS_SUCCESS)
>  		data->if_hdp = NULL;
> -		tester_setup_failed();
> -		return;
> -	}
>  
> -	tester_setup_complete();
> +	return status;
>  }
>  
> -static void setup_a2dp(const void *test_data)
> +static int init_a2dp(void)
>  {
>  	struct test_data *data = tester_get_data();
>  	const bt_interface_t *if_bt;
>  	bt_status_t status;
>  	const void *a2dp;
>  
> -	if (!setup_base(data)) {
> -		tester_setup_failed();
> -		return;
> -	}
> -
>  	if_bt = data->if_bluetooth;
>  
>  	status = if_bt->init(&bt_callbacks);
>  	if (status != BT_STATUS_SUCCESS) {
>  		data->if_bluetooth = NULL;
> -		tester_setup_failed();
> -		return;
> +		return status;
>  	}
>  
>  	a2dp = if_bt->get_profile_interface(BT_PROFILE_ADVANCED_AUDIO_ID);
> -	if (!a2dp) {
> -		tester_setup_failed();
> -		return;
> -	}
> +	if (!a2dp)
> +		return  BT_STATUS_FAIL;
>  
>  	data->if_a2dp = a2dp;
>  
>  	status = data->if_a2dp->init(&bta2dp_callbacks);
> -	if (status != BT_STATUS_SUCCESS) {
> +	if (status != BT_STATUS_SUCCESS)
>  		data->if_a2dp = NULL;
> -		tester_setup_failed();
> -		return;
> -	}
>  
> -	tester_setup_complete();
> +	return status;
>  }
>  
> -static void setup_gatt(const void *test_data)
> +static int init_gatt(void)
>  {
>  	struct test_data *data = tester_get_data();
>  	bt_status_t status;
>  	const void *gatt;
>  
> -	if (!setup_base(data)) {
> -		tester_setup_failed();
> -		return;
> -	}
> -
>  	status = data->if_bluetooth->init(&bt_callbacks);
>  	if (status != BT_STATUS_SUCCESS) {
>  		data->if_bluetooth = NULL;
> -		tester_setup_failed();
> -		return;
> +		return status;
>  	}
>  
>  	gatt = data->if_bluetooth->get_profile_interface(BT_PROFILE_GATT_ID);
> -	if (!gatt) {
> -		tester_setup_failed();
> -		return;
> -	}
> +	if (!gatt)
> +		return BT_STATUS_FAIL;
>  
>  	data->if_gatt = gatt;
>  
>  	status = data->if_gatt->init(&btgatt_callbacks);
> -	if (status != BT_STATUS_SUCCESS) {
> +	if (status != BT_STATUS_SUCCESS)
>  		data->if_gatt = NULL;
>  
> +	return status;
> +}
> +
> +static gboolean join_init_thread(gpointer user_data)
> +{
> +	struct test_data *data = tester_get_data();
> +	int status;
> +
> +	/* Note that pthread_join is blocking mainloop,
> +	 * therefore thread we want to join must
> +	 * exit imediatelly. This is done in init_thread()*/
> +	status = pthread_join(data->thread, NULL);
> +	if (status != 0)
> +		tester_warn("Failed to join init thread, status %d", status);
> +
> +	if (PTR_TO_INT(user_data) == BT_STATUS_SUCCESS)
> +		tester_setup_complete();
> +	else
> +		tester_setup_failed();
> +
> +	return FALSE;
> +}
> +
> +static void *init_thread(void *user_data)
> +{
> +	int (*setup_func)(void) = user_data;
> +	int status;
> +
> +	status = setup_func();
> +
> +	g_idle_add(join_init_thread, INT_TO_PTR(status));
> +
> +	pthread_exit(NULL);
> +}
> +
> +static bool start_init_thread(int (*init)(void))
> +{
> +	struct test_data *data = tester_get_data();
> +
> +	if (pthread_create(&data->thread, NULL, init_thread, init) != 0)
> +		return false;
> +
> +	return true;
> +}
> +
> +static void setup_generic(int (*setup)(void))
> +{
> +	struct test_data *data = tester_get_data();
> +
> +	if (!setup_base(data)) {
>  		tester_setup_failed();
>  		return;
>  	}
>  
> -	tester_setup_complete();
> +	if (!start_init_thread(setup))
> +		tester_setup_failed();
> +}
> +
> +static void setup(const void *test_data)
> +{
> +	setup_generic(init_bluetooth);
> +}
> +
> +static void setup_socket(const void *test_data)
> +{
> +
> +	setup_generic(init_socket);
> +}
> +
> +static void setup_hidhost(const void *test_data)
> +{
> +	setup_generic(init_hidhost);
> +}
> +
> +static void setup_pan(const void *test_data)
> +{
> +	setup_generic(init_pan);
> +}
> +
> +static void setup_hdp(const void *test_data)
> +{
> +	setup_generic(init_hdp);
> +}
> +
> +static void setup_a2dp(const void *test_data)
> +{
> +	setup_generic(init_a2dp);
> +}
> +
> +static void setup_gatt(const void *test_data)
> +{
> +	setup_generic(init_gatt);
>  }
>  
>  static void teardown(const void *test_data)
> diff --git a/android/tester-main.h b/android/tester-main.h
> index 46aacce..f90cf86 100644
> --- a/android/tester-main.h
> +++ b/android/tester-main.h
> @@ -331,6 +331,8 @@ struct test_data {
>  	pid_t bluetoothd_pid;
>  
>  	struct queue *pdus;
> +
> +	pthread_t thread;
>  };
>  
>  /*
> 

I've applied patches 2 and 3. Patch 1 needs to be modified as we discussed
offline. Thanks.

-- 
Best regards, 
Szymon Janc

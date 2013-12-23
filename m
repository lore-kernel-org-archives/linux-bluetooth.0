Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/6] android/tester: Seperate Socket HAL cbs from Bluetooth HAL cb
Date: Mon, 23 Dec 2013 16:59:01 +0100
Message-ID: <14459421.j7CbeIN4m3@uw000953>
In-Reply-To: <1387808154-21661-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1387808154-21661-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

> This patch adds seperate callbacks structure for socket HAL test cases.
> Is's needed beceause Socket HAL cb have other purpose than Bluetooth HAL
> cb. Callbacks are now initialized outside test setup function and
> cb struct depends on HAL type.
> ---
>  android/android-tester.c | 63 ++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 56 insertions(+), 7 deletions(-)
> 
> diff --git a/android/android-tester.c b/android/android-tester.c
> index 0383115..f5ab14f 100644
> --- a/android/android-tester.c
> +++ b/android/android-tester.c
> @@ -872,7 +872,6 @@ static void setup(struct test_data *data)
>  {
>  	const hw_module_t *module;
>  	hw_device_t *device;
> -	bt_status_t status;
>  	int signal_fd[2];
>  	char buf[1024];
>  	pid_t pid;
> @@ -935,19 +934,21 @@ static void setup(struct test_data *data)
>  		return;
>  	}
>  
> -	status = data->if_bluetooth->init(&bt_callbacks);
> -	if (status != BT_STATUS_SUCCESS) {
> -		data->if_bluetooth = NULL;
> -		tester_setup_failed();
> -	}
>  }
>  
>  static void setup_base(const void *test_data)
>  {
>  	struct test_data *data = tester_get_data();
> +	bt_status_t status;
>  
>  	setup(data);
>  
> +	status = data->if_bluetooth->init(&bt_callbacks);
> +	if (status != BT_STATUS_SUCCESS) {
> +		data->if_bluetooth = NULL;
> +		tester_setup_failed();
> +	}
> +
>  	tester_setup_complete();
>  }
>  
> @@ -958,6 +959,11 @@ static void setup_enabled_adapter(const void *test_data)
>  
>  	setup(data);
>  
> +	status = data->if_bluetooth->init(&bt_callbacks);
> +	if (status != BT_STATUS_SUCCESS) {
> +		data->if_bluetooth = NULL;
> +		tester_setup_failed();
> +	}
>  	status = data->if_bluetooth->enable();
>  	if (status != BT_STATUS_SUCCESS)
>  		tester_setup_failed();
> @@ -1157,6 +1163,20 @@ static void test_setprop_service_record_invalid(const void *test_data)
>  
>  /* Test Socket HAL */
>  
> +static void adapter_socket_state_changed_cb(bt_state_t state)
> +{
> +	switch (state) {
> +	case BT_STATE_ON:
> +		setup_powered_emulated_remote();
> +		break;
> +	case BT_STATE_OFF:
> +		tester_setup_failed();
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  const bt_bdaddr_t bdaddr_dummy = {
>  	.address = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55}
>  };
> @@ -1233,13 +1253,36 @@ static const struct socket_data btsock_inv_listen_listen = {
>  	.test_channel = true,
>  };
>  
> +static bt_callbacks_t bt_socket_callbacks = {
> +	.size = sizeof(bt_callbacks),
> +	.adapter_state_changed_cb = adapter_socket_state_changed_cb,
> +	.adapter_properties_cb = NULL,
> +	.remote_device_properties_cb = NULL,
> +	.device_found_cb = NULL,
> +	.discovery_state_changed_cb = NULL,
> +	.pin_request_cb = NULL,
> +	.ssp_request_cb = NULL,
> +	.bond_state_changed_cb = NULL,
> +	.acl_state_changed_cb = NULL,
> +	.thread_evt_cb = NULL,
> +	.dut_mode_recv_cb = NULL,
> +	.le_test_mode_cb = NULL
> +};
> +
>  static void setup_socket_interface(const void *test_data)
>  {
>  	struct test_data *data = tester_get_data();
> +	bt_status_t status;
>  	const void *sock;
>  
>  	setup(data);
>  
> +	status = data->if_bluetooth->init(&bt_socket_callbacks);
> +	if (status != BT_STATUS_SUCCESS) {
> +		data->if_bluetooth = NULL;
> +		tester_setup_failed();
> +	}
> +
>  	sock = data->if_bluetooth->get_profile_interface(BT_PROFILE_SOCKETS_ID);
>  	if (!sock) {
>  		tester_setup_failed();
> @@ -1254,11 +1297,17 @@ static void setup_socket_interface(const void *test_data)
>  static void setup_socket_interface_enabled(const void *test_data)
>  {
>  	struct test_data *data = tester_get_data();
> -	const void *sock;
>  	bt_status_t status;
> +	const void *sock;
>  
>  	setup(data);
>  
> +	status = data->if_bluetooth->init(&bt_socket_callbacks);
> +	if (status != BT_STATUS_SUCCESS) {
> +		data->if_bluetooth = NULL;
> +		tester_setup_failed();
> +	}
> +
>  	sock = data->if_bluetooth->get_profile_interface(BT_PROFILE_SOCKETS_ID);
>  	if (!sock) {
>  		tester_setup_failed();
> 

All patches applied, thanks.

-- 
BR
Szymon Janc

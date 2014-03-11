Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] android/tester: Add support for bredr hciemu devices
Date: Tue, 11 Mar 2014 23:10:29 +0100
Message-ID: <9822870.baiB82NZHx@athlon>
In-Reply-To: <1394547904-19100-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1394547904-19100-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Tuesday 11 March 2014 15:25:02 Grzegorz Kolodziejczyk wrote:
> Current test cases works on bredrle hciemu adapter types. Test cases
> with device scan do LE scan first (for 5 sec - kernel specific) then
> change scan to bredr devices as hciemu device is. To avoid timeout
> (within 3 secs) - fail of test cases, hciemu adapter should be bredr.
> ---
>  android/android-tester.c | 79
> ++++++++++++++++++++++++++++-------------------- 1 file changed, 46
> insertions(+), 33 deletions(-)
> 
> diff --git a/android/android-tester.c b/android/android-tester.c
> index b762a2d..111299f 100644
> --- a/android/android-tester.c
> +++ b/android/android-tester.c
> @@ -4422,6 +4422,19 @@ static void test_hidhost_get_report(const void
> *test_data) tester_test_failed();
>  }
> 
> +#define test_bredr(name, data, test_setup, test, test_teardown) \
> +	do { \
> +		struct test_data *user; \
> +		user = g_malloc0(sizeof(struct test_data)); \
> +		if (!user) \
> +			break; \
> +		user->hciemu_type = HCIEMU_TYPE_BREDR; \
> +		user->test_data = data; \
> +		tester_add_full(name, data, test_pre_setup, test_setup, \
> +				test, test_teardown, test_post_teardown, \
> +							1, user, g_free); \
> +	} while (0)
> +
>  #define test_bredrle(name, data, test_setup, test, test_teardown) \
>  	do { \
>  		struct test_data *user; \
> @@ -4578,157 +4591,157 @@ int main(int argc, char *argv[])
>  				setup_enabled_adapter,
>  				test_discovery_stop_done, teardown);
> 
> -	test_bredrle("Bluetooth BR/EDR Discovery Device Found",
> +	test_bredr("Bluetooth BR/EDR Discovery Device Found",
>  				&bluetooth_discovery_device_found_test,
>  				setup_enabled_adapter,
>  				test_discovery_device_found, teardown);
> 
> -	test_bredrle("Bluetooth Device Get Props - Success",
> +	test_bredr("Bluetooth Device Get Props - Success",
>  					&bt_dev_getprops_success_test,
>  					setup_enabled_adapter,
>  					test_dev_getprops_success, teardown);
> 
> -	test_bredrle("Bluetooth Device Get BDNAME - Success",
> +	test_bredr("Bluetooth Device Get BDNAME - Success",
>  				&bt_dev_getprop_bdname_success_test,
>  				setup_enabled_adapter,
>  				test_dev_getprop_bdname_success, teardown);
> 
> -	test_bredrle("Bluetooth Device Get UUIDS - Success",
> +	test_bredr("Bluetooth Device Get UUIDS - Success",
>  				&bt_dev_getprop_uuids_success_test,
>  				setup_enabled_adapter,
>  				test_dev_getprop_uuids_success, teardown);
> 
> -	test_bredrle("Bluetooth Device Get COD - Success",
> +	test_bredr("Bluetooth Device Get COD - Success",
>  					&bt_dev_getprop_cod_success_test,
>  					setup_enabled_adapter,
>  					test_dev_getprop_cod_success, teardown);
> 
> -	test_bredrle("Bluetooth Device Get TOD - Success",
> +	test_bredr("Bluetooth Device Get TOD - Success",
>  					&bt_dev_getprop_tod_success_test,
>  					setup_enabled_adapter,
>  					test_dev_getprop_tod_success, teardown);
> 
> -	test_bredrle("Bluetooth Device Get RSSI - Success",
> +	test_bredr("Bluetooth Device Get RSSI - Success",
>  				&bt_dev_getprop_rssi_success_test,
>  				setup_enabled_adapter,
>  				test_dev_getprop_rssi_success, teardown);
> 
> -	test_bredrle("Bluetooth Device Get TIMESTAMP - Success",
> +	test_bredr("Bluetooth Device Get TIMESTAMP - Success",
>  				&bt_dev_getprop_timpestamp_success_test,
>  				setup_enabled_adapter,
>  				test_dev_getprop_timestamp_success, teardown);
> 
> -	test_bredrle("Bluetooth Device Get BDADDR - Fail",
> +	test_bredr("Bluetooth Device Get BDADDR - Fail",
>  				&bt_dev_getprop_bdaddr_fail_test,
>  				setup_enabled_adapter,
>  				test_dev_getprop_bdaddr_fail, teardown);
> 
> -	test_bredrle("Bluetooth Device Get SERVICE_RECORD - Fail",
> +	test_bredr("Bluetooth Device Get SERVICE_RECORD - Fail",
>  				&bt_dev_getprop_servrec_fail_test,
>  				setup_enabled_adapter,
>  				test_dev_getprop_servrec_fail, teardown);
> 
> -	test_bredrle("Bluetooth Device Get SCAN_MODE - Fail",
> +	test_bredr("Bluetooth Device Get SCAN_MODE - Fail",
>  				&bt_dev_getprop_scanmode_fail_test,
>  				setup_enabled_adapter,
>  				test_dev_getprop_scanmode_fail, teardown);
> 
> -	test_bredrle("Bluetooth Device Get BONDED_DEVICES - Fail",
> +	test_bredr("Bluetooth Device Get BONDED_DEVICES - Fail",
>  				&bt_dev_getprop_bondeddev_fail_test,
>  				setup_enabled_adapter,
>  				test_dev_getprop_bondeddev_fail, teardown);
> 
> -	test_bredrle("Bluetooth Device Get DISCOVERY_TIMEOUT - Fail",
> +	test_bredr("Bluetooth Device Get DISCOVERY_TIMEOUT - Fail",
>  				&bt_dev_getprop_disctimeout_fail_test,
>  				setup_enabled_adapter,
>  				test_dev_getprop_disctimeout_fail, teardown);
> 
> -	test_bredrle("Bluetooth Device Get VERSION_INFO - Fail",
> +	test_bredr("Bluetooth Device Get VERSION_INFO - Fail",
>  				&bt_dev_getprop_verinfo_fail_test,
>  				setup_enabled_adapter,
>  				test_dev_getprop_verinfo_fail, teardown);
> 
> -	test_bredrle("Bluetooth Device Get FRIENDLY_NAME - Fail",
> +	test_bredr("Bluetooth Device Get FRIENDLY_NAME - Fail",
>  					&bt_dev_getprop_fname_fail_test,
>  					setup_enabled_adapter,
>  					test_dev_getprop_fname_fail, teardown);
> 
> -	test_bredrle("Bluetooth Device Set FRIENDLY_NAME - Success",
> +	test_bredr("Bluetooth Device Set FRIENDLY_NAME - Success",
>  				&bt_dev_setprop_fname_success_test,
>  				setup_enabled_adapter,
>  				test_dev_setprop_fname_success, teardown);
> 
> -	test_bredrle("Bluetooth Device Set BDNAME - Fail",
> +	test_bredr("Bluetooth Device Set BDNAME - Fail",
>  					&bt_dev_setprop_bdname_fail_test,
>  					setup_enabled_adapter,
>  					test_dev_setprop_bdname_fail, teardown);
> 
> -	test_bredrle("Bluetooth Device Set UUIDS - Fail",
> +	test_bredr("Bluetooth Device Set UUIDS - Fail",
>  					&bt_dev_setprop_uuids_fail_test,
>  					setup_enabled_adapter,
>  					test_dev_setprop_uuids_fail, teardown);
> 
> -	test_bredrle("Bluetooth Device Set COD - Fail",
> +	test_bredr("Bluetooth Device Set COD - Fail",
>  					&bt_dev_setprop_cod_fail_test,
>  					setup_enabled_adapter,
>  					test_dev_setprop_cod_fail, teardown);
> 
> -	test_bredrle("Bluetooth Device Set TOD - Fail",
> +	test_bredr("Bluetooth Device Set TOD - Fail",
>  					&bt_dev_setprop_tod_fail_test,
>  					setup_enabled_adapter,
>  					test_dev_setprop_tod_fail, teardown);
> 
> -	test_bredrle("Bluetooth Device Set RSSI - Fail",
> +	test_bredr("Bluetooth Device Set RSSI - Fail",
>  				&bt_dev_setprop_rssi_fail_test,
>  				setup_enabled_adapter,
>  				test_dev_setprop_rssi_fail, teardown);
> 
> -	test_bredrle("Bluetooth Device Set TIMESTAMP - Fail",
> +	test_bredr("Bluetooth Device Set TIMESTAMP - Fail",
>  				&bt_dev_setprop_timpestamp_fail_test,
>  				setup_enabled_adapter,
>  				test_dev_setprop_timestamp_fail, teardown);
> 
> -	test_bredrle("Bluetooth Device Set BDADDR - Fail",
> +	test_bredr("Bluetooth Device Set BDADDR - Fail",
>  				&bt_dev_setprop_bdaddr_fail_test,
>  				setup_enabled_adapter,
>  				test_dev_setprop_bdaddr_fail, teardown);
> 
> -	test_bredrle("Bluetooth Device Set SERVICE_RECORD - Fail",
> +	test_bredr("Bluetooth Device Set SERVICE_RECORD - Fail",
>  				&bt_dev_setprop_servrec_fail_test,
>  				setup_enabled_adapter,
>  				test_dev_setprop_servrec_fail, teardown);
> 
> -	test_bredrle("Bluetooth Device Set SCAN_MODE - Fail",
> +	test_bredr("Bluetooth Device Set SCAN_MODE - Fail",
>  				&bt_dev_setprop_scanmode_fail_test,
>  				setup_enabled_adapter,
>  				test_dev_setprop_scanmode_fail, teardown);
> 
> -	test_bredrle("Bluetooth Device Set BONDED_DEVICES - Fail",
> +	test_bredr("Bluetooth Device Set BONDED_DEVICES - Fail",
>  				&bt_dev_setprop_bondeddev_fail_test,
>  				setup_enabled_adapter,
>  				test_dev_setprop_bondeddev_fail, teardown);
> 
> -	test_bredrle("Bluetooth Device Set DISCOVERY_TIMEOUT - Fail",
> +	test_bredr("Bluetooth Device Set DISCOVERY_TIMEOUT - Fail",
>  				&bt_dev_setprop_disctimeout_fail_test,
>  				setup_enabled_adapter,
>  				test_dev_setprop_disctimeout_fail, teardown);
> 
> -	test_bredrle("Bluetooth Create Bond PIN - Success",
> +	test_bredr("Bluetooth Create Bond PIN - Success",
>  					&bt_bond_create_pin_success_test,
>  					setup_enabled_adapter,
>  					test_bond_create_pin_success, teardown);
> 
> -	test_bredrle("Bluetooth Create Bond PIN - Bad PIN",
> +	test_bredr("Bluetooth Create Bond PIN - Bad PIN",
>  					&bt_bond_create_pin_fail_test,
>  					setup_enabled_adapter,
>  					test_bond_create_pin_fail, teardown);
> 
> -	test_bredrle("Bluetooth Create Bond SSP - Success",
> +	test_bredr("Bluetooth Create Bond SSP - Success",
>  					&bt_bond_create_ssp_success_test,
>  					setup_enabled_adapter,
>  					test_bond_create_ssp_success, teardown);
> 
> -	test_bredrle("Bluetooth Create Bond SSP - Negative reply",
> +	test_bredr("Bluetooth Create Bond SSP - Negative reply",
>  					&bt_bond_create_ssp_fail_test,
>  					setup_enabled_adapter,
>  					test_bond_create_ssp_fail, teardown);
> @@ -4743,12 +4756,12 @@ int main(int argc, char *argv[])
>  				setup_enabled_adapter,
>  				test_bond_create_bad_addr_success, teardown);
> 
> -	test_bredrle("Bluetooth Cancel Bonding - Success",
> +	test_bredr("Bluetooth Cancel Bonding - Success",
>  					&bt_bond_cancel_success_test,
>  					setup_enabled_adapter,
>  					test_bond_cancel_success, teardown);
> 
> -	test_bredrle("Bluetooth Remove Bond - Success",
> +	test_bredr("Bluetooth Remove Bond - Success",
>  					&bt_bond_remove_success_test,
>  					setup_enabled_adapter,
>  					test_bond_remove_success, teardown);

All patches applied, thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com

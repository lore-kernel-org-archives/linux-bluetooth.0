Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [RFC 04/16] android: Start Android Bluetooth daemon
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380291161-10232-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Sun, 29 Sep 2013 15:28:44 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <9A70E0AA-C658-4B1D-8040-DD483CCD6047@holtmann.org>
References: <1380291161-10232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1380291161-10232-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Start Android Bluetooth daemon from HAL init(). Make sure
> that daemon is in "running" state.
> ---
> android/hal_bluetooth.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/android/hal_bluetooth.c b/android/hal_bluetooth.c
> index 5298618..036091e 100644
> --- a/android/hal_bluetooth.c
> +++ b/android/hal_bluetooth.c
> @@ -23,11 +23,16 @@
> #include <hardware/bluetooth.h>
> #include <hardware/bt_sock.h>
> 
> +#include <cutils/sockets.h>
> +#include <cutils/properties.h>
> +
> #define LOG_TAG "BlueZ"
> #include <cutils/log.h>
> 
> #include "hal.h"
> 
> +#define ANDROID_BLUEZ "bluezd"
> +

the name changes to either "btd" or "bluetoothd". We need to pick one, but it is not suppose to be "bluezd".

> bt_callbacks_t *bt_hal_cbacks = NULL;

This needs to be public?

> static bool interface_ready(void)
> @@ -35,6 +40,49 @@ static bool interface_ready(void)
> 	return bt_hal_cbacks != NULL;
> }
> 
> +static bool is_running(const char *service_name)
> +{
> +	char val[PROPERTY_VALUE_MAX];
> +	char name[PROPERTY_KEY_MAX];
> +	int  ret;

No double spaces here.

> +
> +	ALOGI(__func__);
> +
> +	ret = snprintf(name, sizeof(name), "init.svc.%s", service_name);
> +	if (ret > (int) sizeof(name) - 1) {

Can you not just use PROPERTY_KEY_MAX and avoid the casting?


> +		ALOGD("Service name '%s' is too long", service_name);
> +		return false;
> +	}
> +
> +	if (property_get(name, val, NULL)) {
> +		if (strcmp(val, "running") == 0)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool start_bt_daemon(void)
> +{
> +	int tries = 40; /* wait 4 seconds for completion */
> +
> +	ALOGI(__func__);
> +
> +	/* Start Android Bluetooth daemon service */
> +	property_set("ctl.start", ANDROID_BLUEZ);
> +
> +	while (tries-- > 0) {
> +		if (is_running(ANDROID_BLUEZ) == true) {
> +			ALOGI("Android BlueZ daemon started");
> +			return true;
> +		}
> +
> +		usleep(100000);
> +	}
> +
> +	return false;
> +}
> +
> static bool is_profile(const char *profile, const char *str)
> {
> 	return (strlen(str) == strlen(profile)) &&
> @@ -51,7 +99,11 @@ static int init(bt_callbacks_t *callbacks)
> 	/* store reference to user callbacks */
> 	bt_hal_cbacks = callbacks;
> 
> -	/* TODO: Init here bluezd task */
> +	if (start_bt_daemon() == true) {
> +		/* TODO: open channel */
> +
> +		return BT_STATUS_SUCCESS;
> +	}
> 
> 	return BT_STATUS_UNSUPPORTED;
> }

Regards

Marcel


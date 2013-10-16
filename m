Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Oct 2013 15:21:39 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 5/5] android: Add calls to adapter methods in haltest
Message-ID: <20131016122139.GA2301@x220.p-661hnu-f1>
References: <1381842800-3554-1-git-send-email-jerzy.kasenberg@tieto.com>
 <1381842800-3554-6-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381842800-3554-6-git-send-email-jerzy.kasenberg@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerzy,

On Tue, Oct 15, 2013, Jerzy Kasenberg wrote:
> +static bt_callbacks_t bt_callbacks = {
> +	sizeof(bt_callbacks),
> +	adapter_state_changed_cb,
> +	adapter_properties_cb,
> +	remote_device_properties_cb,
> +	device_found_cb,
> +	discovery_state_changed_cb,
> +	pin_request_cb,
> +	ssp_request_cb,
> +	bond_state_changed_cb,
> +	acl_state_changed_cb,
> +	thread_evt_cb,
> +	dut_mode_recv_cb,
> +	le_test_mode_cb
> +};

Could we get structure initializations like this to use follow the
coding style, i.e.:

static bt_callbacks_t bt_callbacks = {
	.member1 = sizeof(),
	.member2 = adapter_state_changed_cb,
	...
};

This way you can directly see that the right members are initialized to
the right values and there's no risk that e.g. two members with the same
type are swapped (something the compiler wouldn't warn about).

As a general point to others working on the android code: if there are
any other similar places elsewhere in the code please fix those too.

> +static void init_p(int argc, const char **argv)
> +{
> +	int err;
> +	const hw_module_t *module;
> +	hw_device_t *device;
> +
> +	err = hw_get_module(BT_HARDWARE_MODULE_ID, &module);
> +	if (err) {
> +		haltest_error("he_get_module returned %d\n", err);
> +		return;
> +	}
> +
> +	err = module->methods->open(module, BT_HARDWARE_MODULE_ID, &device);
> +	if (err) {
> +		haltest_error("module->methods->open returned %d\n", err);
> +		return;
> +	}
> +
> +	if_bluetooth =
> +	    ((bluetooth_device_t *)device)->get_bluetooth_interface();

The user space coding style convention is to have a space between the
type cast and the variable. In this case you might make the code more
readable by adding an extra variable, something like:

	bluetooth_device_t *btdev;

	...

	btdev = (bluetooth_device_t *) device;
	if_bluetooth = btdev->get_bluetooth_interface();
	...

Johan

Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCHv5 3/7] android: Use kernel style to initialize struct fields
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1381998406-16662-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Thu, 17 Oct 2013 11:04:54 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <DC9444E8-D8BD-487E-AC4C-053BE979A8C8@holtmann.org>
References: <1381833423-862-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1381998406-16662-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1381998406-16662-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> ---
> android/hal_bluetooth.c |   46 +++++++++++++++++++++++-----------------------
> 1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/android/hal_bluetooth.c b/android/hal_bluetooth.c
> index 9bb9dcf..89b8ebb 100644
> --- a/android/hal_bluetooth.c
> +++ b/android/hal_bluetooth.c
> @@ -309,29 +309,29 @@ static int dut_mode_send(uint16_t opcode, uint8_t *buf, uint8_t len)
> }
> 
> static const bt_interface_t bluetooth_if = {
> -	sizeof(bt_interface_t),
> -	init,
> -	enable,
> -	disable,
> -	cleanup,
> -	get_adapter_properties,
> -	get_adapter_property,
> -	set_adapter_property,
> -	get_remote_device_properties,
> -	get_remote_device_property,
> -	set_remote_device_property,
> -	get_remote_service_record,
> -	get_remote_services,
> -	start_discovery,
> -	cancel_discovery,
> -	create_bond,
> -	remove_bond,
> -	cancel_bond,
> -	pin_reply,
> -	ssp_reply,
> -	get_profile_interface,
> -	dut_mode_configure,
> -	dut_mode_send
> +	.size = sizeof(bt_interface_t),
> +	.init = init,
> +	.enable = enable,
> +	.disable = disable,
> +	.cleanup = cleanup,
> +	.get_adapter_properties = get_adapter_properties,
> +	.get_adapter_property = get_adapter_property,
> +	.set_adapter_property = set_adapter_property,
> +	.get_remote_device_properties = get_remote_device_properties,
> +	.get_remote_device_property = get_remote_device_property,
> +	.set_remote_device_property = set_remote_device_property,
> +	.get_remote_service_record = get_remote_service_record,
> +	.get_remote_services = get_remote_services,
> +	.start_discovery = start_discovery,
> +	.cancel_discovery = cancel_discovery,
> +	.create_bond = create_bond,
> +	.remove_bond = remove_bond,
> +	.cancel_bond = cancel_bond,
> +	.pin_reply = pin_reply,
> +	.ssp_reply = ssp_reply,
> +	.get_profile_interface = get_profile_interface,
> +	.dut_mode_configure = dut_mode_configure,
> +	.dut_mode_send = dut_mode_send
> };

we could also leave it as is here. Since this does not give any visible improvement for anybody. Also these structure are ABI. So no unintentional reordering will ever happen.

Regards

Marcel


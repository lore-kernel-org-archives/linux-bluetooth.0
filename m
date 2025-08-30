Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7221A4315F
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 Aug 2025 06:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756533638; cv=none; b=n7PFGyzJt+BhsoL/k71ZUgsUCXR0FkHY7FGh5oNPlL2FeUuIWXhgE5pgQFmNTYxWMllj4MezredIubRElzgCv2gh7HZbpVg64Ujby9dvamnqXXTMXQBIx7MBKyIdX9am+KNeWJ0CRSgv6nsgx/5zGJu10F6BbW0uQ29ZyFDeBr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756533638; c=relaxed/simple;
	bh=qXfZKy7nSZjfRlxnLsDJiWGC+6djC2rfJYh58IC8wyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S7az1mu4ejAF+iVYdu0SDZ6I/cSCBnntEtezDb2cmayzAl92PS1CAzmx6yYbHtjBRRXuPhhi1NCFshF8p0swYAITwCBYlf9PSF+AZtNgXsJsEUklrPoZYzv2Bf2HH69ju2HcYgnqS+lR4GCJCwl7SaCnsjBfvcLpJmWbzZ7uqDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7fb.dynamic.kabel-deutschland.de [95.90.247.251])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4BBF16004C2C4;
	Sat, 30 Aug 2025 08:00:13 +0200 (CEST)
Message-ID: <3934b1ee-5e4e-4513-bebe-afe9ee1b4fcd@molgen.mpg.de>
Date: Sat, 30 Aug 2025 08:00:12 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bluetooth-next PATCH] Bluetooth: hci_bcm: Configure sleep mode
 on RPM suspend/resume
To: Marek Vasut <marex@denx.de>
Cc: linux-bluetooth@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>, kernel@dh-electronics.com
References: <20240629172235.29901-1-marex@denx.de>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240629172235.29901-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Marek,


Thank you for your patch. I was made aware of it by Hans’ recent review. 
Some minor nits. Probably, you need to resend the patch anyway.

Am 29.06.24 um 19:22 schrieb Marek Vasut:
> The Infineon CYW43439 Bluetooth device enters suspend mode right after
> receiving the Set_Sleepmode_Param sleep_mode=1 HCI command, even if the
> BT_DEV_WAKE input is HIGH, i.e. device ought to be awake. This triggers
> a timeout of any follow up HCI command, in case of regular boot, that is

follow-up

> HCI_OP_RESET command issued from hci_init1_sync() .
> 
> Rework the code such that during probe, the device is configured to not
> enter sleep mode by issuing Set_Sleepmode_Param sleep_mode=0 instead of
> sleep_mode=1 in bcm_setup(). Upon RPM suspend, issue Set_Sleepmode_Param
> with sleep_mode=1 to allow the device to enter the sleep mode when the
> BT_DEV_WAKE signal is deasserted, which is deasserted soon after in the
> RPM suspend callback. Upon RPM resume, assert BT_DEV_WAKE to resume the
> chip from sleep mode and then issue Set_Sleepmode_Param sleep_mode=0 to
> yet again prevent the device from entering sleep mode until the next RPM
> suspend.

How did you test this? It’d be great if you gave more details.

> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: kernel@dh-electronics.com
> Cc: linux-bluetooth@vger.kernel.org
> ---
>   drivers/bluetooth/hci_bcm.c | 32 +++++++++++++++++++++++++++++---
>   1 file changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 89d4c2224546f..fde5e0136c392 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -389,13 +389,19 @@ static const struct bcm_set_sleep_mode default_sleep_params = {
>   	.pulsed_host_wake = 1,
>   };
>   
> -static int bcm_setup_sleep(struct hci_uart *hu)
> +static int bcm_setup_sleep(struct hci_uart *hu, bool sync, int mode)
>   {
>   	struct bcm_data *bcm = hu->priv;
>   	struct sk_buff *skb;
>   	struct bcm_set_sleep_mode sleep_params = default_sleep_params;
>   
>   	sleep_params.host_wake_active = !bcm->dev->irq_active_low;
> +	sleep_params.sleep_mode = mode;
> +
> +	if (!sync) {
> +		return __hci_cmd_send(hu->hdev, 0xfc27, sizeof(sleep_params),
> +				      &sleep_params);
> +	}
>   
>   	skb = __hci_cmd_sync(hu->hdev, 0xfc27, sizeof(sleep_params),
>   			     &sleep_params, HCI_INIT_TIMEOUT);
> @@ -412,7 +418,7 @@ static int bcm_setup_sleep(struct hci_uart *hu)
>   }
>   #else
>   static inline int bcm_request_irq(struct bcm_data *bcm) { return 0; }
> -static inline int bcm_setup_sleep(struct hci_uart *hu) { return 0; }
> +static inline int bcm_setup_sleep(struct hci_uart *hu, bool sync, int mode) { return 0; }

Without an IDE, I always wonder, if an enum or macro should be used for 
modes, so readers do not need to look up what 0 and 1 mean.

>   #endif
>   
>   static int bcm_set_diag(struct hci_dev *hdev, bool enable)
> @@ -647,7 +653,7 @@ static int bcm_setup(struct hci_uart *hu)
>   		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hu->hdev->quirks);
>   
>   	if (!bcm_request_irq(bcm))
> -		err = bcm_setup_sleep(hu);
> +		err = bcm_setup_sleep(hu, true, 0);
>   
>   	return err;
>   }
> @@ -767,6 +773,16 @@ static int bcm_suspend_device(struct device *dev)
>   	bt_dev_dbg(bdev, "");
>   
>   	if (!bdev->is_suspended && bdev->hu) {
> +		err = bcm_setup_sleep(bdev->hu, false, 1);
> +		/*
> +		 * If the sleep mode cannot be enabled, the BT device
> +		 * may consume more power, but this should not prevent
> +		 * RPM suspend from completion. Warn about this, but
> +		 * attempt to suspend anyway.
> +		 */
> +		if (err)
> +			dev_err(dev, "Failed to enable sleep mode\n");

Please print out the returned error, and maybe give suggestion, what the 
user should do in this case.

> +
>   		hci_uart_set_flow_control(bdev->hu, true);
>   
>   		/* Once this returns, driver suspends BT via GPIO */
> @@ -810,6 +826,16 @@ static int bcm_resume_device(struct device *dev)
>   		bdev->is_suspended = false;
>   
>   		hci_uart_set_flow_control(bdev->hu, false);
> +
> +		err = bcm_setup_sleep(bdev->hu, false, 0);
> +		/*
> +		 * If the sleep mode cannot be disabled, the BT device
> +		 * may fail to respond to commands at times, or may be
> +		 * completely unresponsive. Warn user about this, but
> +		 * attempt to resume anyway in best effort manner.
> +		 */
> +		if (err)
> +			dev_err(dev, "Failed to disable sleep mode\n");

Ditto.

>   	}
>   
>   	return 0;

Overall this looks good.


Kind regards,

Paul

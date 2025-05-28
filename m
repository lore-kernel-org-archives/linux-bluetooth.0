Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6C25C96;
	Wed, 28 May 2025 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748418389; cv=none; b=oB0GmW+J50HveXFrQ8rRtdvJbiXvSSqICbDd0ELr37zUUo1c5/qT5n13Hv3gWSzJAO4LDETBWik+DIS9lV6AAwX4q1T5d55gJY+JmY59W2BtrTQStDOaRgs6sZ2cT/xD7agdRuiDFxDGBnAzv6ZYqV01IF3E57lz9Hr6vjOT/rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748418389; c=relaxed/simple;
	bh=cQm3c1lDvA7kKP0rBKOZKHIR+yvIS7pKEtlBgOcgSi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VmoGo8rmukRsTB4rRMN2W8hQP06PfiOjw1dGnbxdsMKyqiBzboCYlS3l76eZ1WufCUBsdHmKcReTxWFDwAOh15Q0hteLapIwWEZvpUhyJgvHKK+2qpjDrFREnkPVR85k3UkXZpvgLnl3r1c/f3igxt75i8ob4ZoenEl0Ncu+coQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af669.dynamic.kabel-deutschland.de [95.90.246.105])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 62EFA601EBE87;
	Wed, 28 May 2025 09:46:10 +0200 (CEST)
Message-ID: <140ac32d-432c-496d-b62d-d4254735dc4c@molgen.mpg.de>
Date: Wed, 28 May 2025 09:46:09 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: BT Driver: mediatek: add gpio pin to reset bt
To: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Von Dentz <luiz.dentz@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Deren Wu <deren.Wu@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
 Chris Lu <chris.lu@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <20250528070323.14902-1-ot_zhangchao.zhang@mediatek.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250528070323.14902-1-ot_zhangchao.zhang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Zhangchao,


Thank you for your patch. For the summary, I’d just use:

Bluetooth: btmtk: Add gpio pin to reset bt


Am 28.05.25 um 09:03 schrieb Zhangchao Zhang:
> This patch provides some methods btmtk_reset_by_gpio,

some → the two

> btmtk_reset_by_gpio_work_for mediatek controller.
> 
> The pin is configured in dts files, bluetooth is reset by pulling
> the pin, when an exception or coredump occurs, the above method will
> be used to reset the bluetooth.

How did you test this? Could you please add that to the commit message.

> Co-developed-by Hao qin <hao.qin@mediatek.com>

qin → Qin

> Co-developed-by Chirs lu <chris.lu@mediatek.com>

Chirs → Chris
lu → Lu

> Co-developed-by Jiande lu <jiande.lu@mediatek.com>

lu → Lu

> Signed-off-by: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
> ---
>   drivers/bluetooth/btmtk.c | 59 +++++++++++++++++++++++++++++++++++++++
>   drivers/bluetooth/btmtk.h |  5 ++++
>   2 files changed, 64 insertions(+)
> 
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index 4390fd571dbd..16542c724b40 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -6,6 +6,8 @@
>   #include <linux/firmware.h>
>   #include <linux/usb.h>
>   #include <linux/iopoll.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
>   #include <linux/unaligned.h>
>   
>   #include <net/bluetooth/bluetooth.h>
> @@ -109,6 +111,59 @@ static void btmtk_coredump_notify(struct hci_dev *hdev, int state)
>   	}
>   }
>   
> +static void btmtk_reset_by_gpio_work(struct work_struct *work)
> +{
> +	struct btmtk_reset_gpio *reset_gpio_data =
> +			container_of(work, struct btmtk_reset_gpio, reset_work.work);
> +
> +	gpio_direction_output(reset_gpio_data->gpio_number, 1);
> +	kfree(reset_gpio_data);
> +}
> +
> +static int btmtk_reset_by_gpio(struct hci_dev *hdev)
> +{
> +	struct btmtk_data *data = hci_get_priv(hdev);
> +	struct btmtk_reset_gpio *reset_gpio_data;
> +	struct device_node *node;
> +	int reset_gpio_number;
> +
> +	node = of_find_compatible_node(NULL, NULL, "mediatek,usb-bluetooth");
> +	if (node) {
> +		reset_gpio_number = of_get_named_gpio(node, "reset-gpios", 0);
> +		if (!gpio_is_valid(reset_gpio_number)) {
> +			bt_dev_warn(hdev, "invalid reset gpio, use SW reset");

gpio → GPIO
SW → software
reet → reset?

Please also log the GPIO number. Also, a hint, what the user should do 
in this situation would be great.

> +			return -EINVAL;
> +		}
> +	} else {
> +		bt_dev_warn(hdev, "no reset gpio, use SW reet");

gpio → GPIO
SW → software
reet → reset?

> +		return -ENODEV;
> +	}
> +
> +	/* Toggle the hard reset line. The Mediatek device is going to
> +	 * yank itself off the USB and then replug. The cleanup is handled
> +	 * correctly on the way out (standard USB disconnect), and the new
> +	 * device is detected cleanly and bound to the driver again like
> +	 * it should be.
> +	 */
> +
> +	if (test_and_set_bit(BTMTK_HW_RESET_ACTIVE, &data->flags)) {
> +		bt_dev_err(hdev, "last reset failed? Not resetting again");

It’d be great, if this error message could be rephrased, so users know 
what is wrong, and what to do.

> +		return 0;
> +	}
> +
> +	reset_gpio_data = kzalloc(sizeof(*reset_gpio_data), GFP_KERNEL);
> +	if (!reset_gpio_data)
> +		return -ENOMEM;
> +
> +	INIT_DELAYED_WORK(&reset_gpio_data->reset_work, btmtk_reset_by_gpio_work);
> +	reset_gpio_data->gpio_number = reset_gpio_number;
> +
> +	gpio_direction_output(reset_gpio_number, 0);
> +	schedule_delayed_work(&reset_gpio_data->reset_work, msecs_to_jiffies(200));

A 200 ms delay is quite long. Maybe add the datasheet section as a 
reference in a comment?

> +
> +	return 0;
> +}
> +
>   void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, u32 fw_ver,
>   			   u32 fw_flavor)
>   {
> @@ -364,6 +419,10 @@ void btmtk_reset_sync(struct hci_dev *hdev)
>   	struct btmtk_data *reset_work = hci_get_priv(hdev);
>   	int err;
>   
> +	/*Toggle reset gpio if the platform provieds one*/

1.  Please add a space in the beginning and end.
2.  provides (A spell checker should have found this.)

> +	err = btmtk_reset_by_gpio(hdev);
> +	if (!err)
> +		return;
>   	hci_dev_lock(hdev);
>   
>   	err = hci_cmd_sync_queue(hdev, reset_work->reset_sync, NULL, NULL);
> diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
> index 5df7c3296624..8a265ce367d1 100644
> --- a/drivers/bluetooth/btmtk.h
> +++ b/drivers/bluetooth/btmtk.h
> @@ -179,6 +179,11 @@ struct btmtk_data {
>   	spinlock_t isorxlock;
>   };
>   
> +struct btmtk_reset_gpio {
> +	struct delayed_work reset_work;
> +	int gpio_number;
> +};
> +
>   typedef int (*wmt_cmd_sync_func_t)(struct hci_dev *,
>   				   struct btmtk_hci_wmt_params *);
>   


Kind regards,

Paul

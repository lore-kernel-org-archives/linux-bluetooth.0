Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194113A0EB8;
	Thu, 19 Mar 2026 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773905709; cv=none; b=SLhkValVJeAcgRb8YdQiRgy9wS0aurErO6StQH0Vq/YTcaL7ZtKte9IZqCarHWc3XzTisGVDAsI7LYfe/f1RZ13xSWJoG2cEyKoa2OoPhxeD9ZVMPXpNIvoc9xZiZlgvHnxjrX5/ogfFqx1vHgadSfKpqWnDO9+LQCTVif2hz6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773905709; c=relaxed/simple;
	bh=VDentg6sMgYU5QkY8Z/QjgaOBEdAYP53p62I+5Dc0WI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F/7Hg+O9mPCYJB/8m6FAuzyMy79632D4fupuhJcPmNrbjh5qjFXSaqg/uttRgiJaEvnkjquPeodkIPsVEaEM/IS/8GFve7MhUn5T0WySoHKHGWH5TVDmGGAioTv2bGQVziOiS5ehOtlavwuJ5u+UJxQpOvu674LFjMhLQCx5eEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [172.20.10.225] (unknown [24.40.138.251])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 203BF4C2F3FFC0;
	Thu, 19 Mar 2026 08:34:55 +0100 (CET)
Message-ID: <2bf77e71-98e5-4c03-b1c5-29e51d568fbe@molgen.mpg.de>
Date: Thu, 19 Mar 2026 08:34:53 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: clear remote wake on idle Intel ACPI
 paths
To: Sean Rhodes <sean@starlabs.systems>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <4863e9725130166fdfcea77298f70500dcc03b02.1773863497.git.sean@starlabs.systems>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <4863e9725130166fdfcea77298f70500dcc03b02.1773863497.git.sean@starlabs.systems>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Sean,


Thank you for your patch.

Am 18.03.26 um 20:51 schrieb Sean Rhodes:
> Commit 6953217d9f44 ("usb: core: allow ACPI-managed hard-wired ports
> to power off") allows internal USB devices on ACPI-managed hard-wired

I am unable to find the commit [1] besides on the Linux kernel list [2].

> ports to use the existing runtime power-off path. For Intel combined USB
> Bluetooth controllers, btusb still keeps runtime remote wake enabled for
> as long as the adapter is open, which prevents the USB PM core from
> dropping the last child reference and powering the port off while idle.
> 
> Only keep runtime remote wake enabled while the controller is expected
> to signal activity on its own: established links, discovery, LE scan,
> LE advertising, or BR/EDR page/inquiry scan. When those are idle, clear
> needs_remote_wakeup so autosuspend can power-manage the port and a later
> host-initiated command can resume the device again.

Could you add a test case and the device you tested with, and possible 
measurement numbers?

> Signed-off-by: Sean Rhodes <sean@starlabs.systems>
> ---
>   drivers/bluetooth/btusb.c | 50 +++++++++++++++++++++++++++++++++++++--
>   1 file changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 5e9ebf0c5312..9df8a7c3254b 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -901,6 +901,7 @@ struct btusb_data {
>   	unsigned long flags;
>   
>   	bool poll_sync;
> +	bool intel_combined;
>   	int intr_interval;
>   	struct work_struct  work;
>   	struct work_struct  waker;
> @@ -958,6 +959,9 @@ struct btusb_data {
>   	struct qca_dump_info qca_dump;
>   };
>   
> +static bool btusb_intel_idle_power_manageable(struct btusb_data *data);
> +static bool btusb_needs_runtime_remote_wakeup(struct btusb_data *data);
> +
>   static void btusb_reset(struct hci_dev *hdev)
>   {
>   	struct btusb_data *data;
> @@ -1151,12 +1155,19 @@ static inline void btusb_free_frags(struct btusb_data *data)
>   
>   static int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb)
>   {
> +	int err;
> +
>   	if (data->intr_interval) {
>   		/* Trigger dequeue immediately if an event is received */
>   		schedule_delayed_work(&data->rx_work, 0);
>   	}
>   
> -	return data->recv_event(data->hdev, skb);
> +	err = data->recv_event(data->hdev, skb);
> +	if (!err)
> +		data->intf->needs_remote_wakeup =
> +			btusb_needs_runtime_remote_wakeup(data);
> +
> +	return err;
>   }
>   
>   static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
> @@ -1924,7 +1935,8 @@ static int btusb_open(struct hci_dev *hdev)
>   			goto setup_fail;
>   	}
>   
> -	data->intf->needs_remote_wakeup = 1;
> +	data->intf->needs_remote_wakeup =
> +		btusb_needs_runtime_remote_wakeup(data);
>   
>   	if (test_and_set_bit(BTUSB_INTR_RUNNING, &data->flags))
>   		goto done;
> @@ -1967,6 +1979,38 @@ static void btusb_stop_traffic(struct btusb_data *data)
>   	usb_kill_anchored_urbs(&data->ctrl_anchor);
>   }
>   
> +static bool btusb_intel_idle_power_manageable(struct btusb_data *data)
> +{
> +	struct usb_device *udev = data->udev;
> +
> +	return data->intel_combined && udev->parent &&
> +	       usb_acpi_power_manageable(udev->parent, udev->portnum - 1);
> +}
> +
> +static bool btusb_needs_runtime_remote_wakeup(struct btusb_data *data)
> +{
> +	struct hci_dev *hdev = data->hdev;
> +
> +	if (!btusb_intel_idle_power_manageable(data))
> +		return true;
> +
> +	if (hci_conn_count(hdev))
> +		return true;
> +
> +	if (hdev->discovery.state == DISCOVERY_FINDING ||
> +	    hdev->discovery.state == DISCOVERY_RESOLVING)
> +		return true;
> +
> +	if (hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
> +	    hci_dev_test_flag(hdev, HCI_LE_ADV) ||
> +	    hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
> +	    test_bit(HCI_PSCAN, &hdev->flags) ||
> +	    test_bit(HCI_ISCAN, &hdev->flags))
> +		return true;
> +
> +	return false;
> +}
> +
>   static int btusb_close(struct hci_dev *hdev)
>   {
>   	struct btusb_data *data = hci_get_drvdata(hdev);
> @@ -4041,6 +4085,8 @@ static int btusb_probe(struct usb_interface *intf,
>   	data->recv_bulk = btusb_recv_bulk;
>   
>   	if (id->driver_info & BTUSB_INTEL_COMBINED) {
> +		data->intel_combined = true;
> +

I am not clear about this hunk. Could you please elaborate?

>   		/* Allocate extra space for Intel device */
>   		priv_size += sizeof(struct btintel_data);


Kind regards,

Paul


PS: Thank you so much for working on such details! Do you know, if this 
is also a problem on Google Chromebooks/-boxes?


[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/log/?h=usb-next&qt=author&q=rhodes
[2]: 
https://lore.kernel.org/all/20260315223433.23452-1-sean@starlabs.systems/

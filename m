Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE1E156F3C
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 May 2025 07:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748244861; cv=none; b=Ao+Kz0ZkZxZIZn3JtpmLoNOKjwWjG5VgtyUaELEssg9FL5SJTlEEcAG7Sl94F6jou3sOlTZtPq9br/Ie+J8qsI87NEN0CQrX/z2R/+7OBsQdIIGGsqzk1r+a1Fb9mMiOBAh5gx1y+ftVnD15SsQJTKZQwT1xP8IbRUvBrQ6DKDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748244861; c=relaxed/simple;
	bh=iJ41gj5SEfF+pDBb17RaSeerkYEyvjvyniGON0t8VMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JD0076EGkViSDbGQ5d+AueKpU9qhp0sJONCFC/Phkx43qwZTaQ1AU2ZtlfdfGm7agAnSAU3qvZP/2srRbaVfE+sRYK3AzJuDwvVDI3NrEeVFByTZp18HD6Q2itPbOAo6jZd+BddRGBObjT3ObZQrA+pm+Y48KF+Mpz1Oid3rSR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.107] (p5dc5559d.dip0.t-ipconnect.de [93.197.85.157])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3513561E6486B;
	Mon, 26 May 2025 09:33:53 +0200 (CEST)
Message-ID: <d63f80e1-382e-41d2-a0be-82a0ffc6bea9@molgen.mpg.de>
Date: Mon, 26 May 2025 09:33:52 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Bluetooth: btintel_pcie: Support Function level
 reset
To: Kiran K <kiran.k@intel.com>,
 Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, vijay.satija@intel.com
References: <20250525101619.530255-1-kiran.k@intel.com>
 <20250525101619.530255-2-kiran.k@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250525101619.530255-2-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Kiran, dear Chandrashekar,


Thank you for your patch.

Am 25.05.25 um 12:16 schrieb Kiran K:
> From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> 
> Support function level reset (flr) on hardware exception to recover
> controller. Driver also implements the back-off time of 5 seconds and
> the maximum number of retries are limited to 5 before giving up.

Could you elaborate on the implementation, and detail how this can be 
tested?

> Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>   drivers/bluetooth/btintel_pcie.c | 234 ++++++++++++++++++++++++++++++-
>   drivers/bluetooth/btintel_pcie.h |   4 +-
>   2 files changed, 235 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index 74a957784525..6779a2cfa75d 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -41,6 +41,13 @@ static const struct pci_device_id btintel_pcie_table[] = {
>   };
>   MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
>   
> +struct btintel_pcie_dev_restart_data {
> +	struct list_head list;
> +	u8 restart_count;
> +	time64_t last_error;
> +	char name[];
> +};
> +
>   /* Intel PCIe uses 4 bytes of HCI type instead of 1 byte BT SIG HCI type */
>   #define BTINTEL_PCIE_HCI_TYPE_LEN	4
>   #define BTINTEL_PCIE_HCI_CMD_PKT	0x00000001
> @@ -62,6 +69,9 @@ MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
>   #define BTINTEL_PCIE_TRIGGER_REASON_USER_TRIGGER	0x17A2
>   #define BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT		0x1E61
>   
> +#define BTINTEL_PCIE_RESET_OK_TIME_SECS		5
> +#define BTINTEL_PCIE_FLR_RESET_MAX_RETRY	5
> +
>   /* Alive interrupt context */
>   enum {
>   	BTINTEL_PCIE_ROM,
> @@ -99,6 +109,14 @@ struct btintel_pcie_dbgc_ctxt {
>   	struct btintel_pcie_dbgc_ctxt_buf bufs[BTINTEL_PCIE_DBGC_BUFFER_COUNT];
>   };
>   
> +struct btintel_pcie_removal {
> +	struct pci_dev *pdev;
> +	struct work_struct work;
> +};
> +
> +static LIST_HEAD(btintel_pcie_restart_data_list);
> +static DEFINE_SPINLOCK(btintel_pcie_restart_data_lock);
> +
>   /* This function initializes the memory for DBGC buffers and formats the
>    * DBGC fragment which consists header info and DBGC buffer's LSB, MSB and
>    * size as the payload
> @@ -1927,6 +1945,9 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
>   	u32 type;
>   	u32 old_ctxt;
>   
> +	if (test_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags))
> +		return -ENODEV;
> +
>   	/* Due to the fw limitation, the type header of the packet should be
>   	 * 4 bytes unlike 1 byte for UART. In UART, the firmware can read
>   	 * the first byte to get the packet type and redirect the rest of data
> @@ -2187,9 +2208,204 @@ static int btintel_pcie_setup(struct hci_dev *hdev)
>   		}
>   		btintel_pcie_start_rx(data);
>   	}
> +
> +	if (!err)
> +		set_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags);
>   	return err;
>   }
>   
> +static struct btintel_pcie_dev_restart_data *btintel_pcie_get_restart_data(struct pci_dev *pdev,
> +									   struct device *dev)
> +{
> +	struct btintel_pcie_dev_restart_data *tmp, *data = NULL;
> +	const char *name = pci_name(pdev);
> +	struct hci_dev *hdev = to_hci_dev(dev);
> +
> +	spin_lock(&btintel_pcie_restart_data_lock);
> +	list_for_each_entry(tmp, &btintel_pcie_restart_data_list, list) {
> +		if (strcmp(tmp->name, name))
> +			continue;
> +		data = tmp;
> +		break;
> +	}
> +	spin_unlock(&btintel_pcie_restart_data_lock);
> +
> +	if (data) {
> +		bt_dev_dbg(hdev, "Found restart data for BDF:%s", data->name);

Add a space after the colon?

> +		return data;
> +	}
> +
> +	/* First time allocate */
> +	data = kzalloc(struct_size(data, name, strlen(name) + 1), GFP_ATOMIC);
> +	if (!data)
> +		return NULL;
> +
> +	strscpy_pad(data->name, name, strlen(name) + 1);
> +	spin_lock(&btintel_pcie_restart_data_lock);
> +	list_add_tail(&data->list, &btintel_pcie_restart_data_list);
> +	spin_unlock(&btintel_pcie_restart_data_lock);
> +
> +	return data;
> +}
> +
> +static void btintel_pcie_free_restart_list(void)
> +{
> +	struct btintel_pcie_dev_restart_data *tmp;
> +
> +	while ((tmp = list_first_entry_or_null(&btintel_pcie_restart_data_list,
> +					       typeof(*tmp), list))) {
> +		list_del(&tmp->list);
> +		kfree(tmp);
> +	}
> +}
> +
> +static void btintel_pcie_inc_restart_count(struct pci_dev *pdev,
> +					   struct device *dev)
> +{
> +	struct btintel_pcie_dev_restart_data *data;
> +	struct hci_dev *hdev = to_hci_dev(dev);
> +	time64_t retry_window;
> +
> +	data = btintel_pcie_get_restart_data(pdev, dev);
> +	if (!data)
> +		return;
> +
> +	retry_window = ktime_get_boottime_seconds() - data->last_error;
> +	if (data->restart_count == 0) {
> +		/* First iteration initialise the time and counter */

initialises

But with the debug print below, the comment is not needed, in my opinion.

> +		data->last_error = ktime_get_boottime_seconds();
> +		data->restart_count++;
> +		bt_dev_dbg(hdev, "First iteration initialise. last_error:%lld seconds restart_count:%d",

Please add a space after the colon.

> +			   data->last_error, data->restart_count);
> +	} else if (retry_window < BTINTEL_PCIE_RESET_OK_TIME_SECS &&
> +		   data->restart_count <= BTINTEL_PCIE_FLR_RESET_MAX_RETRY) {
> +		/* FLR triggered still within the Max retry time so
> +		 * increment the counter
> +		 */
> +		data->restart_count++;
> +		bt_dev_dbg(hdev, "flr triggered still within the max retry time so increment the restart_count:%d",
> +			   data->restart_count);

Space after colon.

> +	} else if (retry_window > BTINTEL_PCIE_RESET_OK_TIME_SECS) {
> +		/* FLR triggered out of the retry window so reset */
> +		bt_dev_dbg(hdev, "flr triggered out of retry window. last_error:%lld seconds restart_count:%d",

Space after colons.

> +			   data->last_error, data->restart_count);
> +		data->last_error = 0;
> +		data->restart_count = 0;
> +	}
> +}
> +
> +static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data);
> +
> +static void btintel_pcie_removal_work(struct work_struct *wk)
> +{
> +	struct btintel_pcie_removal *removal =
> +		container_of(wk, struct btintel_pcie_removal, work);
> +	struct pci_dev *pdev = removal->pdev;
> +	struct btintel_pcie_data *data;
> +	int err;
> +
> +	pci_lock_rescan_remove();
> +
> +	if (!pdev->bus)
> +		goto error;
> +
> +	data = pci_get_drvdata(pdev);
> +
> +	btintel_pcie_disable_interrupts(data);
> +	btintel_pcie_synchronize_irqs(data);
> +	flush_workqueue(data->workqueue);
> +
> +	bt_dev_dbg(data->hdev, "Release bluetooth interface");
> +	btintel_pcie_release_hdev(data);
> +
> +	err = pci_reset_function(pdev);
> +	if (err) {
> +		BT_ERR("Failed resetting the pcie device (%d)", err);
> +		goto error;
> +	}
> +
> +	btintel_pcie_enable_interrupts(data);
> +	btintel_pcie_config_msix(data);
> +
> +	err = btintel_pcie_enable_bt(data);
> +	if (err) {
> +		BT_ERR("Failed to enable bluetooth hardware after reset (%d)",
> +		       err);

What should the user reading this error do?

> +		goto error;
> +	}
> +
> +	btintel_pcie_reset_ia(data);
> +	btintel_pcie_start_rx(data);
> +	data->flags = 0;
> +
> +	err = btintel_pcie_setup_hdev(data);
> +	if (err) {
> +		BT_ERR("Failed registering hdev (%d)", err);
> +		goto error;
> +	}
> +error:
> +	pci_dev_put(pdev);
> +	pci_unlock_rescan_remove();
> +	kfree(removal);
> +}
> +
> +static void btintel_pcie_reset(struct hci_dev *hdev)
> +{
> +	struct btintel_pcie_removal *removal;
> +	struct btintel_pcie_data *data;
> +
> +	data = hci_get_drvdata(hdev);
> +
> +	if (!test_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags))
> +		return;
> +
> +	removal = kzalloc(sizeof(*removal), GFP_ATOMIC);
> +	if (!removal)
> +		return;
> +
> +	flush_work(&data->rx_work);
> +	flush_work(&hdev->dump.dump_rx);
> +
> +	removal->pdev = data->pdev;
> +	INIT_WORK(&removal->work, btintel_pcie_removal_work);
> +	pci_dev_get(removal->pdev);
> +	schedule_work(&removal->work);
> +}
> +
> +static void btintel_pcie_hw_error(struct hci_dev *hdev, u8 code)
> +{
> +	struct  btintel_pcie_dev_restart_data *data;
> +	struct btintel_pcie_data *dev_data = hci_get_drvdata(hdev);
> +	struct pci_dev *pdev = dev_data->pdev;
> +	time64_t retry_window;
> +
> +	if (code == 0x13) {
> +		bt_dev_err(hdev, "Encountered top exception");
> +		return;
> +	}
> +
> +	data = btintel_pcie_get_restart_data(pdev, &hdev->dev);
> +	if (!data)
> +		return;
> +
> +	retry_window = ktime_get_boottime_seconds() - data->last_error;
> +
> +	/* If within 5 seconds max 5 attempts have already been made
> +	 * then stop any more retry and indicate to user for cold boot
> +	 */

The messages below should be improved, and the comment above can be 
removed then.

> +	if (retry_window < BTINTEL_PCIE_RESET_OK_TIME_SECS &&
> +	    data->restart_count >= BTINTEL_PCIE_FLR_RESET_MAX_RETRY) {
> +		bt_dev_err(hdev, "Max recovery retries(%d)  exhausted.",

Please add a space before (, exactly one space before *exhausted*. What 
should the user do?

> +			   BTINTEL_PCIE_FLR_RESET_MAX_RETRY);
> +		bt_dev_dbg(hdev, "Boot time:%lld seconds first_flr at:%lld seconds restart_count:%d",

Spaces after colons.

> +			   ktime_get_boottime_seconds(), data->last_error,
> +			   data->restart_count);
> +		return;
> +	}
> +	btintel_pcie_inc_restart_count(pdev, &hdev->dev);
> +	btintel_pcie_reset(hdev);
> +}
> +
>   static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
>   {
>   	int err;
> @@ -2211,9 +2427,10 @@ static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
>   	hdev->send = btintel_pcie_send_frame;
>   	hdev->setup = btintel_pcie_setup;
>   	hdev->shutdown = btintel_shutdown_combined;
> -	hdev->hw_error = btintel_hw_error;
> +	hdev->hw_error = btintel_pcie_hw_error;
>   	hdev->set_diag = btintel_set_diag;
>   	hdev->set_bdaddr = btintel_set_bdaddr;
> +	hdev->reset = btintel_pcie_reset;
>   
>   	err = hci_register_dev(hdev);
>   	if (err < 0) {
> @@ -2361,7 +2578,20 @@ static struct pci_driver btintel_pcie_driver = {
>   	.driver.coredump = btintel_pcie_coredump
>   #endif
>   };
> -module_pci_driver(btintel_pcie_driver);
> +
> +static int __init btintel_pcie_init(void)
> +{
> +	return pci_register_driver(&btintel_pcie_driver);
> +}
> +
> +static void __exit btintel_pcie_exit(void)
> +{
> +	pci_unregister_driver(&btintel_pcie_driver);
> +	btintel_pcie_free_restart_list();
> +}
> +
> +module_init(btintel_pcie_init);
> +module_exit(btintel_pcie_exit);
>   
>   MODULE_AUTHOR("Tedd Ho-Jeong An <tedd.an@intel.com>");
>   MODULE_DESCRIPTION("Intel Bluetooth PCIe transport driver ver " VERSION);
> diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
> index 21b964b15c1c..62b6bcdaf10f 100644
> --- a/drivers/bluetooth/btintel_pcie.h
> +++ b/drivers/bluetooth/btintel_pcie.h
> @@ -117,7 +117,9 @@ enum {
>   enum {
>   	BTINTEL_PCIE_CORE_HALTED,
>   	BTINTEL_PCIE_HWEXP_INPROGRESS,
> -	BTINTEL_PCIE_COREDUMP_INPROGRESS
> +	BTINTEL_PCIE_COREDUMP_INPROGRESS,
> +	BTINTEL_PCIE_RECOVERY_IN_PROGRESS,
> +	BTINTEL_PCIE_SETUP_DONE
>   };
>   
>   enum btintel_pcie_tlv_type {


Kind regards,

Paul

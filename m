Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6581D34B437
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 06:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781159408; cv=none; b=p3yomoX9w7G5b9JVoJQHaJr+0D++I1bbPpEOXxoApQz9al+d9VRZIQyoLCTmG7Ly2Y+tFx5M+16W0AwrugUlN3dFXDCVckDjUVRXzekoSNkTk/3t5XSMY1Fur4wRkleJ4H+mB5o8q3rsGPlWXTkEetcS3ATOdjAtjIf18zq8H4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781159408; c=relaxed/simple;
	bh=IyGr9ltk/+u88vYFkkGn+I0hPilrsjEefFIKnHqIAwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hSd29cmGeR5d7hDhUuMp5hrQU74QsMNKwkOjNhByD+JTSrP+key8IHpIjSgAqmJfViN+0nvxsPWD/22gmQx57EsO6YGlxaPowT4mEvfb9FMeD/gXtD9ztoxMsv3jraXTNis3r1zxEwrnEDnXeigJP3oBLkL5fad8Qh1KQLgm+BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.213] (p57bd9f9e.dip0.t-ipconnect.de [87.189.159.158])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 964674C28871A7;
	Thu, 11 Jun 2026 08:29:44 +0200 (CEST)
Message-ID: <bd28b9a0-4574-4dee-90d6-c68cc6468f1b@molgen.mpg.de>
Date: Thu, 11 Jun 2026 08:29:43 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: Separate coredump work from
 RX work
To: Kiran K <kiran.k@intel.com>, Ravindra <ravindra@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com
References: <20260610162544.240444-1-kiran.k@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260610162544.240444-1-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Ravindra, dear Kiran,


Thank you for your patch.

Am 10.06.26 um 18:25 schrieb Kiran K:
> From: Ravindra <ravindra@intel.com>
> 
> Sharing a single workqueue between coredump processing and RX
> delays evacuation of RX events while a coredump is in progress.

How big is the delay?

Is the coredump processed on the Bluetooth device?

> The firmware's RX buffers can overflow during that window, leading
> to dropped events. The issue was observed in HID use cases where
> HID reports arrive in bursts and quickly fill the RX path while a
> coredump is being collected.

How big are the RX buffers, and does Linux log an error in this situation?

> Move coredump processing to a dedicated ordered coredump_workqueue
> with its own coredump_work, so coredumps run independently of RX.
> All four coredump trigger sources (FW assert, HW exception, user
> sysfs trigger, and resume-error detection) are switched to this new
> workqueue. Ordering serialises concurrent triggers without blocking
> RX.

Please paste the logs, and please describe the test setup, how to force 
a coredump, and then, how the workqueues can be displayed to see it’s 
working.

> Signed-off-by: Ravindra <ravindra@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
> changes in v2:
> - Fix the race condition reported by Sashiko b/w reset_work() and
>    .remove()
> 
>   drivers/bluetooth/btintel_pcie.c | 102 +++++++++++++++++++++++++------
>   drivers/bluetooth/btintel_pcie.h |   5 ++
>   2 files changed, 87 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index 52293d19c817..e2f64d42c11c 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -1457,7 +1457,7 @@ static void btintel_pcie_msix_fw_trigger_handler(struct btintel_pcie_data *data)
>   	if (!test_and_set_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags))
>   		data->dmp_hdr.trigger_reason = BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT;
>   
> -	queue_work(data->workqueue, &data->rx_work);
> +	queue_work(data->coredump_workqueue, &data->coredump_work);
>   }
>   
>   static void btintel_pcie_msix_hw_exp_handler(struct btintel_pcie_data *data)
> @@ -1474,16 +1474,21 @@ static void btintel_pcie_msix_hw_exp_handler(struct btintel_pcie_data *data)
>   	if (!test_and_set_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags))
>   		data->dmp_hdr.trigger_reason = BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT;
>   
> -	queue_work(data->workqueue, &data->rx_work);
> +	queue_work(data->coredump_workqueue, &data->coredump_work);
>   }
>   
> -static void btintel_pcie_rx_work(struct work_struct *work)
> +static void btintel_pcie_coredump_worker(struct work_struct *work)
>   {
>   	struct btintel_pcie_data *data = container_of(work,
> -					struct btintel_pcie_data, rx_work);
> -	struct sk_buff *skb;
> +					struct btintel_pcie_data, coredump_work);
>   	int err;
>   
> +	/* hdev is NULL until setup_hdev() succeeds, and is cleared on
> +	 * teardown after disable_work_sync() drains us; bail in that case.
> +	 */
> +	if (!data->hdev)
> +		return;

Excuse my ignorance, but why should the worker not run in this case? Was 
the coredump processed?

> +
>   	if (test_bit(BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS, &data->flags)) {
>   		err = btintel_pcie_dump_fwtrigger_event(data);
>   		if (err)
> @@ -1507,6 +1512,13 @@ static void btintel_pcie_rx_work(struct work_struct *work)
>   		btintel_pcie_read_hwexp(data);
>   		clear_bit(BTINTEL_PCIE_HWEXP_INPROGRESS, &data->flags);
>   	}
> +}
> +
> +static void btintel_pcie_rx_work(struct work_struct *work)
> +{
> +	struct btintel_pcie_data *data = container_of(work,
> +					struct btintel_pcie_data, rx_work);
> +	struct sk_buff *skb;
>   
>   	/* Process the sk_buf in queue and send to the HCI layer */
>   	while ((skb = skb_dequeue(&data->rx_skb_q))) {
> @@ -2181,9 +2193,11 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
>   
>   static void btintel_pcie_release_hdev(struct btintel_pcie_data *data)
>   {
> -	struct hci_dev *hdev;
> +	struct hci_dev *hdev = data->hdev;
> +
> +	if (!hdev)
> +		return;
>   
> -	hdev = data->hdev;
>   	hci_unregister_dev(hdev);
>   	hci_free_dev(hdev);
>   	data->hdev = NULL;
> @@ -2603,6 +2617,10 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
>   	btintel_pcie_synchronize_irqs(data);
>   
>   	flush_work(&data->rx_work);
> +	/* Drain any in-flight coredump and block new ones across reset.
> +	 * Safe from self-deadlock: coredump_work runs on a separate wq.
> +	 */
> +	disable_work_sync(&data->coredump_work);
>   
>   	bt_dev_dbg(data->hdev, "Release bluetooth interface");
>   	if (data->reset_type == BTINTEL_PCIE_IOSF_PRR_PLDR) {
> @@ -2610,16 +2628,27 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
>   		 * pci_rescan_remove_lock. This mutex serializes against PCI device
>   		 * addition/removal (hotplug), so no device can be added to or
>   		 * removed from the bus list while this code runs.
> +		 *
> +		 * device_reprobe() inside btintel_pcie_perform_pldr() destroys
> +		 * 'data' via .remove(); a fresh probe re-INIT_WORKs the
> +		 * coredump_work with disable count 0, so we must not call
> +		 * enable_work() on this path.
>   		 */
>   		btintel_pcie_perform_pldr(data);
>   		goto out;
>   	}
>   	btintel_pcie_release_hdev(data);
>   
> -	err = pci_reset_function(pdev);
> +	/* Use pci_try_reset_function() rather than pci_reset_function() to
> +	 * avoid an ABBA deadlock against btintel_pcie_remove(): the PCI core
> +	 * calls .remove() with device_lock held, and remove() then waits for
> +	 * this work via cancel_work_sync(); pci_reset_function() would in
> +	 * turn try to acquire the same device_lock, deadlocking both paths.
> +	 */
> +	err = pci_try_reset_function(pdev);

This is not mentioned in the commit message. Should that be a separate 
commit for easier review, and easier backporting to the LTS series?

>   	if (err) {
>   		BT_ERR("Failed resetting the pcie device (%d)", err);
> -		goto out;
> +		goto out_enable;
>   	}
>   
>   	btintel_pcie_enable_interrupts(data);
> @@ -2629,7 +2658,7 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
>   	if (err) {
>   		BT_ERR("Failed to enable bluetooth hardware after reset (%d)",
>   		       err);
> -		goto out;
> +		goto out_enable;
>   	}
>   
>   	btintel_pcie_reset_ia(data);
> @@ -2639,8 +2668,15 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
>   	err = btintel_pcie_setup_hdev(data);
>   	if (err) {
>   		BT_ERR("Failed registering hdev (%d)", err);
> -		goto out;
> +		goto out_enable;
>   	}
> +
> +out_enable:
> +	/* Balance disable_work_sync() above on every exit. Leaving the
> +	 * counter incremented on a failed reset would permanently disable
> +	 * coredump_work even after a later successful reset.
> +	 */
> +	enable_work(&data->coredump_work);
>   out:
>   	pci_dev_put(pdev);
>   	pci_unlock_rescan_remove();
> @@ -2774,7 +2810,6 @@ static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
>   	hdev->bus = HCI_PCI;
>   	hci_set_drvdata(hdev, data);
>   
> -	data->hdev = hdev;
>   	SET_HCIDEV_DEV(hdev, &data->pdev->dev);
>   
>   	hdev->manufacturer = 2;
> @@ -2793,15 +2828,17 @@ static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
>   	err = hci_register_dev(hdev);
>   	if (err < 0) {
>   		BT_ERR("Failed to register to hdev (%d)", err);
> -		goto exit_error;
> +		hci_free_dev(hdev);
> +		return err;
>   	}
>   
> +	/* Publish hdev only after successful registration; the coredump
> +	 * worker bails on !data->hdev, so it never observes a half-set-up
> +	 * device.
> +	 */
> +	data->hdev = hdev;
>   	data->dmp_hdr.driver_name = KBUILD_MODNAME;
>   	return 0;
> -
> -exit_error:
> -	hci_free_dev(hdev);
> -	return err;
>   }
>   
>   static int btintel_pcie_probe(struct pci_dev *pdev,
> @@ -2832,9 +2869,16 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
>   	if (!data->workqueue)
>   		return -ENOMEM;
>   
> +	data->coredump_workqueue = alloc_ordered_workqueue(KBUILD_MODNAME "_cd", 0);
> +	if (!data->coredump_workqueue) {
> +		destroy_workqueue(data->workqueue);
> +		return -ENOMEM;
> +	}
> +
>   	skb_queue_head_init(&data->rx_skb_q);
>   	INIT_WORK(&data->rx_work, btintel_pcie_rx_work);
>   	INIT_WORK(&data->reset_work, btintel_pcie_reset_work);
> +	INIT_WORK(&data->coredump_work, btintel_pcie_coredump_worker);
>   
>   	data->boot_stage_cache = 0x00;
>   	data->img_resp_cache = 0x00;
> @@ -2877,6 +2921,8 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
>   	/* reset device before exit */
>   	btintel_pcie_reset_bt(data);
>   
> +	destroy_workqueue(data->coredump_workqueue);
> +
>   	pci_clear_master(pdev);
>   
>   	pci_set_drvdata(pdev, NULL);
> @@ -2894,13 +2940,20 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
>   		return;
>   	}
>   
> +	/* Permanently block coredump triggers and drain the worker before
> +	 * tearing down. Must run before cancel_work_sync(&reset_work) so
> +	 * the disable counter stays >= 1 even after reset_work()'s
> +	 * balanced enable_work() (counter 2 -> 1, never reaching 0).
> +	 */
> +	disable_work_sync(&data->coredump_work);
> +
>   	/* Cancel pending reset work. Skip only when remove() is called from
>   	 * within the reset work itself (PLDR device_reprobe path) to avoid
>   	 * deadlock. current_work() returns the work_struct of the caller if
>   	 * we are in a workqueue context.
>   	 */
>   	if (current_work() != &data->reset_work)
> -		cancel_work_sync(&data->reset_work);
> +		disable_work_sync(&data->reset_work);
>   
>   	btintel_pcie_disable_interrupts(data);
>   
> @@ -2920,6 +2973,7 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
>   
>   	btintel_pcie_release_hdev(data);
>   
> +	destroy_workqueue(data->coredump_workqueue);
>   	destroy_workqueue(data->workqueue);
>   
>   	btintel_pcie_free(data);
> @@ -2935,11 +2989,19 @@ static void btintel_pcie_coredump(struct device *dev)
>   	struct  pci_dev *pdev = to_pci_dev(dev);
>   	struct btintel_pcie_data *data = pci_get_drvdata(pdev);
>   
> +	if (!data)
> +		return;
> +
>   	if (test_and_set_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags))
>   		return;
>   
>   	data->dmp_hdr.trigger_reason  = BTINTEL_PCIE_TRIGGER_REASON_USER_TRIGGER;
> -	queue_work(data->workqueue, &data->rx_work);
> +	/* queue_work() returns false if the work is disabled (reset or
> +	 * remove in progress); clear the in-progress bit so a later
> +	 * trigger can succeed once the work is re-enabled.
> +	 */
> +	if (!queue_work(data->coredump_workqueue, &data->coredump_work))
> +		clear_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags);
>   }
>   #endif
>   
> @@ -3080,7 +3142,7 @@ static int btintel_pcie_resume(struct device *dev)
>   				      &data->flags)) {
>   			data->dmp_hdr.trigger_reason =
>   				BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT;
> -			queue_work(data->workqueue, &data->rx_work);
> +			queue_work(data->coredump_workqueue, &data->coredump_work);
>   		}
>   		set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
>   		btintel_pcie_reset(data->hdev);
> diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
> index e4a8fa479188..7caee093e316 100644
> --- a/drivers/bluetooth/btintel_pcie.h
> +++ b/drivers/bluetooth/btintel_pcie.h
> @@ -466,6 +466,8 @@ struct btintel_pcie_dump_header {
>    * @workqueue: workqueue for RX work
>    * @rx_skb_q: SKB queue for RX packet
>    * @rx_work: RX work struct to process the RX packet in @rx_skb_q
> + * @coredump_workqueue: dedicated workqueue for coredump collection
> + * @coredump_work: work struct for coredump trace collection
>    * @dma_pool: DMA pool for descriptors, index array and ci
>    * @dma_p_addr: DMA address for pool
>    * @dma_v_addr: address of pool
> @@ -514,6 +516,9 @@ struct btintel_pcie_data {
>   	struct work_struct	rx_work;
>   	struct work_struct      reset_work;
>   
> +	struct workqueue_struct	*coredump_workqueue;
> +	struct work_struct	coredump_work;
> +
>   	struct dma_pool	*dma_pool;
>   	dma_addr_t	dma_p_addr;
>   	void		*dma_v_addr;


Kind regards,

Paul

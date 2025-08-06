Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EF12185AA
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Aug 2025 06:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754463030; cv=none; b=qpsk53Xv6wOlzU5+GtXKTfBx9ztv49UnLOUd1P0Ww83vcokbhwdzWqzSqaWWLQJ/YkejNMW/x9ouQh2fPDwdZ68NttAfv9EFvVozR6b0gxedzJ7gSjRKMD6VhhSk3CEIyJa+anONbV2HWZzp77Bi2+7XBwsZKAoIhl9ZfAC0OFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754463030; c=relaxed/simple;
	bh=1NsKWcxVBLQpnQ3FVc7T2299jXQoGV3bh91SdgO2Rzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KevXu1YdLuoBe/cFHI5ncqgYI67T24nI62dlFj8R7SdbmFp3H101tA483xcR+l7hZffB//YSJPkLO42nYlOvj/6uQoSmwFk/cikWvVY68Qcqax8tDMgMfznO2lwwCuiQWJHRf3rpqtcy3GffeSf5x5JoPTGPKBSxRjCimEjaRYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7ca.dynamic.kabel-deutschland.de [95.90.247.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E9CDC61E64848;
	Wed, 06 Aug 2025 08:50:09 +0200 (CEST)
Message-ID: <2b259ec0-ed7e-42a0-981a-8b45348a3b81@molgen.mpg.de>
Date: Wed, 6 Aug 2025 08:50:09 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Refactor Device Coredump
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chandrashekar.devegowda@intel.com, chethan.tumkur.narayan@intel.com
References: <20250806000535.1523133-1-kiran.k@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250806000535.1523133-1-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kiran,


Thank you for your patch.

Am 06.08.25 um 02:05 schrieb Kiran K:
> As device coredumps are not HCI traces, maintain the device coredump at
> the driver level and eliminate the dependency on hdev_devcd*()

Please add a dot/period at the end of sentences.

Also, please elaborate more, how it’s implemented at the driver level.

Also, how can this be tested?

> Signed-off-by: Kiran K <kiran.k@intel.com>
> Fixes: 07e6bddb54b4 ("Bluetooth: btintel_pcie: Add support for device coredump")
> ---
>   drivers/bluetooth/btintel_pcie.c | 208 ++++++++++---------------------
>   drivers/bluetooth/btintel_pcie.h |   2 +
>   2 files changed, 71 insertions(+), 139 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index 22a2953adbd6..3816efd654d2 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -15,6 +15,7 @@
>   #include <linux/interrupt.h>
>   
>   #include <linux/unaligned.h>
> +#include <linux/devcoredump.h>
>   
>   #include <net/bluetooth/bluetooth.h>
>   #include <net/bluetooth/hci_core.h>
> @@ -559,25 +560,6 @@ static void btintel_pcie_mac_init(struct btintel_pcie_data *data)
>   	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
>   }
>   
> -static int btintel_pcie_add_dmp_data(struct hci_dev *hdev, const void *data, int size)
> -{
> -	struct sk_buff *skb;
> -	int err;
> -
> -	skb = alloc_skb(size, GFP_ATOMIC);
> -	if (!skb)
> -		return -ENOMEM;
> -
> -	skb_put_data(skb, data, size);
> -	err = hci_devcd_append(hdev, skb);
> -	if (err) {
> -		bt_dev_err(hdev, "Failed to append data in the coredump");
> -		return err;
> -	}
> -
> -	return 0;
> -}
> -
>   static int btintel_pcie_get_mac_access(struct btintel_pcie_data *data)
>   {
>   	u32 reg;
> @@ -622,30 +604,35 @@ static void btintel_pcie_release_mac_access(struct btintel_pcie_data *data)
>   	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
>   }
>   
> -static void btintel_pcie_copy_tlv(struct sk_buff *skb, enum btintel_pcie_tlv_type type,
> -				  void *data, int size)
> +static void *btintel_pcie_copy_tlv(void *dest, enum btintel_pcie_tlv_type type,
> +				   void *data, size_t size)
>   {
>   	struct intel_tlv *tlv;
>   
> -	tlv = skb_put(skb, sizeof(*tlv) + size);
> +	tlv = dest;
>   	tlv->type = type;
>   	tlv->len = size;
>   	memcpy(tlv->val, data, tlv->len);
> +	return dest + sizeof(*tlv) + size;
>   }
>   
>   static int btintel_pcie_read_dram_buffers(struct btintel_pcie_data *data)
>   {
> -	u32 offset, prev_size, wr_ptr_status, dump_size, i;
> +	u32 offset, prev_size, wr_ptr_status, dump_size, data_len;

Why not use `size_t` or `unsigned int` for `data_len`?

>   	struct btintel_pcie_dbgc *dbgc = &data->dbgc;
> -	u8 buf_idx, dump_time_len, fw_build;
>   	struct hci_dev *hdev = data->hdev;
> +	u8 *pdata, *p, buf_idx;
>   	struct intel_tlv *tlv;
>   	struct timespec64 now;
> -	struct sk_buff *skb;
>   	struct tm tm_now;
> -	char buf[256];
> -	u16 hdr_len;
> -	int ret;
> +	char fw_build[128];
> +	char ts[128];
> +	char vendor[64];
> +	char driver[64];
> +
> +	if (!IS_ENABLED(CONFIG_DEV_COREDUMP))
> +		return -EOPNOTSUPP;
> +
>   
>   	wr_ptr_status = btintel_pcie_rd_dev_mem(data, BTINTEL_PCIE_DBGC_CUR_DBGBUFF_STATUS);
>   	offset = wr_ptr_status & BTINTEL_PCIE_DBG_OFFSET_BIT_MASK;
> @@ -662,88 +649,84 @@ static int btintel_pcie_read_dram_buffers(struct btintel_pcie_data *data)
>   	else
>   		return -EINVAL;
>   
> +	snprintf(vendor, sizeof(vendor), "Vendor: Intel\n");
> +	snprintf(driver, sizeof(driver), "Driver: %s\n",
> +		 data->dmp_hdr.driver_name);
> +

As below, this seems unrelated to the refactoring. Please make it a 
separate patch.

>   	ktime_get_real_ts64(&now);
>   	time64_to_tm(now.tv_sec, 0, &tm_now);
> -	dump_time_len = snprintf(buf, sizeof(buf), "Dump Time: %02d-%02d-%04ld %02d:%02d:%02d",
> +	snprintf(ts, sizeof(ts), "Dump Time: %02d-%02d-%04ld %02d:%02d:%02d",
>   				 tm_now.tm_mday, tm_now.tm_mon + 1, tm_now.tm_year + 1900,
>   				 tm_now.tm_hour, tm_now.tm_min, tm_now.tm_sec);
>   
> -	fw_build = snprintf(buf + dump_time_len, sizeof(buf) - dump_time_len,
> +	snprintf(fw_build, sizeof(fw_build),
>   			    "Firmware Timestamp: Year %u WW %02u buildtype %u build %u",
>   			    2000 + (data->dmp_hdr.fw_timestamp >> 8),
>   			    data->dmp_hdr.fw_timestamp & 0xff, data->dmp_hdr.fw_build_type,
>   			    data->dmp_hdr.fw_build_num);
>   
> -	hdr_len = sizeof(*tlv) + sizeof(data->dmp_hdr.cnvi_bt) +
> +	data_len += sizeof(*tlv) + sizeof(data->dmp_hdr.cnvi_bt) +
>   		  sizeof(*tlv) + sizeof(data->dmp_hdr.write_ptr) +
>   		  sizeof(*tlv) + sizeof(data->dmp_hdr.wrap_ctr) +
>   		  sizeof(*tlv) + sizeof(data->dmp_hdr.trigger_reason) +
>   		  sizeof(*tlv) + sizeof(data->dmp_hdr.fw_git_sha1) +
>   		  sizeof(*tlv) + sizeof(data->dmp_hdr.cnvr_top) +
>   		  sizeof(*tlv) + sizeof(data->dmp_hdr.cnvi_top) +
> -		  sizeof(*tlv) + dump_time_len +
> -		  sizeof(*tlv) + fw_build;
> +		  sizeof(*tlv) + strlen(ts) +
> +		  sizeof(*tlv) + strlen(fw_build) +
> +		  sizeof(*tlv) + strlen(vendor) +
> +		  sizeof(*tlv) + strlen(driver);
>   
> -	dump_size = hdr_len + sizeof(hdr_len);
> +	/*
> +	 * sizeof(u32) - signature
> +	 * sizeof(data_len) - to store tlv data size
> +	 * data_len - TLV data
> +	 */
> +	dump_size = sizeof(u32) + sizeof(data_len) + data_len;
>   
> -	skb = alloc_skb(dump_size, GFP_KERNEL);
> -	if (!skb)
> -		return -ENOMEM;
>   
>   	/* Add debug buffers data length to dump size */
>   	dump_size += BTINTEL_PCIE_DBGC_BUFFER_SIZE * dbgc->count;
>   
> -	ret = hci_devcd_init(hdev, dump_size);
> -	if (ret) {
> -		bt_dev_err(hdev, "Failed to init devcoredump, err %d", ret);
> -		kfree_skb(skb);
> -		return ret;
> -	}
> +	pdata = vmalloc(dump_size);
> +	if (!pdata)
> +		return -ENOMEM;
> +	p = pdata;
> +
> +	*(u32 *)p = BTINTEL_PCIE_MAGIC_NUM;
> +	p += sizeof(u32);
>   
> -	skb_put_data(skb, &hdr_len, sizeof(hdr_len));
> +	*(u32 *)p = data_len;
> +	p += sizeof(u32);
>   
> -	btintel_pcie_copy_tlv(skb, BTINTEL_CNVI_BT, &data->dmp_hdr.cnvi_bt,
> -			      sizeof(data->dmp_hdr.cnvi_bt));
>   
> -	btintel_pcie_copy_tlv(skb, BTINTEL_WRITE_PTR, &data->dmp_hdr.write_ptr,
> -			      sizeof(data->dmp_hdr.write_ptr));
> +	p = btintel_pcie_copy_tlv(p, BTINTEL_VENDOR, vendor, strlen(vendor));
> +	p = btintel_pcie_copy_tlv(p, BTINTEL_DRIVER, driver, strlen(driver));

This two lines are also new. How is that related to the refactoring?

> +	p = btintel_pcie_copy_tlv(p, BTINTEL_DUMP_TIME, ts, strlen(ts));
> +	p = btintel_pcie_copy_tlv(p, BTINTEL_FW_BUILD, fw_build,
> +				  strlen(fw_build));
> +	p = btintel_pcie_copy_tlv(p, BTINTEL_CNVI_BT, &data->dmp_hdr.cnvi_bt,
> +				  sizeof(data->dmp_hdr.cnvi_bt));
> +	p = btintel_pcie_copy_tlv(p, BTINTEL_WRITE_PTR, &data->dmp_hdr.write_ptr,
> +				  sizeof(data->dmp_hdr.write_ptr));
> +	p = btintel_pcie_copy_tlv(p, BTINTEL_WRAP_CTR, &data->dmp_hdr.wrap_ctr,
> +				  sizeof(data->dmp_hdr.wrap_ctr));
>   
>   	data->dmp_hdr.wrap_ctr = btintel_pcie_rd_dev_mem(data,
>   							 BTINTEL_PCIE_DBGC_DBGBUFF_WRAP_ARND);
>   
> -	btintel_pcie_copy_tlv(skb, BTINTEL_WRAP_CTR, &data->dmp_hdr.wrap_ctr,
> -			      sizeof(data->dmp_hdr.wrap_ctr));
> -
> -	btintel_pcie_copy_tlv(skb, BTINTEL_TRIGGER_REASON, &data->dmp_hdr.trigger_reason,
> -			      sizeof(data->dmp_hdr.trigger_reason));
> -
> -	btintel_pcie_copy_tlv(skb, BTINTEL_FW_SHA, &data->dmp_hdr.fw_git_sha1,
> -			      sizeof(data->dmp_hdr.fw_git_sha1));
> -
> -	btintel_pcie_copy_tlv(skb, BTINTEL_CNVR_TOP, &data->dmp_hdr.cnvr_top,
> -			      sizeof(data->dmp_hdr.cnvr_top));
> -
> -	btintel_pcie_copy_tlv(skb, BTINTEL_CNVI_TOP, &data->dmp_hdr.cnvi_top,
> -			      sizeof(data->dmp_hdr.cnvi_top));
> -
> -	btintel_pcie_copy_tlv(skb, BTINTEL_DUMP_TIME, buf, dump_time_len);
> -
> -	btintel_pcie_copy_tlv(skb, BTINTEL_FW_BUILD, buf + dump_time_len, fw_build);
> -
> -	ret = hci_devcd_append(hdev, skb);
> -	if (ret)
> -		goto exit_err;
> -
> -	for (i = 0; i < dbgc->count; i++) {
> -		ret = btintel_pcie_add_dmp_data(hdev, dbgc->bufs[i].data,
> -						BTINTEL_PCIE_DBGC_BUFFER_SIZE);
> -		if (ret)
> -			break;
> -	}
> -
> -exit_err:
> -	hci_devcd_complete(hdev);
> -	return ret;
> +	p = btintel_pcie_copy_tlv(p, BTINTEL_TRIGGER_REASON, &data->dmp_hdr.trigger_reason,
> +				  sizeof(data->dmp_hdr.trigger_reason));
> +	p = btintel_pcie_copy_tlv(p, BTINTEL_FW_SHA, &data->dmp_hdr.fw_git_sha1,
> +				  sizeof(data->dmp_hdr.fw_git_sha1));
> +	p = btintel_pcie_copy_tlv(p, BTINTEL_CNVR_TOP, &data->dmp_hdr.cnvr_top,
> +				  sizeof(data->dmp_hdr.cnvr_top));
> +	p = btintel_pcie_copy_tlv(p, BTINTEL_CNVI_TOP, &data->dmp_hdr.cnvi_top,
> +				  sizeof(data->dmp_hdr.cnvi_top));
> +
> +	memcpy(p, dbgc->bufs[0].data, dbgc->count * BTINTEL_PCIE_DBGC_BUFFER_SIZE);
> +	dev_coredumpv(&hdev->dev, pdata, dump_size, GFP_KERNEL);
> +	return 0;
>   }
>   
>   static void btintel_pcie_dump_traces(struct hci_dev *hdev)
> @@ -765,51 +748,6 @@ static void btintel_pcie_dump_traces(struct hci_dev *hdev)
>   		bt_dev_err(hdev, "Failed to dump traces: (%d)", ret);
>   }
>   
> -static void btintel_pcie_dump_hdr(struct hci_dev *hdev, struct sk_buff *skb)
> -{
> -	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
> -	u16 len = skb->len;
> -	u16 *hdrlen_ptr;
> -	char buf[80];
> -
> -	hdrlen_ptr = skb_put_zero(skb, sizeof(len));
> -
> -	snprintf(buf, sizeof(buf), "Controller Name: 0x%X\n",
> -		 INTEL_HW_VARIANT(data->dmp_hdr.cnvi_bt));
> -	skb_put_data(skb, buf, strlen(buf));
> -
> -	snprintf(buf, sizeof(buf), "Firmware Build Number: %u\n",
> -		 data->dmp_hdr.fw_build_num);
> -	skb_put_data(skb, buf, strlen(buf));
> -
> -	snprintf(buf, sizeof(buf), "Driver: %s\n", data->dmp_hdr.driver_name);
> -	skb_put_data(skb, buf, strlen(buf));
> -
> -	snprintf(buf, sizeof(buf), "Vendor: Intel\n");
> -	skb_put_data(skb, buf, strlen(buf));
> -
> -	*hdrlen_ptr = skb->len - len;
> -}
> -
> -static void btintel_pcie_dump_notify(struct hci_dev *hdev, int state)
> -{
> -	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
> -
> -	switch (state) {
> -	case HCI_DEVCOREDUMP_IDLE:
> -		data->dmp_hdr.state = HCI_DEVCOREDUMP_IDLE;
> -		break;
> -	case HCI_DEVCOREDUMP_ACTIVE:
> -		data->dmp_hdr.state = HCI_DEVCOREDUMP_ACTIVE;
> -		break;
> -	case HCI_DEVCOREDUMP_TIMEOUT:
> -	case HCI_DEVCOREDUMP_ABORT:
> -	case HCI_DEVCOREDUMP_DONE:
> -		data->dmp_hdr.state = HCI_DEVCOREDUMP_IDLE;
> -		break;
> -	}
> -}
> -
>   /* This function enables BT function by setting BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT bit in
>    * BTINTEL_PCIE_CSR_FUNC_CTRL_REG register and wait for MSI-X with
>    * BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0.
> @@ -1383,6 +1321,11 @@ static void btintel_pcie_rx_work(struct work_struct *work)
>   					struct btintel_pcie_data, rx_work);
>   	struct sk_buff *skb;
>   
> +	if (test_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags)) {
> +		btintel_pcie_dump_traces(data->hdev);
> +		clear_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags);
> +	}
> +
>   	if (test_bit(BTINTEL_PCIE_HWEXP_INPROGRESS, &data->flags)) {
>   		/* Unlike usb products, controller will not send hardware
>   		 * exception event on exception. Instead controller writes the
> @@ -1395,11 +1338,6 @@ static void btintel_pcie_rx_work(struct work_struct *work)
>   		clear_bit(BTINTEL_PCIE_HWEXP_INPROGRESS, &data->flags);
>   	}
>   
> -	if (test_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags)) {
> -		btintel_pcie_dump_traces(data->hdev);
> -		clear_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags);
> -	}
> -

Why does this need to be moved?

>   	/* Process the sk_buf in queue and send to the HCI layer */
>   	while ((skb = skb_dequeue(&data->rx_skb_q))) {
>   		btintel_pcie_recv_frame(data, skb);
> @@ -2190,13 +2128,6 @@ static int btintel_pcie_setup_internal(struct hci_dev *hdev)
>   	if (ver_tlv.img_type == 0x02 || ver_tlv.img_type == 0x03)
>   		data->dmp_hdr.fw_git_sha1 = ver_tlv.git_sha1;
>   
> -	err = hci_devcd_register(hdev, btintel_pcie_dump_traces, btintel_pcie_dump_hdr,
> -				 btintel_pcie_dump_notify);
> -	if (err) {
> -		bt_dev_err(hdev, "Failed to register coredump (%d)", err);
> -		goto exit_error;
> -	}
> -
>   	btintel_print_fseq_info(hdev);
>   exit_error:
>   	kfree_skb(skb);
> @@ -2325,7 +2256,6 @@ static void btintel_pcie_removal_work(struct work_struct *wk)
>   	btintel_pcie_synchronize_irqs(data);
>   
>   	flush_work(&data->rx_work);
> -	flush_work(&data->hdev->dump.dump_rx);
>   
>   	bt_dev_dbg(data->hdev, "Release bluetooth interface");
>   	btintel_pcie_release_hdev(data);
> diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
> index 0fa876c5b954..04b21f968ad3 100644
> --- a/drivers/bluetooth/btintel_pcie.h
> +++ b/drivers/bluetooth/btintel_pcie.h
> @@ -132,6 +132,8 @@ enum btintel_pcie_tlv_type {
>   	BTINTEL_CNVI_TOP,
>   	BTINTEL_DUMP_TIME,
>   	BTINTEL_FW_BUILD,
> +	BTINTEL_VENDOR,
> +	BTINTEL_DRIVER
>   };
>   
>   /* causes for the MBOX interrupts */


Kind regards,

Paul

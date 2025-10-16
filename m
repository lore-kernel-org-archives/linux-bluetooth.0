Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61DD2DE704
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 06:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760596600; cv=none; b=gQ55IqhS6bOIycYYpykRLJmMPjS1V6N99Xa1fZQLQ+o4LRBU8mq2ljA0gOnL9rbsD5fnUlSNKm0Pihb+Nh2rlWguO63oRPH5QfvNXK4+7E2eJCa5c13rDVHKvg5t5UqYbKRiNr6ui9aC1ssUzW7NRWT5dR1fw8eD2iBUkKsr1yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760596600; c=relaxed/simple;
	bh=4spb3EfjgtgTZVIR37hYwBdXQkeaAaG5O/Owv4ftt1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IcGlDKwwfSnl9CZuXXaGsnPENN9lyVSISXLepwYOF9NF9INo2ViaqvIlupbEDi+h9NLhsYrLyBM+rMt3IAXqhP51FUkPshT+V5Cv8Ed9kkwzS5xXhfXZT0HSLgPocdS1JLhymc0jVuyck0bSsdsZbDTg6QSQBgVz5cEP2tVR9os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.212] (p5dc5567b.dip0.t-ipconnect.de [93.197.86.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 493116028F35E;
	Thu, 16 Oct 2025 08:36:16 +0200 (CEST)
Message-ID: <1854c81e-ae4e-434c-a034-0b9fce554b66@molgen.mpg.de>
Date: Thu, 16 Oct 2025 08:36:15 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Add support for smart trigger
 dump
To: Kiran K <kiran.k@intel.com>, Vijay Satija <vijay.satija@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chandrashekar.devegowda@intel.com, chethan.tumkur.narayan@intel.com
References: <20251016055755.2587652-1-kiran.k@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251016055755.2587652-1-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Kiran, dear Vijay,


Thank you for the patch.

Am 16.10.25 um 07:57 schrieb Kiran K:
> Based on the debug configuration, firmware can raise MSIX interrupt with

MSI-X

> firmware trigger cause bit set on specific events like Disconnection,
> Connection Timeout, Page Timeout etc.
> 
> Upon receiving an MSIX interrupt with the firmware trigger cause bit

MSI-X

> set, the driver performs the following actions:
> 
> 1. Reads Device Memory: Retrieves data from the device memory,
>     constructs an HCI vendor event, and sends it to the monitor. This
>     event includes details about the trigger, such as connection timeout or
>     page timeout.
> 
> 2. Dumps Device Coredump: Generates a coredump containing firmware
>     traces for further analysis.

Please give an example how to retrieve the coredump.

Maybe also paste the new debug logs.

> Signed-off-by: Vijay Satija <vijay.satija@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>   drivers/bluetooth/btintel.h      |   1 +
>   drivers/bluetooth/btintel_pcie.c | 154 +++++++++++++++++++++++++++++++
>   drivers/bluetooth/btintel_pcie.h |   9 +-
>   3 files changed, 163 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index 431998049e68..bb2bf0b17336 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -53,6 +53,7 @@ struct intel_tlv {
>   } __packed;
>   
>   #define BTINTEL_HCI_OP_RESET	0xfc01
> +#define BTINTEL_HCI_OP_DEBUG	0xfcd9
>   
>   #define BTINTEL_CNVI_BLAZARI		0x900
>   #define BTINTEL_CNVI_BLAZARIW		0x901
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index 6d3963bd56a9..438c67f317b5 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -121,6 +121,21 @@ struct btintel_pcie_removal {
>   	struct work_struct work;
>   };
>   
> +struct btintel_pcie_trigger_evt {
> +	u8 type;
> +	u8 len;
> +	__le32 addr;
> +	__le32 size;
> +} __packed;
> +
> +struct btintel_pcie_fwtrigger_evt {
> +	__le32 reserved;
> +	u8	type; /* Debug Trigger event */
> +	__le16	len;
> +	u8	event_type;
> +	__le16	event_id;
> +} __packed;
> +
>   static LIST_HEAD(btintel_pcie_recovery_list);
>   static DEFINE_SPINLOCK(btintel_pcie_recovery_lock);
>   
> @@ -677,6 +692,11 @@ static int btintel_pcie_read_dram_buffers(struct btintel_pcie_data *data)
>   		sizeof(*tlv) + strlen(vendor) +
>   		sizeof(*tlv) + strlen(driver);
>   
> +	if (data->dmp_hdr.trigger_reason == BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT) {
> +		data_len += sizeof(*tlv) + sizeof(data->dmp_hdr.event_type);
> +		data_len += sizeof(*tlv) + sizeof(data->dmp_hdr.event_id);
> +	}
> +
>   	/*
>   	 * sizeof(u32) - signature
>   	 * sizeof(data_len) - to store tlv data size
> @@ -724,6 +744,15 @@ static int btintel_pcie_read_dram_buffers(struct btintel_pcie_data *data)
>   	p = btintel_pcie_copy_tlv(p, BTINTEL_CNVI_TOP, &data->dmp_hdr.cnvi_top,
>   				  sizeof(data->dmp_hdr.cnvi_top));
>   
> +	if (data->dmp_hdr.trigger_reason == BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT) {
> +		p = btintel_pcie_copy_tlv(p, BTINTEL_EVENT_TYPE,
> +					  &data->dmp_hdr.event_type,
> +					  sizeof(data->dmp_hdr.event_type));
> +		p = btintel_pcie_copy_tlv(p, BTINTEL_EVENT_ID,
> +					  &data->dmp_hdr.event_id,
> +					  sizeof(data->dmp_hdr.event_id));
> +	}
> +
>   	memcpy(p, dbgc->bufs[0].data, dbgc->count * BTINTEL_PCIE_DBGC_BUFFER_SIZE);
>   	dev_coredumpv(&hdev->dev, pdata, dump_size, GFP_KERNEL);
>   	return 0;
> @@ -1298,6 +1327,75 @@ static void btintel_pcie_read_hwexp(struct btintel_pcie_data *data)
>   	kfree(buf);
>   }
>   
> +static int btintel_pcie_dump_fwtrigger_event(struct btintel_pcie_data *data)
> +{
> +	struct btintel_pcie_fwtrigger_evt *evt;
> +	struct hci_event_hdr *hdr;
> +	struct sk_buff *skb;
> +	int len, err;

Make `len` `unsigned int`?

> +	u32 val;
> +	u8 *buf;
> +
> +	if (!data->debug_evt_size || !data->debug_evt_addr)
> +		return -EINVAL;
> +
> +	len = data->debug_evt_size;
> +
> +	buf = kzalloc(len, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	btintel_pcie_mac_init(data);
> +
> +	err = btintel_pcie_read_device_mem(data, buf, data->debug_evt_addr,
> +					   data->debug_evt_size);
> +	if (err)
> +		goto exit_on_error;
> +
> +	evt = (void *)buf;
> +	data->dmp_hdr.event_type  = evt->event_type;
> +	data->dmp_hdr.event_id  = le16_to_cpu(evt->event_id);

Please just use one space before the = above.


Kind regards,

Paul


> +
> +	bt_dev_dbg(data->hdev, "event type: 0x%2.2x event id: 0x%4.4x",
> +		   data->dmp_hdr.event_type, data->dmp_hdr.event_id);
> +
> +	skb = bt_skb_alloc(sizeof(*hdr) + len, GFP_KERNEL);
> +	if (!skb) {
> +		err = -ENOMEM;
> +		goto exit_on_error;
> +	}
> +	hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
> +	hdr = skb_put(skb, sizeof(*hdr));
> +	hdr->evt = 0xff;
> +	hdr->plen = len;
> +	skb_put_data(skb, buf, len);
> +
> +	/* copy Intel specific pcie packet type */
> +	val = BTINTEL_PCIE_HCI_EVT_PKT;
> +	memcpy(skb_push(skb, BTINTEL_PCIE_HCI_TYPE_LEN), &val,
> +	       BTINTEL_PCIE_HCI_TYPE_LEN);
> +
> +	btintel_pcie_recv_frame(data, skb);
> +
> +exit_on_error:
> +	kfree(buf);
> +	return err;
> +}
> +
> +static void btintel_pcie_msix_fw_trigger_handler(struct btintel_pcie_data *data)
> +{
> +	bt_dev_dbg(data->hdev, "Received firmware smart trigger cause");
> +
> +	if (test_and_set_bit(BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS, &data->flags))
> +		return;
> +
> +	/* Trigger device core dump when there is FW assert */
> +	if (!test_and_set_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags))
> +		data->dmp_hdr.trigger_reason  = BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT;
> +
> +	queue_work(data->workqueue, &data->rx_work);
> +}
> +
>   static void btintel_pcie_msix_hw_exp_handler(struct btintel_pcie_data *data)
>   {
>   	bt_dev_err(data->hdev, "Received hw exception interrupt");
> @@ -1321,6 +1419,11 @@ static void btintel_pcie_rx_work(struct work_struct *work)
>   					struct btintel_pcie_data, rx_work);
>   	struct sk_buff *skb;
>   
> +	if (test_bit(BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS, &data->flags)) {
> +		btintel_pcie_dump_fwtrigger_event(data);
> +		clear_bit(BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS, &data->flags);
> +	}
> +
>   	if (test_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags)) {
>   		btintel_pcie_dump_traces(data->hdev);
>   		clear_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags);
> @@ -1467,6 +1570,9 @@ static irqreturn_t btintel_pcie_irq_msix_handler(int irq, void *dev_id)
>   	if (intr_hw & BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP1)
>   		btintel_pcie_msix_gp1_handler(data);
>   
> +	if (intr_hw & BTINTEL_PCIE_MSIX_HW_INT_CAUSES_FWTRIG)
> +		btintel_pcie_msix_fw_trigger_handler(data);
> +
>   	/* This interrupt is triggered by the firmware after updating
>   	 * boot_stage register and image_response register
>   	 */
> @@ -1555,6 +1661,7 @@ static struct btintel_pcie_causes_list causes_list[] = {
>   	{ BTINTEL_PCIE_MSIX_FH_INT_CAUSES_1,	BTINTEL_PCIE_CSR_MSIX_FH_INT_MASK,	0x01 },
>   	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0,	BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x20 },
>   	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_HWEXP, BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x23 },
> +	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_FWTRIG, BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x25 },
>   };
>   
>   /* This function configures the interrupt masks for both HW_INT_CAUSES and
> @@ -2031,6 +2138,49 @@ static void btintel_pcie_synchronize_irqs(struct btintel_pcie_data *data)
>   		synchronize_irq(data->msix_entries[i].vector);
>   }
>   
> +static int btintel_pcie_get_debug_info_addr(struct hci_dev *hdev)
> +{
> +	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
> +	struct btintel_pcie_trigger_evt *evt;
> +	u8 param[1] = {0x10};
> +	struct sk_buff *skb;
> +	int err = 0;
> +
> +	skb = __hci_cmd_sync(hdev, BTINTEL_HCI_OP_DEBUG, 1, param,
> +			     HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		bt_dev_err(hdev, "Reading Intel read debug info address command failed (%ld)",
> +			   PTR_ERR(skb));
> +		/* Not all Intel products supports this command */
> +		if (PTR_ERR(skb) == -EOPNOTSUPP)
> +			return 0;
> +		return PTR_ERR(skb);
> +	}
> +
> +	/* Check the status */
> +	if (skb->data[0]) {
> +		bt_dev_err(hdev, "Reading Intel read debug info command failed (0x%2.2x)",
> +			   skb->data[0]);
> +		err = -EIO;
> +		goto exit_error;
> +	}
> +
> +	/* Consume Command Complete Status field */
> +	skb_pull(skb, 1);
> +
> +	evt = (void *)skb->data;
> +
> +	data->debug_evt_addr = le32_to_cpu(evt->addr);
> +	data->debug_evt_size = le32_to_cpu(evt->size);
> +
> +	bt_dev_dbg(hdev, "config type: %u config len: %u debug event addr: 0x%8.8x size: 0x%8.8x",
> +		   evt->type, evt->len, data->debug_evt_addr,
> +		   data->debug_evt_size);
> +exit_error:
> +	kfree_skb(skb);
> +	return err;
> +}
> +
>   static int btintel_pcie_setup_internal(struct hci_dev *hdev)
>   {
>   	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
> @@ -2128,6 +2278,10 @@ static int btintel_pcie_setup_internal(struct hci_dev *hdev)
>   	if (ver_tlv.img_type == 0x02 || ver_tlv.img_type == 0x03)
>   		data->dmp_hdr.fw_git_sha1 = ver_tlv.git_sha1;
>   
> +	err = btintel_pcie_get_debug_info_addr(hdev);
> +	if (err)
> +		goto exit_error;
> +
>   	btintel_print_fseq_info(hdev);
>   exit_error:
>   	kfree_skb(skb);
> diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
> index 04b21f968ad3..ef9983891f4b 100644
> --- a/drivers/bluetooth/btintel_pcie.h
> +++ b/drivers/bluetooth/btintel_pcie.h
> @@ -101,6 +101,7 @@ enum msix_hw_int_causes {
>   	BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0	= BIT(0),	/* cause 32 */
>   	BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP1	= BIT(1),	/* cause 33 */
>   	BTINTEL_PCIE_MSIX_HW_INT_CAUSES_HWEXP	= BIT(3),	/* cause 35 */
> +	BTINTEL_PCIE_MSIX_HW_INT_CAUSES_FWTRIG	= BIT(5),	/* cause 37 */
>   };
>   
>   /* PCIe device states
> @@ -118,6 +119,7 @@ enum {
>   	BTINTEL_PCIE_CORE_HALTED,
>   	BTINTEL_PCIE_HWEXP_INPROGRESS,
>   	BTINTEL_PCIE_COREDUMP_INPROGRESS,
> +	BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS,
>   	BTINTEL_PCIE_RECOVERY_IN_PROGRESS,
>   	BTINTEL_PCIE_SETUP_DONE
>   };
> @@ -133,7 +135,9 @@ enum btintel_pcie_tlv_type {
>   	BTINTEL_DUMP_TIME,
>   	BTINTEL_FW_BUILD,
>   	BTINTEL_VENDOR,
> -	BTINTEL_DRIVER
> +	BTINTEL_DRIVER,
> +	BTINTEL_EVENT_TYPE,
> +	BTINTEL_EVENT_ID
>   };
>   
>   /* causes for the MBOX interrupts */
> @@ -429,6 +433,8 @@ struct btintel_pcie_dump_header {
>   	u32		wrap_ctr;
>   	u16		trigger_reason;
>   	int		state;
> +	u8		event_type;
> +	u16		event_id;
>   };
>   
>   /* struct btintel_pcie_data
> @@ -513,6 +519,7 @@ struct btintel_pcie_data {
>   	u32	alive_intr_ctxt;
>   	struct btintel_pcie_dbgc	dbgc;
>   	struct btintel_pcie_dump_header dmp_hdr;
> +	u32	debug_evt_addr, debug_evt_size;
>   };
>   
>   static inline u32 btintel_pcie_rd_reg32(struct btintel_pcie_data *data,


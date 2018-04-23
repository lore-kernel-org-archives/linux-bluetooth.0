Return-Path: <bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 23 Apr 2018 16:22:30 +0530
From: bgodavar@codeaurora.org
To: Thierry Escande <thierry.escande@linaro.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
 linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Bluetooth: Add support for wcn3990 soc.
In-Reply-To: <378fdaaa-a7f4-3305-ff14-d4eaa4362354@linaro.org>
References: <1524144898-4645-1-git-send-email-bgodavar@codeaurora.org>
 <1524144898-4645-3-git-send-email-bgodavar@codeaurora.org>
 <378fdaaa-a7f4-3305-ff14-d4eaa4362354@linaro.org>
Message-ID: <7e6b708736fab72d7f2facf43b2cf473@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Thierry,

On 2018-04-20 21:41, Thierry Escande wrote:
> Hi Balakrishna,
> 
> On 19/04/2018 15:34, Balakrishna Godavarthi wrote:
>>   - Add support to set voltage/current of various regualtors
>>     to power up/down BT QCA chip wcn3990.
>>   - Add firmware download support for BT QCA chip wcn3990.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>>   drivers/bluetooth/btqca.c        | 393 
>> +++++++++++++++++++++++-------
>>   drivers/bluetooth/btqca.h        |  49 +++-
>>   drivers/bluetooth/hci_qca.c      | 501 
>> +++++++++++++++++++++++++++++++++------
>>   include/net/bluetooth/hci_core.h |   3 +-
>>   net/bluetooth/hci_core.c         |   2 +-
>>   net/bluetooth/hci_request.c      |  23 ++
>>   net/bluetooth/hci_request.h      |   2 +
>>   7 files changed, 812 insertions(+), 161 deletions(-)
> 
> This is a pretty big patch. You should at least put the renaming of
> the rome_* functions and structures into a separate patch.

    yes this will be big patch as we have added support for qualcomm new 
bluetooth chip. In this we have changed existing function names rome_* 
to reuse it for new bluetooth chip. I feel we will not face any merge 
conflicts
    for btqca.c file. if we put rome_* function and structures into new 
patch, this make create merge conflicts for hci_qca.c file.

> 
> Also there are some coding style issues. You can use
> ./scripts/checkpatch.pl to check and fix them.
> 

   will double check the coding style issues.

> Regards,
> Thierry
> 
>> 
>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>> index 0bbdfce..5b47df8 100644
>> --- a/drivers/bluetooth/btqca.c
>> +++ b/drivers/bluetooth/btqca.c
>> @@ -1,7 +1,7 @@
>>   /*
>>    *  Bluetooth supports for Qualcomm Atheros chips
>>    *
>> - *  Copyright (c) 2015 The Linux Foundation. All rights reserved.
>> + *  Copyright (c) 2015, 2018 The Linux Foundation. All rights 
>> reserved.
>>    *
>>    *  This program is free software; you can redistribute it and/or 
>> modify
>>    *  it under the terms of the GNU General Public License version 2
>> @@ -19,82 +19,18 @@
>>    */
>>   #include <linux/module.h>
>>   #include <linux/firmware.h>
>> -
>>   #include <net/bluetooth/bluetooth.h>
>>   #include <net/bluetooth/hci_core.h>
>> -
>>   #include "btqca.h"
>>     #define VERSION "0.1"
>>   -static int rome_patch_ver_req(struct hci_dev *hdev, u32 
>> *rome_version)
>> -{
>> -	struct sk_buff *skb;
>> -	struct edl_event_hdr *edl;
>> -	struct rome_version *ver;
>> -	char cmd;
>> -	int err = 0;
>> -
>> -	BT_DBG("%s: ROME Patch Version Request", hdev->name);
>> -
>> -	cmd = EDL_PATCH_VER_REQ_CMD;
>> -	skb = __hci_cmd_sync_ev(hdev, EDL_PATCH_CMD_OPCODE, 
>> EDL_PATCH_CMD_LEN,
>> -				&cmd, HCI_VENDOR_PKT, HCI_INIT_TIMEOUT);
>> -	if (IS_ERR(skb)) {
>> -		err = PTR_ERR(skb);
>> -		BT_ERR("%s: Failed to read version of ROME (%d)", hdev->name,
>> -		       err);
>> -		return err;
>> -	}
>> -
>> -	if (skb->len != sizeof(*edl) + sizeof(*ver)) {
>> -		BT_ERR("%s: Version size mismatch len %d", hdev->name,
>> -		       skb->len);
>> -		err = -EILSEQ;
>> -		goto out;
>> -	}
>> -
>> -	edl = (struct edl_event_hdr *)(skb->data);
>> -	if (!edl) {
>> -		BT_ERR("%s: TLV with no header", hdev->name);
>> -		err = -EILSEQ;
>> -		goto out;
>> -	}
>> -
>> -	if (edl->cresp != EDL_CMD_REQ_RES_EVT ||
>> -	    edl->rtype != EDL_APP_VER_RES_EVT) {
>> -		BT_ERR("%s: Wrong packet received %d %d", hdev->name,
>> -		       edl->cresp, edl->rtype);
>> -		err = -EIO;
>> -		goto out;
>> -	}
>> -
>> -	ver = (struct rome_version *)(edl->data);
>> -
>> -	BT_DBG("%s: Product:0x%08x", hdev->name, 
>> le32_to_cpu(ver->product_id));
>> -	BT_DBG("%s: Patch  :0x%08x", hdev->name, 
>> le16_to_cpu(ver->patch_ver));
>> -	BT_DBG("%s: ROM    :0x%08x", hdev->name, 
>> le16_to_cpu(ver->rome_ver));
>> -	BT_DBG("%s: SOC    :0x%08x", hdev->name, le32_to_cpu(ver->soc_id));
>> -
>> -	/* ROME chipset version can be decided by patch and SoC
>> -	 * version, combination with upper 2 bytes from SoC
>> -	 * and lower 2 bytes from patch will be used.
>> -	 */
>> -	*rome_version = (le32_to_cpu(ver->soc_id) << 16) |
>> -			(le16_to_cpu(ver->rome_ver) & 0x0000ffff);
>> -
>> -out:
>> -	kfree_skb(skb);
>> -
>> -	return err;
>> -}
>> -
>> -static int rome_reset(struct hci_dev *hdev)
>> +static int qca_btsoc_reset(struct hci_dev *hdev)
>>   {
>>   	struct sk_buff *skb;
>>   	int err;
>>   -	BT_DBG("%s: ROME HCI_RESET", hdev->name);
>> +	BT_DBG("%s: ROME/wcn3990 HCI_RESET", hdev->name);
>>     	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, 
>> HCI_INIT_TIMEOUT);
>>   	if (IS_ERR(skb)) {
>> @@ -108,7 +44,7 @@ static int rome_reset(struct hci_dev *hdev)
>>   	return 0;
>>   }
>>   -static void rome_tlv_check_data(struct rome_config *config,
>> +static void rome_tlv_check_data(struct qca_config *config,
>>   				const struct firmware *fw)
>>   {
>>   	const u8 *data;
>> @@ -194,8 +130,121 @@ static void rome_tlv_check_data(struct 
>> rome_config *config,
>>   	}
>>   }
>>   -static int rome_tlv_send_segment(struct hci_dev *hdev, int idx, int 
>> seg_size,
>> -				 const u8 *data)
>> +static void cherokee_tlv_check_data(struct qca_config *config,
>> +			const struct firmware *fw, bool *dwnd_flag)
>> +{
>> +	const u8 *data;
>> +	u32 type_len;
>> +	u16 tag_id, tag_len;
>> +	int idx, length;
>> +	struct tlv_type_hdr *tlv;
>> +	struct cherokee_tlv_type_patch *tlv_patch;
>> +	struct tlv_type_nvm *tlv_nvm;
>> +
>> +	tlv = (struct tlv_type_hdr *)fw->data;
>> +
>> +	type_len = le32_to_cpu(tlv->type_len);
>> +	length = (type_len >> 8) & 0x00ffffff;
>> +
>> +	BT_DBG("TLV Type\t\t : 0x%x", type_len & 0x000000ff);
>> +	BT_DBG("Length\t\t : %d bytes", length);
>> +
>> +	switch (config->type) {
>> +	case TLV_TYPE_PATCH:
>> +		tlv_patch = (struct tlv_type_patch *)tlv->data;
>> +		BT_DBG("Total Length\t\t : %d bytes",
>> +			le32_to_cpu(tlv_patch->total_size));
>> +		BT_DBG("Patch Data Length\t : %d bytes",
>> +			le32_to_cpu(tlv_patch->data_length));
>> +		BT_DBG("Signing Format Version : 0x%x",
>> +			tlv_patch->format_version);
>> +		BT_DBG("Signature Algorithm\t : 0x%x",
>> +			tlv_patch->signature);
>> +		BT_DBG("Download flag\t : 0x%x",
>> +			tlv_patch->dwnd_cfg);
>> +		BT_DBG("Reserved\t\t : 0x%x",
>> +			le16_to_cpu(tlv_patch->reserved1));
>> +		BT_DBG("Product ID\t\t : 0x%04x",
>> +			le16_to_cpu(tlv_patch->product_id));
>> +		BT_DBG("Rom Build Version\t : 0x%04x",
>> +			le16_to_cpu(tlv_patch->rom_build));
>> +		BT_DBG("Patch Version\t\t : 0x%04x",
>> +			le16_to_cpu(tlv_patch->patch_version));
>> +		BT_DBG("Reserved\t\t : 0x%x",
>> +			le16_to_cpu(tlv_patch->reserved2));
>> +		BT_DBG("Patch Entry Address\t : 0x%x",
>> +			le32_to_cpu(tlv_patch->entry));
>> +		/* If the download flag is 0x03, don't wait
>> +		 * for response from soc,i.e. 1 to n-1
>> +		 * segment download.
>> +		 */
>> +		if (tlv_patch->dwnd_cfg == 0x03)
>> +			*dwnd_flag = false;
>> +		else
>> +			*dwnd_flag = true;
>> +		break;
>> +
>> +	case TLV_TYPE_NVM:
>> +		idx = 0;
>> +		data = tlv->data;
>> +		while (idx < length) {
>> +			tlv_nvm = (struct tlv_type_nvm *)(data + idx);
>> +			tag_id = le16_to_cpu(tlv_nvm->tag_id);
>> +			tag_len = le16_to_cpu(tlv_nvm->tag_len);
>> +
>> +			/* Update NVM tags as needed */
>> +			switch (tag_id) {
>> +			case EDL_TAG_ID_HCI:
>> +				/* HCI transport layer parameters
>> +				 * enabling software inband sleep
>> +				 * onto controller side.
>> +				 */
>> +				tlv_nvm->data[0] |= 0x80;
>> +
>> +				/* UART Baud Rate */
>> +				tlv_nvm->data[2] = config->user_baud_rate;
>> +				break;
>> +			case EDL_TAG_ID_DEEP_SLEEP:
>> +				/* Sleep enable mask
>> +				 * enabling deep sleep feature on controller.
>> +				 */
>> +				tlv_nvm->data[0] |= 0x01;
>> +				break;
>> +			}
>> +
>> +			idx += (sizeof(u16) + sizeof(u16) + 8 + tag_len);
>> +		}
>> +		break;
>> +	default:
>> +		BT_ERR("Unknown TLV type %d", config->type);
>> +		break;
>> +	}
>> +}
>> +
>> +static int cherokee_tlv_send_segment(struct hci_dev *hdev, int idx,
>> +					int seg_size, const u8 *data)
>> +{
>> +	u8 cmd[MAX_SIZE_PER_TLV_SEGMENT + 2];
>> +	int err = 0;
>> +
>> +	BT_DBG("%s: Download segment #%d size %d", hdev->name, idx, 
>> seg_size);
>> +
>> +	cmd[0] = EDL_PATCH_TLV_REQ_CMD;
>> +	cmd[1] = seg_size;
>> +	memcpy(cmd + 2, data, seg_size);
>> +
>> +	err = __hci_cmd_no_event(hdev, EDL_PATCH_CMD_OPCODE, seg_size + 2,
>> +					cmd);
>> +	if (err < 0) {
>> +		BT_ERR("%s: Failed to send TLV segment (%d)", hdev->name, err);
>> +		return err;
>> +	}
>> +
>> +	return err;
>> +}
>> +
>> +static int qca_btsoc_tlv_send_segment(struct hci_dev *hdev, int idx,
>> +					int seg_size, const u8 *data)
>>   {
>>   	struct sk_buff *skb;
>>   	struct edl_event_hdr *edl;
>> @@ -264,16 +313,56 @@ static int rome_tlv_download_request(struct 
>> hci_dev *hdev,
>>   	data = fw->data;
>>   	for (i = 0; i < total_segment; i++) {
>>   		buffer = data + i * MAX_SIZE_PER_TLV_SEGMENT;
>> -		ret = rome_tlv_send_segment(hdev, i, MAX_SIZE_PER_TLV_SEGMENT,
>> -					    buffer);
>> +		ret = qca_btsoc_tlv_send_segment(hdev, i,
>> +					MAX_SIZE_PER_TLV_SEGMENT, buffer);
>>   		if (ret < 0)
>>   			return -EIO;
>>   	}
>>     	if (remain_size) {
>>   		buffer = data + total_segment * MAX_SIZE_PER_TLV_SEGMENT;
>> -		ret = rome_tlv_send_segment(hdev, total_segment, remain_size,
>> -					    buffer);
>> +		ret = qca_btsoc_tlv_send_segment(hdev, total_segment,
>> +							remain_size, buffer);
>> +		if (ret < 0)
>> +			return -EIO;
>> +	}
>> +
>> +	return 0;
>> +}
>> +static int cherokee_tlv_download_request(struct hci_dev *hdev,
>> +			const struct firmware *fw)
>> +{
>> +	const u8 *buffer, *data;
>> +	int total_segment, remain_size;
>> +	int ret, i;
>> +
>> +	if (!fw || !fw->data)
>> +		return -EINVAL;
>> +
>> +	total_segment = fw->size / MAX_SIZE_PER_TLV_SEGMENT;
>> +	remain_size = fw->size % MAX_SIZE_PER_TLV_SEGMENT;
>> +
>> +	BT_DBG("%s: Total segment num %d remain size %d total size %zu",
>> +			hdev->name, total_segment, remain_size, fw->size);
>> +
>> +	data = fw->data;
>> +	for (i = 0; i < total_segment; i++) {
>> +		buffer = data + i * MAX_SIZE_PER_TLV_SEGMENT;
>> +		/* Read response from soc for last segment sent */
>> +		if (!remain_size && ((i+1) == total_segment))
>> +			ret = qca_btsoc_tlv_send_segment(hdev, i,
>> +					MAX_SIZE_PER_TLV_SEGMENT, buffer);
>> +		else
>> +			ret = cherokee_tlv_send_segment(hdev, i,
>> +					MAX_SIZE_PER_TLV_SEGMENT, buffer);
>> +		if (ret < 0)
>> +			return -EIO;
>> +	}
>> +
>> +	if (remain_size) {
>> +		buffer = data + total_segment * MAX_SIZE_PER_TLV_SEGMENT;
>> +		ret = qca_btsoc_tlv_send_segment(hdev, total_segment,
>> +							remain_size, buffer);
>>   		if (ret < 0)
>>   			return -EIO;
>>   	}
>> @@ -282,7 +371,7 @@ static int rome_tlv_download_request(struct 
>> hci_dev *hdev,
>>   }
>>     static int rome_download_firmware(struct hci_dev *hdev,
>> -				  struct rome_config *config)
>> +				  struct qca_config *config)
>>   {
>>   	const struct firmware *fw;
>>   	int ret;
>> @@ -309,7 +398,46 @@ static int rome_download_firmware(struct hci_dev 
>> *hdev,
>>   	return ret;
>>   }
>>   -int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t 
>> *bdaddr)
>> +static int cherokee_download_firmware(struct hci_dev *hdev,
>> +					struct qca_config *config)
>> +{
>> +	const struct firmware *fw;
>> +	bool dwnd_flag = true;
>> +	int ret;
>> +
>> +	BT_INFO("%s: wcn3990  Downloading %s", hdev->name, config->fwname);
>> +
>> +	ret = request_firmware(&fw, config->fwname, &hdev->dev);
>> +	if (ret) {
>> +		BT_ERR("%s: Failed to request file: %s (%d)", hdev->name,
>> +			config->fwname, ret);
>> +		return ret;
>> +	}
>> +
>> +	cherokee_tlv_check_data(config, fw, &dwnd_flag);
>> +	/* check whether the download flag is set.if bit is enabled
>> +	 * terminate the ram patch download. As we are not supporting,
>> +	 * receiving of response from soc for every segment sent.
>> +	 * We look for response from soc for last segment.
>> +	 */
>> +	if (dwnd_flag == true && config->type == TLV_TYPE_PATCH) {
>> +		BT_ERR("%s: btsoc download flag enabled", hdev->name);
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	ret = cherokee_tlv_download_request(hdev, fw);
>> +	if (ret) {
>> +		BT_ERR("%s: Failed to download file: %s (%d)", hdev->name,
>> +		config->fwname, ret);
>> +	}
>> +
>> +	release_firmware(fw);
>> +
>> +	return ret;
>> +}
>> +
>> +
>> +int qca_btsoc_set_bdaddr(struct hci_dev *hdev, const bdaddr_t 
>> *bdaddr)
>>   {
>>   	struct sk_buff *skb;
>>   	u8 cmd[9];
>> @@ -332,12 +460,12 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, 
>> const bdaddr_t *bdaddr)
>>     	return 0;
>>   }
>> -EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
>> +EXPORT_SYMBOL_GPL(qca_btsoc_set_bdaddr);
>>     int qca_uart_setup_rome(struct hci_dev *hdev, uint8_t baudrate)
>>   {
>>   	u32 rome_ver = 0;
>> -	struct rome_config config;
>> +	struct qca_config config;
>>   	int err;
>>     	BT_DBG("%s: ROME setup on UART", hdev->name);
>> @@ -345,7 +473,7 @@ int qca_uart_setup_rome(struct hci_dev *hdev, 
>> uint8_t baudrate)
>>   	config.user_baud_rate = baudrate;
>>     	/* Get ROME version information */
>> -	err = rome_patch_ver_req(hdev, &rome_ver);
>> +	err = qca_btsoc_patch_ver_req(hdev, &rome_ver);
>>   	if (err < 0 || rome_ver == 0) {
>>   		BT_ERR("%s: Failed to get version 0x%x", hdev->name, err);
>>   		return err;
>> @@ -374,7 +502,7 @@ int qca_uart_setup_rome(struct hci_dev *hdev, 
>> uint8_t baudrate)
>>   	}
>>     	/* Perform HCI reset */
>> -	err = rome_reset(hdev);
>> +	err = qca_btsoc_reset(hdev);
>>   	if (err < 0) {
>>   		BT_ERR("%s: Failed to run HCI_RESET (%d)", hdev->name, err);
>>   		return err;
>> @@ -386,6 +514,111 @@ int qca_uart_setup_rome(struct hci_dev *hdev, 
>> uint8_t baudrate)
>>   }
>>   EXPORT_SYMBOL_GPL(qca_uart_setup_rome);
>>   +int qca_btsoc_patch_ver_req(struct hci_dev *hdev, u32 *soc_version)
>> +{
>> +	struct sk_buff *skb;
>> +	struct edl_event_hdr *edl;
>> +	struct qca_btsoc_version *ver;
>> +	char cmd;
>> +	int err = 0;
>> +
>> +	BT_DBG("%s: BTSOC Patch Version Request", hdev->name);
>> +
>> +	cmd = EDL_PATCH_VER_REQ_CMD;
>> +	skb = __hci_cmd_sync_ev(hdev, EDL_PATCH_CMD_OPCODE, 
>> EDL_PATCH_CMD_LEN,
>> +				&cmd, HCI_VENDOR_PKT, HCI_INIT_TIMEOUT);
>> +	if (IS_ERR(skb)) {
>> +		err = PTR_ERR(skb);
>> +		BT_ERR("%s: Failed to read version of ROME (%d)", hdev->name,
>> +		       err);
>> +		return err;
>> +	}
>> +
>> +	if (skb->len != sizeof(*edl) + sizeof(*ver)) {
>> +		BT_ERR("%s: Version size mismatch len %d", hdev->name,
>> +		       skb->len);
>> +		err = -EILSEQ;
>> +		goto out;
>> +	}
>> +
>> +	edl = (struct edl_event_hdr *)(skb->data);
>> +	if (!edl) {
>> +		BT_ERR("%s: TLV with no header", hdev->name);
>> +		err = -EILSEQ;
>> +		goto out;
>> +	}
>> +
>> +	if (edl->cresp != EDL_CMD_REQ_RES_EVT ||
>> +	    edl->rtype != EDL_APP_VER_RES_EVT) {
>> +		BT_ERR("%s: Wrong packet received %d %d", hdev->name,
>> +		       edl->cresp, edl->rtype);
>> +		err = -EIO;
>> +		goto out;
>> +	}
>> +
>> +	ver = (struct qca_btsoc_version *)(edl->data);
>> +
>> +	BT_DBG("%s: Product:0x%08x", hdev->name, 
>> le32_to_cpu(ver->product_id));
>> +	BT_DBG("%s: Patch  :0x%08x", hdev->name, 
>> le16_to_cpu(ver->patch_ver));
>> +	BT_DBG("%s: ROM    :0x%08x", hdev->name, 
>> le16_to_cpu(ver->btsoc_ver));
>> +	BT_DBG("%s: SOC    :0x%08x", hdev->name, le32_to_cpu(ver->soc_id));
>> +
>> +	/* BTSOC chipset version can be decided by patch and SoC
>> +	 * version, combination with upper 2 bytes from SoC
>> +	 * and lower 2 bytes from patch will be used.
>> +	 */
>> +	*soc_version = (le32_to_cpu(ver->soc_id) << 16) |
>> +				(le16_to_cpu(ver->btsoc_ver) & 0x0000ffff);
>> +
>> +out:
>> +	kfree_skb(skb);
>> +
>> +	return err;
>> +}
>> +EXPORT_SYMBOL_GPL(qca_btsoc_patch_ver_req);
>> +
>> +int qca_uart_setup_cherokee(struct hci_dev *hdev, uint8_t baudrate,
>> +					u32 *cherokee_ver)
>> +{
>> +	struct qca_config config;
>> +	int err;
>> +
>> +	BT_DBG("%s: wcn3990 setup on UART", hdev->name);
>> +	config.user_baud_rate = baudrate;
>> +
>> +	/* Download rampatch file */
>> +	config.type = TLV_TYPE_PATCH;
>> +	snprintf(config.fwname, sizeof(config.fwname), 
>> "qca/rampatch_%08x.tlv",
>> +		*cherokee_ver);
>> +	err = cherokee_download_firmware(hdev, &config);
>> +	if (err < 0) {
>> +		BT_ERR("%s: Failed to download patch (%d)", hdev->name, err);
>> +		return err;
>> +	}
>> +
>> +	/* Download NVM configuration */
>> +	config.type = TLV_TYPE_NVM;
>> +	snprintf(config.fwname, sizeof(config.fwname), "qca/nvm_%08x.bin",
>> +		*cherokee_ver);
>> +	err = cherokee_download_firmware(hdev, &config);
>> +	if (err < 0) {
>> +		BT_ERR("%s: Failed to download NVM (%d)", hdev->name, err);
>> +		return err;
>> +	}
>> +
>> +	/* Perform HCI reset */
>> +	err = qca_btsoc_reset(hdev);
>> +	if (err < 0) {
>> +		BT_ERR("%s: Failed to run HCI_RESET (%d)", hdev->name, err);
>> +		return err;
>> +	}
>> +
>> +	BT_INFO("%s: wcn3990 setup on UART is completed", hdev->name);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(qca_uart_setup_cherokee);
>> +
>>   MODULE_AUTHOR("Ben Young Tae Kim <ytkim@qca.qualcomm.com>");
>>   MODULE_DESCRIPTION("Bluetooth support for Qualcomm Atheros family 
>> ver " VERSION);
>>   MODULE_VERSION(VERSION);
>> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
>> index 65e994b..7608423 100644
>> --- a/drivers/bluetooth/btqca.h
>> +++ b/drivers/bluetooth/btqca.h
>> @@ -1,7 +1,7 @@
>>   /*
>>    *  Bluetooth supports for Qualcomm Atheros ROME chips
>>    *
>> - *  Copyright (c) 2015 The Linux Foundation. All rights reserved.
>> + *  Copyright (c) 2015, 2018 The Linux Foundation. All rights 
>> reserved.
>>    *
>>    *  This program is free software; you can redistribute it and/or 
>> modify
>>    *  it under the terms of the GNU General Public License version 2
>> @@ -37,6 +37,9 @@
>>   #define EDL_TAG_ID_HCI			(17)
>>   #define EDL_TAG_ID_DEEP_SLEEP		(27)
>>   +#define CHEROKEE_POWERON_PULSE		(0xFC)
>> +#define CHEROKEE_POWEROFF_PULSE		(0xC0)
>> +
>>   enum qca_bardrate {
>>   	QCA_BAUDRATE_115200 	= 0,
>>   	QCA_BAUDRATE_57600,
>> @@ -66,7 +69,7 @@ enum rome_tlv_type {
>>   	TLV_TYPE_NVM
>>   };
>>   -struct rome_config {
>> +struct qca_config {
>>   	u8 type;
>>   	char fwname[64];
>>   	uint8_t user_baud_rate;
>> @@ -78,13 +81,14 @@ struct edl_event_hdr {
>>   	__u8 data[0];
>>   } __packed;
>>   -struct rome_version {
>> +struct qca_btsoc_version {
>>   	__le32 product_id;
>>   	__le16 patch_ver;
>> -	__le16 rome_ver;
>> +	__le16 btsoc_ver;
>>   	__le32 soc_id;
>>   } __packed;
>>   +
>>   struct tlv_seg_resp {
>>   	__u8 result;
>>   } __packed;
>> @@ -102,6 +106,21 @@ struct tlv_type_patch {
>>   	__le32 entry;
>>   } __packed;
>>   +struct cherokee_tlv_type_patch {
>> +	__le32 total_size;
>> +	__le32 data_length;
>> +	__u8   format_version;
>> +	__u8   signature;
>> +	__u8   dwnd_cfg;
>> +	__le16 reserved1;
>> +	__le16 product_id;
>> +	__le16 rom_build;
>> +	__le16 patch_version;
>> +	__le16 reserved2;
>> +	__le32 entry;
>> +} __packed;
>> +
>> +
>>   struct tlv_type_nvm {
>>   	__le16 tag_id;
>>   	__le16 tag_len;
>> @@ -115,14 +134,21 @@ struct tlv_type_hdr {
>>   	__u8   data[0];
>>   } __packed;
>>   +int qca_btsoc_cleanup(struct hci_dev *hdev);
>> +int btqca_power_setup(bool on);
>> +
>>   #if IS_ENABLED(CONFIG_BT_QCA)
>>   -int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t 
>> *bdaddr);
>> +int qca_btsoc_set_bdaddr(struct hci_dev *hdev, const bdaddr_t 
>> *bdaddr);
>>   int qca_uart_setup_rome(struct hci_dev *hdev, uint8_t baudrate);
>> +int qca_uart_setup_cherokee(struct hci_dev *hdev, uint8_t baudrate,
>> +				u32 *cherokee_ver);
>> +int qca_btsoc_patch_ver_req(struct hci_dev *hdev, u32 *soc_version);
>>     #else
>>   -static inline int qca_set_bdaddr_rome(struct hci_dev *hdev, const 
>> bdaddr_t *bdaddr)
>> +static inline int qca_btsoc_set_bdaddr(struct hci_dev *hdev,
>> +						const bdaddr_t *bdaddr)
>>   {
>>   	return -EOPNOTSUPP;
>>   }
>> @@ -132,4 +158,15 @@ static inline int qca_uart_setup_rome(struct 
>> hci_dev *hdev, int speed)
>>   	return -EOPNOTSUPP;
>>   }
>>   +static inline int qca_uart_setup_cherokee(struct hci_dev *hdev,
>> +					uint8_t baudrate, u32 *cherokee_ver)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static int qca_btsoc_patch_ver_req(struct hci_dev *hdev, u32 
>> *cherokee_version)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>>   #endif
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index b7547e6..1343e63 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -5,7 +5,7 @@
>>    *  protocol extension to H4.
>>    *
>>    *  Copyright (C) 2007 Texas Instruments, Inc.
>> - *  Copyright (c) 2010, 2012 The Linux Foundation. All rights 
>> reserved.
>> + *  Copyright (c) 2010, 2012, 2018 The Linux Foundation. All rights 
>> reserved.
>>    *
>>    *  Acknowledgements:
>>    *  This file is based on hci_ll.c, which was...
>> @@ -35,9 +35,15 @@
>>   #include <linux/mod_devicetable.h>
>>   #include <linux/module.h>
>>   #include <linux/serdev.h>
>> -
>>   #include <net/bluetooth/bluetooth.h>
>>   #include <net/bluetooth/hci_core.h>
>> +#include <asm-generic/delay.h>
>> +#include <linux/tty.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/delay.h>
>> +#include <linux/slab.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/of_device.h>
>>     #include "hci_uart.h"
>>   #include "btqca.h"
>> @@ -84,12 +90,12 @@ struct qca_data {
>>   	struct hci_uart *hu;
>>   	struct sk_buff *rx_skb;
>>   	struct sk_buff_head txq;
>> -	struct sk_buff_head tx_wait_q;	/* HCI_IBS wait queue	*/
>> -	spinlock_t hci_ibs_lock;	/* HCI_IBS state lock	*/
>> -	u8 tx_ibs_state;	/* HCI_IBS transmit side power state*/
>> -	u8 rx_ibs_state;	/* HCI_IBS receive side power state */
>> -	bool tx_vote;		/* Clock must be on for TX */
>> -	bool rx_vote;		/* Clock must be on for RX */
>> +	struct sk_buff_head tx_wait_q;  /* HCI_IBS wait queue   */
>> +	spinlock_t hci_ibs_lock;        /* HCI_IBS state lock   */
>> +	u8 tx_ibs_state;        /* HCI_IBS transmit side power state*/
>> +	u8 rx_ibs_state;        /* HCI_IBS receive side power state */
>> +	bool tx_vote;           /* Clock must be on for TX */
>> +	bool rx_vote;           /* Clock must be on for RX */
>>   	struct timer_list tx_idle_timer;
>>   	u32 tx_idle_delay;
>>   	struct timer_list wake_retrans_timer;
>> @@ -119,12 +125,49 @@ struct qca_data {
>>   	u64 votes_off;
>>   };
>>   +enum btqca_soc_t {
>> +	BTQCA_INVALID = -1,
>> +	BTQCA_AR3002,
>> +	BTQCA_ROME,
>> +	BTQCA_CHEROKEE
>> +};
>> +
>>   struct qca_serdev {
>>   	struct hci_uart	 serdev_hu;
>>   	struct gpio_desc *bt_en;
>>   	struct clk	 *susclk;
>> +	enum btqca_soc_t btsoc_type;
>> +};
>> +
>> +/*
>> + * voltage regulator information required for configuring the
>> + * QCA bluetooth chipset
>> + */
>> +struct btqca_vreg {
>> +	const char *name;
>> +	unsigned int min_v;
>> +	unsigned int max_v;
>> +	unsigned int load_ua;
>>   };
>>   +struct btqca_vreg_data {
>> +	enum btqca_soc_t soc_type;
>> +	struct btqca_vreg *vregs;
>> +	size_t num_vregs;
>> +};
>> +
>> +/*
>> + * Platform data for the QCA bluetooth power driver.
>> + */
>> +struct btqca_power {
>> +	struct device *dev;
>> +	struct btqca_vreg_data *vreg_data;
>> +	struct regulator_bulk_data *vreg_bulk;
>> +	bool vreg_status;
>> +};
>> +
>> +static struct btqca_power *qca;
>> +
>>   static void __serial_clock_on(struct tty_struct *tty)
>>   {
>>   	/* TODO: Some chipset requires to enable UART clock on client
>> @@ -462,9 +505,11 @@ static int qca_open(struct hci_uart *hu)
>>     	if (hu->serdev) {
>>   		serdev_device_open(hu->serdev);
>> -
>>   		qcadev = serdev_device_get_drvdata(hu->serdev);
>> -		gpiod_set_value_cansleep(qcadev->bt_en, 1);
>> +		if (qcadev->btsoc_type == BTQCA_CHEROKEE)
>> +			btqca_power_setup(true);
>> +		else
>> +			gpiod_set_value_cansleep(qcadev->bt_en, 1);
>>   	}
>>     	BT_DBG("HCI_UART_QCA open, tx_idle_delay=%u, wake_retrans=%u",
>> @@ -553,7 +598,10 @@ static int qca_close(struct hci_uart *hu)
>>   		serdev_device_close(hu->serdev);
>>     		qcadev = serdev_device_get_drvdata(hu->serdev);
>> -		gpiod_set_value_cansleep(qcadev->bt_en, 0);
>> +		if (qcadev->btsoc_type == BTQCA_CHEROKEE)
>> +			qca_btsoc_cleanup(hu->hdev);
>> +		else
>> +			gpiod_set_value_cansleep(qcadev->bt_en, 0);
>>   	}
>>     	kfree_skb(qca->rx_skb);
>> @@ -873,6 +921,8 @@ static uint8_t qca_get_baudrate_value(int speed)
>>   		return QCA_BAUDRATE_2000000;
>>   	case 3000000:
>>   		return QCA_BAUDRATE_3000000;
>> +	case 3200000:
>> +		return QCA_BAUDRATE_3200000;
>>   	case 3500000:
>>   		return QCA_BAUDRATE_3500000;
>>   	default:
>> @@ -887,7 +937,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, 
>> uint8_t baudrate)
>>   	struct sk_buff *skb;
>>   	u8 cmd[] = { 0x01, 0x48, 0xFC, 0x01, 0x00 };
>>   -	if (baudrate > QCA_BAUDRATE_3000000)
>> +	if (baudrate > QCA_BAUDRATE_3200000)
>>   		return -EINVAL;
>>     	cmd[4] = baudrate;
>> @@ -924,62 +974,263 @@ static inline void host_set_baudrate(struct 
>> hci_uart *hu, unsigned int speed)
>>   		hci_uart_set_baudrate(hu, speed);
>>   }
>>   +static int qca_send_poweron_cmd(struct hci_dev *hdev)
>> +{
>> +	struct hci_uart *hu = hci_get_drvdata(hdev);
>> +	struct qca_data *qca = hu->priv;
>> +	struct sk_buff *skb;
>> +	u8 cmd;
>> +
>> +	BT_DBG("%s sending power on command to btsoc", hdev->name);
>> +	/* By sending 0xFC host is trying to power up the soc */
>> +	cmd = CHEROKEE_POWERON_PULSE;
>> +	skb = bt_skb_alloc(sizeof(cmd), GFP_ATOMIC);
>> +	if (!skb) {
>> +		BT_ERR("Failed to allocate memory for skb  packet");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	skb_put_data(skb, &cmd, sizeof(cmd));
>> +	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
>> +
>> +	skb_queue_tail(&qca->txq, skb);
>> +	hci_uart_tx_wakeup(hu);
>> +
>> +	/* Wait for 100 us for soc to settle down */
>> +	set_current_state(TASK_UNINTERRUPTIBLE);
>> +	schedule_timeout(usecs_to_jiffies(100));
>> +	set_current_state(TASK_INTERRUPTIBLE);
>> +
>> +	return 0;
>> +}
>> +
>> +static int qca_send_poweroff_cmd(struct hci_dev *hdev)
>> +{
>> +	struct hci_uart *hu = hci_get_drvdata(hdev);
>> +	struct qca_data *qca = hu->priv;
>> +	struct sk_buff *skb;
>> +	u8 cmd;
>> +
>> +	BT_DBG("%s sending power off command to btsoc", hdev->name);
>> +	/* By sending 0xC0 host is trying to power off the soc */
>> +	cmd = CHEROKEE_POWEROFF_PULSE;
>> +	skb = bt_skb_alloc(sizeof(cmd), GFP_ATOMIC);
>> +	if (!skb) {
>> +		BT_ERR("Failed to allocate memory for skb  packet");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	skb_put_data(skb, &cmd, sizeof(cmd));
>> +	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
>> +
>> +	skb_queue_tail(&qca->txq, skb);
>> +	hci_uart_tx_wakeup(hu);
>> +
>> +	/* Wait for 100 us for soc to settle down */
>> +	set_current_state(TASK_UNINTERRUPTIBLE);
>> +	schedule_timeout(usecs_to_jiffies(100));
>> +	set_current_state(TASK_INTERRUPTIBLE);
>> +
>> +	return 0;
>> +}
>> +
>> +static int qca_serdev_open(struct hci_uart *hu)
>> +{
>> +	int ret = 0;
>> +
>> +	if (hu->serdev)
>> +		serdev_device_open(hu->serdev);
>> +	else {
>> +		BT_ERR("%s:open operation not supported", hu->hdev->name);
>> +		ret = 1;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +int qca_btsoc_cleanup(struct hci_dev *hdev)
>> +{
>> +	struct hci_uart *hu = hci_get_drvdata(hdev);
>> +
>> +	/* change host baud rate before sending power off command */
>> +	host_set_baudrate(hu, 2400);
>> +	/* send 0xC0 command to btsoc before turning off regulators */
>> +	qca_send_poweroff_cmd(hdev);
>> +	/* turn off btsoc */
>> +	return btqca_power_setup(false);
>> +}
>> +
>> +static int qca_serdev_close(struct hci_uart *hu)
>> +{
>> +	int ret = 0;
>> +
>> +	if (hu->serdev)
>> +		serdev_device_close(hu->serdev);
>> +	else {
>> +		BT_ERR("%s:close operation not supported", hu->hdev->name);
>> +		ret = 1;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>   static int qca_setup(struct hci_uart *hu)
>>   {
>>   	struct hci_dev *hdev = hu->hdev;
>>   	struct qca_data *qca = hu->priv;
>> +	struct qca_serdev *qcadev;
>>   	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
>>   	int ret;
>> +	unsigned int  soc_ver;
>> +
>> +	qcadev = serdev_device_get_drvdata(hu->serdev);
>> +
>> +	switch (qcadev->btsoc_type) {
>> +	case BTQCA_CHEROKEE:
>> +
>> +		BT_INFO("%s:setting up wcn3990", hdev->name);
>> +		/* Patch downloading has to be done without IBS mode */
>> +		clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
>> +		/* Setup initial baudrate */
>> +		speed = 0;
>> +		if (hu->init_speed)
>> +			speed = hu->init_speed;
>> +		else if (hu->proto->init_speed)
>> +			speed = hu->proto->init_speed;
>> +
>> +		if (speed)
>> +			host_set_baudrate(hu, speed);
>> +		else {
>> +			BT_ERR("%s:initial speed %u", hdev->name, speed);
>> +			return -1;
>> +		}
>>   -	BT_INFO("%s: ROME setup", hdev->name);
>> +		/* clear flow control- for sync cmd*/
>> +		hci_uart_set_flow_control(hu, true);
>> +		/* send poweron command to btsoc */
>> +		ret = qca_send_poweron_cmd(hdev);
>> +		if (ret) {
>> +			BT_ERR("%s:sending sync command failed", hdev->name);
>> +			return ret;
>> +		}
>> +
>> +		/* close port */
>> +		ret = qca_serdev_close(hu);
>> +		if (ret)
>> +			return ret;
>> +		/* reopen port */
>> +		ret = qca_serdev_open(hu);
>> +		if (ret)
>> +			return ret;
>> +		/* Setup initial baudrate */
>> +		speed = 0;
>> +		if (hu->init_speed)
>> +			speed = hu->init_speed;
>> +		else if (hu->proto->init_speed)
>> +			speed = hu->proto->init_speed;
>> +		if (speed)
>> +			host_set_baudrate(hu, speed);
>> +		else {
>> +			BT_ERR("%s:initial speed %u", hdev->name, speed);
>> +			return -1;
>> +		}
>>   -	/* Patch downloading has to be done without IBS mode */
>> -	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
>> +		/* Enable flow control */
>> +		hci_uart_set_flow_control(hu, false);
>> +		/*  wait until flow control settled */
>> +		mdelay(100);
>>   -	/* Setup initial baudrate */
>> -	speed = 0;
>> -	if (hu->init_speed)
>> -		speed = hu->init_speed;
>> -	else if (hu->proto->init_speed)
>> -		speed = hu->proto->init_speed;
>> +		ret = qca_btsoc_patch_ver_req(hdev, &soc_ver);
>> +		if (ret < 0 || soc_ver == 0) {
>> +			BT_ERR("%s: Failed to get version 0x%x", hdev->name,
>> +				ret);
>> +			return ret;
>> +		}
>>   -	if (speed)
>> -		host_set_baudrate(hu, speed);
>> +		BT_INFO("%s:wcn3990 controller version 0x%08x", hdev->name,
>> +			soc_ver);
>>   -	/* Setup user speed if needed */
>> -	speed = 0;
>> -	if (hu->oper_speed)
>> -		speed = hu->oper_speed;
>> -	else if (hu->proto->oper_speed)
>> +		/* clear flow control */
>> +		hci_uart_set_flow_control(hu, true);
>> +		/* set operating speed */
>>   		speed = hu->proto->oper_speed;
>> +		if (speed) {
>> +			qca_baudrate = qca_get_baudrate_value(speed);
>> +			BT_INFO("%s: Set UART speed to %d", hdev->name, speed);
>> +			ret = qca_set_baudrate(hdev, qca_baudrate);
>> +			if (ret) {
>> +				BT_ERR("%s:Failed to change the baud rate(%d)",
>> +					hdev->name, ret);
>> +				return ret;
>> +			}
>> +			if (speed)
>> +				host_set_baudrate(hu, speed);
>> +			else {
>> +				BT_ERR("%s:Error in setting operator speed:%u",
>> +					hdev->name, speed);
>> +				return -1;
>> +			}
>> +		}
>>   -	if (speed) {
>> -		qca_baudrate = qca_get_baudrate_value(speed);
>> +		/* Set flow control */
>> +		hci_uart_set_flow_control(hu, false);
>> +		/*Setup patch and  NVM configurations */
>> +		ret = qca_uart_setup_cherokee(hdev, qca_baudrate, &soc_ver);
>> +		if (!ret) {
>> +			set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
>> +			qca_debugfs_init(hdev);
>> +		}
>>   -		BT_INFO("%s: Set UART speed to %d", hdev->name, speed);
>> -		ret = qca_set_baudrate(hdev, qca_baudrate);
>> -		if (ret) {
>> -			BT_ERR("%s: Failed to change the baud rate (%d)",
>> -			       hdev->name, ret);
>> -			return ret;
>> +		/* Setup wcn3990 bdaddr */
>> +		hu->hdev->set_bdaddr = qca_btsoc_set_bdaddr;
>> +
>> +		return ret;
>> +
>> +	default:
>> +		BT_INFO("%s: ROME setup", hdev->name);
>> +		/* Patch downloading has to be done without IBS mode */
>> +		clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
>> +		/* Setup initial baudrate */
>> +		speed = 0;
>> +		if (hu->init_speed)
>> +			speed = hu->init_speed;
>> +		else if (hu->proto->init_speed)
>> +			speed = hu->proto->init_speed;
>> +		if (speed)
>> +			hci_uart_set_baudrate(hu, speed);
>> +
>> +		/* Setup user speed if needed */
>> +		speed = 0;
>> +		if (hu->oper_speed)
>> +			speed = hu->oper_speed;
>> +		else if (hu->proto->oper_speed)
>> +			speed = hu->proto->oper_speed;
>> +
>> +		if (speed) {
>> +			qca_baudrate = qca_get_baudrate_value(speed);
>> +
>> +			BT_INFO("%s: Set UART speed to %d", hdev->name, speed);
>> +			ret = qca_set_baudrate(hdev, qca_baudrate);
>> +			if (ret) {
>> +				BT_ERR("%s:Failed to change the baud rate(%d)",
>> +					hdev->name, ret);
>> +					return ret;
>> +				}
>> +			host_set_baudrate(hu, speed);
>>   		}
>> -		host_set_baudrate(hu, speed);
>> -	}
>>   -	/* Setup patch / NVM configurations */
>> -	ret = qca_uart_setup_rome(hdev, qca_baudrate);
>> -	if (!ret) {
>> -		set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
>> -		qca_debugfs_init(hdev);
>> -	} else if (ret == -ENOENT) {
>> -		/* No patch/nvm-config found, run with original fw/config */
>> -		ret = 0;
>> -	}
>> +		/* Setup patch / NVM configurations */
>> +		ret = qca_uart_setup_rome(hdev, qca_baudrate);
>> +		if (!ret) {
>> +			set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
>> +			qca_debugfs_init(hdev);
>> +		}
>>   -	/* Setup bdaddr */
>> -	hu->hdev->set_bdaddr = qca_set_bdaddr_rome;
>> +		/* Setup bdaddr */
>> +		hu->hdev->set_bdaddr = qca_btsoc_set_bdaddr;
>>   -	return ret;
>> +		return ret;
>> +	}
>>   }
>>     static struct hci_uart_proto qca_proto = {
>> @@ -997,42 +1248,142 @@ static int qca_setup(struct hci_uart *hu)
>>   	.dequeue	= qca_dequeue,
>>   };
>>   +static const struct btqca_vreg_data cherokee_data = {
>> +	.soc_type = BTQCA_CHEROKEE,
>> +	.vregs = (struct btqca_vreg []) {
>> +		{ "vddio",   1352000, 1352000,  0 },
>> +		{ "vddxtal", 1904000, 2040000,  0 },
>> +		{ "vddcore", 1800000, 1800000,  1 },
>> +		{ "vddpa",   130400,  1304000,  1 },
>> +		{ "vddldo",  3000000, 3312000,  1 },
>> +		{ "vddpwd",  3312000, 3600000,  0 },
>> +	},
>> +	.num_vregs = 6,
>> +};
>> +
>> +int btqca_power_setup(bool on)
>> +{
>> +	int ret = 0;
>> +	int i;
>> +	struct btqca_vreg *vregs;
>> +
>> +	if (!qca || !qca->vreg_data || !qca->vreg_bulk)
>> +		return -EINVAL;
>> +	vregs = qca->vreg_data->vregs;
>> +
>> +	BT_DBG("on: %d", on);
>> +
>> +	/* turn on if regualtors are off */
>> +	if (on == true && qca->vreg_status == false) {
>> +		qca->vreg_status = true;
>> +		for (i = 0; i < qca->vreg_data->num_vregs; i++) {
>> +			regulator_set_voltage(qca->vreg_bulk[i].consumer,
>> +					      vregs[i].min_v,
>> +					      vregs[i].max_v);
>> +
>> +			if (vregs[i].load_ua)
>> +				regulator_set_load(qca->vreg_bulk[i].consumer,
>> +						   vregs[i].load_ua);
>> +
>> +			regulator_enable(qca->vreg_bulk[i].consumer);
>> +		}
>> +	} else if (on == false && qca->vreg_status == true) {
>> +		qca->vreg_status = false;
>> +		for (i = 0; i < qca->vreg_data->num_vregs; i++) {
>> +			regulator_disable(qca->vreg_bulk[i].consumer);
>> +			regulator_set_voltage(qca->vreg_bulk[i].consumer,
>> +						0, vregs[i].max_v);
>> +			if (vregs[i].load_ua)
>> +				regulator_set_load(qca->vreg_bulk[i].consumer,
>> +						   0);
>> +		}
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int init_regulators(struct btqca_power *qca,
>> +			   const struct btqca_vreg *vregs,
>> +			   size_t num_vregs)
>> +{
>> +	int i;
>> +
>> +	qca->vreg_bulk = devm_kzalloc(qca->dev, num_vregs *
>> +					sizeof(struct regulator_bulk_data),
>> +					GFP_KERNEL);
>> +	if (!qca->vreg_bulk)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < num_vregs; i++)
>> +		qca->vreg_bulk[i].supply = vregs[i].name;
>> +
>> +	return devm_regulator_bulk_get(qca->dev, num_vregs, qca->vreg_bulk);
>> +}
>> +
>>   static int qca_serdev_probe(struct serdev_device *serdev)
>>   {
>>   	struct qca_serdev *qcadev;
>> -	int err;
>> +	struct btqca_vreg_data *data;
>> +	int err = 0;
>>     	qcadev = devm_kzalloc(&serdev->dev, sizeof(*qcadev), GFP_KERNEL);
>>   	if (!qcadev)
>>   		return -ENOMEM;
>>     	qcadev->serdev_hu.serdev = serdev;
>> +	data = of_device_get_match_data(&serdev->dev);
>> +	if (data && data->soc_type == BTQCA_CHEROKEE)
>> +		qcadev->btsoc_type = BTQCA_CHEROKEE;
>> +	else
>> +		qcadev->btsoc_type = BTQCA_ROME;
>> +
>>   	serdev_device_set_drvdata(serdev, qcadev);
>> +	if (qcadev->btsoc_type == BTQCA_CHEROKEE) {
>> +		qca = kzalloc(sizeof(struct btqca_power), GFP_KERNEL);
>> +		if (!qca)
>> +			return -ENOMEM;
>> +
>> +		qca->dev = &serdev->dev;
>> +		qca->vreg_data = data;
>> +		err = init_regulators(qca, data->vregs, data->num_vregs);
>> +		if (err) {
>> +			BT_ERR("Failed to init regualtors:%d", err);
>> +			kfree(qca);
>> +		}
>>   -	qcadev->bt_en = devm_gpiod_get(&serdev->dev, "enable",
>> -				       GPIOD_OUT_LOW);
>> -	if (IS_ERR(qcadev->bt_en)) {
>> -		dev_err(&serdev->dev, "failed to acquire enable gpio\n");
>> -		return PTR_ERR(qcadev->bt_en);
>> -	}
>> +		/* set voltage regulator status as false */
>> +		qca->vreg_status = false;
>> +		err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
>> +		if (err) {
>> +			BT_ERR("wcn3990 serdev registration failed");
>> +			kfree(qca);
>> +		}
>> +	} else {
>> +		qcadev->bt_en = devm_gpiod_get(&serdev->dev, "enable",
>> +					       GPIOD_OUT_LOW);
>> +		if (IS_ERR(qcadev->bt_en)) {
>> +			dev_err(&serdev->dev, "failed to acquire enable gpio\n");
>> +			return PTR_ERR(qcadev->bt_en);
>> +		}
>>   -	qcadev->susclk = devm_clk_get(&serdev->dev, NULL);
>> -	if (IS_ERR(qcadev->susclk)) {
>> -		dev_err(&serdev->dev, "failed to acquire clk\n");
>> -		return PTR_ERR(qcadev->susclk);
>> -	}
>> +		qcadev->susclk = devm_clk_get(&serdev->dev, NULL);
>> +		if (IS_ERR(qcadev->susclk)) {
>> +			dev_err(&serdev->dev, "failed to acquire clk\n");
>> +			return PTR_ERR(qcadev->susclk);
>> +		}
>>   -	err = clk_set_rate(qcadev->susclk, SUSCLK_RATE_32KHZ);
>> -	if (err)
>> -		return err;
>> +		err = clk_set_rate(qcadev->susclk, SUSCLK_RATE_32KHZ);
>> +		if (err)
>> +			return err;
>>   -	err = clk_prepare_enable(qcadev->susclk);
>> -	if (err)
>> -		return err;
>> +		err = clk_prepare_enable(qcadev->susclk);
>> +		if (err)
>> +			return err;
>>   -	err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
>> -	if (err)
>> -		clk_disable_unprepare(qcadev->susclk);
>> +		err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
>> +		if (err)
>> +			clk_disable_unprepare(qcadev->susclk);
>> +	}
>>     	return err;
>>   }
>> @@ -1042,12 +1393,16 @@ static void qca_serdev_remove(struct 
>> serdev_device *serdev)
>>   	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
>>     	hci_uart_unregister_device(&qcadev->serdev_hu);
>> -
>> -	clk_disable_unprepare(qcadev->susclk);
>> +	if (qcadev->btsoc_type == BTQCA_CHEROKEE) {
>> +		btqca_power_setup(false);
>> +		kfree(qca);
>> +	} else
>> +		clk_disable_unprepare(qcadev->susclk);
>>   }
>>     static const struct of_device_id qca_bluetooth_of_match[] = {
>>   	{ .compatible = "qcom,qca6174-bt" },
>> +	{ .compatible = "qca,wcn3990-bt", .data = &cherokee_data},
>>   	{ /* sentinel */ }
>>   };
>>   MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);
>> diff --git a/include/net/bluetooth/hci_core.h 
>> b/include/net/bluetooth/hci_core.h
>> index c10cb79..b932ec50 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -1418,7 +1418,8 @@ struct sk_buff *__hci_cmd_sync(struct hci_dev 
>> *hdev, u16 opcode, u32 plen,
>>   			       const void *param, u32 timeout);
>>   struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, 
>> u32 plen,
>>   				  const void *param, u8 event, u32 timeout);
>> -
>> +int __hci_cmd_no_event(struct hci_dev *hdev, u16 opcode, u32 plen,
>> +			const void *param);
>>   int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
>>   		 const void *param);
>>   void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 
>> flags);
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 97ef85e..8addd97 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -3370,7 +3370,7 @@ int hci_unregister_cb(struct hci_cb *cb)
>>   }
>>   EXPORT_SYMBOL(hci_unregister_cb);
>>   -static void hci_send_frame(struct hci_dev *hdev, struct sk_buff 
>> *skb)
>> +void hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
>>   {
>>   	int err;
>>   diff --git a/net/bluetooth/hci_request.c 
>> b/net/bluetooth/hci_request.c
>> index f7d6ba6..1ffee59a 100644
>> --- a/net/bluetooth/hci_request.c
>> +++ b/net/bluetooth/hci_request.c
>> @@ -114,6 +114,29 @@ void hci_req_sync_cancel(struct hci_dev *hdev, 
>> int err)
>>   	}
>>   }
>>   +/*  Queue a frame to an asynchronous transfer to btdevice,
>> + *  with out any event from btdevice.
>> + */
>> +int __hci_cmd_no_event(struct hci_dev *hdev, u16 opcode, u32 plen,
>> +		       const void *param)
>> +{
>> +	struct sk_buff *skb;
>> +
>> +	BT_DBG("%s opcode 0x%4.4x plen %d", hdev->name, opcode, plen);
>> +
>> +	skb = hci_prepare_cmd(hdev, opcode, plen, param);
>> +	if (!skb) {
>> +		BT_ERR("%s no memory for command (opcode 0x%4.4x)",
>> +		       hdev->name, opcode);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	hci_send_frame(hdev, skb);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(__hci_cmd_no_event);
>> +
>>   struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, 
>> u32 plen,
>>   				  const void *param, u8 event, u32 timeout)
>>   {
>> diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
>> index dde77bd..a855edd 100644
>> --- a/net/bluetooth/hci_request.h
>> +++ b/net/bluetooth/hci_request.h
>> @@ -128,3 +128,5 @@ static inline u16 eir_append_le16(u8 *eir, u16 
>> eir_len, u8 type, u16 data)
>>     	return eir_len;
>>   }
>> +
>> +void hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb);
>> 

Regards
Balakrishna.

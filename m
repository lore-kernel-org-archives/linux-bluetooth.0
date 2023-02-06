Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5114AC05027
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Feb 2023 11:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjBFLkn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Feb 2023 06:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjBFLkm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Feb 2023 06:40:42 -0500
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C156618173
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Feb 2023 03:40:39 -0800 (PST)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 45DA060027FD5;
        Mon,  6 Feb 2023 12:40:38 +0100 (CET)
Message-ID: <d0fab1ee-6906-7295-3b02-84b6949ca2fc@molgen.mpg.de>
Date:   Mon, 6 Feb 2023 12:40:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] Bluetooth: btintel: Set Per Platform Antenna
 Gain(PPAG)
To:     Kiran K <kiran.k@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        lokendra.singh@intel.com, chethan.tumkur.narayan@intel.com,
        Seema Sreemantha <seema.sreemantha@intel.com>
References: <20230206062305.6340-1-kiran.k@intel.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230206062305.6340-1-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Kiran, dear Seema,


Thank you for the patch.


Am 06.02.23 um 07:23 schrieb Kiran K:
> From: Seema Sreemantha <seema.sreemantha@intel.com>

Please add a space before the ( in the commit message summary.

> Antenna gain is defined as the antenna’s ability to
> increase the Tx power in a given direction. Intel
> is certifying its products with fixed reference
> antenna peak gain values (3/5dBi). The feature takes
> into account the actual antenna gain, and increases
> output power values, which results in a performance
> improvement.
> 
> After firmware download is completed, driver reads from
> ACPI table and configures PPAG as required. ACPI table
> entry for PPAG is defined as below.

It’d be great if you reflowed the text for 72/75 characters per line so 
less lines are used.

> 
> Name (PPAG, Package (0x02)
> {
>      0x00000001,
>      Package (0x02)
>      {
>          0x00000012, /* Bluetooth Domain */
>          0x00000001  /* 1 - Enable PPAG, 0 - Disable PPAG */
>      }
> })
> 
> btmon log:
> < HCI Command: Intel Configure Per Platform Antenna Gain (0x3f|0x0219) plen 12
>          Mcc: 0x00000000
>          Selector: Enable
>          Delta: 0x00000000
>> HCI Event: Command Complete (0x0e) plen 4
>        Intel Configure Per Platform Antenna Gain (0x3f|0x0219) ncmd 1
>          Status: Success (0x00)
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Seema Sreemantha <seema.sreemantha@intel.com>
> ---
> changes in v2:
> - Address review comments
> 
>   drivers/bluetooth/btintel.c | 115 ++++++++++++++++++++++++++++++++++++
>   drivers/bluetooth/btintel.h |  13 ++++
>   2 files changed, 128 insertions(+)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index d4e2cb9a4eb4..608fa1e59e89 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -24,6 +24,9 @@
>   #define ECDSA_OFFSET		644
>   #define ECDSA_HEADER_LEN	320
>   
> +#define BTINTEL_PPAG_NAME   "PPAG"
> +#define BTINTEL_PPAG_PREFIX "\\_SB_.PCI0.XHCI.RHUB"
> +
>   #define CMD_WRITE_BOOT_PARAMS	0xfc0e
>   struct cmd_write_boot_params {
>   	__le32 boot_addr;
> @@ -1278,6 +1281,63 @@ static int btintel_read_debug_features(struct hci_dev *hdev,
>   	return 0;
>   }
>   
> +static acpi_status btintel_ppag_callback(acpi_handle handle, u32 lvl, void *data,
> +					 void **ret)
> +{
> +	acpi_status status;
> +	size_t len;
> +	struct btintel_ppag *ppag = data;
> +	union acpi_object *p, *elements;
> +	struct acpi_buffer string = {ACPI_ALLOCATE_BUFFER, NULL};
> +	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> +	struct hci_dev *hdev = ppag->hdev;
> +
> +	status = acpi_get_name(handle, ACPI_FULL_PATHNAME, &string);
> +	if (ACPI_FAILURE(status)) {
> +		bt_dev_warn(hdev, "ACPI Failure: %s", acpi_format_exception(status));
> +		return status;
> +	}
> +
> +	if (strncmp(BTINTEL_PPAG_PREFIX, string.pointer,
> +		    strlen(BTINTEL_PPAG_PREFIX))) {
> +		kfree(string.pointer);
> +		return AE_OK;
> +	}
> +
> +	len = strlen(string.pointer);
> +	if (strncmp((char *)string.pointer + len - 4, BTINTEL_PPAG_NAME, 4)) {
> +		kfree(string.pointer);
> +		return AE_OK;
> +	}
> +	kfree(string.pointer);
> +
> +	status = acpi_evaluate_object(handle, NULL, NULL, &buffer);
> +	if (ACPI_FAILURE(status)) {
> +		bt_dev_warn(hdev, "ACPI Failure: %s", acpi_format_exception(status));
> +		return status;
> +	}
> +
> +	p = buffer.pointer;
> +	ppag = (struct btintel_ppag *)data;
> +
> +	if (p->type != ACPI_TYPE_PACKAGE || p->package.count != 2) {
> +		kfree(buffer.pointer);
> +		bt_dev_warn(hdev, "Invalid object type: %d or package count: %d",
> +			    p->type, p->package.count);
> +		return AE_ERROR;
> +	}
> +
> +	elements = p->package.elements;
> +
> +	/* PPAG table is located at element[1] */
> +	p = &elements[1];
> +
> +	ppag->domain = (u32)p->package.elements[0].integer.value;
> +	ppag->mode = (u32)p->package.elements[1].integer.value;
> +	kfree(buffer.pointer);
> +	return AE_CTRL_TERMINATE;
> +}
> +
>   static int btintel_set_debug_features(struct hci_dev *hdev,
>   			       const struct intel_debug_features *features)
>   {
> @@ -2251,6 +2311,58 @@ static int btintel_configure_offload(struct hci_dev *hdev)
>   	return err;
>   }
>   
> +static void btintel_set_ppag(struct hci_dev *hdev, struct intel_version_tlv *ver)
> +{
> +	acpi_status status;
> +	struct btintel_ppag ppag;
> +	struct sk_buff *skb;
> +	struct btintel_loc_aware_reg ppag_cmd;
> +
> +    /* PPAG is not supported if CRF is HrP2, Jfp2, JfP1 */

At least in Mozilla Thunderbird, this does not look properly indented. 
Please use tabs in the beginning.

> +	switch (ver->cnvr_top & 0xFFF) {
> +	case 0x504:     /* Hrp2 */
> +	case 0x202:     /* Jfp2 */
> +	case 0x201:     /* Jfp1 */
> +		return;
> +	}
> +
> +	memset(&ppag, 0, sizeof(ppag));
> +
> +	ppag.hdev = hdev;
> +	status = acpi_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
> +				     ACPI_UINT32_MAX, NULL,
> +				     btintel_ppag_callback, &ppag, NULL);
> +
> +	if (ACPI_FAILURE(status)) {
> +		/* Do not log warning message if ACPI entry is not found */

The comment seems useless, as it’s describing what the code does. (Maybe 
a debug message should be added.)

> +		if (status == AE_NOT_FOUND)
> +			return;
> +		bt_dev_warn(hdev, "PPAG: ACPI Failure: %s", acpi_format_exception(status));
> +		return;
> +	}
> +
> +	if (ppag.domain != 0x12) {
> +		bt_dev_warn(hdev, "PPAG-BT Domain disabled");

Please elaborate and be more specific. Maybe:

 > PPAG-BT Domain disabled in ACPI firwmare.

> +		return;
> +	}
> +
> +	/* PPAG mode, BIT0 = 0 Disabled, BIT0 = 1 Enabled */
> +	if (!(ppag.mode & BIT(0))) {
> +		bt_dev_dbg(hdev, "PPAG disabled");

Maybe be consistent and keep using PPAG-BT. Maybe also add the term mode 
in there.

> +		return;
> +	}
> +
> +	ppag_cmd.mcc = cpu_to_le32(0);
> +	ppag_cmd.sel = cpu_to_le32(0); /* 0 - Enable , 1 - Disable, 2 - Testing mode */
> +	ppag_cmd.delta = cpu_to_le32(0);
> +	skb = __hci_cmd_sync(hdev, 0xfe19, sizeof(ppag_cmd), &ppag_cmd, HCI_CMD_TIMEOUT);

Where does 0xfe19 come from?

> +	if (IS_ERR(skb)) {
> +		bt_dev_warn(hdev, "Failed to send PPAG Enable (%ld)", PTR_ERR(skb));

Should this be error level? What could a user do? Contact the hardware 
vendor?


Kind regards,

Paul


> +		return;
> +	}
> +	kfree_skb(skb);
> +}
> +
>   static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
>   					struct intel_version_tlv *ver)
>   {
> @@ -2297,6 +2409,9 @@ static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
>   
>   	hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);
>   
> +	/* Set PPAG feature */
> +	btintel_set_ppag(hdev, ver);
> +
>   	/* Read the Intel version information after loading the FW  */
>   	err = btintel_read_version_tlv(hdev, &new_ver);
>   	if (err)
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index e0060e58573c..8e7da877efae 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -137,6 +137,19 @@ struct intel_offload_use_cases {
>   	__u8	preset[8];
>   } __packed;
>   
> +/* structure to store the PPAG data read from ACPI table */
> +struct btintel_ppag {
> +	u32	domain;
> +	u32     mode;
> +	struct hci_dev *hdev;
> +};
> +
> +struct btintel_loc_aware_reg {
> +	__le32 mcc;
> +	__le32 sel;
> +	__le32 delta;
> +} __packed;
> +
>   #define INTEL_HW_PLATFORM(cnvx_bt)	((u8)(((cnvx_bt) & 0x0000ff00) >> 8))
>   #define INTEL_HW_VARIANT(cnvx_bt)	((u8)(((cnvx_bt) & 0x003f0000) >> 16))
>   #define INTEL_CNVX_TOP_TYPE(cnvx_top)	((cnvx_top) & 0x00000fff)

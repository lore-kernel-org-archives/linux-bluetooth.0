Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B56C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Sun, 11 Jun 2023 09:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjFKJmm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 11 Jun 2023 05:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFKJmm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 11 Jun 2023 05:42:42 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC9FBC
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jun 2023 02:42:39 -0700 (PDT)
Received: from [192.168.0.185] (ip5f5aebdb.dynamic.kabel-deutschland.de [95.90.235.219])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id E4DF561EA1BFF;
        Sun, 11 Jun 2023 11:42:20 +0200 (CEST)
Message-ID: <fa2131b8-0186-f9cf-fb79-1975868934ff@molgen.mpg.de>
Date:   Sun, 11 Jun 2023 11:42:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RESEND v3] Bluetooth: btintel: Add support to reset bluetooth
 via ACPI DSM
To:     Kiran K <kiran.k@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.nayaran@intel.com
References: <20230611064342.1587278-1-kiran.k@intel.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230611064342.1587278-1-kiran.k@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Kiran,


Thank you for your patch. Some minor nits.

Am 11.06.23 um 08:43 schrieb Kiran K:
> New Intel platforms supports reset of Bluetooth device  via ACPI DSM

1.  support
2.  one space after device

> methods. The legacy reset mechanism via GPIO will be deprecated in

Can you please name the new platform it started with.

> future. This patch checks the platform support for reset methods and if
> supported uses the same instead of legacy GPIO toggling method.

Could you please document the datasheet name, version and section this 
is documented in?

> ACPI firmware supports two types of reset method based on NIC card.
> (Discrete or Integrated).

I’d remove the dot/period before (.

> 1. VSEC Type - Vendor Specific Extended Capability. Here  BT_EN and

Only one space after Here.

>     BT_IF_SELECT lines are driven by a register in PCH cluster. This
>     interface is supported on discrete BT solution.
> 
> 2. WDISABLE2 - In this soluton, W_DISABLE2 pin in M.2 is connected to

solution

>     physical GPIO from PCH. The DSM interface shall toggle this to recover
>     from  error.

Only one space after from.

How did you test this? (Maybe also paste the new log messages?)

I’d also appreciated one paragraph about the implentation.

> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>   drivers/bluetooth/btintel.c | 121 ++++++++++++++++++++++++++++++++++++
>   drivers/bluetooth/btintel.h |   2 +
>   drivers/bluetooth/btusb.c   |  16 +++++
>   3 files changed, 139 insertions(+)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index d9349ba48281..dd1e48808ee2 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -10,6 +10,7 @@
>   #include <linux/firmware.h>
>   #include <linux/regmap.h>
>   #include <linux/acpi.h>
> +#include <acpi/acpi_bus.h>
>   #include <asm/unaligned.h>
>   
>   #include <net/bluetooth/bluetooth.h>
> @@ -27,6 +28,11 @@
>   
>   #define BTINTEL_PPAG_NAME   "PPAG"
>   
> +enum {
> +	DSM_SET_WDISABLE2_DELAY = 1,
> +	DSM_SET_RESET_METHOD = 3,
> +};
> +
>   /* structure to store the PPAG data read from ACPI table */
>   struct btintel_ppag {
>   	u32	domain;
> @@ -49,6 +55,10 @@ static struct {
>   	u32        fw_build_num;
>   } coredump_info;
>   
> +static const guid_t btintel_guid_dsm =
> +	GUID_INIT(0xaa10f4e0, 0x81ac, 0x4233,
> +		  0xab, 0xf6, 0x3b, 0x2a, 0xc5, 0x0e, 0x28, 0xd9);
> +
>   int btintel_check_bdaddr(struct hci_dev *hdev)
>   {
>   	struct hci_rp_read_bd_addr *bda;
> @@ -2444,6 +2454,116 @@ static void btintel_set_ppag(struct hci_dev *hdev, struct intel_version_tlv *ver
>   	kfree_skb(skb);
>   }
>   
> +static int btintel_acpi_reset_method(struct hci_dev *hdev)
> +{
> +	int ret = 0;
> +	acpi_status status;
> +	union acpi_object *p, *ref;
> +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +
> +	status = acpi_evaluate_object(ACPI_HANDLE(GET_HCIDEV_DEV(hdev)), "_PRR", NULL, &buffer);
> +	if (ACPI_FAILURE(status)) {
> +		bt_dev_err(hdev, "Failed to run _PRR method");

Will the failure code(?) be printed?

> +		ret = -ENODEV;
> +		return ret;
> +	}
> +	p = buffer.pointer;
> +
> +	if (p->package.count != 1 || p->type != ACPI_TYPE_PACKAGE) {
> +		bt_dev_err(hdev, "Invalid arguments");

Output the values?

> +		ret = -EINVAL;
> +		goto exit_on_error;
> +	}
> +
> +	ref = &p->package.elements[0];
> +	if (ref->type != ACPI_TYPE_LOCAL_REFERENCE) {
> +		bt_dev_err(hdev, "Invalid object type: 0x%x", ref->type);

… should be ACPI_TYPE_LOCAL_REFERENCE.

> +		ret = -EINVAL;
> +		goto exit_on_error;
> +	}
> +
> +	status = acpi_evaluate_object(ref->reference.handle, "_RST", NULL, NULL);
> +	if (ACPI_FAILURE(status)) {
> +		bt_dev_err(hdev, "Failed to run_RST method");

Will the failure code(?) be printed?

> +		ret = -ENODEV;
> +		goto exit_on_error;
> +	}
> +
> +exit_on_error:
> +	kfree(buffer.pointer);
> +	return ret;
> +}
> +
> +static void btintel_set_dsm_reset_method(struct hci_dev *hdev,
> +					 struct intel_version_tlv *ver_tlv)
> +{
> +	struct btintel_data *data = hci_get_priv(hdev);
> +	acpi_handle handle = ACPI_HANDLE(GET_HCIDEV_DEV(hdev));
> +	u8 reset_payload[4] = {0x01, 0x00, 0x01, 0x00};

In other parts you add spaces after { and before }.

> +	union acpi_object *obj, argv4;
> +	enum {
> +		RESET_TYPE_WDISABLE2,
> +		RESET_TYPE_VSEC
> +	};
> +
> +	handle = ACPI_HANDLE(GET_HCIDEV_DEV(hdev));
> +
> +	if (!handle) {
> +		bt_dev_dbg(hdev, "No support for bluetooth device in ACPI firmware");
> +		return;
> +	}
> +
> +	if (!acpi_has_method(handle, "_PRR")) {
> +		bt_dev_err(hdev, "No support for _PRR ACPI method");
> +		return;
> +	}
> +
> +	switch (ver_tlv->cnvi_top & 0xfff) {
> +	case 0x910: /* GalePeak2 */
> +		reset_payload[2] = RESET_TYPE_VSEC;
> +		break;
> +	default:
> +		/* WDISABLE2 is the default reset method */
> +		reset_payload[2] = RESET_TYPE_WDISABLE2;
> +
> +		if (!acpi_check_dsm(handle, &btintel_guid_dsm, 0,
> +				    BIT(DSM_SET_WDISABLE2_DELAY))) {
> +			bt_dev_err(hdev, "No dsm support to set reset delay");
> +			return;
> +		}
> +		argv4.integer.type = ACPI_TYPE_INTEGER;
> +		/* delay required to toggle BT power */
> +		argv4.integer.value = 160;

Where does that 160 come from?

> +		obj = acpi_evaluate_dsm(handle, &btintel_guid_dsm, 0,
> +					DSM_SET_WDISABLE2_DELAY, &argv4);
> +		if (!obj) {
> +			bt_dev_err(hdev, "Failed to call dsm to set reset delay");
> +			return;
> +		}
> +		ACPI_FREE(obj);
> +	}
> +
> +	bt_dev_info(hdev, "DSM reset method type: 0x%02x", reset_payload[2]);
> +
> +	if (!acpi_check_dsm(handle, &btintel_guid_dsm, 0,
> +			    DSM_SET_RESET_METHOD)) {

Does this fit in one line?

> +		bt_dev_warn(hdev, "No support for dsm to set reset method");
> +		return;
> +	}
> +	argv4.buffer.type = ACPI_TYPE_BUFFER;
> +	argv4.buffer.length = sizeof(reset_payload);
> +	argv4.buffer.pointer = reset_payload;
> +
> +	obj = acpi_evaluate_dsm(handle, &btintel_guid_dsm, 0,
> +				DSM_SET_RESET_METHOD, &argv4);
> +	if (!obj) {
> +		bt_dev_err(hdev, "Failed to call dsm to set reset method");
> +		return;
> +	}
> +	ACPI_FREE(obj);
> +	data->acpi_reset_method = btintel_acpi_reset_method;
> +}
> +
>   static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
>   					struct intel_version_tlv *ver)
>   {
> @@ -2757,6 +2877,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
>   		/* Setup MSFT Extension support */
>   		btintel_set_msft_opcode(hdev,
>   					INTEL_HW_VARIANT(ver_tlv.cnvi_bt));
> +		btintel_set_dsm_reset_method(hdev, &ver_tlv);
>   
>   		err = btintel_bootloader_setup_tlv(hdev, &ver_tlv);
>   		btintel_register_devcoredump_support(hdev);
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index d6a1dc8d8a82..7fd29ef038bd 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -166,12 +166,14 @@ enum {
>   	INTEL_BROKEN_SHUTDOWN_LED,
>   	INTEL_ROM_LEGACY,
>   	INTEL_ROM_LEGACY_NO_WBS_SUPPORT,
> +	INTEL_ACPI_RESET_ACTIVE,
>   
>   	__INTEL_NUM_FLAGS,
>   };
>   
>   struct btintel_data {
>   	DECLARE_BITMAP(flags, __INTEL_NUM_FLAGS);
> +	int (*acpi_reset_method)(struct hci_dev *hdev);
>   };
>   
>   #define btintel_set_flag(hdev, nr)					\
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 8776e0f93c73..c6ac63fdecfa 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -857,10 +857,26 @@ static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
>   {
>   	struct btusb_data *data = hci_get_drvdata(hdev);
>   	struct gpio_desc *reset_gpio = data->reset_gpio;
> +	struct btintel_data *intel_data = hci_get_priv(hdev);
>   
>   	if (++data->cmd_timeout_cnt < 5)
>   		return;
>   
> +	if (intel_data->acpi_reset_method) {
> +		if (test_and_set_bit(INTEL_ACPI_RESET_ACTIVE, intel_data->flags)) {
> +			bt_dev_err(hdev, "acpi: last reset failed ? Not resetting again");

Why the question mark? (No space before it.)

> +			return;
> +		}
> +
> +		bt_dev_err(hdev, "Initiating acpi reset method");
> +		/* If ACPI reset method fails, lets try with legacy GPIO
> +		 * toggling
> +		 */
> +		if (!intel_data->acpi_reset_method(hdev)) {
> +			return;
> +		}
> +	}
> +
>   	if (!reset_gpio) {
>   		btusb_reset(hdev);
>   		return;


Kind regards,

Paul

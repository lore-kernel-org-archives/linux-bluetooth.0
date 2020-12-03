Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D807C64E8A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 13:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 461D321D91
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 13:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbgLCNP5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Dec 2020 08:15:57 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:42529 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbgLCNP5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Dec 2020 08:15:57 -0500
Received: from marcel-macbook.holtmann.net (unknown [37.83.193.87])
        by mail.holtmann.org (Postfix) with ESMTPSA id B6533CECFC;
        Thu,  3 Dec 2020 14:22:28 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: Re: [PATCH v3] Bluetooth: btintel parse TLV structure
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201106092119.20486-1-sathish.narasimman@intel.com>
Date:   Thu, 3 Dec 2020 14:15:14 +0100
Cc:     linux-bluetooth@vger.kernel.org, chethan.tumkur.narayan@intel.com,
        ravishankar.srivatsa@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <C856D5A5-3B2D-4DCE-BA10-E03BEBF5A3DB@holtmann.org>
References: <20201106092119.20486-1-sathish.narasimman@intel.com>
To:     Sathish Narasimman <sathish.narasimman@intel.com>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

> Latest intel firmware supports TLV structure in operational mode for intel
> read version. so made changes accordingly to support both bootloader
> and operational mode . These changes are only to specific intel bluetooth
> controller for example ThP, CcP.
> 
> Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
> ---
> drivers/bluetooth/btintel.c | 105 +++++++++++++++++++++++++++---------
> drivers/bluetooth/btintel.h |  16 ++++++
> drivers/bluetooth/btusb.c   |  41 ++++++++++----
> 3 files changed, 129 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 88ce5f0ffc4b..67267afc83e1 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -401,31 +401,9 @@ void btintel_version_info_tlv(struct hci_dev *hdev, struct intel_version_tlv *ve
> }
> EXPORT_SYMBOL_GPL(btintel_version_info_tlv);
> 
> -int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *version)
> +static void btintel_parse_tlv(struct sk_buff *skb,
> +			      struct intel_version_tlv *version)
> {
> -	struct sk_buff *skb;
> -	const u8 param[1] = { 0xFF };
> -
> -	if (!version)
> -		return -EINVAL;
> -
> -	skb = __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
> -	if (IS_ERR(skb)) {
> -		bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
> -			   PTR_ERR(skb));
> -		return PTR_ERR(skb);
> -	}
> -
> -	if (skb->data[0]) {
> -		bt_dev_err(hdev, "Intel Read Version command failed (%02x)",
> -			   skb->data[0]);
> -		kfree_skb(skb);
> -		return -EIO;
> -	}
> -
> -	/* Consume Command Complete Status field */
> -	skb_pull(skb, 1);
> -
> 	/* Event parameters contatin multiple TLVs. Read each of them
> 	 * and only keep the required data. Also, it use existing legacy
> 	 * version field like hw_platform, hw_variant, and fw_variant
> @@ -496,6 +474,85 @@ int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *ver
> 		/* consume the current tlv and move to next*/
> 		skb_pull(skb, tlv->len + sizeof(*tlv));
> 	}
> +}
> +
> +int btintel_read_version_new(struct hci_dev *hdev, struct btintel_version *ver)
> +{
> +	struct sk_buff *skb;
> +	struct intel_version *version = &ver->ver;
> +	const u8 param[1] = { 0xFF };
> +
> +	skb = __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		bt_dev_err(hdev, "Reading Intel version info failed (%ld)",
> +			   PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +
> +	if (skb->data[0]) {
> +		bt_dev_err(hdev, "Intel Read Version command failed (%02x)",
> +			   skb->data[0]);
> +		kfree_skb(skb);
> +		return -EIO;
> +	}
> +
> +	/* The new Intel read version is backward compatible for Thp and CcP

isn’t it ThP here?

> +	 * type cards. when the controller is in bootloader mode the controller

Please state a sentence with uppercase.

> +	 * response remains same as old intel_read version. For ThP/CcP cards
> +	 * TLV structure supports only during the Operation Mode. The best way
> +	 * to differentiate the read_version response is to check the length
> +	 * parameter and the first byte of the payload, which is a fixed value.
> +	 * After the status parameter if the payload starts with 0x37(This is
> +	 * a fixed value) and length of the payload is 10 then it is identified
> +	 * as legacy struct intel_version. In the latest firmware the support
> +	 * of TLV structure is added during Operational Firmware.
> +	 */

If in doubt, please run a spell checker over patch.

> +	if (skb->len == sizeof(*version) && skb->data[1] == 0x37) {
> +		memcpy(version, skb->data, sizeof(*version));
> +		ver->tlv_format = false;
> +		goto finish;
> +	}
> +
> +	/* Consume Command Complete Status field */
> +	skb_pull(skb, 1);
> +
> +	ver->tlv_format = true;
> +
> +	bt_dev_info(hdev, "Parsing TLV Supported intel read version");
> +	btintel_parse_tlv(skb, &ver->ver_tlv);
> +
> +finish:
> +	kfree_skb(skb);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(btintel_read_version_new);
> +
> +int btintel_read_version_tlv(struct hci_dev *hdev, struct intel_version_tlv *version)
> +{
> +	struct sk_buff *skb;
> +	const u8 param[1] = { 0xFF };
> +
> +	if (!version)
> +		return -EINVAL;
> +
> +	skb = __hci_cmd_sync(hdev, 0xfc05, 1, param, HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		bt_dev_err(hdev, "Reading Intel version information failed (%ld)",
> +			   PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +
> +	if (skb->data[0]) {
> +		bt_dev_err(hdev, "Intel Read Version command failed (%02x)",
> +			   skb->data[0]);
> +		kfree_skb(skb);
> +		return -EIO;
> +	}
> +
> +	/* Consume Command Complete Status field */
> +	skb_pull(skb, 1);
> +
> +	btintel_parse_tlv(skb, version);
> 
> 	kfree_skb(skb);
> 	return 0;
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index 09346ae308eb..952da44b79de 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -132,6 +132,15 @@ struct intel_debug_features {
> 	__u8    page1[16];
> } __packed;
> 
> +struct btintel_version {
> +	bool tlv_format;
> +	union {
> +		struct intel_version ver; /*Legacy Intel read version*/
> +		struct intel_version_tlv ver_tlv;
> +	};
> +} __packed;
> +

So last time around I said, I don’t like it this way. Now I get the same thing again. Can we please stop trying to hack this into the driver like this.

If we now actually start pushing these change into our firmware, then maybe it would be good to give Linux a heads up that this is changing. Intermixing these kind of firmware “modes” is something that should be designed properly. If not, this driver become unmaintainable and we start seeing bugs after bugs for corner cases that are not tested.

The problem you have to address here is not the Intel Read Version command and trying to fit everything into some magic union struct and add if-clauses everywhere. The problem is that we have now 4 combinations of device initialization that we need to handle correctly (and I am including StP here as well).

Let me try to summarize what we have.

	1) Gen 1 ROM patching with maintainer mode and all the fun around it
	2) Gen 2 RAM firmware loading and static structs bootloader and operational
	3) Gen 2 RAM firmware loading with static struct for bootloader and TLV for operational
	4) Gen 3 RAM firmware loading and TLV for bootloader and operational

Is this correct?

We have to realize that btintel_read_version function is no longer usable as it is. It can also not be extended properly.

What we need is a generic btusb_setup_intel that executes the read version (without any helper), runs basic sanity checks and then segways into legacy, static or TLV versions of firmware loading and operational setup.

Of course there are optimization in the logic for 1) and 4) since you know what the operational handling will be. Nevertheless this needs to be changed now before this grows out of control and we still have users that are testing it and reporting back problems.

To achieve this, pick one hardware (say ThP since it is wildly available) and move it to a new btusb_setup_intel_generic() that does what I described above. Test this with 2) and 3) firmwares to ensure we can handle things correctly.

Actually it might be worth while to build a btvirt that allows us to emulate all Intel controllers boot handling. So that we can have automated intel-tester tool to verify that we don’t break things.

Regards

Marcel


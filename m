Return-Path: <SRS0=pby4=AY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D06CC433E2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 19:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 494F720738
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 19:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgGMTQM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:16:12 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52459 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgGMTQL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jul 2020 15:16:11 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8D9E4CECCD;
        Mon, 13 Jul 2020 21:26:08 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2 3/5] Bluetooth: btintel: Refactor firmware payload
 download code
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200703071212.17046-3-kiran.k@intel.com>
Date:   Mon, 13 Jul 2020 21:16:10 +0200
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        kiraank@gmail.com, Amit K Bag <amit.k.bag@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <87AEDF27-8DE1-4A95-A669-F33BEED91880@holtmann.org>
References: <20200703071212.17046-1-kiran.k@intel.com>
 <20200703071212.17046-3-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> Move firmware payload download code to a separate function to
> enhance readability and reusability
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Reviewed-by: Sathish Narasimman <Sathish.Narasimman@intel.com>
> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
> 
> Changes in v2:
> - Avoid exporting new public function for firmware download
> - Move firmware payload download code to a new function
> Changes in v1:
> - Move firmware payload download code to a new function
> 
> 
> drivers/bluetooth/btintel.c | 22 +++++++++++++++++++---
> 1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index ffc888c4e9e3..2cb55a97598c 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -19,6 +19,7 @@
> #define VERSION "0.1"
> 
> #define BDADDR_INTEL (&(bdaddr_t) {{0x00, 0x8b, 0x9e, 0x19, 0x03, 0x00}})
> +#define RSA_HEADER_LEN	644
> 
> int btintel_check_bdaddr(struct hci_dev *hdev)
> {
> @@ -682,8 +683,9 @@ static int btintel_sfi_rsa_header_secure_send(struct hci_dev *hdev,
> 	return err;
> }
> 
> -int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,
> -			      u32 *boot_param)
> +static int btintel_download_firmware_payload(struct hci_dev *hdev,
> +					     const struct firmware *fw,
> +					     u32 *boot_param, size_t offset)
> {
> 	int err;
> 	const u8 *fw_ptr;
> @@ -693,8 +695,9 @@ int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,
> 	if (err)
> 		goto done;
> 
> -	fw_ptr = fw->data + 644;
> +	fw_ptr = fw->data + offset;
> 	frag_len = 0;
> +	err = -EINVAL;
> 
> 	while (fw_ptr - fw->data < fw->size) {
> 		struct hci_command_hdr *cmd = (void *)(fw_ptr + frag_len);
> @@ -740,6 +743,19 @@ int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,
> done:
> 	return err;
> }
> +
> +int btintel_download_firmware(struct hci_dev *hdev,
> +			      const struct firmware *fw,
> +			      u32 *boot_param)
> +{
> +	int err;
> +
> +	err = btintel_sfi_rsa_header_secure_send(hdev, fw);
> +	if (err)
> +		return err;
> +
> +	return btintel_download_firmware_payload(hdev, fw, boot_param, RSA_HEADER_LEN);
> +}
> EXPORT_SYMBOL_GPL(btintel_download_firmware);
> 
> void btintel_reset_to_bootloader(struct hci_dev *hdev)

can we apply patch 1 and 2 independently from general TLV support? If so, then I would just try to get these two applied right away.

Regards

Marcel


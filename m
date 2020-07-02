Return-Path: <SRS0=k5tg=AN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B012DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 13:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AD9D20672
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 13:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgGBN0B convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:26:01 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:46278 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729335AbgGBN0A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jul 2020 09:26:00 -0400
Received: from marcel-macpro.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 45535CED13;
        Thu,  2 Jul 2020 15:35:53 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 2/5] Bluetooth: btintel: Refactor firmware header download
 sequence
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200702120315.26768-3-kiran.k@intel.com>
Date:   Thu, 2 Jul 2020 15:25:57 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        kiraank@gmail.com, Amit K Bag <amit.k.bag@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <8040CBA1-AF50-43A1-8314-4E44E4F27173@holtmann.org>
References: <20200702120315.26768-1-kiran.k@intel.com>
 <20200702120315.26768-3-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> Move firmware header download code to a separate function to
> enhance readability and reusability
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Reviewed-by: Sathish Narasimman <Sathish.Narasimman@intel.com>
> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
> drivers/bluetooth/btintel.c | 21 +++++++++++++++++----
> 1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index dea96c585ecb..1c820c187421 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -646,12 +646,10 @@ int btintel_read_boot_params(struct hci_dev *hdev,
> }
> EXPORT_SYMBOL_GPL(btintel_read_boot_params);
> 
> -int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,
> -			      u32 *boot_param)
> +static int btintel_sfi_rsa_header_secure_send(struct hci_dev *hdev,
> +					      const struct firmware *fw)
> {
> 	int err;
> -	const u8 *fw_ptr;
> -	u32 frag_len;
> 
> 	/* Start the firmware download transaction with the Init fragment
> 	 * represented by the 128 bytes of CSS header.
> @@ -679,6 +677,21 @@ int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,
> 		bt_dev_err(hdev, "Failed to send firmware signature (%d)", err);
> 		goto done;
> 	}

Here should be an extra empty line before the label.

> +done:
> +	return err;
> +}
> +
> +int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,
> +			      u32 *boot_param)
> +{
> +	int err;
> +	const u8 *fw_ptr;
> +	u32 frag_len;
> +
> +	err = btintel_sfi_rsa_header_secure_send(hdev, fw);
> +	if (err)
> +		goto done;
> +

Scrap the extra empty line here.

> 
> 	fw_ptr = fw->data + 644;
> 	frag_len = 0;

Regards

Marcel


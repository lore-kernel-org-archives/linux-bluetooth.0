Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEB8C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 19:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B6DD60C40
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 19:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhG2Tko convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 15:40:44 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48378 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhG2Tko (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 15:40:44 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id A05D2CED1E;
        Thu, 29 Jul 2021 21:40:39 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v5 11/11] Bluetooth: btintel: Fix the legacy bootloader
 returns tlv based version
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210729183600.281586-12-hj.tedd.an@gmail.com>
Date:   Thu, 29 Jul 2021 21:40:39 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <F95FB44C-1E3B-485A-A373-878768518C6F@holtmann.org>
References: <20210729183600.281586-1-hj.tedd.an@gmail.com>
 <20210729183600.281586-12-hj.tedd.an@gmail.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

> From the ThP, it supports both old and TLV based HCI_Intel_Read_Version
> command after downloading the operational firmware.
> Starting from th JfP, it supports both old and TLV based
> HCI_Intel_Read_Version command in the operational firmware and it causes
> the setup() uses the TLV based setup instead of legacy setup.
> 
> So, as a workaround, this patch checks the fw variant from the TLV based
> version and it uses the legacy HCI_Intel_Read_Version command to get the
> legacy version information and run the legacy bootloader setup with it.
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> drivers/bluetooth/btintel.c | 25 ++++++++++++++++++++++++-
> 1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 57b64d744f0a..f11882d10da7 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2254,10 +2254,33 @@ int btintel_setup_combined(struct hci_dev *hdev)
> 	/* For TLV type device, parse the tlv data */
> 	btintel_parse_version_tlv(hdev, &ver_tlv, skb);
> 
> +	/* Some legacy bootloader devices from JfP supports both old and TLV
> +	 * based HCI_Intel_Read_Version command. But we don't want to use the
> +	 * TLV based setup routines for those old bootloader device.
> +	 * Also, it is not easy to convert TLV based version to the legacy
> +	 * version format.
> +	 *
> +	 * So, as a workaround for those devices, use the legacy
> +	 * HCI_Intel_Read_Version to get the version information and run the
> +	 * legacy bootloader setup.
> +	 */

why is that again? If possible we should convert them. What information is missing from the TLV format that we need?

Regards

Marcel


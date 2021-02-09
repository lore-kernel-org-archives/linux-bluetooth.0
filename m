Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47027C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Feb 2021 13:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 062FF64EDA
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Feb 2021 13:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhBINpK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Feb 2021 08:45:10 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:40556 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbhBINnC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Feb 2021 08:43:02 -0500
Received: from marcel-macbook.holtmann.net (p4ff9f72d.dip0.t-ipconnect.de [79.249.247.45])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5253BCED1F;
        Tue,  9 Feb 2021 14:49:39 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] Bluetooth: btusb: Fallback to 16 bit ROM version lookup
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210209114024.2910-2-falbrechtskirchinger@gmail.com>
Date:   Tue, 9 Feb 2021 14:42:10 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <94DD2143-175D-4FAC-B001-D4F362DC604C@holtmann.org>
References: <20210209114024.2910-1-falbrechtskirchinger@gmail.com>
 <20210209114024.2910-2-falbrechtskirchinger@gmail.com>
To:     Florian Albrechtskirchinger <falbrechtskirchinger@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Florian,

> Commit b40f58b97386 ("Bluetooth: btusb: Add Qualcomm Bluetooth SoC WCN6855
> support") changes ROM version lookup from 16 bit to 32 bit. Previously, the
> upper 16 bit of the version number were ignored. This breaks setups, where the
> upper 16 bits are non-zero, but are now assumed to be zero.
> 
> An example of such a device would be
> 0cf3:3008 Qualcomm Atheros Communications Bluetooth (AR3011)
> with ROM version 0x1020200 and this corresponding entry in the device table:
> { 0x00000200, 28, 4, 16 }, /* Rome 2.0 */
> 
> This patch adds a potential second round of lookups that mimics the old
> behavior, should no version have been matched by comparing the full 32 bits.
> During this second round only the lower 16 bits are compared, but only where
> the upper 16 bits are defined zero in the lookup table.
> 
> Fixes: b40f58b97386 ("Bluetooth: btusb: Add Qualcomm Bluetooth SoC WCN6855
> support")
> 
> Signed-off-by: Florian Albrechtskirchinger <falbrechtskirchinger@gmail.com>
> ---
> drivers/bluetooth/btusb.c | 17 ++++++++++++++++-
> 1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 03b83aa91277..d8c4c6474f14 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4054,6 +4054,7 @@ static int btusb_setup_qca(struct hci_dev *hdev)
> 	const struct qca_device_info *info = NULL;
> 	struct qca_version ver;
> 	u32 ver_rom;
> +	u16 ver_rom_low;
> 	u8 status;
> 	int i, err;
> 
> @@ -4065,8 +4066,22 @@ static int btusb_setup_qca(struct hci_dev *hdev)
> 	ver_rom = le32_to_cpu(ver.rom_version);
> 
> 	for (i = 0; i < ARRAY_SIZE(qca_devices_table); i++) {
> -		if (ver_rom == qca_devices_table[i].rom_version)
> +		if (ver_rom == qca_devices_table[i].rom_version) {
> 			info = &qca_devices_table[i];
> +			break;
> +		}
> +	}
> +	if (!info) {
> +		// If we don't find an exact version match, try with
> +		// the lower half, but only where the upper half is 0

please use correct comment style.

> +		ver_rom_low = ver_rom & 0xffff;
> +		for (i = 0; i < ARRAY_SIZE(qca_devices_table); i++) {
> +			if (!(qca_devices_table[i].rom_version & 0xffff0000) &&
> +			    ver_rom_low == qca_devices_table[i].rom_version) {
> +				info = &qca_devices_table[i];
> +				break;
> +			}
> +		}
> 	}
> 	if (!info) {
> 		bt_dev_err(hdev, "don't support firmware rome 0x%x", ver_rom);

Regards

Marcel


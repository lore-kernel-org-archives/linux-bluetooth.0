Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342F7C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jan 2021 19:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED1D82311B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jan 2021 19:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbhAZFbq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:31:46 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:51657 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730380AbhAYPq3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Jan 2021 10:46:29 -0500
Received: from marcel-macbook.holtmann.net (p4ff9f11c.dip0.t-ipconnect.de [79.249.241.28])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6E68DCECC8;
        Mon, 25 Jan 2021 16:17:50 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH v3] Bluetooth: btrtl: Enable WBS for the specific Realtek
 devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210122015938.964-1-max.chou@realtek.com>
Date:   Mon, 25 Jan 2021 16:10:25 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex_lu@realsil.com.cn, hildawu@realtek.com, kidman@realtek.com,
        abhishekpandit@chromium.org, josephsih@chromium.org
Content-Transfer-Encoding: 7bit
Message-Id: <675B3B14-76DB-4748-811C-AA98848EA30E@holtmann.org>
References: <20210122015938.964-1-max.chou@realtek.com>
To:     Max Chou <max.chou@realtek.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Max,

> By this change, it will enable WBS supported on the specific Realtek BT
> devices, such as RTL8822C and RTL8852A.
> In the future, it's able to maintain what the Realtek devices support WBS
> here.
> 
> Tested-by: Hilda Wu <hildawu@realtek.com>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Signed-off-by: Max Chou <max.chou@realtek.com>
> 
> ---
> change in v3
> -remove the null check due to unnecessary
> ---
> drivers/bluetooth/btrtl.c | 29 +++++++++++++++++++++++------
> 1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 24f03a1f8d57..a21d6abc93c4 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -38,6 +38,19 @@
> 	.hci_ver = (hciv), \
> 	.hci_bus = (bus)
> 
> +enum  btrtl_chip_id {

remove the extra space here.

> +	CHIP_ID_8723A,		/* index  0 for RTL8723A*/
> +	CHIP_ID_8723B,		/* index  1 for RTL8723B*/
> +	CHIP_ID_8821A,		/* index  2 for RTL8821A*/
> +	CHIP_ID_8761A,		/* index  3 for RTL8761A*/
> +	CHIP_ID_8822B = 8,	/* index  8 for RTL8822B */
> +	CHIP_ID_8723D,		/* index  9 for RTL8723D */
> +	CHIP_ID_8821C,		/* index 10 for RTL8821C */
> +	CHIP_ID_8822C = 13,	/* index 13 for RTL8822C */
> +	CHIP_ID_8761B,		/* index 14 for RTL8761B */
> +	CHIP_ID_8852A = 18,	/* index 18 for RTL8852A */
> +};
> +
> struct id_table {
> 	__u16 match_flags;
> 	__u16 lmp_subver;
> @@ -58,6 +71,7 @@ struct btrtl_device_info {
> 	u8 *cfg_data;
> 	int cfg_len;
> 	bool drop_fw;
> +	int project_id;
> };
> 
> static const struct id_table ic_id_table[] = {
> @@ -307,8 +321,10 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
> 
> 	/* Find project_id in table */
> 	for (i = 0; i < ARRAY_SIZE(project_id_to_lmp_subver); i++) {
> -		if (project_id == project_id_to_lmp_subver[i].id)
> +		if (project_id == project_id_to_lmp_subver[i].id) {
> +			btrtl_dev->project_id = project_id;
> 			break;
> +		}
> 	}
> 
> 	if (i >= ARRAY_SIZE(project_id_to_lmp_subver)) {
> @@ -719,18 +735,19 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
> 	 */
> 	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
> 
> -	if (!btrtl_dev->ic_info)
> -		goto done;
> -
> 	/* Enable central-peripheral role (able to create new connections with
> 	 * an existing connection in slave role).
> 	 */
> -	switch (btrtl_dev->ic_info->lmp_subver) {
> -	case RTL_ROM_LMP_8822B:
> +	/* Enable WBS supported for the specific Realtek devices. */
> +	switch (btrtl_dev->project_id) {
> +	case CHIP_ID_8822C:
> +	case CHIP_ID_8852A:
> 		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
> +		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
> 		break;
> 	default:
> 		rtl_dev_dbg(hdev, "Central-peripheral role not enabled.");
> +		rtl_dev_dbg(hdev, "WBS supported not enabled.");
> 		break;
> 	}

Regards

Marcel


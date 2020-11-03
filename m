Return-Path: <SRS0=oxy1=EJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E5AC4742C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Nov 2020 02:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFD202067C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Nov 2020 02:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgKCCbM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Nov 2020 21:31:12 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:49565 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgKCCbL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Nov 2020 21:31:11 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0A32UwyE6012810, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0A32UwyE6012810
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 3 Nov 2020 10:30:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.33) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Tue, 3 Nov 2020 10:30:58 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.34) by
 RTEXMBS04.realtek.com.tw (172.21.6.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 3 Nov 2020 10:30:57 +0800
Received: from RTEXMBS03.realtek.com.tw ([::1]) by RTEXMBS03.realtek.com.tw
 ([fe80::1416:4382:69d3:e2f0%16]) with mapi id 15.01.2106.002; Tue, 3 Nov 2020
 10:30:57 +0800
From:   Max Chou <max.chou@realtek.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        alex_lu <alex_lu@realsil.com.cn>
CC:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] Bluetooth: btrtl: Ask 8821C to drop old firmware
Thread-Topic: [PATCH v2] Bluetooth: btrtl: Ask 8821C to drop old firmware
Thread-Index: AQHWq3IJ1OecwEeK006ZXNvRfZFhwKm0XDyAgAFfVzA=
Date:   Tue, 3 Nov 2020 02:30:57 +0000
Message-ID: <9f663bf0e4ce4101b688127de088d477@realtek.com>
References: <20201026082838.26532-1-kai.heng.feng@canonical.com>
 <1A6AB99C-425D-42D5-B1F4-818AD7525F53@canonical.com>
In-Reply-To: <1A6AB99C-425D-42D5-B1F4-818AD7525F53@canonical.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.132.163]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear guys,
I agree this patch.


BRs,
Max


-----Original Message-----
From: Kai-Heng Feng <kai.heng.feng@canonical.com> 
Sent: Monday, November 2, 2020 9:33 PM
To: Max Chou <max.chou@realtek.com>; alex_lu <alex_lu@realsil.com.cn>
Cc: Marcel Holtmann <marcel@holtmann.org>; Johan Hedberg <johan.hedberg@gmail.com>; open list:BLUETOOTH DRIVERS <linux-bluetooth@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] Bluetooth: btrtl: Ask 8821C to drop old firmware

> On Oct 26, 2020, at 16:28, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> Some platforms keep USB power even when they are powered off and in 
> S5, this makes Realtek 8821C keep its firmware even after a cold boot, 
> and make 8821C never load new firmware.
> 
> So use vendor specific HCI command to ask 8821C drop its firmware 
> after system shutdown.
> 
> Newer firmware doesn't have this issue so we only use this trick for 
> old 8821C firmware version.
> 
> Suggested-by: Max Chou <max.chou@realtek.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Max and Alex,

Can you please ack or review the patch?

Kai-Heng

> ---
> v2:
> - Fix incorrect parAnthesis on le16_to_cpu.
> - Ensure firmware gets re-uploaded in initialization.
> 
> drivers/bluetooth/btrtl.c | 46 +++++++++++++++++++++++++++++++++++++++
> 1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c 
> index 3a9afc905f24..37e24bbb2eb4 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -55,6 +55,7 @@ struct btrtl_device_info {
> 	int fw_len;
> 	u8 *cfg_data;
> 	int cfg_len;
> +	bool drop_fw;
> };
> 
> static const struct id_table ic_id_table[] = { @@ -563,6 +564,8 @@ 
> struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
> 	u16 hci_rev, lmp_subver;
> 	u8 hci_ver;
> 	int ret;
> +	u16 opcode;
> +	u8 cmd[2];
> 
> 	btrtl_dev = kzalloc(sizeof(*btrtl_dev), GFP_KERNEL);
> 	if (!btrtl_dev) {
> @@ -584,6 +587,49 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
> 	hci_ver = resp->hci_ver;
> 	hci_rev = le16_to_cpu(resp->hci_rev);
> 	lmp_subver = le16_to_cpu(resp->lmp_subver);
> +
> +	if (resp->hci_ver == 0x8 && le16_to_cpu(resp->hci_rev) == 0x826c &&
> +	    resp->lmp_ver == 0x8 && le16_to_cpu(resp->lmp_subver) == 0xa99e)
> +		btrtl_dev->drop_fw = true;
> +
> +	if (btrtl_dev->drop_fw) {
> +		opcode = hci_opcode_pack(0x3f, 0x66);
> +		cmd[0] = opcode & 0xff;
> +		cmd[1] = opcode >> 8;
> +
> +		skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
> +		if (IS_ERR(skb))
> +			goto out_free;
> +
> +		skb_put_data(skb, cmd, sizeof(cmd));
> +		hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
> +
> +		hdev->send(hdev, skb);
> +
> +		/* Ensure the above vendor command is sent to controller and
> +		 * process has done.
> +		 */
> +		msleep(200);
> +
> +		/* Read the local version again. Expect to have the vanilla
> +		 * version as cold boot.
> +		 */
> +		skb = btrtl_read_local_version(hdev);
> +		if (IS_ERR(skb)) {
> +			ret = PTR_ERR(skb);
> +			goto err_free;
> +		}
> +
> +		resp = (struct hci_rp_read_local_version *)skb->data;
> +		rtl_dev_info(hdev, "examining hci_ver=%02x hci_rev=%04x lmp_ver=%02x lmp_subver=%04x",
> +			     resp->hci_ver, resp->hci_rev,
> +			     resp->lmp_ver, resp->lmp_subver);
> +
> +		hci_ver = resp->hci_ver;
> +		hci_rev = le16_to_cpu(resp->hci_rev);
> +		lmp_subver = le16_to_cpu(resp->lmp_subver);
> +	}
> +out_free:
> 	kfree_skb(skb);
> 
> 	btrtl_dev->ic_info = btrtl_match_ic(lmp_subver, hci_rev, hci_ver,
> --
> 2.17.1
> 


------Please consider the environment before printing this e-mail.

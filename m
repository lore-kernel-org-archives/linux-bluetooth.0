Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AA2C4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Nov 2022 17:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbiKSRAY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Nov 2022 12:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKSRAX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Nov 2022 12:00:23 -0500
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A771DF8A
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Nov 2022 09:00:21 -0800 (PST)
Date:   Sat, 19 Nov 2022 17:00:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=33yhficswjcszmm2xye2f7ecgi.protonmail; t=1668877216; x=1669136416;
        bh=rletqYHCgrYj0O2Pfa66FWX/W7KHEt6blcjtxRaV2n8=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=kHuBSPWDcZEVAYPjKPu77mH2nV9bjySCzhMjPSQ52VtAcGMnhx/tMEVcFxMVY5LGe
         wmn0mIehzRAVPVHr+Y2tK14RTVstSH1+iMFCUwVrdyJbo0bXIdCxTRvRqQuB08xGOp
         oluOyw6ic+e9dwmId1Jmwr8fGibfhRhB2Mcu4BYLgudIO/wAQJHrGLnnv7KKxqIM/D
         ocQJbzqeRtMcRzm+hmjs1KctorGih9lxUbWrc+HnHesvLzGB5C2vtzilUbDyo5ymdA
         aElgPPbuz1G0399tDsjPx4CoW4e93m1ZFOyZs47NakR+vmMumPpIqV/pHqq67lMDc+
         rQJm6mSA2Q5xA==
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>
From:   Mihir Khatri <MihirKhatri@proton.me>
Subject: [PATCH] btusb: HCI_QUICK_NO_SUSPEND_NOTIFIER causes kernel panic
Message-ID: <zEEbuiH5Idm8MyWzcjDThSGXk1jtLq8YxNQPGtHSClFG3F-22Zb3kYwj_IR_YVLszbAnWC-9cqTvWS-RjiZHlNqX8Ftduyy6fwIL8iDHkns=@proton.me>
Feedback-ID: 62013127:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It seems that setting the bit HCI_QUICK_NO_SUSPEND_NOTIFIER on some fake CS=
R 5.0 clones can them to get registered 2 times causing a kernel panic. Aft=
er not setting the bit HCI_QUICK_NO_SUSPEND_NOTIFIER everything works fine =
and no kernel panic can be observed.

Signed-off-by: Mihir Khatri <MihirKhatri@proton.me>

---

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e7914783d29e..1bb8d0f2e8b8 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2267,7 +2267,6 @@ static int btusb_setup_csr(struct hci_dev *hdev)
                set_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY, &hdev->quirks);
                set_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->quirks)=
;
                set_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks);
-               set_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks);
=20
                /* Clear the reset quirk since this is not an actual
                 * early Bluetooth 1.1 device from CSR.


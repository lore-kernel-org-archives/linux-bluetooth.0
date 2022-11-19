Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A23DC433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Nov 2022 18:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbiKSSHb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Nov 2022 13:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiKSSHa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Nov 2022 13:07:30 -0500
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD023C45
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Nov 2022 10:07:28 -0800 (PST)
Date:   Sat, 19 Nov 2022 18:07:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1668881243; x=1669140443;
        bh=gudxiCCMMQR2wR811CFizNqqpRdnnwgp2LzciDQFvOg=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=Nw5aZNcfsgWzUuylD8fEChUgkNbSpTxIc7m3NMcaRFLDFhMzyXW2Z/+FqP7RBXxjx
         OGW3XBvkdlhkId9/5Fn+OFMPUrrxN1EpaPEgQ0Td3hqnAsGF8ymvPQegoBLie51ZYo
         XOjrY2gGSzpUzpr8a95zVZBcUskheMExrYsU5+eeQ/rHyhn1pAy57s20ZjNg3CquS+
         oSt4Dc68anNVZVdxgYhxFL4F5p220GS4CO3Tmus1tsCgxKUscRzf3TwDiWEI2fWev0
         V2Pui8nwHIoCjqbbzUWgUrE80mCaniVwJgcnzE2JDSk26D78GzB3VX0QpkFEy8eXfi
         14SioBJSrJeLg==
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>
From:   Mihir Khatri <MihirKhatri@proton.me>
Subject: [PATCH] Bluetooth: btusb HCI_QUIRK_NO_SUSPEND_NOTIFIER causes kernel panic on CSR 5.0 clones
Message-ID: <CecyZdAwliTFqNWeZYcBef--uL7SBwD_JGjv1i4pxjQPSDNpheMorDHT2dAiFVvcZbO2afBLIVjbE52fcUYLWtEroa68AkhM5GdJLHEsQ6c=@proton.me>
Feedback-ID: 62013127:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It seems that setting the bit HCI_QUICK_NO_SUSPEND_NOTIFIER
on some fake CSR 5.0 clones can them to get registered 2 times
causing a kernel panic. After not setting the bit HCI_QUICK_NO_SUSPEND_NOTI=
FIER
everything works fine and no kernel panic can be observed.

Signed-off-by: Mihir Khatri <MihirKhatri@proton.me>

---

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e7914783d29e..f0d0224ca59e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2267,8 +2267,7 @@ static int btusb_setup_csr(struct hci_dev *hdev)
                set_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY, &hdev->quirks);
                set_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->quirks)=
;
                set_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks);
-               set_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks);
                         =20
                /* Clear the reset quirk since this is not an actual
                 * early Bluetooth 1.1 device from CSR.
                 */


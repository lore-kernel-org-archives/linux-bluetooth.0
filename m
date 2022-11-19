Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9774AC4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Nov 2022 18:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbiKSSyj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Nov 2022 13:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiKSSyi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Nov 2022 13:54:38 -0500
X-Greylist: delayed 6858 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 19 Nov 2022 10:54:36 PST
Received: from mail-40137.protonmail.ch (mail-40137.protonmail.ch [185.70.40.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AF71A054
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Nov 2022 10:54:36 -0800 (PST)
Date:   Sat, 19 Nov 2022 18:54:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1668884073; x=1669143273;
        bh=Dt0SDfDHbF+PZoG/fUOGTm7Y9KCvpFvmzfutc/tye3U=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=F6FVxnTbL5oBqAh58I+/ntPuKFk66y7C52I/CJzRS00JM8GFv6n399n5dEBpFRYTG
         LareGvVtIyhNy0SuYXwNIctQ5/z8zS6AYqSfk45wrfIvjnuSmqCwC9qQpipfvLPDFB
         FqR4TrXlhnNEBspFFG58+VwaaxCAR6ZTp5jAXoDMx+qP/feMs+avyQq6M8swe3ceGo
         EnIH1Tds5zKK8CELs2FyDxUR57j+0K17NqCmqrzCr1nUq+kMFXHPniHOHWbycAVz+E
         XxJSFpPR8F+K++VkYOPCMiSSwrGhRB9yG+E7YknCyDQWRRu+3Ek14VjI55d39vzi/5
         02RckQKHPj+Sg==
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>
From:   Mihir Khatri <MihirKhatri@proton.me>
Subject: [PATCH] Bluetooth: btusb HCI_QUIRK_NO_SUSPEND_NOTIFIER causes kernel panic on CSR 5.0 clones
Message-ID: <ehYYBNwlU_5Z9W9Wzl5scfuMSmrs_K_s9vKb0M7nVP5JPgTDJB1q1rrnPCoXbxtirqiG5jy98alelPr2zWh_0BsZDpMLEiMOPfUbwAZ_pWg=@proton.me>
Feedback-ID: 62013127:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It seems that setting the bit HCI_QUICK_NO_SUSPEND_NOTIFIER
on some fake CSR 5.0 clones can them to get=20
registered 2 times causing a kernel panic. After not setting
the bit HCI_QUICK_NO_SUSPEND_NOTIFIER everything works fine=20
and no kernel panic can be observed.

---
 drivers/bluetooth/btusb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e7914783d29e..1bb8d0f2e8b8 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2267,7 +2267,6 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 =09=09set_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY, &hdev->quirks);
 =09=09set_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->quirks);
 =09=09set_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks);
-=09=09set_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks);
=20
 =09=09/* Clear the reset quirk since this is not an actual
 =09=09 * early Bluetooth 1.1 device from CSR.
--=20
2.38.1

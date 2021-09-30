Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D75C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 14:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A15C61268
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 14:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351800AbhI3OPs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Sep 2021 10:15:48 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:46414 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240149AbhI3OPq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Sep 2021 10:15:46 -0400
Date:   Thu, 30 Sep 2021 14:13:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1633011240;
        bh=SKiqC0vYIWy4echhG6w2Xl9hrL12Zgq/Z/lU6fDKHW4=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=aru8gaDrHxFdIk3jKlURKD4jTHxAOo3vsGPtXj71HwDKUNVAtiiksjbfkfrETokVz
         hRmLMcFwTxOlCLlg52Rq/bl1bfwYTnvJD7ILcJvqsd6dhH7Deq5Oh6nVxdsAFSqrGZ
         oFKihfmNYbZlcNGYL5r4gl1EgGJtLLneCiomS3EY=
To:     redecorating@protonmail.com
From:   Orlando Chamberlain <redecorating@protonmail.com>
Cc:     danielwinkler@google.com, johan.hedberg@intel.com,
        linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        regressions@lists.linux.dev, sonnysasaka@chromium.org,
        linux-kernel@vger.kernel.org
Reply-To: Orlando Chamberlain <redecorating@protonmail.com>
Subject: [PATCH] Bluetooth: add quirk disabling query LE tx power
Message-ID: <20210930141256.19943-1-redecorating@protonmail.com>
In-Reply-To: <20210930063106.19881-1-redecorating@protonmail.com>
References: <4970a940-211b-25d6-edab-21a815313954@protonmail.com> <20210930063106.19881-1-redecorating@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Querying LE tx power on startup broke Bluetooth on some Broadcom chips
in Apple computers (at least MacBookPro16,1 and iMac20,1). Added a quirk
disabling this query for affected devices, based off their common chip
id 150. Affected devices will not be able to query LE tx power, however
they were not doing this before.

Fixes: 7c395ea521e6m ("Bluetooth: Query LE tx power on startup")
Signed-off-by: Orlando Chamberlain <redecorating@protonmail.com>
---
 drivers/bluetooth/btbcm.c   | 4 ++++
 include/net/bluetooth/hci.h | 8 ++++++++
 net/bluetooth/hci_core.c    | 3 ++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index e4182acee488..4ecc50d93107 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -353,6 +353,10 @@ static int btbcm_read_info(struct hci_dev *hdev)
 =09=09return PTR_ERR(skb);
=20
 =09bt_dev_info(hdev, "BCM: chip id %u", skb->data[1]);
+
+=09if (skb->data[1] =3D=3D 150)
+=09=09set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks);
+
 =09kfree_skb(skb);
=20
 =09/* Read Controller Features */
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index b80415011dcd..5e0dd0c39ade 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -246,6 +246,14 @@ enum {
 =09 * HCI after resume.
 =09 */
 =09HCI_QUIRK_NO_SUSPEND_NOTIFIER,
+
+=09/*
+=09 * When this quirk is set, LE tx power is not queried on startup.
+=09 *
+=09 * This quirk can be set before hci_register_dev is called or
+=09 * during the hdev->setup vendor callback.
+=09 */
+=09HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER,
 };
=20
 /* HCI device flags */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8a47a3017d61..16e39739c662 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -742,7 +742,8 @@ static int hci_init3_req(struct hci_request *req, unsig=
ned long opt)
 =09=09=09hci_req_add(req, HCI_OP_LE_READ_ADV_TX_POWER, 0, NULL);
 =09=09}
=20
-=09=09if (hdev->commands[38] & 0x80) {
+=09=09if (hdev->commands[38] & 0x80 &&
+=09=09=09!test_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks)) {
 =09=09=09/* Read LE Min/Max Tx Power*/
 =09=09=09hci_req_add(req, HCI_OP_LE_READ_TRANSMIT_POWER,
 =09=09=09=09    0, NULL);
--=20
2.33.0



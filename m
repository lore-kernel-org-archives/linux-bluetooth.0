Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43E4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 08:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A925D613A7
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Oct 2021 08:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352768AbhJAIiT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Oct 2021 04:38:19 -0400
Received: from mail-4325.protonmail.ch ([185.70.43.25]:38269 "EHLO
        mail-4325.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhJAIiK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Oct 2021 04:38:10 -0400
Date:   Fri, 01 Oct 2021 08:36:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1633077382;
        bh=R70czlvvk3XDeVB9oVaPPYq0I5725a5+YjSYUTpQ7+s=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=qn4gHqOzKzYNuBxxRQp4214pq069o7QXUO95qxqlv6crz5SZ+eS7w2eRreRrThLvt
         bNAp7JX3WwQTdHcylAV4fbHwMww6L1PPoG8N7CWVvdEseVslf9Qv3xk7eRUivKzFmK
         6rkqHq4urGgYJc+EyJWWe8WZyuyJLtHThUGG+Mpk=
To:     redecorating@protonmail.com
From:   Orlando Chamberlain <redecorating@protonmail.com>
Cc:     danielwinkler@google.com, johan.hedberg@intel.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, regressions@lists.linux.dev,
        sonnysasaka@chromium.org
Reply-To: Orlando Chamberlain <redecorating@protonmail.com>
Subject: [PATCHv2] Bluetooth: quirk disabling LE Read Transmit Power
Message-ID: <20211001083412.3078-1-redecorating@protonmail.com>
In-Reply-To: <275acce4-9eab-9cba-7145-5a75a69ca530@protonmail.com>
References: <4970a940-211b-25d6-edab-21a815313954@protonmail.com> <20210930063106.19881-1-redecorating@protonmail.com> <20210930141256.19943-1-redecorating@protonmail.com> <FA02CDD7-CFEC-4481-9940-BA95D81FD3F3@holtmann.org> <275acce4-9eab-9cba-7145-5a75a69ca530@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The LE Read Transmit Power command is Advertised on some Broadcom
controlers, but not supported. Using this command breaks Bluetooth
on the MacBookPro16,1 and iMac20,1. Added a quirk disabling LE Read
Transmit Power for these devices, based off their common chip id 150.

Link: https://lore.kernel.org/r/4970a940-211b-25d6-edab-21a815313954@proton=
mail.com
Signed-off-by: Orlando Chamberlain <redecorating@protonmail.com>
---
v1->v2: Clarified quirk description

 drivers/bluetooth/btbcm.c   |  4 ++++
 include/net/bluetooth/hci.h | 11 +++++++++++
 net/bluetooth/hci_core.c    |  3 ++-
 3 files changed, 17 insertions(+), 1 deletion(-)

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
index b80415011dcd..6da9bd6b7259 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -246,6 +246,17 @@ enum {
 =09 * HCI after resume.
 =09 */
 =09HCI_QUIRK_NO_SUSPEND_NOTIFIER,
+
+=09/* When this quirk is set, LE Read Transmit Power is disabled.
+=09 * This is mainly due to the fact that the HCI LE Read Transmit
+=09 * Power command is advertised, but not supported; these
+=09 * controllers often reply with unknown command and need a hard
+=09 * reset.
+=09 *
+=09 * This quirk can be set before hci_register_dev is called or
+=09 * during the hdev->setup vendor callback.
+=09 */
+=09HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER,
 };
=20
 /* HCI device flags */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8a47a3017d61..9a23fe7c8d67 100644
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



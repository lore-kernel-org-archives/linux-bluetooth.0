Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C17C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 06:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2AC4615E1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 06:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348053AbhI3Gex (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Sep 2021 02:34:53 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:57981 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbhI3Gew (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Sep 2021 02:34:52 -0400
Date:   Thu, 30 Sep 2021 06:32:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1632983587;
        bh=hCJzelxpI/8EEO8zQFRfUJi7q3yxmz/nJ845rrtiffk=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=d2ZQD/ToxtGp2b3t5P1J4EZF4GKjmjzTsUwVj1dCEbBiDBzoSctY+o+JANb2EiRaS
         IfOALQna9PleJcFvuvpGGyMoQPegX6hv+6Ua/QqSaTXNDGYRbCkHbZ9CU1k9i/cWD4
         WBYTRRo/6efNH7ZoeiRbUHsU3vSQPn+nWGK4fBBA=
To:     redecorating@protonmail.com
From:   Orlando Chamberlain <redecorating@protonmail.com>
Cc:     danielwinkler@google.com, johan.hedberg@intel.com,
        linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        regressions@lists.linux.dev, sonnysasaka@chromium.org
Reply-To: Orlando Chamberlain <redecorating@protonmail.com>
Subject: Re: [regression] Bluetooth: Query LE tx power on startup broke Bluetooth on MacBookPro16,1
Message-ID: <20210930063106.19881-1-redecorating@protonmail.com>
In-Reply-To: <4970a940-211b-25d6-edab-21a815313954@protonmail.com>
References: <4970a940-211b-25d6-edab-21a815313954@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I've realised that thunderbird has added empty lines between each line in m=
y
previous email, but here's the same patch I sent before that adds a quirk
disabling querying LE tx power for affected controllers, but this time
without the aforementioned extra empty lines (I'm using git send-email now)=
.

---
 drivers/bluetooth/btbcm.c   | 4 ++++
 include/net/bluetooth/hci.h | 9 +++++++++
 net/bluetooth/hci_core.c    | 3 ++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index e4182acee488..4ecc50d93107 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -353,6 +353,10 @@ static int btbcm_read_info(struct hci_dev *hdev)
 =09=09return PTR_ERR(skb);

 =09bt_dev_info(hdev, "BCM: chip id %u", skb->data[1]);
+
+=09if (skb->data[1] =3D=3D 150)
+=09=09set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks);
+
 =09kfree_skb(skb);

 =09/* Read Controller Features */
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index b80415011dcd..9ce46cb8564d 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -246,6 +246,15 @@ enum {
 =09 * HCI after resume.
 =09 */
 =09HCI_QUIRK_NO_SUSPEND_NOTIFIER,
+
+=09/*
+=09 * When this quirk is set, LE tx power is not queried on startup
+=09 * and the min/max tx power values default to HCI_TX_POWER_INVALID.
+=09 *
+=09 * This quirk can be set before hci_register_dev is called or
+=09 * during the hdev->setup vendor callback.
+=09 */
+=09HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER,
 };

 /* HCI device flags */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8a47a3017d61..9a23fe7c8d67 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -742,7 +742,8 @@ static int hci_init3_req(struct hci_request *req, unsig=
ned long opt)
 =09=09=09hci_req_add(req, HCI_OP_LE_READ_ADV_TX_POWER, 0, NULL);
 =09=09}

-=09=09if (hdev->commands[38] & 0x80) {
+=09=09if (hdev->commands[38] & 0x80 &&
+=09    =09!test_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks)) =
{
 =09=09=09/* Read LE Min/Max Tx Power*/
 =09=09=09hci_req_add(req, HCI_OP_LE_READ_TRANSMIT_POWER,
 =09=09=09=09    0, NULL);
--
2.33.0


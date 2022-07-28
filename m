Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0063C04A68
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jul 2022 21:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiG1VGC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Jul 2022 17:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiG1VGB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Jul 2022 17:06:01 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333451C139
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Jul 2022 14:06:00 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 6so2448601pgb.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Jul 2022 14:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PPJVpWJ09MC5tGsRIBjIrwQ/efJoeRRc/GZpqbHs9tg=;
        b=bDiqtp8TQkaK5BkYVgH/tEpAoHtxjRH+4bYifXoO6bTRUCRicCoNp2CKRi5/dvDo3R
         RGiqSjZM+zsDy1MBCKEGAoYgFch5c74ddr+Nrl0KPBGmzXLvIOJ8pp6WTfsML/xhpr8Y
         +kH3Tn+L18eYtEGvXmr/12ldqCX7s3v1CWk2XL4BsRy2tV5acEom22IfzpLt1m4L22/U
         AHl/dYXsM0dvQas53ARoed+ZNc1P6HhAMIDvNYNPT3AyCFIluYeKTgQW3+PATCIevM1v
         T0hojqCRb7NBKY4wZbBW/qpESVpNlBSnv5sOZB389cfVW8EHCM78s96b/0bqbzMzr58n
         THWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PPJVpWJ09MC5tGsRIBjIrwQ/efJoeRRc/GZpqbHs9tg=;
        b=ORDtPXo4XLIG5/7k4exyWKnakyONhO7zmySBi+RyVH7keiCmS2Nch2j5kT1G81l9+h
         rArf97QOFQqzy0W5+NLfW1f5wc0nRVSioD4eguMTMbk/E86nkgsVV02ETCy873EJbuKy
         zQl3mtZ9Ok3DdimdAew7/O6KjHMUNnkDH7yJ2SycC9oXUQzYZvUpZa2R3XiFG5BjgEHD
         1GRWESXCa1fe73V2d0S7wzJhnMWvMy230L8qtKfo5wt2kQ3tsOIiSm6XCOPZhJqxqQ+F
         +6VzoZu/AZkta9Ll0+kZsLiL/q1jtefApndrmxLETWM5rfjOxvd/+LMPmNHJDU8A1CKy
         ORcw==
X-Gm-Message-State: AJIora/YDmDQzggXoTz6vzB0pnZr9GYdBH7YMEsEMXgzK2gt1sd643+t
        ZyfWi+pI/mTRN/FAwGutTUfx3kC31uALPw==
X-Google-Smtp-Source: AGRyM1vfXTQ8wFYGCFUmU3kZ1t46BLj38oXmptfmeZM3IELLoABRNMdXtM+6vdepsfxjBSwmbKc8KA==
X-Received: by 2002:a63:155f:0:b0:41b:6acb:68b6 with SMTP id 31-20020a63155f000000b0041b6acb68b6mr452920pgv.225.1659042359142;
        Thu, 28 Jul 2022 14:05:59 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b12-20020a1709027e0c00b0016d3a354cffsm1764832plm.89.2022.07.28.14.05.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 14:05:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_conn: Fix updating ISO QoS PHY
Date:   Thu, 28 Jul 2022 14:05:56 -0700
Message-Id: <20220728210556.1236145-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

BT_ISO_QOS has different semantics when it comes to QoS PHY as it uses
0x00 to disable a direction but that value is invalid over HCI and
sockets using DEFER_SETUP to connect may attempt to use hci_bind_cis
multiple times in order to detect if the parameters have changed, so to
fix the code will now just mirror the PHY for the parameters of
HCI_OP_LE_SET_CIG_PARAMS and will not update the PHY of the socket
leaving it disabled.

Fixes: 26afbd826ee32 ("Bluetooth: Add initial implementation of CIS connections")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index f54864e19866..9777e7b109ee 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1551,8 +1551,8 @@ static void cis_add(struct iso_list_data *d, struct bt_iso_qos *qos)
 	cis->cis_id = qos->cis;
 	cis->c_sdu  = cpu_to_le16(qos->out.sdu);
 	cis->p_sdu  = cpu_to_le16(qos->in.sdu);
-	cis->c_phy  = qos->out.phy;
-	cis->p_phy  = qos->in.phy;
+	cis->c_phy  = qos->out.phy ? qos->out.phy : qos->in.phy;
+	cis->p_phy  = qos->in.phy ? qos->in.phy : qos->out.phy;
 	cis->c_rtn  = qos->out.rtn;
 	cis->p_rtn  = qos->in.rtn;
 
@@ -1735,13 +1735,6 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
 	if (!qos->in.latency)
 		qos->in.latency = qos->out.latency;
 
-	/* Mirror PHYs that are disabled as SDU will be set to 0 */
-	if (!qos->in.phy)
-		qos->in.phy = qos->out.phy;
-
-	if (!qos->out.phy)
-		qos->out.phy = qos->in.phy;
-
 	if (!hci_le_set_cig_params(cis, qos)) {
 		hci_conn_drop(cis);
 		return ERR_PTR(-EINVAL);
-- 
2.37.1


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F08C433E6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Jan 2021 21:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAFC564E0F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Jan 2021 21:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhA2Vyv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Jan 2021 16:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbhA2Vye (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Jan 2021 16:54:34 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5247C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jan 2021 13:53:53 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id d8so7172433qvs.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jan 2021 13:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=643acH89VEQHcwpklt23WpkkyT+VYViWWlVx9KgOWxg=;
        b=A39nQ3NCXrgWvJKuWwE39pC017eiMZHvd4Ha7v/EqY8gFO69GT/wc90grQfHqx3ItT
         c8BF7/fPoh6iYMLkskg91h0ltKbXMiYMVJs9qNqJZ13+b3CKkI04OPDKDLh1XHzBzQbZ
         NO+U5CmCVWqAxSykIZk0ymasniaxyzIvq6A7DYsPEX+vLOX1r1V4Szu+vImuZ+Xy2kNI
         eALt5eyGt+oJ17zHAoOe9QQigGq3qIeT+Xp1VPt0c1jvHSgRyiyk+2MzDTHUa7UahaQu
         iMOmmpIhBSdpJwCl04CrEGwOfVIl18I2e/Ni5A5r9wSFbC9ZctRtH4Rd9Wkf21E35hk0
         yynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=643acH89VEQHcwpklt23WpkkyT+VYViWWlVx9KgOWxg=;
        b=csMGfNEIDEq19gH2Ru++dgOvJL4cXrTcWDgnAX9PKOhM0oGvG0oqUUwHSwSuBxldxB
         rtxoqYnfC/nr0mtL34/di9ZdE+6qSPpOljx/PBfobq0IdZEf8lHirMvEInGt0WlUtpar
         NIt+H3skDtts21JYmb4zL3w/fF6IEiQiT2xv9wdhO//wrKBjjKkvSCQdNupxnvm5uoEH
         JWhGc91275pdLS34YVQJCFgcsq4bqxTDMi6ZoTajbcp67a3hRoor6ND3X5zFvJywGxkJ
         UM10vUDjbcGFgCH12yayE5c9NP6fAnEImiQLAUTvQG5gzwjIEL4exHCrdoJkEM6EQSCU
         SllA==
X-Gm-Message-State: AOAM530PmHXuNIXKFOmrEH8YC3m4TzflsgyeGBLpVcnVsTy3Fo5bx1Ek
        eejwXc5EZ72P9s9SlCB1WH2r2Ec4TtE6WmBky9FEndj+GD/WQGlyqx/v36Js19h+200iU6E2Ak+
        vDaAUIu8eNNs678b7JxlZWGuVcZ/egp024UZFitdNmgaSKR6y3tO1AEfZ8sQUhf+qCzyFUOItWM
        rP
X-Google-Smtp-Source: ABdhPJymqJsHfHIw67ec9A1GAbW++LidCddf125yLwXpufjJpvhcA1WKAG3uIasXbN2ErspKFfs4Om4Vb/sq
Sender: "yudiliu via sendgmr" <yudiliu@yudiliu.mtv.corp.google.com>
X-Received: from yudiliu.mtv.corp.google.com ([2620:15c:202:201:8edc:d4ff:fe53:2823])
 (user=yudiliu job=sendgmr) by 2002:a0c:b4a8:: with SMTP id
 c40mr5970799qve.60.1611957232807; Fri, 29 Jan 2021 13:53:52 -0800 (PST)
Date:   Fri, 29 Jan 2021 13:53:48 -0800
Message-Id: <20210129135322.v3.1.I7d3819e3c406b20307a56fe96159e8f842f72d89@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v3] Bluetooth: Skip eSCO 2M params when not supported
From:   Yu Liu <yudiliu@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        chromeos-bluetooth-upstreaming@chromium.org
Cc:     Yu Liu <yudiliu@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If a peer device doesn't support eSCO 2M we should skip the params that
use it when setting up sync connection since they will always fail.

Signed-off-by: Yu Liu <yudiliu@google.com>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v3:
- Use pkt_type instead of adding new field

Changes in v2:
- Fix title

Changes in v1:
- Initial change

 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_conn.c         | 20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 239ab72f16c6e..71468a9ea798a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1237,6 +1237,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define lmp_le_capable(dev)        ((dev)->features[0][4] & LMP_LE)
 #define lmp_sniffsubr_capable(dev) ((dev)->features[0][5] & LMP_SNIFF_SUBR)
 #define lmp_pause_enc_capable(dev) ((dev)->features[0][5] & LMP_PAUSE_ENC)
+#define lmp_esco_2m_capable(dev)   ((dev)->features[0][5] & LMP_EDR_ESCO_2M)
 #define lmp_ext_inq_capable(dev)   ((dev)->features[0][6] & LMP_EXT_INQ)
 #define lmp_le_br_capable(dev)     (!!((dev)->features[0][6] & LMP_SIMUL_LE_BR))
 #define lmp_ssp_capable(dev)       ((dev)->features[0][6] & LMP_SIMPLE_PAIR)
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 07c34c55fc508..357ce0cfbc5c9 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -278,6 +278,20 @@ static void hci_add_sco(struct hci_conn *conn, __u16 handle)
 	hci_send_cmd(hdev, HCI_OP_ADD_SCO, sizeof(cp), &cp);
 }
 
+static bool find_next_esco_param(struct hci_conn *conn,
+				 const struct sco_param *esco_param, int size)
+{
+	for (; conn->attempt <= size; conn->attempt++) {
+		if (lmp_esco_2m_capable(conn->link) ||
+		    (esco_param[conn->attempt - 1].pkt_type & ESCO_2EV3))
+			break;
+		BT_DBG("hcon %p skipped attempt %d, eSCO 2M not supported",
+		       conn, conn->attempt);
+	}
+
+	return conn->attempt <= size;
+}
+
 bool hci_setup_sync(struct hci_conn *conn, __u16 handle)
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -299,13 +313,15 @@ bool hci_setup_sync(struct hci_conn *conn, __u16 handle)
 
 	switch (conn->setting & SCO_AIRMODE_MASK) {
 	case SCO_AIRMODE_TRANSP:
-		if (conn->attempt > ARRAY_SIZE(esco_param_msbc))
+		if (!find_next_esco_param(conn, esco_param_msbc,
+					  ARRAY_SIZE(esco_param_msbc)))
 			return false;
 		param = &esco_param_msbc[conn->attempt - 1];
 		break;
 	case SCO_AIRMODE_CVSD:
 		if (lmp_esco_capable(conn->link)) {
-			if (conn->attempt > ARRAY_SIZE(esco_param_cvsd))
+			if (!find_next_esco_param(conn, esco_param_cvsd,
+						  ARRAY_SIZE(esco_param_cvsd)))
 				return false;
 			param = &esco_param_cvsd[conn->attempt - 1];
 		} else {
-- 
2.30.0.365.g02bc693789-goog


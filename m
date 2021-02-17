Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FE9C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Feb 2021 14:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB9B64DE0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Feb 2021 14:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbhBQOZ6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Feb 2021 09:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbhBQOZ4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Feb 2021 09:25:56 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180DBC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Feb 2021 06:25:16 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id j188so2891236vke.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Feb 2021 06:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dIQ6aHGg8HcH1+n09aKvn5XXToN4WSs6zi/spnd4RUA=;
        b=Wt4C0OZXBWCNDN0AEBb0VB0YW4qqrCnaCZ/yOkC+nm9DUMW9WAghxHfnAa+IL1/BOV
         khvOWjQAlZdlcR8bnMu+aGmmtjiEk/mJM3cjmuj7REGDo5jK0jL8jvLU7Gqaa9gM0aDk
         R6oGCcXazy/m1CrXr6T5CohFYmvGAROvYkVSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dIQ6aHGg8HcH1+n09aKvn5XXToN4WSs6zi/spnd4RUA=;
        b=aM1fvm4azeXP4BVU29YXy3UjParaIrePeoq48Vp6avqdV6AqJyJcuSa26Dr9OUD3Zz
         pnzTxcyx4aYH95YmQNUN+nQGfOQQ/A5FX+M3lMV6TCGW6EsuqdZw6Rs4fxV0zEu/FFOM
         lKJffGHFtPItdRWYW+xWWDpgSiq9dA2stcL8W72AmdHroUBr/MpITg+xj8bhdmgOfy7V
         IySKOV2Q3IOU2SgL0wsUzjzah9MdtHbAgwm81PoTFo7PEkNF3V8t8KZpKMlufqb9UyHs
         jqWt9qwydyP0J7Qa+ExRBbvQik6ghJYqZ6/5Nq9R0xH7QjBAQ58JeH+jbbIrkGZBCDTc
         ku8g==
X-Gm-Message-State: AOAM531TycgQ1wZsOgsyLxn6rh3UpEFg+5i/aN3TB+3foJxEqnEJ0l2E
        dnYhMPkTA02EW33QJLxNl9G7fGEHX/6mJcR5
X-Google-Smtp-Source: ABdhPJwC4iElAnRqCiAi6RBblsB41C21s/ahI+WrLKGsCnj0VZYKD9K/1evuFg/ARwAbLaYE2kvG/w==
X-Received: by 2002:a1f:9fc8:: with SMTP id i191mr14002307vke.5.1613571913951;
        Wed, 17 Feb 2021 06:25:13 -0800 (PST)
Received: from alain.c.googlers.com.com (245.7.75.34.bc.googleusercontent.com. [34.75.7.245])
        by smtp.gmail.com with ESMTPSA id r130sm252484vke.29.2021.02.17.06.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 06:25:13 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Harry Cutts <hcutts@chromium.org>
Subject: [PATCH v1] Bluetooth: Tolerate valid pre 4.2 conn params
Date:   Wed, 17 Feb 2021 14:25:11 +0000
Message-Id: <20210217142511.3221605-1-alainm@chromium.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch tolerates connection parameters that were valid before
ESR08_v1.0.0 which was also incoporated into the 4.2 core specification.

In particular, this addresses compatibility issues with the Lenovo Yoga
Mouse that sees its connection parameters rejected by the max_latency
computation in hci_conn_check_params, but was perfectly valid at the
time this mouse was qualified.

Before the patch, the mouse was extremely laggy, after the patch, the
mouse worked as expected.

Signed-off-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Tested-by: Harry Cutts <hcutts@chromium.org>

---

 include/net/bluetooth/hci_core.h | 30 ++++++++++++++++++++++++++++++
 net/bluetooth/l2cap_core.c       | 12 ++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ebdd4afe30d2..67b75077c82e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1646,6 +1646,36 @@ static inline struct smp_irk *hci_get_irk(struct hci_dev *hdev,
 	return hci_find_irk_by_rpa(hdev, bdaddr);
 }
 
+/* Erratum 5412 which has been fixed in 4.2 changed the validation of
+ * connection parameters.  For backwards compatibility reasons, the old
+ * calculation must be tolerated.
+ * For further details :
+ * https://www.bluetooth.org/errata/errata_view.cfm?errata_id=5419
+ */
+static inline int hci_check_conn_params_legacy(u16 min, u16 max, u16 latency,
+					u16 to_multiplier)
+{
+	u16 max_latency;
+
+	if (min > max || min < 6 || max > 3200)
+		return -EINVAL;
+
+	if (to_multiplier < 10 || to_multiplier > 3200)
+		return -EINVAL;
+
+	if (max >= to_multiplier * 8)
+		return -EINVAL;
+
+	max_latency = (to_multiplier * 8 / max) - 1;
+	if (latency > 499 || latency > max_latency)
+		return -EINVAL;
+
+	return 0;
+}
+
+/* Connection Parameter Validation Helper.
+ * See Vol 6, Part B, section 4.5.1.
+ */
 static inline int hci_check_conn_params(u16 min, u16 max, u16 latency,
 					u16 to_multiplier)
 {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 72c2f5226d67..726e78bd85ff 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5553,6 +5553,18 @@ static inline int l2cap_conn_param_update_req(struct l2cap_conn *conn,
 	memset(&rsp, 0, sizeof(rsp));
 
 	err = hci_check_conn_params(min, max, latency, to_multiplier);
+	if (err) {
+		BT_WARN("Invalid conn params min 0x%4.4x max 0x%4.4x latency: 0x%4.4x TO: 0x%4.4x",
+			min, max, latency, to_multiplier);
+
+		err = hci_check_conn_params_legacy(min, max, latency,
+						   to_multiplier);
+		if (!err) {
+			/* latency is invalid, cap it to the max allowed */
+			latency = min(499, (to_multiplier * 4 / max) - 1);
+		}
+	}
+
 	if (err)
 		rsp.result = cpu_to_le16(L2CAP_CONN_PARAM_REJECTED);
 	else
-- 
2.30.0.478.g8a0d178c01-goog


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794ABC4332B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Mar 2021 18:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57DC264F51
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Mar 2021 18:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbhCLSUF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Mar 2021 13:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbhCLSTu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Mar 2021 13:19:50 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EFDC061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Mar 2021 10:19:50 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id p21so16391291pgl.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Mar 2021 10:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O7UWZ+Ze3AquMfmcWowDD2Xvs4zQyu7Rw0hN/yVuSe4=;
        b=jm3xKrG6BdqB2JKCq02OLPJVVwsb8RIzP8nwnE4k1OaYRfHloyhFkKKVS+QYGJ+csH
         VO2gCFx8YM939VvzDgawXodx0X3h0EyFRTV2hhgy3n4VOqhzIGrjHegUHuiDNDI+2po+
         Z5ncwXVSaM/0XKMzRjs19S7HKgaGj1wh4f33kUy19+jmmNk+OQgedIA2RoGaN5q1OCSx
         GQY7fcVCd4uN03gAf5It/3bQBzmb666g4ZaY7rNhRBwp2F0BXL3w+CP/UiJkZRhO9z01
         7jp1PSIoEksppkeQpMo5H66FU+LTsbAadVoitxqfF72sRvU16OgfmhOQcQ2A7vKrvc91
         6BHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O7UWZ+Ze3AquMfmcWowDD2Xvs4zQyu7Rw0hN/yVuSe4=;
        b=nFjpWdGLFmt41/4fwjhiZsDuaDm/22Ks0CaHbDNhrUu4y2Os5gss8EdR3vQYy9rpv2
         JBo5b5BNOvLE+tU3hjNrqEerRfi+Eyr8d2KduuEuKoX0bJk26wBxTlcq04ESxSmVy9/V
         EYDEQm+u7MmSOFC4YdBbybpAt/gdnI+WAvueNr7/LWPcJGlh43Mwt3t+pENg+lzHgeTp
         nsSs3MbqVvvliRRimb3hY62JrR27HVKzTW0lLSEi+btGVDGyMtooiSLp9GdhWBjPV3od
         77J8HRKhOEW9AKIiJ+xy0+rhr2bADeN+4UPrOA2molZktlUg7BEcXIV8NiyAiTp2r9PY
         UvXQ==
X-Gm-Message-State: AOAM533V7kaAG9oYEu4+c4tfNKxo9jvXxdA4jK5RI0ZiQzfMMBbm7jm5
        4AWEKaF8Y63/z7oWvXtQevYMiCThADVKcA==
X-Google-Smtp-Source: ABdhPJwjPWdsOlUGn7iMYFbnufPFzQ+pXoRUkXBByOMZLgUH2YBAbxJIJLTGZYFaJs2L6rzY+9FanQ==
X-Received: by 2002:aa7:99c4:0:b029:1f6:c0bf:43d1 with SMTP id v4-20020aa799c40000b02901f6c0bf43d1mr13378421pfi.37.1615573189364;
        Fri, 12 Mar 2021 10:19:49 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x7sm6208876pff.12.2021.03.12.10.19.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 10:19:48 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: Fix not checking for maximum number of DCID
Date:   Fri, 12 Mar 2021 10:19:48 -0800
Message-Id: <20210312181948.1225833-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When receiving L2CAP_CREDIT_BASED_CONNECTION_REQ the remote may request
more channels than allowed by the spec (10 octecs = 5 CIDs) so this
truncates the response allowing it to create only the maximum allowed.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/l2cap.h | 1 +
 net/bluetooth/l2cap_core.c    | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 61800a7b6192..3c4f550e5a8b 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -494,6 +494,7 @@ struct l2cap_le_credits {
 
 #define L2CAP_ECRED_MIN_MTU		64
 #define L2CAP_ECRED_MIN_MPS		64
+#define L2CAP_ECRED_MAX_CID		5
 
 struct l2cap_ecred_conn_req {
 	__le16 psm;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 72c2f5226d67..6325d4a89b31 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5921,7 +5921,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 	struct l2cap_ecred_conn_req *req = (void *) data;
 	struct {
 		struct l2cap_ecred_conn_rsp rsp;
-		__le16 dcid[5];
+		__le16 dcid[L2CAP_ECRED_MAX_CID];
 	} __packed pdu;
 	struct l2cap_chan *chan, *pchan;
 	u16 mtu, mps;
@@ -5973,7 +5973,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 	cmd_len -= sizeof(*req);
 	num_scid = cmd_len / sizeof(u16);
 
-	for (i = 0; i < num_scid; i++) {
+	for (i = 0; i < num_scid && i < ARRAY_SIZE(pdu.dcid); i++) {
 		u16 scid = __le16_to_cpu(req->scid[i]);
 
 		BT_DBG("scid[%d] 0x%4.4x", i, scid);
-- 
2.29.2


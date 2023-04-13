Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73C8C77B61
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Apr 2023 18:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjDMSbU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Apr 2023 14:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDMSbT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Apr 2023 14:31:19 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB3761BD
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Apr 2023 11:31:18 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id f2so7498522pjs.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Apr 2023 11:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681410677; x=1684002677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4k2A8pfRtcN4PdArtJXPwFrg2PKKtqm4O6vo/GOMtG8=;
        b=WwDLSELIoXs3ZFe5QbZk1TCdxN3PXItPCN1Whjjdb2YLmuicNb5ID1v9HrJMnOZyAK
         7w17Iiz4e8h84SYodtQDwSeE+0FMuwoHCU6Pk7C4SRTRCcMRkwRw1sH34lONUhgyuFFu
         vRGIRRAt5MJ0WJJ8N7NMsvw6Nx+5E7ZxxExt7CW/paWdvxBU9A4cSDfFg2bnC7fAz501
         Lj21EDnjiiiS9gDZqW+c6jPmSWvSB8iDlU9YqBra6rek8w0WJa28aeesntWVaIe4RJYY
         /VXjK1ZbHDA0UD44nOaHEfWG+gQQfT7MksV6rIzWZqh1bD/RZiP7L/3wtk5oXx/e3yEa
         Gkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681410677; x=1684002677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4k2A8pfRtcN4PdArtJXPwFrg2PKKtqm4O6vo/GOMtG8=;
        b=HmeLrGIXZcATkZZ1pdf3b6wYtlAtk6Xln/VwsWJnsAIWVwdaIwx1xNckrGOpftaC5H
         GZCe6DK3BRRPxxJOLs7GAz9DAPU9uXrls2QiUIIe3g5aOzgjix+XzhwgLnvc6wxzoerr
         tptRoD30SyPd/8PoLOUmjnZfyRfP6m32hJAAxVdxAkgHvxXj9IqjUMjwpQft7QVEIJTk
         4PGNbVBRSxUN2t9RTtKo8Zi+IK+xUt1dXc2RWLeXAPwvAkxMPog/qBf9ZQMeWC/KWB8K
         qDmh79IkiRL4usoZNJlp0ZGfIqqdELtU7Ot/19kzmb+nN2G4AeuPnqAMUFMo9VlJ/2Xv
         Dx8Q==
X-Gm-Message-State: AAQBX9c+E42rTn63qH8d/uB9KqfC9tlbH6U3CPYpA6HhJ9lU/5DAi/r3
        a9ZnFNhFZg4SPIm0038gmXGPeVUOrPI3jA==
X-Google-Smtp-Source: AKy350YVCoAq+2W0pMyedYFGsWhRUqKDtIiX93rBPplrcngH5c2bgmQIJtvnCsQmeMLWPkXU+14IDA==
X-Received: by 2002:a17:90b:38ce:b0:247:2300:87d9 with SMTP id nn14-20020a17090b38ce00b00247230087d9mr2436370pjb.34.1681410677039;
        Thu, 13 Apr 2023 11:31:17 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902b68d00b001a19438336esm1790257pls.67.2023.04.13.11.31.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 11:31:16 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] Bluetooth: hci_conn: Fix not matching by CIS ID
Date:   Thu, 13 Apr 2023 11:31:12 -0700
Message-Id: <20230413183113.896669-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413183113.896669-1-luiz.dentz@gmail.com>
References: <20230413183113.896669-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes only matching CIS by address which prevents creating new hcon
if upper layer is requesting a specific CIS ID.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 7 ++++++-
 net/bluetooth/hci_conn.c         | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4fe1e71cb9d8..6f5e8594ff2d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1180,7 +1180,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_le(struct hci_dev *hdev,
 
 static inline struct hci_conn *hci_conn_hash_lookup_cis(struct hci_dev *hdev,
 							bdaddr_t *ba,
-							__u8 ba_type)
+							__u8 ba_type,
+							__u8 id)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
@@ -1191,6 +1192,10 @@ static inline struct hci_conn *hci_conn_hash_lookup_cis(struct hci_dev *hdev,
 		if (c->type != ISO_LINK)
 			continue;
 
+		/* Match CIS ID if set */
+		if (id != BT_ISO_QOS_CIS_UNSET && id != c->iso_qos.ucast.cis)
+			continue;
+
 		if (ba_type == c->dst_type && !bacmp(&c->dst, ba)) {
 			rcu_read_unlock();
 			return c;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 204164ee5f9a..b9ecfc782be9 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1842,7 +1842,7 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
 {
 	struct hci_conn *cis;
 
-	cis = hci_conn_hash_lookup_cis(hdev, dst, dst_type);
+	cis = hci_conn_hash_lookup_cis(hdev, dst, dst_type, qos->ucast.cis);
 	if (!cis) {
 		cis = hci_conn_add(hdev, ISO_LINK, dst, HCI_ROLE_MASTER);
 		if (!cis)
-- 
2.39.2


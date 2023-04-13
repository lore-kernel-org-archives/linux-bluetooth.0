Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35F0C77B6C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Apr 2023 00:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjDMAuy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Apr 2023 20:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjDMAux (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Apr 2023 20:50:53 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6B62717
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Apr 2023 17:50:52 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id g16so14751227iom.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Apr 2023 17:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681347051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hWZGyUIe8vDHexeKos2oNQ+poJ0+KHtIaTu1usVgnDI=;
        b=TZbCV4gKcHVXGO/KChtbomLXpjZn8qwZxeTC7y5hi/YLQIsgai75UdRk94RV4/syOD
         M85ZDDOHG+MyDip2z/uNt3HzXPs1uHXPKUtJgG2m6IYlKHCxWEN/c+8FoWXLf48RFjl2
         LEeutcGsr+P12xriQTxCMPOHW2RWmO/znVlLhHOWHVCtEOdArf5ECbCEow8rIQaPF8sl
         TnUdQqpqrrV3daKIa1YtRcdFgPCVkPQj1iOo9Qxwgrr15lipdvS0SYmrtDEAJjk6r6F8
         o5mYY4IAsjoKDxtJOEekJ+B3KXDPZ9tQ1fiTAODH1rY7qGXqcAGEghIHQfN2fkA1nJc8
         2FmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681347051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWZGyUIe8vDHexeKos2oNQ+poJ0+KHtIaTu1usVgnDI=;
        b=Mf8D9nZKQnxtlBqX9bSEuFYlTxRlHP24a2LsPWeUw/wrbk4Ad7g0D0zI2j0RG2RkFM
         wX9TbcLJcmNOykKEbCRu1galF2qg3WmBVB1PtAcgTga/RfmmIOhWa/j4EoBkp/l4aUo3
         OHhqyCpanoGgfN9RiXye+pglVzaiHgGp2rj1ArXtQH8oGuv1MpkNl5WYAhLrj6LcyITO
         DpSrC8qsRrsrBQyaiYzeLt3lb3sb5wFspUEDhSjPLmIMHYTN6JtpW0Bjl/IeluRXYNyR
         zmtGJGBuo463r0PB6tPmkjXA9ceIfVyMwkOzMSoslG2UQCRPNsNjGhhXn9/noLTr2WWU
         K4uA==
X-Gm-Message-State: AAQBX9dN/QTZhNMg4d5rv8Si15Cg0uRegLjbZDDlYHiCa+XmcZuEMYPv
        LcijP57hwDo2Ca2iuNd8fkQ6LOZjvte/KQ==
X-Google-Smtp-Source: AKy350ZPTXTefyxabgaf1ocYj2YO/jO0H8CwYyMY+Phqk4d6XbDPczSFAqAHcRY7EZ6r2Q5xOjjxkw==
X-Received: by 2002:a6b:d918:0:b0:751:e48c:7eed with SMTP id r24-20020a6bd918000000b00751e48c7eedmr33938ioc.11.1681347051149;
        Wed, 12 Apr 2023 17:50:51 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id r14-20020a6bd90e000000b00758facb11fdsm141717ioc.17.2023.04.12.17.50.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 17:50:50 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 2/3] Bluetooth: hci_conn: Fix not matching by CIS ID
Date:   Wed, 12 Apr 2023 17:50:45 -0700
Message-Id: <20230413005046.642682-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413005046.642682-1-luiz.dentz@gmail.com>
References: <20230413005046.642682-1-luiz.dentz@gmail.com>
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
index 8b8ebd3e2585..5524f08b91ae 100644
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


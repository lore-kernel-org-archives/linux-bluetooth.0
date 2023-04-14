Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08A0C77B72
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Apr 2023 20:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjDNU0P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Apr 2023 16:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjDNU0O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Apr 2023 16:26:14 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EDD6A6F
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Apr 2023 13:26:13 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id lh8so6516888plb.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Apr 2023 13:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681503972; x=1684095972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zWcziJQrkYN9usLsUKPem8LL97aKOFRRa9P2n9/sR00=;
        b=p/K/ngzTmL6kRiNIydtyuaueR+qGtzaFMa6g27mR9MM7JGoErW+KjscMgg2oHvcAQi
         ueyfXQLPqHOR6hYkvIsSY0bKWtmlXCOkorof7oNqAJkruZwH8sNcV5kQiXPM7Gp0IJht
         pPUjhgUEyy9ThyNp4uLHIitK6CZBnMnv+JMr4RWkF3N7kz83AIpjPUQjsVSLN9JB6cFY
         m12PSkySnqsY4YMSzDAEIDfMrdMF3HYbFjLsNHCGI5GosPlTxIOMtZAvTBHpcM7K5Sbf
         qm+AUUzufIu9skQhs4sDBF2y3dHJOiosFvCEsLHEjbbxWZIAl6XsydNyHY0IZACKditY
         +kmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681503972; x=1684095972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWcziJQrkYN9usLsUKPem8LL97aKOFRRa9P2n9/sR00=;
        b=dWIkGInfltsSvww6DgOE0fAISSFbH4sujiI01eUMRLiGQIgtYj5WkHrOiMUfBhHHYZ
         qX5+cNftCYNOESiya393DPlnDxRktoLWGJEZmbe9YReO9dbi1D37oiTwRTSFjuMQjbcy
         6z6wiV7Gwm09RYVqllzRUPtgkUFtgm09e/8p1R3ktVqM56rMqf4xXRYVc3dWAAeeAaHX
         +ozwuSfq/1GXldvHSKJE1HIZPJJ3XowjHkfG8ItgXJvU9BKz5MmrXbZ/EJby0fJLcRwp
         MIZ6O901tORthWzpgD0E+hjtBUvyaETpUOy2q+v1dWBo9aFtMrIpCCnX6M79U3envqj/
         cYow==
X-Gm-Message-State: AAQBX9e+g3zFuQJQcpa26pZGosbghz/GjtocDV4/lHcr+AB/DtBochdY
        nkUsvoVPMwBAunknD1kt+uLSv16xKJA=
X-Google-Smtp-Source: AKy350Z+Hk6gHwvRgxHzPlsdw4pYHvjksRcZ+WaBRL1zZR6OAIb0XAaz9crF2ithNEQZHBAe7G4kwQ==
X-Received: by 2002:a05:6a20:2008:b0:d9:6c3d:29cf with SMTP id w8-20020a056a20200800b000d96c3d29cfmr6810871pzw.52.1681503971992;
        Fri, 14 Apr 2023 13:26:11 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id b16-20020aa78110000000b0062dedfd3d73sm3482453pfi.95.2023.04.14.13.26.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 13:26:11 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v3 2/3] Bluetooth: hci_conn: Fix not matching by CIS ID
Date:   Fri, 14 Apr 2023 13:26:07 -0700
Message-Id: <20230414202608.1152970-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230414202608.1152970-1-luiz.dentz@gmail.com>
References: <20230414202608.1152970-1-luiz.dentz@gmail.com>
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
 include/net/bluetooth/hci_core.h | 12 +++++++++++-
 net/bluetooth/hci_conn.c         |  3 ++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4fe1e71cb9d8..a6c8aee2f256 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1180,7 +1180,9 @@ static inline struct hci_conn *hci_conn_hash_lookup_le(struct hci_dev *hdev,
 
 static inline struct hci_conn *hci_conn_hash_lookup_cis(struct hci_dev *hdev,
 							bdaddr_t *ba,
-							__u8 ba_type)
+							__u8 ba_type,
+							__u8 cig,
+							__u8 id)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
@@ -1191,6 +1193,14 @@ static inline struct hci_conn *hci_conn_hash_lookup_cis(struct hci_dev *hdev,
 		if (c->type != ISO_LINK)
 			continue;
 
+		/* Match CIG ID if set */
+		if (cig != BT_ISO_QOS_CIG_UNSET && cig != c->iso_qos.ucast.cig)
+			continue;
+
+		/* Match CIS ID if set */
+		if (id != BT_ISO_QOS_CIS_UNSET && id != c->iso_qos.ucast.cis)
+			continue;
+
 		if (ba_type == c->dst_type && !bacmp(&c->dst, ba)) {
 			rcu_read_unlock();
 			return c;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d8466abbb36a..c215e983e287 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1841,7 +1841,8 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
 {
 	struct hci_conn *cis;
 
-	cis = hci_conn_hash_lookup_cis(hdev, dst, dst_type);
+	cis = hci_conn_hash_lookup_cis(hdev, dst, dst_type, qos->ucast.cig,
+				       qos->ucast.cis);
 	if (!cis) {
 		cis = hci_conn_add(hdev, ISO_LINK, dst, HCI_ROLE_MASTER);
 		if (!cis)
-- 
2.39.2


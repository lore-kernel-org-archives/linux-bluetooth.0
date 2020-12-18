Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A99C2BBCD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 00:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BED723A53
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 00:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732197AbgLRAOi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Dec 2020 19:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732074AbgLRAOh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Dec 2020 19:14:37 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8D1C0617B0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Dec 2020 16:13:57 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id i7so213922pgc.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Dec 2020 16:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VTJIRYcgHwZbGRN6Peujt6xlrWJf6qiS7wBUgXNen2w=;
        b=Kfa9IG4vZPfw/2JHQbnYjaCZ5v24OyQOeznpUXGMpF4XhzeMjuwxai8IraIkVtZc/M
         8sVc8vZNpTte0BdU38JD4jN7Iw+8QUjPkVShG3LT1krnr5INMyVypgcipwhIMGNBs3iz
         bxPkWfQgx+LicxcrztfFWTacGrzddUB70UUFcDUkpMEnkJJd5WmUYmT01xry2GSrjIBD
         uNw6pbkh97qd4lzR42nmwjfugUGVrUemn0qmb8yVBtANcGC1LLyZNFSZeMhY+9tMBb9z
         UrettFqHtj9aFB9lWk6vCRBjtmqI/anhC2AYFVfhX5l+GzYyljZTU0ph23lSYESbM3xT
         OAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VTJIRYcgHwZbGRN6Peujt6xlrWJf6qiS7wBUgXNen2w=;
        b=A7KhD7Of46V1Jc7FVtMb9PDDUZ6WF4OihtXa2/F3JCul14K/U5RbpI0W0h/SLxJlD1
         TitEYgV96HO81KoTrMz0S77L64NB4lcufhsg+YuNvtE/e0kX3lyMYlBItFc3Gsner2T0
         GPiyiJgEI+L45APl31waJ0aSuj5dteeej4bOZbnHsUD0IqFeowvpJTU4VxWiMcPS1q8R
         qb5LUQ7BU2VL7K6l7s1pEJapF6Bn3wVAV2vihI+2s8PMJO0XADqhaYyhdLjC4GT6D4YD
         w4X8Damapc6wc48Arw+PnA5KtFH7HkLi8AlZ3A9aCp7pKhEFP6hxX/QzL70MAArhMFOR
         BntQ==
X-Gm-Message-State: AOAM5338skVNm4KGgb+o1sc7b8LxHa7nkL/2jqA7CM2ryZOhu/EBQpHS
        q7r/7vE/2VDN30XqmPKnj8kYsB1G0cI=
X-Google-Smtp-Source: ABdhPJwhvsSAPYIu79CGAA2sTkFr3v6NOGsnG7Hx25gZxF0n2qLWxAUKUzv6qQF4GaQGJD0V+jkrfw==
X-Received: by 2002:a63:fb42:: with SMTP id w2mr1700388pgj.354.1608250436631;
        Thu, 17 Dec 2020 16:13:56 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m77sm6428189pfd.105.2020.12.17.16.13.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 16:13:55 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/3] bthost: Add support for address types other then public
Date:   Thu, 17 Dec 2020 16:13:51 -0800
Message-Id: <20201218001351.1442784-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201218001351.1442784-1-luiz.dentz@gmail.com>
References: <20201218001351.1442784-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This properly initialize the address type according to the connection
address.
---
 emulator/bthost.c |  9 +++++++--
 emulator/bthost.h |  5 +++--
 emulator/smp.c    | 24 +++++++++++++++++++-----
 3 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 3b42c0664..16934d35a 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -923,6 +923,7 @@ static void init_conn(struct bthost *bthost, uint16_t handle,
 {
 	struct btconn *conn;
 	const uint8_t *ia, *ra;
+	uint8_t ia_type, ra_type;
 
 	conn = malloc(sizeof(*conn));
 	if (!conn)
@@ -939,14 +940,18 @@ static void init_conn(struct bthost *bthost, uint16_t handle,
 
 	if (bthost->conn_init) {
 		ia = bthost->bdaddr;
+		ia_type = addr_type;
 		ra = conn->bdaddr;
+		ra_type = conn->addr_type;
 	} else {
 		ia = conn->bdaddr;
+		ia_type = conn->addr_type;
 		ra = bthost->bdaddr;
+		ra_type = addr_type;
 	}
 
-	conn->smp_data = smp_conn_add(bthost->smp_data, handle, ia, ra,
-						addr_type, bthost->conn_init);
+	conn->smp_data = smp_conn_add(bthost->smp_data, handle, ia, ia_type,
+					ra, ra_type, bthost->conn_init);
 
 	if (bthost->new_conn_cb)
 		bthost->new_conn_cb(conn->handle, bthost->new_conn_data);
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 77f17fd69..7e5286df3 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -142,8 +142,9 @@ void bthost_start(struct bthost *bthost);
 
 void *smp_start(struct bthost *bthost);
 void smp_stop(void *smp_data);
-void *smp_conn_add(void *smp_data, uint16_t handle, const uint8_t *ia,
-			const uint8_t *ra, uint8_t addr_type, bool conn_init);
+void *smp_conn_add(void *smp_data, uint16_t handle,
+			const uint8_t *ia, uint8_t ia_type,
+			const uint8_t *ra, uint8_t ra_type, bool conn_init);
 void smp_conn_del(void *conn_data);
 void smp_conn_encrypted(void *conn_data, uint8_t encrypt);
 void smp_data(void *conn_data, const void *data, uint16_t len);
diff --git a/emulator/smp.c b/emulator/smp.c
index db0065d7d..ec1baea04 100644
--- a/emulator/smp.c
+++ b/emulator/smp.c
@@ -834,8 +834,22 @@ void smp_conn_encrypted(void *conn_data, uint8_t encrypt)
 	distribute_keys(conn);
 }
 
-void *smp_conn_add(void *smp_data, uint16_t handle, const uint8_t *ia,
-			const uint8_t *ra, uint8_t addr_type, bool conn_init)
+static uint8_t type2hci(uint8_t addr_type)
+{
+	switch (addr_type) {
+	case BDADDR_BREDR:
+	case BDADDR_LE_PUBLIC:
+		return LE_PUBLIC_ADDRESS;
+	case BDADDR_LE_RANDOM:
+		return LE_RANDOM_ADDRESS;
+	}
+
+	return 0x00;
+}
+
+void *smp_conn_add(void *smp_data, uint16_t handle,
+			const uint8_t *ia, uint8_t ia_type,
+			const uint8_t *ra, uint8_t ra_type, bool conn_init)
 {
 	struct smp *smp = smp_data;
 	struct smp_conn *conn;
@@ -848,11 +862,11 @@ void *smp_conn_add(void *smp_data, uint16_t handle, const uint8_t *ia,
 
 	conn->smp = smp;
 	conn->handle = handle;
-	conn->addr_type = addr_type;
 	conn->out = conn_init;
+	conn->addr_type = conn_init ? ia_type : ra_type;
 
-	conn->ia_type = LE_PUBLIC_ADDRESS;
-	conn->ra_type = LE_PUBLIC_ADDRESS;
+	conn->ia_type = type2hci(ia_type);
+	conn->ra_type = type2hci(ra_type);
 	memcpy(conn->ia, ia, 6);
 	memcpy(conn->ra, ra, 6);
 
-- 
2.26.2


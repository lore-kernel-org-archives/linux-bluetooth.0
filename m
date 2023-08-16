Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDA6C27C42
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Aug 2023 22:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344275AbjHPWbw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Aug 2023 18:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346997AbjHPWbw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Aug 2023 18:31:52 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E762F1B2
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 15:31:50 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bdbbede5d4so48126435ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 15:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692225110; x=1692829910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cCWyHgLcVPzpFFLmX+q9DIaBIvCOJPEVjefrgbIlmFo=;
        b=O3DRLbtzIdCs/ZzehdEtl84ag5tl3M577D/GYACO6nEsoZ2sSXo/PYsUDEv7MEL48C
         1IYs22p0j+rC+tFQuSGGzYGg27Nxcj72lQcrTYJRQt6S3oJxIAtl+CQ64NIzOVrBv9sG
         KNh+xx9QAwH5S6+28DNo6eopTqLsATvwQheLY1cN5fqN5D9vdzYxMp7GnSwz6oB9i4Y2
         VFt5EvEoa9s6/fp5FxXxqh2vmyGJhuVKWwXl5owYfSGtbNDLelO2ifmv2fvkzefq+Mue
         +xjQm74fDCQnZ71SdiDk/C7GWGHilh2cHD8e9W8iHY1hVmKXII1jqKCMrpPhSvvQhFaH
         wlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692225110; x=1692829910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cCWyHgLcVPzpFFLmX+q9DIaBIvCOJPEVjefrgbIlmFo=;
        b=b6wVXNaxkqHfrZmPLY25N0stB+qOzG1L1Mp5Y+YbtKSocbh4jR6i9+95/pV4BkFZYH
         FDVZFwnv/QK/F8vciHNyJebG1oKsd6xFzVW45m0DBGeQ1Ocz0jj/bBmb4PTeBHba4qAU
         QPe1sJwb/fR5zDJ0guNLRwW/8ItGHCi7fqNhlwWcXeydtegJJxGbgjRMCXDLhqgZp9eR
         ppeqGBdadR2BHhzDDKirMDsxUa7WlR4UXpbXtVzrhd8vDDDzWWxSoGMgUA48THLz3oiD
         QMH5Leu2KRwycqWBomTaNvKXz/Ia+4a+L7OZJN8j/Fjgvn8tDwwtnrgZCIeXcCMeMJKq
         RmpA==
X-Gm-Message-State: AOJu0YxZckaQ7gJ6guefUAw1Org7Yb8uCxaZe0oLT2zhfRqliZs7Hart
        8TLHU9PGdQ/4InGxLDkK1VO1WYJWywc=
X-Google-Smtp-Source: AGHT+IFzDRKFc1BIBVUR9S2YO4+YRMiPO2aBVltFTPi1i311jKI2eUauPXWNM4uCSXezij+aRpu0bQ==
X-Received: by 2002:a17:903:1109:b0:1b5:2fdf:5bd8 with SMTP id n9-20020a170903110900b001b52fdf5bd8mr4673157plh.8.1692225109616;
        Wed, 16 Aug 2023 15:31:49 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902e9cc00b001993a1fce7bsm13582347plk.196.2023.08.16.15.31.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 15:31:48 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] monitor: Fix not printing latency information with -r
Date:   Wed, 16 Aug 2023 15:31:46 -0700
Message-ID: <20230816223147.2787284-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When reading a log from file hci_devba may not work, also store link
information so assign_handle can use use the parent (ACL) destination.
---
 monitor/packet.c | 40 +++++++++++++++++++++++++++++++++++++---
 monitor/packet.h |  1 +
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 84af03a0011f..8eae8c9ea8fa 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -174,6 +174,18 @@ static uint16_t get_format(uint32_t cookie)
 
 static struct packet_conn_data conn_list[MAX_CONN];
 
+static struct packet_conn_data *lookup_parent(uint16_t handle)
+{
+	int i;
+
+	for (i = 0; i < MAX_CONN; i++) {
+		if (conn_list[i].link == handle)
+			return &conn_list[i];
+	}
+
+	return NULL;
+}
+
 static void assign_handle(uint16_t index, uint16_t handle, uint8_t type,
 					uint8_t *dst, uint8_t dst_type)
 {
@@ -181,15 +193,27 @@ static void assign_handle(uint16_t index, uint16_t handle, uint8_t type,
 
 	for (i = 0; i < MAX_CONN; i++) {
 		if (conn_list[i].handle == 0x0000) {
-			if (hci_devba(index, (bdaddr_t *)conn_list[i].src) < 0)
-				return;
+			hci_devba(index, (bdaddr_t *)conn_list[i].src);
 
 			conn_list[i].index = index;
 			conn_list[i].handle = handle;
 			conn_list[i].type = type;
 
-			if (!dst)
+			if (!dst) {
+				struct packet_conn_data *p;
+
+				/* If destination is not set attempt to use the
+				 * parent one if that exists.
+				 */
+				p = lookup_parent(handle);
+				if (p) {
+					memcpy(conn_list[i].dst, p->dst,
+						sizeof(conn_list[i].dst));
+					conn_list[i].dst_type = p->dst_type;
+				}
+
 				break;
+			}
 
 			memcpy(conn_list[i].dst, dst, sizeof(conn_list[i].dst));
 			conn_list[i].dst_type = dst_type;
@@ -8725,9 +8749,14 @@ static void le_set_cig_params_rsp(uint16_t index, const void *data,
 static void print_cis(const void *data, int i)
 {
 	const struct bt_hci_cis *cis = data;
+	struct packet_conn_data *conn;
 
 	print_field("CIS Handle: %d", cis->cis_handle);
 	print_field("ACL Handle: %d", cis->acl_handle);
+
+	conn = packet_get_conn_data(cis->acl_handle);
+	if (conn)
+		conn->link = cis->cis_handle;
 }
 
 static void le_create_cis_cmd(uint16_t index, const void *data, uint8_t size)
@@ -11643,11 +11672,16 @@ static void le_req_cis_evt(struct timeval *tv, uint16_t index,
 					const void *data, uint8_t size)
 {
 	const struct bt_hci_evt_le_cis_req *evt = data;
+	struct packet_conn_data *conn;
 
 	print_field("ACL Handle: %d", le16_to_cpu(evt->acl_handle));
 	print_field("CIS Handle: %d", le16_to_cpu(evt->cis_handle));
 	print_field("CIG ID: 0x%2.2x", evt->cig_id);
 	print_field("CIS ID: 0x%2.2x", evt->cis_id);
+
+	conn = packet_get_conn_data(evt->acl_handle);
+	if (conn)
+		conn->link = evt->cis_handle;
 }
 
 static void print_bis_handle(const void *data, int i)
diff --git a/monitor/packet.h b/monitor/packet.h
index 750ce405e4bc..384f460d2f58 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -42,6 +42,7 @@ struct packet_conn_data {
 	uint16_t index;
 	uint8_t  src[6];
 	uint16_t handle;
+	uint16_t link;
 	uint8_t  type;
 	uint8_t  dst[6];
 	uint8_t  dst_type;
-- 
2.41.0


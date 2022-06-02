Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F559C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jun 2022 21:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239401AbiFBVWe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jun 2022 17:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiFBVWd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jun 2022 17:22:33 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABC66587
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jun 2022 14:22:32 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 187so5747513pfu.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jun 2022 14:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GE7waCN9vvgZJ/qqvD8MDtvR6+wfz5ovETsZEMV55Bg=;
        b=QQWGZ1/HdWZe+WAY6urcUviwBqhnp5B8Et3nyeZzDdaM4c9OnCBiywzuVyHOfCgJFN
         qlI3yaeLehXzIEb3P9SfYnS6wSs3Bk53vNnocVCRHeH3aJ0I4l8sj6LwZL8MHaeir+GE
         G2a8Q9+ALJUchLi6wU4qt1Bm1q3tzxAVXQnZs40CyxcOKOfWfOIeL6m05VCsxcoyZXTk
         ZrxAjpXIIoOGPkq6DC4J1W9G1pROZMywu+6P6Cm2CqVFWFI3MumBZnnKWjHE0Dat/uxY
         II50TaMAmvqbO29VhuG8htondHH4k3Zb/qbSRz+y6rmgb8qNAuSSEO4pDXixIY0Pyv9o
         a6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GE7waCN9vvgZJ/qqvD8MDtvR6+wfz5ovETsZEMV55Bg=;
        b=2OjaGz5uFjUY3NgG8VnuKVS3Kavq6iZrXRNRQd9cB6zxTF4Xv1QCfc4hsPgl/dmqzC
         JiDohNaz7M/s4cf8mwtg1n4cQGjr7lfpElbl1PqtVEmjMp/kWIP3gHCXxRpBDtGVw0Fr
         7ZhTUgSHOvSGCf++a4NAMQ2X4mu5Iw0WfUuJNKm3dYW7GUR+Yt7kjXp44BjPMFlMzaL1
         ASetiszmn5iMFjpQ19HxuGq/ugGnaf2BOV/bHqhiIdm9IfQQOzIE3GNYLBxPvii6r3Mh
         62P3ub/xBBYE7U0ss653OXJKijADi3z25MznkWfxeKpb26Ob6pXPuka44bFWa8TCzoXI
         IvOg==
X-Gm-Message-State: AOAM5311kaniySieU0T/bNqi2BNtGx3uCG2AJ3X6v6ysyBjq4GuLwZpD
        7LKySxSWcohNVNBizkL6cU3izIfW0hY=
X-Google-Smtp-Source: ABdhPJzqtm+9NM3ia2/7OG6Az/vOARCTMMF5peJ6NcaGTSjFlfAOLUQWZx5Ke1ZPeWkeWdverPQxug==
X-Received: by 2002:a05:6a00:815:b0:518:8acd:be39 with SMTP id m21-20020a056a00081500b005188acdbe39mr7074163pfk.70.1654204951225;
        Thu, 02 Jun 2022 14:22:31 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id v13-20020a17090331cd00b00163daef3dc2sm3935295ple.84.2022.06.02.14.22.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 14:22:30 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] monitor: Stop spamming logs when GATT db cannot be loaded
Date:   Thu,  2 Jun 2022 14:22:29 -0700
Message-Id: <20220602212229.1486206-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This stops calling hci_devba everytime the GATT db needs to be loaded
since that causes a raw socket to be open to read back the address
pointed by the index, instead this is done only once at assign_handle
and store in packet_conn_data.
---
 monitor/att.c    | 6 +-----
 monitor/packet.c | 3 +++
 monitor/packet.h | 1 +
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index 152a5f320..00db8ddaa 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -1228,7 +1228,6 @@ static void load_gatt_db(struct packet_conn_data *conn)
 {
 	struct att_conn_data *data = conn->data;
 	char filename[PATH_MAX];
-	bdaddr_t src;
 	char local[18];
 	char peer[18];
 
@@ -1243,10 +1242,7 @@ static void load_gatt_db(struct packet_conn_data *conn)
 	if (!gatt_db_isempty(data->ldb) && !gatt_db_isempty(data->rdb))
 		return;
 
-	if (hci_devba(conn->index, &src) < 0)
-		return;
-
-	ba2str(&src, local);
+	ba2str((bdaddr_t *)conn->src, local);
 	ba2str((bdaddr_t *)conn->dst, peer);
 
 	if (gatt_db_isempty(data->ldb)) {
diff --git a/monitor/packet.c b/monitor/packet.c
index c7739fba5..bd9efd2c7 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -178,6 +178,9 @@ static void assign_handle(uint16_t index, uint16_t handle, uint8_t type,
 
 	for (i = 0; i < MAX_CONN; i++) {
 		if (conn_list[i].handle == 0x0000) {
+			if (hci_devba(index, (bdaddr_t *)conn_list[i].src) < 0)
+				return;
+
 			conn_list[i].index = index;
 			conn_list[i].handle = handle;
 			conn_list[i].type = type;
diff --git a/monitor/packet.h b/monitor/packet.h
index 97d683e3a..3a6b9f7a1 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -25,6 +25,7 @@
 
 struct packet_conn_data {
 	uint16_t index;
+	uint8_t  src[6];
 	uint16_t handle;
 	uint8_t  type;
 	uint8_t  dst[6];
-- 
2.35.1


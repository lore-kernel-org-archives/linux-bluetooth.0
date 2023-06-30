Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112A5EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jun 2023 19:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjF3T0s (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jun 2023 15:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjF3T0r (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jun 2023 15:26:47 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E30B9
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 12:26:46 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b80512a7f2so13923735ad.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 12:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688153205; x=1690745205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rp6M4///7vvT2sDDxV+yCpjeREL9xSGKp9ENeRDKCLw=;
        b=WdNxRWXmcQODTE6Vn38PBL/iSUhW9pT3AJuH435bQ7PCcvJvTLTs6EUJej0gl6OQxL
         TBS9bu1Z0PxltV/RvuBfLi+gzqlMPTQBaIgFc5Sn6nxW47DXFYxhKgIiEZd1YZGUmyzl
         1D1IqDgK0NvjBB7jVgIFhfcYC1pyhkQu27JPRfJzbsyc1PwI7OrUTbZTLdTWYcxBPWtO
         ziPKmQWS86PDJy+OlGTn3ZUxR5OeaN9zwv0VAdryZ+xuA4w8hogb1jfFNuaXzxEvnirk
         VANnNwUSeZhu3TS80E7xGoRdJCTCJQl/Z5W+P7+iKQkSYE51g1y5zTB3jnhkhzGKQDhH
         VVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688153205; x=1690745205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rp6M4///7vvT2sDDxV+yCpjeREL9xSGKp9ENeRDKCLw=;
        b=XKDU94ZsWQYyK7liNZENU8uuax6Uzr6TAW1VLpp2YLIdabqh+H9D++Mkkgxfh2nkQk
         DxCnSvSFIe1YUewX5E3OToLIFqJZpuZvOYnhiChZw5dNlxmHCjDB4cIIbcsDIkogIoVN
         Gbi4hiPR86FjH3FvGxTS2inMKNgH6pFDqGdXKMQ2sBLgkcsZv5MBAYoaJymW0wR8rr7A
         eWVOJWIYQsY9toQ3SDdh3LGVHH41V+5tQwcKzpPzq7oxQAa5xXF8oGcrJc7A+IlhJcv9
         6SMQZwpaIOhiiHvTQ/hlUXl3pAT8Zylv5zKmDOp77cUtiUFYjxBzJEqYg1fhgpdoVADI
         DP5g==
X-Gm-Message-State: ABy/qLbcuMZQ81ZZTbJzVewnNK3yqPXftloYqr4dBMj29RpYpLHrCrUk
        idicq+DNRH70RMh049C6MxfwLpQRam4=
X-Google-Smtp-Source: APBJJlEfa0ImjmT7garCOkg0Jm0a0WRoN5cmCsPF0/KemzVl8XmncxHMLBASzGEsSUUs4waCbaYh3A==
X-Received: by 2002:a17:903:1c5:b0:1b8:48f3:7a70 with SMTP id e5-20020a17090301c500b001b848f37a70mr3137072plh.1.1688153204636;
        Fri, 30 Jun 2023 12:26:44 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id w7-20020a170902904700b001b809082a69sm8419719plz.235.2023.06.30.12.26.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 12:26:43 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] transport: Fix crash on Transport.Acquire
Date:   Fri, 30 Jun 2023 12:26:42 -0700
Message-Id: <20230630192642.3591626-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes crash introduced by 3030883 which caused requests not be
initialized properly for A2DP.

Fixes: https://github.com/bluez/bluez/issues/542
---
 profiles/audio/transport.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 48a40858b873..77216e10b3b3 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -539,7 +539,7 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 {
 	struct media_transport *transport = data;
 	struct media_owner *owner;
-	struct media_request *req;
+	struct media_request *req = NULL;
 	guint id;
 
 	if (transport->owner != NULL)
@@ -549,20 +549,21 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_not_authorized(msg);
 
 	owner = media_owner_create(msg);
-	if (bt_bap_stream_get_type(get_stream_bap(transport)) ==
-				BT_BAP_STREAM_TYPE_BCAST) {
+
+	if (!strcmp(media_endpoint_get_uuid(transport->endpoint),
+						BAA_SERVICE_UUID)) {
 		req = media_request_create(msg, 0x00);
 		media_owner_add(owner, req);
 		media_transport_set_owner(transport, owner);
 	}
+
 	id = transport->resume(transport, owner);
 	if (id == 0) {
 		media_owner_free(owner);
 		return btd_error_not_authorized(msg);
 	}
 
-	if (bt_bap_stream_get_type(get_stream_bap(transport)) ==
-				BT_BAP_STREAM_TYPE_UCAST) {
+	if (!req) {
 		req = media_request_create(msg, id);
 		media_owner_add(owner, req);
 		media_transport_set_owner(transport, owner);
-- 
2.40.1


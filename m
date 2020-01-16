Return-Path: <SRS0=0CDr=3F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3706C33CB1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jan 2020 12:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA3A2081E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jan 2020 12:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="wAlzM5ab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgAPMpX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jan 2020 07:45:23 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:37546 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgAPMpX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jan 2020 07:45:23 -0500
Received: by mail-lj1-f181.google.com with SMTP id o13so22451353ljg.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jan 2020 04:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xqRMlA9EAradXfumTGaOHUH18ZfVfJ/fqUtluxFdlh8=;
        b=wAlzM5abrovHYD5cOVNE+AY7gKQOIZUkjDqja36D3jorW5fri1JCKR96Kvrm2FvxZg
         mWdJx2fu+Cfn1D7QHsuuq7pj3TPCnKNb3x2av7CFGDGHdc61E0zp8GjIo6e2xRvOCqP4
         TBU1f1MESi7qIk9gbeW46j62AxbJ6QcsqARBamoGaRYfkMvLQgjZrucj9xKppAv3nMjc
         PhC58MUwS5J+Dy7QBG7KkqVek74ED3wxZ3XbHJyww1cPAzbX7oCe+9D4F7F/finMEQ+F
         Siwl5Y45oLMcv8MyWd5+ETesvt2Ia5tOv+KLvsRUg4cT162/CBJbA2GLiscx0SHh4VOB
         0y4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xqRMlA9EAradXfumTGaOHUH18ZfVfJ/fqUtluxFdlh8=;
        b=oondYYcDzcM2N9u4qyqJrekBRRWS6Ol3LrjVNQoTMYoPxU1LYKML6Ana8annOFqQo+
         24MuKEP+xPVWTz9gLvtQTI1M8CX+nt/BsuKuumGszLjVfUBgYqBMA8p7Y3IJqP9d+ILm
         9RLGg5HItg/qePvhdveR2wDc18oUHX6kUj+X3Y7KAVgNymQbA8dDyonh3fCb0iCeYn8l
         OnkeYFf2tmmFC13ipe4Quavgys7m6hkAZcaKKN7bpWFvu+p51q8UuOg2FRs+oVMBlIHA
         dP9zPCqckZS0KFVMO2+pGOWIF9wftFP1pmH0e4yYH51zvRq5QASobaVXjVNKy68hQzfk
         WRzA==
X-Gm-Message-State: APjAAAXzoo6Tgu6qa3m4umCQjWT0TwSr14PjsMmodql1n7b16t4gryIn
        iKOxXY+rDrB08q8VbusIpYNbTVBx/1WdpA==
X-Google-Smtp-Source: APXvYqyb+TJky16oJd4D+hHum50K3Bbq/psb8bZm6X+RLwUCB1PQEpD8vPuL6NmrcEHwc1tBxw8nUg==
X-Received: by 2002:a2e:8745:: with SMTP id q5mr2048290ljj.208.1579178721054;
        Thu, 16 Jan 2020 04:45:21 -0800 (PST)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id w8sm10790887ljd.13.2020.01.16.04.45.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 04:45:20 -0800 (PST)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] mesh: Sequence number related fixes
Date:   Thu, 16 Jan 2020 13:45:02 +0100
Message-Id: <20200116124502.28322-1-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/crypto.c           |  3 +++
 mesh/mesh-config-json.c | 10 +++++++++-
 mesh/net.c              |  6 ++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/mesh/crypto.c b/mesh/crypto.c
index 8ea906ac9..596a289f9 100644
--- a/mesh/crypto.c
+++ b/mesh/crypto.c
@@ -637,6 +637,9 @@ bool mesh_crypto_packet_build(bool ctl, uint8_t ttl,
 	uint32_t hdr;
 	size_t n;
 
+	if (seq > SEQ_MASK)
+		return false;
+
 	l_put_be32(seq, packet + 1);
 	packet[1] = (ctl ? CTL : 0) | (ttl & TTL_MASK);
 
diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 755caab0e..0abb77b36 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -40,6 +40,7 @@
 #include "mesh/mesh-defs.h"
 #include "mesh/util.h"
 #include "mesh/mesh-config.h"
+#include "mesh/net.h"
 
 /* To prevent local node JSON cache thrashing, minimum update times */
 #define MIN_SEQ_CACHE_TRIGGER	32
@@ -365,7 +366,7 @@ static bool read_seq_number(json_object *jobj, uint32_t *seq_number)
 	if (!val && errno == EINVAL)
 		return false;
 
-	if (val < 0 || val > 0xffffff)
+	if (val < 0 || val > SEQ_MASK + 1)
 		return false;
 
 	*seq_number = (uint32_t) val;
@@ -2019,6 +2020,13 @@ bool mesh_config_write_seq_number(struct mesh_config *cfg, uint32_t seq,
 		if (cached < seq + MIN_SEQ_CACHE_VALUE)
 			cached = seq + MIN_SEQ_CACHE_VALUE;
 
+		/* when the cached exceeds the max allowed seq nr value,
+		 * update it with out of range value in order not to send
+		 * again the message with max seq nr after application crash
+		 */
+		if (cached > SEQ_MASK)
+			cached = SEQ_MASK + 1;
+
 		l_debug("Seq Cache: %d -> %d", seq, cached);
 
 		cfg->write_seq = seq;
diff --git a/mesh/net.c b/mesh/net.c
index f0f0dbdbd..530a41ee5 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -511,6 +511,12 @@ uint32_t mesh_net_next_seq_num(struct mesh_net *net)
 {
 	uint32_t seq = net->seq_num++;
 
+	/* Exceed the seq_nr max value in order
+	 * not to send duplicated messages with the same max seq_nr
+	 */
+	if (net->seq_num > SEQ_MASK)
+		net->seq_num = SEQ_MASK + 1;
+
 	node_set_sequence_number(net->node, net->seq_num);
 	return seq;
 }
-- 
2.20.1


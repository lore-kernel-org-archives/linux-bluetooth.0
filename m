Return-Path: <SRS0=Arr2=V4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B02DC433FF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Jul 2019 07:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BE7218A4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Jul 2019 07:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="bvfhYCNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfGaHQ4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Jul 2019 03:16:56 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:40187 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfGaHQ4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Jul 2019 03:16:56 -0400
Received: by mail-lf1-f43.google.com with SMTP id b17so46690460lff.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2019 00:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TS3YjcR35vgwwoTAcqIHVeoIPGZgJRx1zj8XUcQMroI=;
        b=bvfhYCNRxhWUAS65FYKR+0InMvk8E9vB98lF5mcbyYKuIpje81YFtuxGcnUHO61lAZ
         6lusHjfq+55GTXL92IahM8TkrIgJ68Nn/gW01z6cV9mm3mYpoIGLH8q+g5A6NHkFACCJ
         oMpf9YJjOhSI3E6i4wp2yY3SemVZgb9WJxKqeMLbAt93AMHkN+CRxzX7+Gxu/0XPiIzn
         5lIRD8rzNhmcP9NLJiU+3yRnnomIv/RV/ABWbDLEgtNoLAWl5lUlj/j44kQX4BKVp+jk
         x2bLcg2fDgtgbRDyOxD7ImNIr9oddRSP7lFckOY4mB9yrj4QM1sMVDg3YsUzpcb0ze6+
         iRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TS3YjcR35vgwwoTAcqIHVeoIPGZgJRx1zj8XUcQMroI=;
        b=FAtLcou8fVcYP9gjqkB3KIXnhdVoa1I9Ob+2L/0GeBJYh6rbW5T63s/3dWB9aqaxOa
         DqpztXWQ9sVtTEkH2boy6QoufUqk8NGt0WgRYgblNJy728xnuwHiI4biEoEDWvSdwjRW
         VT03v8F30XBBRr/YrduAE/sDycRx4QAE0DabEBgtd/FA0EY+SlrWKJoQQ5t7A/hgJmdC
         arNvSy1SebdjoCcqriB4vioHUuxM2IVU0n12whnNZYfxzr4FP1fcDrtEVwfK/QV6URjG
         tt8vEyyLM/bBifAWoHyPn4WCyqk+vbYsaGGO5//MBbIjQbQrmyfxcPuiuCPWXjUdEdd1
         f3xw==
X-Gm-Message-State: APjAAAV2rEoZFaclo0lX9kq1kua2WP0CwQzaDOmgtzHSJvTDee6Xz+f8
        mPvv/uktZFH0RHfak2DgcseI9pwVlPI=
X-Google-Smtp-Source: APXvYqyQbYin3wzMTWDlKyjK3yWeoStSvtH9Y/isK08TsEJd9HxeDUWZyNQoMuSbZQrvs99v+kU+Bw==
X-Received: by 2002:a19:ccc6:: with SMTP id c189mr56410033lfg.160.1564557414118;
        Wed, 31 Jul 2019 00:16:54 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id n10sm11662477lfe.24.2019.07.31.00.16.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 00:16:53 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Jakub Witowski <jakub.witowski@silvair.com>
Subject: [PATCH BlueZ v7 1/3] mesh: Extract read_* functions in mesh-config-json
Date:   Wed, 31 Jul 2019 09:16:45 +0200
Message-Id: <20190731071647.27217-2-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190731071647.27217-1-michal.lowas-rzechonek@silvair.com>
References: <20190731071647.27217-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Jakub Witowski <jakub.witowski@silvair.com>

This is a small improvement of read_node function readability.
---
 mesh/mesh-config-json.c | 83 +++++++++++++++++++++++++++++++++--------
 1 file changed, 68 insertions(+), 15 deletions(-)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index e3baf5dc6..177aaac7b 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -297,6 +297,65 @@ static json_object *jarray_key_del(json_object *jarray, int16_t idx)
 	return jarray_new;
 }
 
+static bool read_unicast_address(json_object *jobj, uint16_t *unicast)
+{
+	json_object *jvalue;
+	char *str;
+
+	if (!json_object_object_get_ex(jobj, "unicastAddress", &jvalue))
+		return false;
+
+	str = (char *)json_object_get_string(jvalue);
+	if (sscanf(str, "%04hx", unicast) != 1)
+		return false;
+
+	return true;
+}
+
+static bool read_default_ttl(json_object *jobj, uint8_t *ttl)
+{
+	json_object *jvalue;
+	int val;
+
+	/* defaultTTL is optional */
+	if (!json_object_object_get_ex(jobj, "defaultTTL", &jvalue))
+		return true;
+
+	val = json_object_get_int(jvalue);
+
+	if (!val && errno == EINVAL)
+		return false;
+
+	if (val < 0 || val == 1 || val > DEFAULT_TTL)
+		return false;
+
+	*ttl = (uint8_t) val;
+
+	return true;
+}
+
+static bool read_seq_number(json_object *jobj, uint32_t *seq_number)
+{
+	json_object *jvalue;
+	int val;
+
+	/* sequenceNumber is optional */
+	if (!json_object_object_get_ex(jobj, "sequenceNumber", &jvalue))
+		return true;
+
+	val = json_object_get_int(jvalue);
+
+	if (!val && errno == EINVAL)
+		return false;
+
+	if (val < 0 || val > 0xffffff)
+		return false;
+
+	*seq_number = (uint32_t) val;
+
+	return true;
+}
+
 static bool read_iv_index(json_object *jobj, uint32_t *idx, bool *update)
 {
 	int tmp;
@@ -424,7 +483,7 @@ fail:
 	return false;
 }
 
-static bool read_net_keys(json_object *jobj,  struct mesh_config_node *node)
+static bool read_net_keys(json_object *jobj, struct mesh_config_node *node)
 {
 	json_object *jarray;
 	int len;
@@ -1294,7 +1353,6 @@ static bool read_net_transmit(json_object *jobj, struct mesh_config_node *node)
 static bool read_node(json_object *jnode, struct mesh_config_node *node)
 {
 	json_object *jvalue;
-	char *str;
 
 	if (!read_iv_index(jnode, &node->iv_index, &node->iv_update)) {
 		l_info("Failed to read IV index");
@@ -1318,25 +1376,20 @@ static bool read_node(json_object *jnode, struct mesh_config_node *node)
 
 	parse_features(jnode, node);
 
-	if (!json_object_object_get_ex(jnode, "unicastAddress", &jvalue)) {
-		l_info("Bad config: Unicast address must be present");
+	if (!read_unicast_address(jnode, &node->unicast)) {
+		l_info("Failed to parse unicast address");
 		return false;
 	}
 
-	str = (char *)json_object_get_string(jvalue);
-	if (sscanf(str, "%04hx", &node->unicast) != 1)
+	if (!read_default_ttl(jnode, &node->ttl)) {
+		l_info("Failed to parse default ttl");
 		return false;
-
-	if (json_object_object_get_ex(jnode, "defaultTTL", &jvalue)) {
-		int ttl = json_object_get_int(jvalue);
-
-		if (ttl < 0 || ttl == 1 || ttl > DEFAULT_TTL)
-			return false;
-		node->ttl = (uint8_t) ttl;
 	}
 
-	if (json_object_object_get_ex(jnode, "sequenceNumber", &jvalue))
-		node->seq_number = json_object_get_int(jvalue);
+	if (!read_seq_number(jnode, &node->seq_number)) {
+		l_info("Failed to parse sequence number");
+		return false;
+	}
 
 	/* Check for required "elements" property */
 	if (!json_object_object_get_ex(jnode, "elements", &jvalue))
-- 
2.19.1


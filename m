Return-Path: <SRS0=/vUS=V2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE676C7618E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jul 2019 13:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F1E206DD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jul 2019 13:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="dV5/Mg0I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfG2Nk5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Jul 2019 09:40:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42932 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfG2Nk4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Jul 2019 09:40:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id t28so58627796lje.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2019 06:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jLTv3f5KRrQvSUT7EWO8p45jlUUQ/gIaogWpQmPQNSw=;
        b=dV5/Mg0Ina8wJiwZDNtUHm/9T9I9UzJ8LtHybjh1/oN4MivVoxg6x7cfpZiVgeONxz
         OYdYpbICqz0c1hLHAt99kwULHHHXoyUKl2C8uUxRCRlym2mNGvxDQcY91tD2QuvQvbJV
         1NW9zOVE37y+nw2NnQahr3HZB17BXzfSbMkLH0PKGrUGYnCFFeeN/p96Njgk0FPeUB2I
         uorBC01ODpCR/o6elP+3lJVZL/AfB/m98BMmx0qPiy0dYJjmQvOENC+9Zv/n9GnKTj6+
         xKmiTm+2fQveKS+29QFfKsTbG5ux500bo3ub7HlQnNtHfeTw0gVPRyr5w0899IoDif79
         Quyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jLTv3f5KRrQvSUT7EWO8p45jlUUQ/gIaogWpQmPQNSw=;
        b=PoKxH8wROIqsWMk3yrFeGkE2xSCUpxy/cKDksRkIeXm7pbGJFZgETRq2w0BcT5/9It
         NWs0O9NPbDTVzXwoNvVC8aArK70mkkVDMyaLsqOkeMN8BdhFvhmHsARTAkM66UGzaorm
         HY9y1NKIytwm09jkPFowD2fx4njSxDlBZF+h6rwDTs6o94elOidUL0s43tUtXwL5+8dA
         VjnuV0uqpMBArOY3cCdwiXqDnCtwNtuVrF5eLMomLI8ZJi3K7f9rZ7pAvYbQClu4Ct04
         0vzBSyDWjRm946hUU2d9JxdY4GjKfb8bKWr/dv9svIFpbksv2RQNpCR7vBC0VCz/Jnyd
         Lrqg==
X-Gm-Message-State: APjAAAWhP2PIyqzjz8IDK5MutlgC6ljPIQI37hTV7xjdp7QVGWUaIqq/
        613IRrACwSc3ocB5xgab9BlSpzoKYsU=
X-Google-Smtp-Source: APXvYqyJcoFsFzdV51w7g6jzWrZTEMooMBL46iRjL7frk6duHqqY4GM5z/AtXkeHVIekf+TjDgUU/g==
X-Received: by 2002:a2e:7c15:: with SMTP id x21mr58280967ljc.55.1564407654736;
        Mon, 29 Jul 2019 06:40:54 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id h84sm12762220ljf.42.2019.07.29.06.40.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 06:40:54 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Jakub Witowski <jakub.witowski@silvair.com>
Subject: [PATCH BlueZ v6 1/3] mesh: Extract read_* functions in mesh-config-json
Date:   Mon, 29 Jul 2019 15:40:45 +0200
Message-Id: <20190729134047.21033-2-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190729134047.21033-1-michal.lowas-rzechonek@silvair.com>
References: <20190729134047.21033-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Jakub Witowski <jakub.witowski@silvair.com>

This is a small improvement of read_node function readability.
---
 mesh/mesh-config-json.c | 68 +++++++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 19 deletions(-)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index e3baf5dc6..c63883a3d 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -297,6 +297,51 @@ static json_object *jarray_key_del(json_object *jarray, int16_t idx)
 	return jarray_new;
 }
 
+static bool read_unicast_address(json_object *jobj,
+							uint16_t *unicast)
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
+static bool read_default_ttl(json_object *jobj,
+								uint8_t *ttl)
+{
+	json_object *jvalue;
+	int val;
+
+	if (!json_object_object_get_ex(jobj, "defaultTTL", &jvalue))
+		return false;
+
+	val = json_object_get_int(jvalue);
+
+	if (val < 0 || val == 1 || val > DEFAULT_TTL)
+		return false;
+	*ttl = (uint8_t) val;
+
+	return true;
+}
+
+static bool read_seq_number(json_object *jobj, uint32_t *seq_number)
+{
+	json_object *jvalue;
+
+	if (!json_object_object_get_ex(jobj, "sequenceNumber", &jvalue))
+		return false;
+
+	*seq_number = json_object_get_int(jvalue);
+	return true;
+}
+
 static bool read_iv_index(json_object *jobj, uint32_t *idx, bool *update)
 {
 	int tmp;
@@ -424,7 +469,7 @@ fail:
 	return false;
 }
 
-static bool read_net_keys(json_object *jobj,  struct mesh_config_node *node)
+static bool read_net_keys(json_object *jobj, struct mesh_config_node *node)
 {
 	json_object *jarray;
 	int len;
@@ -1294,7 +1339,6 @@ static bool read_net_transmit(json_object *jobj, struct mesh_config_node *node)
 static bool read_node(json_object *jnode, struct mesh_config_node *node)
 {
 	json_object *jvalue;
-	char *str;
 
 	if (!read_iv_index(jnode, &node->iv_index, &node->iv_update)) {
 		l_info("Failed to read IV index");
@@ -1318,25 +1362,11 @@ static bool read_node(json_object *jnode, struct mesh_config_node *node)
 
 	parse_features(jnode, node);
 
-	if (!json_object_object_get_ex(jnode, "unicastAddress", &jvalue)) {
-		l_info("Bad config: Unicast address must be present");
-		return false;
-	}
-
-	str = (char *)json_object_get_string(jvalue);
-	if (sscanf(str, "%04hx", &node->unicast) != 1)
-		return false;
-
-	if (json_object_object_get_ex(jnode, "defaultTTL", &jvalue)) {
-		int ttl = json_object_get_int(jvalue);
+	read_unicast_address(jnode, &node->unicast);
 
-		if (ttl < 0 || ttl == 1 || ttl > DEFAULT_TTL)
-			return false;
-		node->ttl = (uint8_t) ttl;
-	}
+	read_default_ttl(jnode, &node->ttl);
 
-	if (json_object_object_get_ex(jnode, "sequenceNumber", &jvalue))
-		node->seq_number = json_object_get_int(jvalue);
+	read_seq_number(jnode, &node->seq_number);
 
 	/* Check for required "elements" property */
 	if (!json_object_object_get_ex(jnode, "elements", &jvalue))
-- 
2.19.1


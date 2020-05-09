Return-Path: <SRS0=Rej4=6X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D73C47247
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 May 2020 00:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6270B217BA
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 May 2020 00:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgEIAA2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 May 2020 20:00:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:65492 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728355AbgEIAA1 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 May 2020 20:00:27 -0400
IronPort-SDR: XHREUZgc6FakBlPi0kI2yLuTFXacmII+qBrddVpxDVr6uUsjHSzfhD0Y9ZyH/tzj4cnaLbYdg/
 gkb0QwQ2ZxWA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 17:00:27 -0700
IronPort-SDR: D/TLFg/HW1FsLUGamigzTDQWTPcv8ap8LPTy5y2UVG+nDo2ZfiMt7/Q09PubXjtjGrf/cMSZ+A
 mlHfeBYM1JTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,369,1583222400"; 
   d="scan'208";a="408275096"
Received: from ingas-nuc1.sea.intel.com ([10.254.110.242])
  by orsmga004.jf.intel.com with ESMTP; 08 May 2020 17:00:26 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/4] mesh: Avoid saving duplicate fields in node config
Date:   Fri,  8 May 2020 17:00:22 -0700
Message-Id: <20200509000024.5704-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200509000024.5704-1-inga.stotland@intel.com>
References: <20200509000024.5704-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This modifies miscellaneous utility functions in mesh-config-json.c:
when writing a new value to a node configuration file, delete
the existing field containing an old value first.
---
 mesh/mesh-config-json.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 7362112f2..ce7058b5a 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -105,7 +105,7 @@ static bool get_int(json_object *jobj, const char *keyword, int *value)
 	return true;
 }
 
-static bool add_u64_value(json_object *jobject, const char *desc,
+static bool add_u64_value(json_object *jobj, const char *desc,
 					const uint8_t u64[8])
 {
 	json_object *jstring;
@@ -116,11 +116,12 @@ static bool add_u64_value(json_object *jobject, const char *desc,
 	if (!jstring)
 		return false;
 
-	json_object_object_add(jobject, desc, jstring);
+	json_object_object_del(jobj, desc);
+	json_object_object_add(jobj, desc, jstring);
 	return true;
 }
 
-static bool add_key_value(json_object *jobject, const char *desc,
+static bool add_key_value(json_object *jobj, const char *desc,
 					const uint8_t key[16])
 {
 	json_object *jstring;
@@ -131,7 +132,8 @@ static bool add_key_value(json_object *jobject, const char *desc,
 	if (!jstring)
 		return false;
 
-	json_object_object_add(jobject, desc, jstring);
+	json_object_object_del(jobj, desc);
+	json_object_object_add(jobj, desc, jstring);
 	return true;
 }
 
@@ -1398,6 +1400,7 @@ static bool write_uint16_hex(json_object *jobj, const char *desc,
 	if (!jstring)
 		return false;
 
+	json_object_object_del(jobj, desc);
 	json_object_object_add(jobj, desc, jstring);
 	return true;
 }
@@ -1412,21 +1415,21 @@ static bool write_uint32_hex(json_object *jobj, const char *desc, uint32_t val)
 	if (!jstring)
 		return false;
 
+	json_object_object_del(jobj, desc);
 	json_object_object_add(jobj, desc, jstring);
 	return true;
 }
 
-static bool write_int(json_object *jobj, const char *keyword, int val)
+static bool write_int(json_object *jobj, const char *desc, int val)
 {
 	json_object *jvalue;
 
-	json_object_object_del(jobj, keyword);
-
 	jvalue = json_object_new_int(val);
 	if (!jvalue)
 		return false;
 
-	json_object_object_add(jobj, keyword, jvalue);
+	json_object_object_del(jobj, desc);
+	json_object_object_add(jobj, desc, jvalue);
 	return true;
 }
 
@@ -1442,7 +1445,7 @@ static const char *mode_to_string(int mode)
 	}
 }
 
-static bool write_mode(json_object *jobj, const char *keyword, int value)
+static bool write_mode(json_object *jobj, const char *desc, int value)
 {
 	json_object *jstring;
 
@@ -1451,7 +1454,8 @@ static bool write_mode(json_object *jobj, const char *keyword, int value)
 	if (!jstring)
 		return false;
 
-	json_object_object_add(jobj, keyword, jstring);
+	json_object_object_del(jobj, desc);
+	json_object_object_add(jobj, desc, jstring);
 
 	return true;
 }
-- 
2.21.3


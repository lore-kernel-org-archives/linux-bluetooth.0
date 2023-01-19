Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EB1C46467
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Jan 2023 23:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjASX6W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Jan 2023 18:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjASX6V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Jan 2023 18:58:21 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AB6A1990
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jan 2023 15:58:13 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id k10-20020a17090a590a00b0022ba875a1a4so489264pji.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jan 2023 15:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zy9iY3/QbiZ1OQ7dIvLs67lPrMPeRn+BI6A1zHzax00=;
        b=RdbTTsjVloQhhDvNoxmdGkz/vACxqYUEGOECaZNXb/Gz9OwEOnpbsoC7VkPz3IpEoR
         b6ZP32YJsNCb6rYyv5FhdHfanoupHbQTuzRweVXueUhtLNVXOJvC1rc5oB09DFO7xsOm
         4V55C+MucxF0++eC4L2AHOBC3t9CheucQiBBlAvVQENmmN1/vBQLGV1Bkp8EQePZVcR4
         KJT+SitsSmYa0Pc+v0xSITIHpiASzxPHcc8iUnI5g+thErs/53Sqx42C0NPStrIXbqad
         hiJNEQYNkjulG5eGptgLn1MHkNADhJr+5dW2sRIhy0mCT47F8PHrp642wRF4mbz5QFoX
         NQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zy9iY3/QbiZ1OQ7dIvLs67lPrMPeRn+BI6A1zHzax00=;
        b=fcYeW3rLtmObX4Uk+SXQssv839P124cpUfd+ntTgs+QYsmzahrHhN4j2qpvxAvms5r
         Hqo2S0wd5ncrdT4l4hJ9mXqZdFxdOxLQ0vXNyHMePXMRGchDW+MeYAJBfKJnHlL0GCKa
         R6o/roiAmzdzj3Hlvg6SPmeJmi+G2dalwJdCCosFt7T405reESY4OuSwg5audx5G2iQh
         BZMU/4cNdoAWt9OwY5DJ4IMOLf3BdHqtAAAmLBJXAOmo1HH+upZ8gFNnqdrYjKn98mcc
         3nxG/K9svg8HOjHK7lL6mfCqvEWcPQgv7ULN0RbZhYxRRIdi0Mg8Op0bKivqfW0GRnGI
         We4w==
X-Gm-Message-State: AFqh2kqTwdTSCFHNBbHXjHxqH39ga4nBH73SCQnxUMWSWlrUZSH+ERWg
        mgrY+LX62ZPjxsbvOO3DHI9SKjXL70ySaQ==
X-Google-Smtp-Source: AMrXdXv/OugGbxnYp+1lPXnxuvX2HEM9Pq5bfwbVjPP1YO0/gkchlorvTHzsijSFLpFeV36fJWXIRQ==
X-Received: by 2002:a17:902:bd97:b0:190:fc28:8cca with SMTP id q23-20020a170902bd9700b00190fc288ccamr13310981pls.10.1674172692592;
        Thu, 19 Jan 2023 15:58:12 -0800 (PST)
Received: from fedora.. (97-113-173-242.tukw.qwest.net. [97.113.173.242])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902d2ca00b0019460c34839sm14826373plc.185.2023.01.19.15.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 15:58:12 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ 09/12] mesh: Add internal Mesh Private Beacon model
Date:   Thu, 19 Jan 2023 15:57:52 -0800
Message-Id: <20230119235755.46002-10-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119235755.46002-1-brian.gix@gmail.com>
References: <20230119235755.46002-1-brian.gix@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

Adds recgnition that the Mesh Private Beacon model is internal
and foundational, without bindings.
---
 mesh/model.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mesh/model.c b/mesh/model.c
index e2babea10..4ccafa17e 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -26,6 +26,7 @@
 #include "mesh/cfgmod.h"
 #include "mesh/prov.h"
 #include "mesh/remprv.h"
+#include "mesh/prv-beacon.h"
 #include "mesh/error.h"
 #include "mesh/dbus.h"
 #include "mesh/util.h"
@@ -81,6 +82,9 @@ static bool is_internal(uint32_t id)
 	if (id == REM_PROV_SRV_MODEL || id == REM_PROV_CLI_MODEL)
 		return true;
 
+	if (id == PRV_BEACON_SRV_MODEL || id == PRV_BEACON_CLI_MODEL)
+		return true;
+
 	return false;
 }
 
@@ -647,6 +651,9 @@ static int update_binding(struct mesh_node *node, uint16_t addr, uint32_t id,
 	if (id == CONFIG_SRV_MODEL || id == CONFIG_CLI_MODEL)
 		return MESH_STATUS_INVALID_MODEL;
 
+	if (id == PRV_BEACON_SRV_MODEL || id == PRV_BEACON_CLI_MODEL)
+		return MESH_STATUS_INVALID_MODEL;
+
 	if (!appkey_have_key(node_get_net(node), app_idx))
 		return MESH_STATUS_INVALID_APPKEY;
 
@@ -1655,7 +1662,8 @@ static struct mesh_model *model_setup(struct mesh_net *net, uint8_t ele_idx,
 						SET_ID(SIG_VENDOR, db_mod->id));
 
 	/* Implicitly bind config server model to device key */
-	if (db_mod->id == CONFIG_SRV_MODEL) {
+	if (db_mod->id == CONFIG_SRV_MODEL ||
+					db_mod->id == PRV_BEACON_SRV_MODEL) {
 
 		if (ele_idx != PRIMARY_ELE_IDX) {
 			l_free(mod);
-- 
2.39.0


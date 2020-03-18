Return-Path: <SRS0=jOg2=5D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE99C10DCE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 17:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2768220752
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 17:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgCRRtM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:49:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:6966 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgCRRtM (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Mar 2020 13:49:12 -0400
IronPort-SDR: 63whZLuKpdGOxpJRugWz2ZLyx0lDp69XvJ9PqsTtMJdi7OZzj2+CtPzZgYHqll4ZYYow6rn6v7
 3nElOmAfUfkw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 10:49:01 -0700
IronPort-SDR: piXBiRjJKmEk3w3sn2MCISXFaLMvTNYIgUfQzZ2KNl3OU1GO74VZ08koh9XlcXisrqlLJwGhz4
 D5BD/L+/dgUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,568,1574150400"; 
   d="scan'208";a="233915376"
Received: from ingas-nuc1.sea.intel.com ([10.251.7.231])
  by orsmga007.jf.intel.com with ESMTP; 18 Mar 2020 10:49:00 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] tools/mesh-cfgclient: Increase app's CRPL size
Date:   Wed, 18 Mar 2020 10:48:59 -0700
Message-Id: <20200318174859.27387-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This increases the value of the CRPL supplied by the applicaiton
to 0x7fff: since the tool is intended to be a provisioner and config
client, it may have to keep track of communications with a significant
number of unique mesh nodes, each with its corresponding CRPL entry in
config client node storage. Therefore, a large CRPL size is necessary.
---
 tools/mesh-cfgclient.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index e4523e5fc..ae13c4409 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -57,6 +57,7 @@
 #define DEFAULT_START_ADDRESS	0x00aa
 #define DEFAULT_MAX_ADDRESS	(VIRTUAL_ADDRESS_LOW - 1)
 #define DEFAULT_NET_INDEX	0x0000
+#define MAX_CRPL_SIZE		0x7fff
 
 #define DEFAULT_CFG_FILE	"config_db.json"
 
@@ -122,7 +123,7 @@ static struct meshcfg_app app = {
 	.cid = 0x05f1,
 	.pid = 0x0002,
 	.vid = 0x0001,
-	.crpl = 10,
+	.crpl = MAX_CRPL_SIZE,
 	.ele = {
 		.path = "/mesh/cfgclient/ele0",
 		.index = 0,
-- 
2.21.1


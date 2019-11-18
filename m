Return-Path: <SRS0=idF9=ZK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5480AC432C0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 00:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3271920730
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 00:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfKRAlR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 17 Nov 2019 19:41:17 -0500
Received: from jax4mhob16.registeredsite.com ([64.69.218.104]:33570 "EHLO
        jax4mhob16.registeredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726297AbfKRAlR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 17 Nov 2019 19:41:17 -0500
X-Greylist: delayed 1847 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Nov 2019 19:41:16 EST
Received: from mailpod.hostingplatform.com ([10.30.71.85])
        by jax4mhob16.registeredsite.com (8.14.4/8.14.4) with ESMTP id xAI0AQBu168753
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Nov 2019 19:10:27 -0500
Received: (qmail 142336 invoked by uid 0); 18 Nov 2019 00:10:26 -0000
X-TCPREMOTEIP: 65.41.18.216
X-Authenticated-UID: sbrown@opensat.com
Received: from unknown (HELO 155-15-85-208.altiusbb.net) (sbrown@opensat.com@65.41.18.216)
  by 0 with ESMTPA; 18 Nov 2019 00:10:26 -0000
Received: from localhost (localhost [127.0.0.1])
        by 155-15-85-208.altiusbb.net (Postfix) with ESMTP id BF0901540518;
        Sun, 17 Nov 2019 19:10:25 -0500 (EST)
X-Virus-Scanned: Debian amavisd-new at ewol.com
Received: from 155-15-85-208.altiusbb.net ([127.0.0.1])
        by localhost (fl-server.ewol.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gFPm7eC0mPRo; Sun, 17 Nov 2019 19:10:24 -0500 (EST)
Received: from raspberrypi.ewol.com (unknown [192.168.2.126])
        by 155-15-85-208.altiusbb.net (Postfix) with ESMTPS id 06F491540293;
        Sun, 17 Nov 2019 19:10:24 -0500 (EST)
Received: from pi by raspberrypi.ewol.com with local (Exim 4.89)
        (envelope-from <sbrown@ewol.com>)
        id 1iWUcY-0001ZB-Cq; Sun, 17 Nov 2019 19:10:22 -0500
From:   sbrown@ewol.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Steve Brown <sbrown@ewol.com>
Subject: [PATCH BlueZ] mesh: Correct typo in cfg_cmd table
Date:   Sun, 17 Nov 2019 19:09:51 -0500
Message-Id: <20191118000951.5982-1-sbrown@ewol.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Steve Brown <sbrown@ewol.com>

---
 tools/mesh/cfgcli.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index 44f7dac1e..dc7b266f8 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -140,9 +140,9 @@ static struct cfg_cmd cmds[] = {
 	{ OP_CONFIG_HEARTBEAT_PUB_SET, OP_CONFIG_HEARTBEAT_PUB_STATUS,
 							"HeartbeatPubSet" },
 	{ OP_CONFIG_HEARTBEAT_PUB_STATUS, NO_RESPONSE, "HeartbeatPubStatus" },
-	{ OP_CONFIG_HEARTBEAT_SUB_GET, OP_CONFIG_HEARTBEAT_SUB_GET,
+	{ OP_CONFIG_HEARTBEAT_SUB_GET, OP_CONFIG_HEARTBEAT_SUB_STATUS,
 							"HeartbeatSubGet" },
-	{ OP_CONFIG_HEARTBEAT_SUB_SET, OP_CONFIG_HEARTBEAT_SUB_GET,
+	{ OP_CONFIG_HEARTBEAT_SUB_SET, OP_CONFIG_HEARTBEAT_SUB_STATUS,
 							"HeartbeatSubSet" },
 	{ OP_CONFIG_HEARTBEAT_SUB_STATUS, NO_RESPONSE, "HeartbeatSubStatus" },
 	{ OP_MODEL_APP_BIND, OP_MODEL_APP_STATUS, "ModelAppBind" },
-- 
2.11.0


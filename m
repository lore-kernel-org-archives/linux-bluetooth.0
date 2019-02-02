Return-Path: <SRS0=cdju=QJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9327DC282DB
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Feb 2019 06:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F78721721
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Feb 2019 06:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfBBGth (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 2 Feb 2019 01:49:37 -0500
Received: from mga01.intel.com ([192.55.52.88]:13516 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbfBBGth (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 2 Feb 2019 01:49:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 22:49:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,551,1539673200"; 
   d="scan'208";a="130559559"
Received: from ingas-nuc1.sea.intel.com ([10.254.14.200])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Feb 2019 22:49:36 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, brian.gix@intel.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Remove unnecessary variable initialization
Date:   Fri,  1 Feb 2019 22:49:35 -0800
Message-Id: <20190202064935.13579-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/mesh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/mesh.c b/mesh/mesh.c
index 881b6ed73..2c45c0a87 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -665,7 +665,7 @@ static struct l_dbus_message *attach_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
 {
-	uint64_t token = 1;
+	uint64_t token;
 	const char *app_path, *sender;
 	struct attach_data *pending;
 
-- 
2.17.2


Return-Path: <SRS0=/mwE=PU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009FDC43387
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Jan 2019 02:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA17F20851
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Jan 2019 02:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfALClF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Jan 2019 21:41:05 -0500
Received: from mga17.intel.com ([192.55.52.151]:47479 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfALClE (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Jan 2019 21:41:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jan 2019 18:41:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,467,1539673200"; 
   d="scan'208";a="125286942"
Received: from ingas-nuc1.sea.intel.com ([10.254.189.224])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jan 2019 18:41:04 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/2] mesh: Fix reading device UUID from Join() call
Date:   Fri, 11 Jan 2019 18:40:54 -0800
Message-Id: <20190112024055.9967-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Supply correct parameters to l_dbus_message_iter_get_fixed_array
to get the location from where to read UUID value.
---
 mesh/mesh.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mesh/mesh.c b/mesh/mesh.c
index 169e6f42c..8971f7cc4 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -564,6 +564,7 @@ static struct l_dbus_message *join_network_call(struct l_dbus *dbus,
 {
 	const char *app_path, *sender;
 	struct l_dbus_message_iter iter_uuid;
+	uint8_t *uuid;
 	uint32_t n;
 
 	l_debug("Join network request");
@@ -578,7 +579,7 @@ static struct l_dbus_message *join_network_call(struct l_dbus *dbus,
 
 	join_pending = l_new(struct join_data, 1);
 
-	l_dbus_message_iter_get_fixed_array(&iter_uuid, join_pending->uuid, &n);
+	l_dbus_message_iter_get_fixed_array(&iter_uuid, &uuid, &n);
 
 	if (n != 16) {
 		l_free(join_pending);
@@ -587,6 +588,8 @@ static struct l_dbus_message *join_network_call(struct l_dbus *dbus,
 							"Bad device UUID");
 	}
 
+	memcpy(join_pending->uuid, uuid, 16);
+
 	sender = l_dbus_message_get_sender(msg);
 
 	join_pending->sender = l_strdup(sender);
-- 
2.17.2


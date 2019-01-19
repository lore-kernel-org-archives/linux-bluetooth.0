Return-Path: <SRS0=MOIW=P3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8051EC61CE8
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Jan 2019 06:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B542086D
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Jan 2019 06:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfASGxV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Jan 2019 01:53:21 -0500
Received: from mga11.intel.com ([192.55.52.93]:23404 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbfASGxU (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Jan 2019 01:53:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2019 22:53:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,494,1539673200"; 
   d="scan'208";a="119705393"
Received: from ingas-nuc1.sea.intel.com ([10.254.106.117])
  by orsmga003.jf.intel.com with ESMTP; 18 Jan 2019 22:53:19 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Fix logic when cleaning up incomplete provisioning
Date:   Fri, 18 Jan 2019 22:53:18 -0800
Message-Id: <20190119065318.9203-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Do not call acceptor_cancel() if the provisioning has been completed,
either fail or success. Acceptor automatically takes care of cleanup
on completion, either successful or not.
---
 mesh/mesh.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mesh/mesh.c b/mesh/mesh.c
index a1c26e77c..881b6ed73 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -354,8 +354,6 @@ static void free_pending_join_call(bool failed)
 		l_dbus_remove_watch(dbus_get_bus(),
 						join_pending->disc_watch);
 
-	acceptor_cancel(&mesh);
-
 	mesh_agent_remove(join_pending->agent);
 
 	if (failed) {
@@ -375,11 +373,14 @@ void mesh_cleanup(void)
 	mgmt_unref(mgmt_mesh);
 
 	if (join_pending) {
-		/* The Join() call failed since it has not been completed */
-		reply = dbus_error(join_pending->msg, MESH_ERROR_FAILED,
+
+		if (join_pending->msg) {
+			reply = dbus_error(join_pending->msg, MESH_ERROR_FAILED,
 							"Failed. Exiting");
-		l_dbus_send(dbus_get_bus(), reply);
+			l_dbus_send(dbus_get_bus(), reply);
+		}
 
+		acceptor_cancel(&mesh);
 		free_pending_join_call(true);
 	}
 
@@ -428,6 +429,7 @@ static void prov_disc_cb(struct l_dbus *bus, void *user_data)
 	if (join_pending->msg)
 		l_dbus_message_unref(join_pending->msg);
 
+	acceptor_cancel(&mesh);
 	join_pending->disc_watch = 0;
 
 	free_pending_join_call(true);
-- 
2.17.2


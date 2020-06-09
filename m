Return-Path: <SRS0=V72R=7W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B058DC433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 19:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C0CB20734
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 19:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389155AbgFITKT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:10:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:40922 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389150AbgFITKS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Jun 2020 15:10:18 -0400
IronPort-SDR: pXjy7dcf9HweKPMYpuuGtQGooRFtVHqQXGyeLEkJSoVdsX1zbPqjftKYQVw1A0Z0PZRzpoCyKv
 2/2xnCvZ8Ueg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 12:10:18 -0700
IronPort-SDR: zWl0NMbl8A5e4Ye20zIpQinUNhIefMCsZL1+HPt/dVhtue7raUPg/mUxAms2Ti6hwizb/NXzV1
 3CVq3+NVkfLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,493,1583222400"; 
   d="scan'208";a="259071182"
Received: from rpedgeco-mobl.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.255.229.21])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2020 12:10:18 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, przemyslaw.fierek@silvair.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2 1/4] mesh: Make "Busy" and "InProgress" to be distinct errors
Date:   Tue,  9 Jun 2020 12:10:12 -0700
Message-Id: <20200609191015.18459-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200609191015.18459-1-inga.stotland@intel.com>
References: <20200609191015.18459-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This separates "Busy" and "InProgress" error codes:
MESH_ERROR_IN_PROGRESS maps to org.bluez.mesh.Error.InProgress
MESH_ERROR_BUSY maps to org.bluez.mesh.Error.Busy

Minor API change:
UpdateAppKey() returns "InProgress" error instead of "Busy"
---
 doc/mesh-api.txt |  2 +-
 mesh/dbus.c      |  3 ++-
 mesh/error.h     |  1 +
 mesh/manager.c   | 11 +++++------
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 24cface22..e85f0bf52 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -654,7 +654,7 @@ Methods:
 			org.bluez.mesh.Error.Failed
 			org.bluez.mesh.Error.InvalidArguments
 			org.bluez.mesh.Error.DoesNotExist
-			org.bluez.mesh.Error.Busy
+			org.bluez.mesh.Error.InProgress
 
 	void DeleteAppKey(uint16 app_index)
 
diff --git a/mesh/dbus.c b/mesh/dbus.c
index bf0f73bd9..83ae22c9f 100644
--- a/mesh/dbus.c
+++ b/mesh/dbus.c
@@ -56,7 +56,8 @@ static struct error_entry const error_table[] =
 	{ ERROR_INTERFACE ".NotAuthorized", "Permission denied"},
 	{ ERROR_INTERFACE ".NotFound", "Object not found"},
 	{ ERROR_INTERFACE ".InvalidArgs", "Invalid arguments"},
-	{ ERROR_INTERFACE ".InProgress", "Already in progress"},
+	{ ERROR_INTERFACE ".InProgress", "Operation already in progress"},
+	{ ERROR_INTERFACE ".Busy", "Busy"},
 	{ ERROR_INTERFACE ".AlreadyExists", "Already exists"},
 	{ ERROR_INTERFACE ".DoesNotExist", "Does not exist"},
 	{ ERROR_INTERFACE ".Canceled", "Operation canceled"},
diff --git a/mesh/error.h b/mesh/error.h
index f3e0f5476..2809915b0 100644
--- a/mesh/error.h
+++ b/mesh/error.h
@@ -27,6 +27,7 @@ enum mesh_error {
 	MESH_ERROR_NOT_AUTHORIZED,
 	MESH_ERROR_NOT_FOUND,
 	MESH_ERROR_INVALID_ARGS,
+	MESH_ERROR_IN_PROGRESS,
 	MESH_ERROR_BUSY,
 	MESH_ERROR_ALREADY_EXISTS,
 	MESH_ERROR_DOES_NOT_EXIST,
diff --git a/mesh/manager.c b/mesh/manager.c
index 2be471088..8ef681366 100644
--- a/mesh/manager.c
+++ b/mesh/manager.c
@@ -60,7 +60,7 @@ static void scan_cancel(struct l_timeout *timeout, void *user_data)
 	struct mesh_io *io;
 	struct mesh_net *net;
 
-	l_debug("scan_cancel");
+	l_debug("");
 
 	if (scan_timeout)
 		l_timeout_remove(scan_timeout);
@@ -249,11 +249,10 @@ static struct l_dbus_message *add_node_call(struct l_dbus *dbus,
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
 	if (!l_dbus_message_iter_get_fixed_array(&iter_uuid, &uuid, &n)
-	    || n != 16) {
-		l_debug("n = %u", n);
+								|| n != 16)
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
 							"Bad device UUID");
-	}
+
 	/* Allow AddNode to cancel Scanning if from the same node */
 	if (scan_node) {
 		if (scan_node != node)
@@ -263,7 +262,6 @@ static struct l_dbus_message *add_node_call(struct l_dbus *dbus,
 	}
 
 	/* Invoke Prov Initiator */
-
 	add_pending = l_new(struct add_data, 1);
 	memcpy(add_pending->uuid, uuid, 16);
 	add_pending->node = node;
@@ -554,7 +552,8 @@ static struct l_dbus_message *update_subnet_call(struct l_dbus *dbus,
 	}
 
 	/* All other phases mean KR already in progress over-the-air */
-	return dbus_error(msg, MESH_ERROR_BUSY, "Key Refresh in progress");
+	return dbus_error(msg, MESH_ERROR_IN_PROGRESS,
+					"Key Refresh in progress");
 }
 
 static struct l_dbus_message *delete_subnet_call(struct l_dbus *dbus,
-- 
2.26.2


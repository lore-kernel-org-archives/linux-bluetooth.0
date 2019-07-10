Return-Path: <SRS0=sCKx=VH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA89C74A36
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 23:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40CC7214AF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 23:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfGJXIY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jul 2019 19:08:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:52368 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfGJXIY (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jul 2019 19:08:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 16:08:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,476,1557212400"; 
   d="scan'208";a="186250405"
Received: from bgix-dell-lap.sea.intel.com ([10.255.80.129])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2019 16:08:24 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, michal.lowas-rzechonek@silvair.com,
        brian.gix@intel.com
Subject: [PATCH BlueZ 4/8] mesh: Expose mapping function for D-Bus errors
Date:   Wed, 10 Jul 2019 16:07:53 -0700
Message-Id: <20190710230757.8425-5-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190710230757.8425-1-brian.gix@intel.com>
References: <20190710230757.8425-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/mesh.c | 8 ++++----
 mesh/mesh.h | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/mesh/mesh.c b/mesh/mesh.c
index 26acfd4dc..62c80c0f3 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -266,7 +266,7 @@ static void prov_disc_cb(struct l_dbus *bus, void *user_data)
 	free_pending_join_call(true);
 }
 
-static const char *prov_status_str(uint8_t status)
+const char *mesh_prov_status_str(uint8_t status)
 {
 	switch (status) {
 	case PROV_ERR_SUCCESS:
@@ -301,7 +301,7 @@ static void send_join_failed(const char *owner, const char *path,
 						MESH_APPLICATION_INTERFACE,
 						"JoinFailed");
 
-	l_dbus_message_set_arguments(msg, "s", prov_status_str(status));
+	l_dbus_message_set_arguments(msg, "s", mesh_prov_status_str(status));
 	l_dbus_send(dbus_get_bus(), msg);
 
 	free_pending_join_call(true);
@@ -316,7 +316,7 @@ static bool prov_complete_cb(void *user_data, uint8_t status,
 	const char *path;
 	const uint8_t *token;
 
-	l_debug("Provisioning complete %s", prov_status_str(status));
+	l_debug("Provisioning complete %s", mesh_prov_status_str(status));
 
 	if (!join_pending)
 		return false;
@@ -342,7 +342,7 @@ static bool prov_complete_cb(void *user_data, uint8_t status,
 
 	l_dbus_message_set_arguments(msg, "t", l_get_be64(token));
 
-	l_dbus_send(dbus_get_bus(), msg);
+	l_dbus_send(dbus, msg);
 
 	free_pending_join_call(false);
 
diff --git a/mesh/mesh.h b/mesh/mesh.h
index 14b1fb517..2ef77b57d 100644
--- a/mesh/mesh.h
+++ b/mesh/mesh.h
@@ -42,3 +42,4 @@ bool mesh_send_pkt(uint8_t count, uint16_t interval, uint8_t *data,
 bool mesh_send_cancel(const uint8_t *filter, uint8_t len);
 bool mesh_reg_prov_rx(prov_rx_cb_t cb, void *user_data);
 void mesh_unreg_prov_rx(prov_rx_cb_t cb);
+const char *mesh_prov_status_str(uint8_t status);
-- 
2.14.5


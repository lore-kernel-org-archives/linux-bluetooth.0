Return-Path: <SRS0=ssTf=VI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBD3C742A2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 23:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F27208E4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 23:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbfGKXAb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Jul 2019 19:00:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:52146 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbfGKXAb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Jul 2019 19:00:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 16:00:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,480,1557212400"; 
   d="scan'208";a="166516237"
Received: from bgix-dell-lap.sea.intel.com ([10.255.80.129])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jul 2019 16:00:30 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, michal.lowas-rzechonek@silvair.com,
        brian.gix@intel.com
Subject: [PATCH BlueZ v2 4/9] mesh: Expose mapping function for D-Bus errors
Date:   Thu, 11 Jul 2019 15:59:47 -0700
Message-Id: <20190711225952.1599-5-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190711225952.1599-1-brian.gix@intel.com>
References: <20190711225952.1599-1-brian.gix@intel.com>
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


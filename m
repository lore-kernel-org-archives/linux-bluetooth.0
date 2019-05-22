Return-Path: <SRS0=CsNs=TW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6DBC18E7C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 May 2019 05:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A3920862
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 May 2019 05:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbfEVFdv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 May 2019 01:33:51 -0400
Received: from mga05.intel.com ([192.55.52.43]:63614 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728424AbfEVFdv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 May 2019 01:33:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 May 2019 22:33:50 -0700
X-ExtLoop1: 1
Received: from ingas-nuc1.sea.intel.com ([10.254.190.110])
  by orsmga007.jf.intel.com with ESMTP; 21 May 2019 22:33:50 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/2] mesh: Remove unnecessary message ref/unref in agent.c
Date:   Tue, 21 May 2019 22:33:39 -0700
Message-Id: <20190522053339.6289-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190522053339.6289-1-inga.stotland@intel.com>
References: <20190522053339.6289-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This removes calls to reference/unrefernce D-Bus messages for
the methods that are called on org.bluez.mesh.ProvisionAgent1
interface since the referenced messages are not used.
---
 mesh/agent.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/mesh/agent.c b/mesh/agent.c
index 4f99bad7b..1cd09eee8 100644
--- a/mesh/agent.c
+++ b/mesh/agent.c
@@ -199,7 +199,6 @@ static void agent_free(void *agent_data)
 			break;
 		}
 
-		l_dbus_message_unref(req->msg);
 		l_free(req);
 	}
 
@@ -310,8 +309,6 @@ static void simple_reply(struct l_dbus_message *reply, void *user_data)
 
 	err = get_reply_error(reply);
 
-	l_dbus_message_unref(req->msg);
-
 	if (req->cb) {
 		cb = req->cb;
 		cb(req->user_data, err);
@@ -345,8 +342,6 @@ static void numeric_reply(struct l_dbus_message *reply, void *user_data)
 		}
 	}
 
-	l_dbus_message_unref(req->msg);
-
 	if (req->cb) {
 		cb = req->cb;
 		cb(req->user_data, err, count);
@@ -402,8 +397,6 @@ static void key_reply(struct l_dbus_message *reply, void *user_data)
 	}
 
 done:
-	l_dbus_message_unref(req->msg);
-
 	if (req->cb) {
 		cb = req->cb;
 		cb(req->user_data, err, buf, n);
@@ -444,8 +437,6 @@ static int output_request(struct mesh_agent *agent, const char *action,
 	l_dbus_send_with_reply(dbus_get_bus(), msg, simple_reply, agent,
 									NULL);
 
-	agent->req->msg = l_dbus_message_ref(msg);
-
 	return MESH_ERROR_NONE;
 }
 
@@ -486,8 +477,6 @@ static int prompt_input(struct mesh_agent *agent, const char *action,
 
 	l_dbus_send_with_reply(dbus_get_bus(), msg, reply_cb, agent, NULL);
 
-	agent->req->msg = l_dbus_message_ref(msg);
-
 	return MESH_ERROR_NONE;
 }
 
@@ -519,8 +508,6 @@ static int request_key(struct mesh_agent *agent,
 
 	l_dbus_send_with_reply(dbus_get_bus(), msg, key_reply, agent, NULL);
 
-	agent->req->msg = l_dbus_message_ref(msg);
-
 	return MESH_ERROR_NONE;
 }
 
@@ -554,10 +541,7 @@ int mesh_agent_display_string(struct mesh_agent *agent, const char *str,
 	l_dbus_send_with_reply(dbus_get_bus(), msg, simple_reply, agent,
 									NULL);
 
-	agent->req->msg = l_dbus_message_ref(msg);
-
 	return MESH_ERROR_NONE;
-
 }
 
 int mesh_agent_display_number(struct mesh_agent *agent, bool initiator,
-- 
2.21.0


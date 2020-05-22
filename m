Return-Path: <SRS0=Rzh7=7E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2BCC433E2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 20:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D898720679
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 20:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbgEVU6A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 May 2020 16:58:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:25387 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731026AbgEVU57 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 May 2020 16:57:59 -0400
IronPort-SDR: o6BpXFifhJRA/nE/kDn2fLNN72YqVyDX6EgpYI8RIcdHoaqU5hkLvQv2CbXpD29F+gq2GSbDDD
 2VBr2akRkbhA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 13:57:58 -0700
IronPort-SDR: jYY4v45wpOLyr0DwHm2WA/4hXKk1kjQYJeUv4Br/rAJ7vKrjcLnPPkJ2OkSI6DtvH7E+HT87Ro
 9RDatejGPBUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,423,1583222400"; 
   d="scan'208";a="254369949"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.254.68.94])
  by fmsmga007.fm.intel.com with ESMTP; 22 May 2020 13:57:58 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ 3/3] mesh: Fix leaked message reference
Date:   Fri, 22 May 2020 13:57:56 -0700
Message-Id: <20200522205756.230907-4-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200522205756.230907-1-brian.gix@intel.com>
References: <20200522205756.230907-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/manager.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mesh/manager.c b/mesh/manager.c
index 0242bb9e9..a7383e4d5 100644
--- a/mesh/manager.c
+++ b/mesh/manager.c
@@ -228,6 +228,7 @@ static void add_start(void *user_data, int err)
 				"Failed to start provisioning initiator");
 
 	l_dbus_send(dbus_get_bus(), reply);
+	l_dbus_message_unref(add_pending->msg);
 
 	add_pending->msg = NULL;
 }
@@ -264,7 +265,6 @@ static struct l_dbus_message *add_node_call(struct l_dbus *dbus,
 	/* Invoke Prov Initiator */
 
 	add_pending = l_new(struct add_data, 1);
-	add_pending->msg = l_dbus_message_ref(msg);
 	memcpy(add_pending->uuid, uuid, 16);
 	add_pending->node = node;
 	add_pending->agent = node_get_agent(node);
@@ -277,6 +277,7 @@ static struct l_dbus_message *add_node_call(struct l_dbus *dbus,
 		goto fail;
 	}
 
+	add_pending->msg = l_dbus_message_ref(msg);
 	initiator_start(PB_ADV, uuid, 99, 60, add_pending->agent, add_start,
 				add_data_get, add_cmplt, node, add_pending);
 
-- 
2.25.4


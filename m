Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FBCC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBF83610A1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 03:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239065AbhIWD24 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Sep 2021 23:28:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:16373 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239066AbhIWD2p (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Sep 2021 23:28:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="220555930"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="220555930"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:27:01 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="534072397"
Received: from jdudwadk-mobl.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.212.205.211])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 20:27:01 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 16/20] doc/mesh-api: Add ExportKeys call
Date:   Wed, 22 Sep 2021 20:25:59 -0700
Message-Id: <20210923032603.50536-17-inga.stotland@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210923032603.50536-1-inga.stotland@intel.com>
References: <20210923032603.50536-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add description for a new method:
ExportKeys() on org.bluez.mesh.Management1 interface.

This method is used by the authorized application to export information
about network keys, application keys and device keys present in the local
key database.
---
 doc/mesh-api.txt | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index ce651c801..85de6705e 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -728,6 +728,62 @@ Methods:
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments
 
+	dict ExportKeys(void)
+
+		This method is used by the application to export information
+		about network keys, application keys and device keys present
+		in the local key database.
+
+		dict
+			A dictionary that contains information for the keys
+			stored in the keyring with the following keys defined:
+
+			NetKeys:
+				array{struct} net_keys:
+
+				uint16 index
+					Subnet index
+
+				array{byte}[16] key
+
+				dict:
+					A dictionary that contains optional
+					key info with the following keys
+					defined:
+
+					uint8 Phase
+						Key Refresh phase of the subnet
+
+					array{byte}[16] OldKey
+
+					array{struct} AppKeys:
+
+						uint16 index
+
+							Application key index
+
+						array{byte}[16] key
+
+						dict:
+							A dictionary of optional
+							key info with the
+							following keys defined:
+
+							array{byte}[16] OldKey
+
+			DevKeys:
+				array{struct} dev_keys:
+
+				Device Key information for known remote
+				nodes in the configured Mesh network
+
+				uint16 unicast
+
+					Unicast address of the node's primary
+					element
+
+				array{byte}[16] key
+
 Mesh Application Hierarchy
 ==========================
 Service		unique name
-- 
2.31.1


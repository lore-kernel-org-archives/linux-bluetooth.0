Return-Path: <SRS0=jb0q=TO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743F1C04AB7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 May 2019 22:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449B020645
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 May 2019 22:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfENWyK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 May 2019 18:54:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:22776 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbfENWyK (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 May 2019 18:54:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 15:54:10 -0700
X-ExtLoop1: 1
Received: from ingas-nuc1.sea.intel.com ([10.252.138.236])
  by orsmga003.jf.intel.com with ESMTP; 14 May 2019 15:54:10 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/2] mesh: Add check for org.bluez.mesh.Provisioner1 interface
Date:   Tue, 14 May 2019 15:54:06 -0700
Message-Id: <20190514225407.29594-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514225407.29594-1-inga.stotland@intel.com>
References: <20190514225407.29594-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds check for the presence of org.bluez.mesh.Provisioner1
interface when collecting information about mesh application
that is received in callback of GetManagedObjects() method.
Set "provisioner" flag in the node structure to trueto indicate
that the node may act aa a provisioner.
---
 mesh/mesh.h | 3 ++-
 mesh/node.c | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/mesh/mesh.h b/mesh/mesh.h
index ff4e04fa1..9b63500d1 100644
--- a/mesh/mesh.h
+++ b/mesh/mesh.h
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
@@ -24,6 +24,7 @@
 #define MESH_ELEMENT_INTERFACE "org.bluez.mesh.Element1"
 #define MESH_APPLICATION_INTERFACE "org.bluez.mesh.Application1"
 #define MESH_PROVISION_AGENT_INTERFACE "org.bluez.mesh.ProvisionAgent1"
+#define MESH_PROVISIONER_INTERFACE "org.bluez.mesh.Provisioner1"
 #define ERROR_INTERFACE "org.bluez.mesh.Error"
 
 typedef void (*prov_rx_cb_t)(void *user_data, const uint8_t *data,
diff --git a/mesh/node.c b/mesh/node.c
index 3618595b3..21dcfd007 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2017-2018  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2017-2019  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
@@ -1492,6 +1492,9 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 								&properties);
 				if (!agent)
 					goto fail;
+			} else if (!strcmp(MESH_PROVISIONER_INTERFACE,
+								interface)) {
+				node->provisioner = true;
 			}
 		}
 	}
-- 
2.21.0


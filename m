Return-Path: <SRS0=/IWC=O4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A63C43387
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 04:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC852204FD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 04:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbeLSEWN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 23:22:13 -0500
Received: from mga04.intel.com ([192.55.52.120]:4230 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbeLSEWN (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 23:22:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 20:22:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,371,1539673200"; 
   d="scan'208";a="99820336"
Received: from bgix-dell-lap.sea.intel.com ([10.252.192.41])
  by orsmga007.jf.intel.com with ESMTP; 18 Dec 2018 20:22:12 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org, brian.gix@intel.com
Subject: [PATCH BlueZ v5 27/30] mesh: Sample Provisioning Agent
Date:   Tue, 18 Dec 2018 20:20:13 -0800
Message-Id: <20181219042016.25538-28-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181219042016.25538-1-brian.gix@intel.com>
References: <20181219042016.25538-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Inga Stotland <inga.stotland@intel.com>

---
 mesh/agent.py | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100755 mesh/agent.py

diff --git a/mesh/agent.py b/mesh/agent.py
new file mode 100755
index 000000000..22c92f952
--- /dev/null
+++ b/mesh/agent.py
@@ -0,0 +1,40 @@
+#!/usr/bin/python
+
+import sys
+import dbus
+import dbus.service
+import dbus.mainloop.glib
+
+AGENT_IFACE = 'org.bluez.mesh.ProvisionAgent1'
+AGENT_PATH = "/mesh/test/agent"
+
+bus = None
+
+class Agent(dbus.service.Object):
+	def __init__(self, bus):
+		self.path = AGENT_PATH
+		self.bus = bus
+		dbus.service.Object.__init__(self, bus, self.path)
+
+	def get_properties(self):
+		caps = []
+		oob = []
+		caps.append('out-numeric')
+		oob.append('other')
+		return {
+			AGENT_IFACE: {
+				'Capabilities': dbus.Array(caps, 's'),
+				'OutOfBandInfo': dbus.Array(oob, 's')
+			}
+		}
+
+	def get_path(self):
+		return dbus.ObjectPath(self.path)
+
+	@dbus.service.method(AGENT_IFACE, in_signature="", out_signature="")
+	def Cancel(self):
+		print("Cancel")
+
+	@dbus.service.method(AGENT_IFACE, in_signature="su", out_signature="")
+	def DisplayNumeric(self, type, value):
+		print("DisplayNumeric type=", type, " number=", value)
-- 
2.14.5


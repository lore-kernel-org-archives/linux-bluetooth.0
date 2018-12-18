Return-Path: <SRS0=Q26+=O3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46310C43612
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 22:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8512184C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 22:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbeLRWcB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:32:01 -0500
Received: from mga03.intel.com ([134.134.136.65]:60673 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbeLRWb6 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 17:31:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2018 14:31:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,370,1539673200"; 
   d="scan'208";a="101704219"
Received: from bgix-dell-lap.sea.intel.com ([10.241.111.161])
  by orsmga006.jf.intel.com with ESMTP; 18 Dec 2018 14:31:52 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org
Subject: [PATCH BlueZ v4 27/30] mesh: Sample Provisioning Agent
Date:   Tue, 18 Dec 2018 14:31:36 -0800
Message-Id: <20181218223139.8041-28-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181218223139.8041-1-brian.gix@intel.com>
References: <20181218223139.8041-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Inga Stotland <inga.stotland@intel.com>

---
 mesh/test/agent.py | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100755 mesh/test/agent.py

diff --git a/mesh/test/agent.py b/mesh/test/agent.py
new file mode 100755
index 000000000..22c92f952
--- /dev/null
+++ b/mesh/test/agent.py
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


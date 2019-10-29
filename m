Return-Path: <SRS0=CsyS=YW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AE1C47E49
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Oct 2019 20:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA5B2087F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Oct 2019 20:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfJ2UlH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Oct 2019 16:41:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:15200 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfJ2UlH (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Oct 2019 16:41:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 13:41:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,245,1569308400"; 
   d="scan'208";a="401277243"
Received: from ingas-nuc1.sea.intel.com ([10.255.229.102])
  by fmsmga006.fm.intel.com with ESMTP; 29 Oct 2019 13:41:07 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 10/10] tools/mesh-cfgclient: Add README file
Date:   Tue, 29 Oct 2019 13:40:54 -0700
Message-Id: <20191029204054.30599-11-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191029204054.30599-1-inga.stotland@intel.com>
References: <20191029204054.30599-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 tools/mesh/README | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 tools/mesh/README

diff --git a/tools/mesh/README b/tools/mesh/README
new file mode 100644
index 000000000..9362d8ff6
--- /dev/null
+++ b/tools/mesh/README
@@ -0,0 +1,54 @@
+MeshCfgclient - BlueZ PB-Adv based Bluetooth Mesh Provisioner
+*************************************************************
+
+Copyright (C) 2019  Intel Corporation. All rights reserved.
+
+Compilation and installation
+============================
+
+In addition to main BlueZ requirements, MeshCfgclient needs the following:
+	- JSON library
+
+Configuration and options
+=========================
+
+	--enable-mesh
+
+		Build mesh-cfgclient and other Bluetooth Mesh based tools
+
+Storage for mesh configuration file
+===================================
+
+The mesh-cfgclient tool generates a mesh configuration file in JSON format:
+	- mesh_db.json
+that contains information about the current state of the configured mesh
+network.
+
+The default directory for mesh-cfgclient configuration file is
+/home/<username>/.config/mesh-cfgcli
+
+To specify a custom storage directory, run mesh-config tool as:
+
+	meshctl -c <config_dir_name>
+
+If a configuration file is not found, it is assumed that a mesh network
+does not exist. In this case, the tool may be used to generate a new  mesh
+network by invoking "create" command from the main menu and, on a successful
+completion of this command, an initial configuration file is written.
+
+If the configuration file is present, then "create" command will fail. This
+is done so that the existing configuration is not accidentally overwritten.
+If the intention is to create a new network then, the existing mesh
+configuration file has to be either moved or dleted prior to running the
+mesh-cfgclient tool. Also, a new custom storage location may be
+specified for a new network on the start up as a command line option.
+
+
+Information
+===========
+
+Mailing lists:
+	linux-bluetooth@vger.kernel.org
+
+For additional information about the project visit BlueZ web site:
+	http://www.bluez.org
-- 
2.21.0


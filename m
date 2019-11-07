Return-Path: <SRS0=nDLV=Y7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF6FC5DF60
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Nov 2019 12:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFE12084D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Nov 2019 12:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388582AbfKGMze (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Nov 2019 07:55:34 -0500
Received: from hall.aurel32.net ([195.154.113.88]:41330 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388378AbfKGMze (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Nov 2019 07:55:34 -0500
X-Greylist: delayed 2328 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Nov 2019 07:55:34 EST
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <aurelien@aurel32.net>)
        id 1iSgiU-0001S4-0a; Thu, 07 Nov 2019 13:16:46 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.92.3)
        (envelope-from <aurelien@aurel32.net>)
        id 1iSgiT-0006vr-Ld; Thu, 07 Nov 2019 13:16:45 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH BlueZ] tools/mesh-cfgclient: fix binaries and config name in README
Date:   Thu,  7 Nov 2019 13:16:40 +0100
Message-Id: <20191107121640.26600-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch fixes the mesh-cfgclient README file:
- The configuration directory is meshcfg not mesh-cfgcli
- The home directory is looked up using $HOME not using /home/$USER
- The binary is called mesh-cfgclient, not mesh-config
- The -c option takes a config file path, not the directory where the
  config file is stored.

---
 tools/mesh/README | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/mesh/README b/tools/mesh/README
index 9362d8ff6..3830d1b17 100644
--- a/tools/mesh/README
+++ b/tools/mesh/README
@@ -25,11 +25,11 @@ that contains information about the current state of the configured mesh
 network.
 
 The default directory for mesh-cfgclient configuration file is
-/home/<username>/.config/mesh-cfgcli
+$HOME/.config/meshcfg
 
-To specify a custom storage directory, run mesh-config tool as:
+To specify a custom file, run mesh-cfgclient tool as:
 
-	meshctl -c <config_dir_name>
+	mesh-cfgclient -c <config_file_name>
 
 If a configuration file is not found, it is assumed that a mesh network
 does not exist. In this case, the tool may be used to generate a new  mesh
-- 
2.24.0.rc1


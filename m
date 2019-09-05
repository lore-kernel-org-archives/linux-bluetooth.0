Return-Path: <SRS0=Ti+w=XA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E51C43331
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Sep 2019 22:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9D5206DE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Sep 2019 22:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390323AbfIEWf0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Sep 2019 18:35:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:51621 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729719AbfIEWf0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Sep 2019 18:35:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2019 15:35:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,471,1559545200"; 
   d="scan'208";a="199376633"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.254.24.188])
  by fmsmga001.fm.intel.com with ESMTP; 05 Sep 2019 15:35:26 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH BlueZ v3 1/2] doc: Remove uneeded dbus API for App Key Refresh
Date:   Thu,  5 Sep 2019 15:35:17 -0700
Message-Id: <20190905223518.18073-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190905223518.18073-1-brian.gix@intel.com>
References: <20190905223518.18073-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 doc/mesh-api.txt | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 470751f7a..9b9f4e3de 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -627,25 +627,6 @@ Methods:
 			org.bluez.mesh.Error.DoesNotExist
 			org.bluez.mesh.Error.Busy
 
-	void CompleteAppKeyUpdate(uint16 app_index)
-
-		This method is used by the application at the completion of
-		a Key Refresh Procedure.  This method should be called for each
-		app key being updated during the procedure, and must be
-		performed prior to changing the phase of the bound net key
-		to phase 3. (See SetKeyPhase() method).
-
-		The app_index parameter is a 12-bit value (0x000-0xFFF)
-		specifying which app key was updated. Note that the subnet that
-		the key is bound to must exist and be in Phase 2.
-
-		This call affects the local bluetooth-meshd key database only.
-
-		PossibleErrors:
-			org.bluez.mesh.Error.Failed
-			org.bluez.mesh.Error.InvalidArguments
-			org.bluez.mesh.Error.DoesNotExist
-
 	void DeleteAppKey(uint16 app_index)
 
 		This method is used by the application to delete an application
-- 
2.21.0


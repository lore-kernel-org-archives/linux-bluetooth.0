Return-Path: <SRS0=JHfm=6F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F61C54FC9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 16:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A1222068F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 16:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgDUQKA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:10:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:59416 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgDUQJ7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Apr 2020 12:09:59 -0400
IronPort-SDR: 0GMvrWW6QEFRCs5i/RxTaYpvTU4RMRDyC6CoDnSpKm7pfNH3z2dgoEa2XlV6nNmk4Ok9eZnwsX
 VoH+YpfSa3LQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 09:09:59 -0700
IronPort-SDR: CaXgUXgtfTgA7AMjS1nUcwkehXAIWeO6/9hQyHiP+ZgPZDcwnkhmuEku6x3EvS+0oEZGABiLIu
 rs+hnGgUmjtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,410,1580803200"; 
   d="scan'208";a="245718279"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.254.29.188])
  by fmsmga007.fm.intel.com with ESMTP; 21 Apr 2020 09:09:59 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ] test/mesh: Fix token format to use all 16 digits
Date:   Tue, 21 Apr 2020 09:09:51 -0700
Message-Id: <20200421160951.25583-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 test/test-mesh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/test-mesh b/test/test-mesh
index 5db1d6d1a..6a607835c 100755
--- a/test/test-mesh
+++ b/test/test-mesh
@@ -305,7 +305,7 @@ def create_cb(value):
 	global attach
 
 	print(set_yellow('Created mesh network with token ') +
-			set_green(format(value, '16x')))
+			set_green(format(value, '016x')))
 
 	token = value
 	have_token = True
@@ -462,7 +462,7 @@ class Application(dbus.service.Object):
 		global attach
 
 		print(set_yellow('Joined mesh network with token ') +
-				set_green(format(value, '16x')))
+				set_green(format(value, '016x')))
 
 		token = value
 		have_token = True
-- 
2.21.1


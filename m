Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA8AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jan 2022 19:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243294AbiAFTXP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jan 2022 14:23:15 -0500
Received: from mga11.intel.com ([192.55.52.93]:35437 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243233AbiAFTXP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jan 2022 14:23:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641496995; x=1673032995;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I93U42v6NThZiD4Z9hwuCScr3EhvlKyz+gS7G39Fgk4=;
  b=V9o6IDctOhm9aNrPPQmu5p2OygZCJxAun/nTqkx456fC0GPU4xWeTbM5
   ts5hEXEDVoNg7lqRboMZ+kx/9CnSeb5QRJgMcq5gpZyYHSG0J+v7fVOri
   VkqaCV7ugSWCu9ChQYOPwCQPXbc0v29NJxNKnxz0kzjf7e5l/Id0021lD
   H1cj3c7hHLcGtYQWySKIazTbX9yxaJ2Nm+oi3saWY0fTaQGXUSrpH/xUf
   f9uznvyfRXlt2Gz0NfP//LgFtkRZ8zjtzZijuFD8wrSkcVIQFr7fzHh73
   KMcN5AGUctw7jGW0k3LSlYP1Ao2wogTnWJv+xLI9pTjYq/ugguCIimxNk
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="240271541"
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="240271541"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 11:23:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="513511982"
Received: from avaidyan-mobl3.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.212.63.113])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 11:23:14 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] tools/mesh: Fix help config menu help message
Date:   Thu,  6 Jan 2022 11:23:06 -0800
Message-Id: <20220106192306.28552-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

An info message suggesting to request a remote node composition
should reference the correct menu command: "composition-get".
---
 tools/mesh/cfgcli.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index f815c513c..a48eace74 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -1291,7 +1291,7 @@ static void cmd_bind(uint32_t opcode, int argc, char *argv[])
 
 	if (!remote_has_composition(target)) {
 		bt_shell_printf("Node composition is unknown\n");
-		bt_shell_printf("Call \"get-composition\" first\n");
+		bt_shell_printf("Call \"composition-get\" first\n");
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
@@ -1493,7 +1493,7 @@ static void cmd_pub_set(int argc, char *argv[])
 
 	if (!remote_has_composition(target)) {
 		bt_shell_printf("Node composition is unknown\n");
-		bt_shell_printf("Call \"get-composition\" first\n");
+		bt_shell_printf("Call \"composition-get\" first\n");
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
@@ -1593,7 +1593,7 @@ static void subscription_cmd(int argc, char *argv[], uint32_t opcode)
 
 	if (!remote_has_composition(target)) {
 		bt_shell_printf("Node composition is unknown\n");
-		bt_shell_printf("Call \"get-composition\" first\n");
+		bt_shell_printf("Call \"composition-get\" first\n");
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-- 
2.31.1


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28CEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jan 2022 19:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243309AbiAFT2s (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jan 2022 14:28:48 -0500
Received: from mga07.intel.com ([134.134.136.100]:64844 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243298AbiAFT2s (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jan 2022 14:28:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641497328; x=1673033328;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I93U42v6NThZiD4Z9hwuCScr3EhvlKyz+gS7G39Fgk4=;
  b=U+T7X8SkZIMlPCD5U4qisLc0aLt7EGqJ1CyKRsjJY0UmrhWfUGp561YR
   //ueqkpnDRZ2k5cKbo3l0bBmTKD318k5u/nA03J/sHPJvxiqLEY3h2T4J
   guyYZckUrSEPeeePwmrwFqL3bpai3ay4lit+Qkr0c8WDkkLxcp5HwRisI
   ciq/ln8x8Tj9sDdaY6BSIBTm/XTs/rEBUtzyvcTk3jwjxemifAOap+L/J
   T2aUkP23ncITKQA6E5vnLnZ7kZWN+0Q/M/sE0ZDA35bWCN5/7QOEcevBk
   pTPD0rAwHCnM9Oo5GE+HuPC9UwWROHa9PPUiOII9ElnRhVSyTimrTa3nv
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="306075213"
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="306075213"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 11:26:38 -0800
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="591480580"
Received: from avaidyan-mobl3.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.212.63.113])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 11:26:37 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2] tools/mesh-cfgclient: Fix config menu help message
Date:   Thu,  6 Jan 2022 11:26:32 -0800
Message-Id: <20220106192632.28915-1-inga.stotland@intel.com>
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


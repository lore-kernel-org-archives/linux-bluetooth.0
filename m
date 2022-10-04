Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11A7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Oct 2022 00:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiJDAPJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Oct 2022 20:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiJDAPI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Oct 2022 20:15:08 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC3F13D24
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Oct 2022 17:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664842506; x=1696378506;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ncSC+8XGXMSlfw9pUHDfBIay6ecZGht6RbJFlYqhLSk=;
  b=Yu7tqcNbyyFD2ogyw2ggIGk5hu1I23rZQCeQNXco/u0jLSo2KjhfQ6eL
   M+uJltTQHfAVfyrofG1YN7Ly288iGwbqyURAJaBZ2LyIlJAD1nf9wW1oA
   1vXVIErD5lYm72Db51YEehplobmgM3Xc1fEgY07v/+Voyad0y/4IGPRvJ
   zYOnReIGdclauqa0aR8QdqQxVTPZqOU1XXov5gn4cVgbXCxstv0sJNaYr
   dcqzv48qk471Lbx1qbPqYtY5b+i+xffju3cgEu3+2U6PQMXpTlyuVaL/3
   XyvgBldE39I747CITM+oY1Y/CWL7b7X5BQ/dy5Ydzql3HTLMDxupMOTkU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="302770590"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="302770590"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 17:15:06 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="601436311"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="601436311"
Received: from sadhana1-mobl3.amr.corp.intel.com (HELO istotlan-mobl1.intel.com) ([10.212.232.112])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 17:15:05 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] README: Update Mesh required Kernel Config section
Date:   Mon,  3 Oct 2022 17:14:59 -0700
Message-Id: <20221004001459.176032-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add CONFIG_CRYPTO_USER_API_SKCIPHER to the list of the required
.config options
---
 README | 1 +
 1 file changed, 1 insertion(+)

diff --git a/README b/README
index 3dc226ff1..7de7045a8 100644
--- a/README
+++ b/README
@@ -79,6 +79,7 @@ may need to be enabled, and the kernel rebuilt.
 	CONFIG_CRYPTO_USER_API
 	CONFIG_CRYPTO_USER_API_AEAD
 	CONFIG_CRYPTO_USER_API_HASH
+	CONFIG_CRYPTO_USER_API_SKCIPHER
 
 	CONFIG_CRYPTO_AES
 	CONFIG_CRYPTO_CCM
-- 
2.37.3


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364BFC32771
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Aug 2022 20:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350601AbiHSUrC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Aug 2022 16:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350558AbiHSUrB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Aug 2022 16:47:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67EBBD2BC
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Aug 2022 13:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660942020; x=1692478020;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ftDAKwsHUQfU0xsBrjb6tR8Ix4YFkUb9XAXhSzjIylk=;
  b=DvU4xtujIYIqSH/0iL6HLzB/qJRu5eGPjwiLduPPv6KyNqViex5jxcOD
   xqH4RC8dftYcabydxZU8/z4h9jsbzoIWMU7dfbYpoQljKHgs+5SQc+REM
   N8IIFLT9R9zjbxNwSOYPWQJyFRPlNPDmgGBxlXJ0v7iHRQT6evGNr1wr7
   Rx1x2zPD8WrM0aitwF7woA1lfwRZJVucm5hs4vuPtFLgaF1o/ZygWXBtE
   SnvTvC/6spHQVG/g/OfQPCZsyKhnYkDXHyWg+QGa8A8FmV7gWDdbMCMER
   eaFmLQ1xufEk7TSPr730ydM4WR7O5lzCUxXQWolgL2c4uFiImgX6ZOLR+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="379395458"
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="379395458"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 13:47:00 -0700
X-IronPort-AV: E=Sophos;i="5.93,249,1654585200"; 
   d="scan'208";a="559068695"
Received: from scjha-mobl.amr.corp.intel.com (HELO istotlan-mobl1.intel.com) ([10.209.109.17])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 13:47:00 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] README: Update Mesh required Kernel Config section
Date:   Fri, 19 Aug 2022 13:46:48 -0700
Message-Id: <20220819204649.244035-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.37.2
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
2.37.1


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BEAECAAD1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 21:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiHaVld (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Aug 2022 17:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiHaVl3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Aug 2022 17:41:29 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B13DDB78
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 14:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661982087; x=1693518087;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nQ7H9hRJlsDsrhiZNakmjbYUycQV3aCBBNQBh+XBBeU=;
  b=G8zbsYImOhEKBroWMXQ7LPel0Wer3cxPmKMMeo31wdMMFr1kYZENsa3k
   BIrgS9JCIS2sjtTr0+iEhHw4nHqhjQkmWeo0XdKT7Np4QoK1jpjZ8Wf1J
   mCx+pOddUvJU3sfp3s6o7D8sSOW13YAjYrLQV8wQKktAm11yBpUgSDOSx
   UySuQgkp06k9bVxWPws81QDMop5B8VtqJ8OF+NmM+GeM9xr02/10CtU6e
   i/+e/lGwiYuqjIU2lbAZpuaVYhRR1LJd2Htf/Yr1E2hzy2t+S08dEoVkW
   +79Kmjj2mmEjE+OJZ6ldqeQP7Cx7pz9wdEFMNDNRoyRiSPrYRyE2bITDg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="275298892"
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="275298892"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 14:41:27 -0700
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="612240163"
Received: from sbhatia4-mobl2.amr.corp.intel.com (HELO bgi1-mobl2.attlocal.net) ([10.213.189.113])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 14:41:27 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH BlueZ v2 0/2] Add mesh testing support
Date:   Wed, 31 Aug 2022 14:41:17 -0700
Message-Id: <20220831214119.273727-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch set reserves MGMT events and opcodes for Mesh, and adds a new
unit tester for those features: mesh-tester

v2: Fix whitespace

Brian Gix (2):
  lib: Add mgmt opcodes and events for Mesh
  tools: Add mesh-tester to test Kernel mesh support

 Makefile.tools      |   12 +-
 lib/mgmt.h          |   47 ++
 tools/mesh-tester.c | 1435 +++++++++++++++++++++++++++++++++++++++++++
 tools/test-runner.c |    2 +
 4 files changed, 1495 insertions(+), 1 deletion(-)
 create mode 100644 tools/mesh-tester.c

-- 
2.37.2


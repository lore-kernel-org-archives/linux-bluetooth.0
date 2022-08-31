Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC54ECAAD5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 20:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbiHaUL1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Aug 2022 16:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiHaULU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Aug 2022 16:11:20 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99FD1EEE3
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 13:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661976679; x=1693512679;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z4WQY7tlQQkm93GYQ6GBfH4+PfWUn8Q0JUftZLFxR1o=;
  b=j7n0DEnsz4rXZTBbbNLiyJdrNCBYZQiCy28aijmKo0riguuHPzY6xZIs
   K1k68Nvhr6OfL7NzlsMQHGsGgalP+5r/O07PZ4sDQ8wQHjXwBvGhW/h1C
   CxZxQ5FBqAe1GE3XtSX+KNvxTOc8P8CZ2y7enQ7YL3WzuPUQRiGrZAuKC
   RyGlVMJgwan+cgCYV9UDdO0B+j+UURCbxHuN+vmATed4fJEWcYyrldI5n
   IExX/qAaMxF9Mie4m5anDgFYHEHdFLAgZ097RtYYkFfJOcj13HwcI1kSJ
   yt0PHW9uBYlakS1zWaY432mqzfUPtgMlWWjgeAM9k5KjfdX9uY+VQ2Nuw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="296318711"
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="296318711"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 13:11:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="787976067"
Received: from sbhatia4-mobl2.amr.corp.intel.com (HELO bgi1-mobl2.attlocal.net) ([10.213.189.113])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 13:11:10 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH BlueZ 0/2] Add mesh testing support
Date:   Wed, 31 Aug 2022 13:10:59 -0700
Message-Id: <20220831201101.260925-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch set reserves MGMT events and opcodes for Mesh, and adds a new
unit tester for those features: mesh-tester

Brian Gix (2):
  lib: Add mgmt opcodes and events for Mesh
  tools: Add mesh-tester to test Kernel mesh support

 Makefile.tools      |   12 +-
 lib/mgmt.h          |   47 ++
 tools/mesh-tester.c | 1434 +++++++++++++++++++++++++++++++++++++++++++
 tools/test-runner.c |    2 +
 4 files changed, 1494 insertions(+), 1 deletion(-)
 create mode 100644 tools/mesh-tester.c

-- 
2.37.2


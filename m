Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F274BC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Oct 2022 14:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiJFOfS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Oct 2022 10:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiJFOfR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Oct 2022 10:35:17 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2534662937
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Oct 2022 07:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665066914; x=1696602914;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ajUVz3sXe5tE0/YnoN9UaPoqKsVcNZrgvw1l/R1S6C0=;
  b=SDS53Jn9PmHqz7R4By1fTTMFPoO0dYkr3dcHX4W9NDJasWdWBBpPxZTk
   bOAvHx7lKaDQyrv6EODBB+YqdAtfWbhYz4FYTdBHkKIa0sfybQMEOkuxz
   PKBDZLIwqwYWczbeQ2S6nQ6ql8nFaWaXe1WS837/QJzOLgFqdSeoxmNd4
   7Tgux0VYUjjZ7fJijy2W19v/9HjhMgA8kLs4EyqCHZsVHqIDC1ZrAxLeH
   7WoVsa6kJN3lVfeFDT+lrQo4zmG5mCj0hRLgmKt/JUUiTZC/HRujiwQFx
   nvzEPD0Gj5GwOaY+Z/cSwXk+LsGiVp1V5+Hin5h7YvBKDL6dCO3TXmEVv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="304453663"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="304453663"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 07:35:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="693373271"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="693373271"
Received: from bsbdt.iind.intel.com ([10.224.186.26])
  by fmsmga004.fm.intel.com with ESMTP; 06 Oct 2022 07:34:46 -0700
From:   Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
Subject: [PATCH BlueZ 0/4] Media Control Profile Client 
Date:   Thu,  6 Oct 2022 20:03:39 +0530
Message-Id: <20221006143343.199055-1-abhay.maheshbhai.maheta@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This series of patches adds support for Media Control Profile for LE Audio.
These patches primarily foces on Media Control Client Role.

Abhay Maheta (4):
  lib/uuid: Add GMCS UUIDs
  shared/mcp: Add initial code for handling MCP
  profiles: Add initial code for mcp plugin
  monitor/att: Add decoding support for GMCS

 Makefile.am          |    1 +
 Makefile.plugins     |    5 +
 configure.ac         |    4 +
 lib/uuid.h           |   15 +
 monitor/att.c        |  511 +++++++++++++++
 profiles/audio/mcp.c |  429 +++++++++++++
 src/shared/mcp.c     | 1408 ++++++++++++++++++++++++++++++++++++++++++
 src/shared/mcp.h     |   60 ++
 src/shared/mcs.h     |   65 ++
 9 files changed, 2498 insertions(+)
 create mode 100644 profiles/audio/mcp.c
 create mode 100644 src/shared/mcp.c
 create mode 100644 src/shared/mcp.h
 create mode 100644 src/shared/mcs.h

-- 
2.25.1


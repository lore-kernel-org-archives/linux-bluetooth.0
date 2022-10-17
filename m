Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F75C43217
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Oct 2022 13:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiJQNfG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Oct 2022 09:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJQNfE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Oct 2022 09:35:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD4E22B2A
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Oct 2022 06:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666013698; x=1697549698;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oqjgKqlv3KuCDuuk23fq+Hd9GRLQ0mq8wBzWkMYbONA=;
  b=h3Hu91bxCHx5rLY6l/QBO1YNW+V9ZM584Nztypp29Kcd95ZRYoCQEu+J
   9ERVUHJ8J1S45DDCU0v9EE17e0uEQZ2ZzhaG8Um5VRGVw7QNOm2XLLkuJ
   V7fL9UTZtUdiD6PvjoHJIVC5guBxxFQda++NcYx/3O4ig6drqMzulIH2M
   3boCcqtjnrfBjhp0orlX/F9db55z1rkWJ9SLNLDBgbtUjUd4aZix1LIaJ
   zsUHLE9IOKgGLnxP315j3nVvqlrYvTkWfJEevjbVoX8M0G1OcI9CmkzfM
   NqeJN4QbG5yAMSbq253ZUJWlYOJ/DzADcB8VSply4cUqDYCJFVBsnvvEf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="285522160"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="285522160"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 06:34:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="957336343"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="957336343"
Received: from bsbdt.iind.intel.com ([10.224.186.26])
  by fmsmga005.fm.intel.com with ESMTP; 17 Oct 2022 06:34:57 -0700
From:   Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
Subject: [PATCH BlueZ v2 0/4] Media Control Profile Client
Date:   Mon, 17 Oct 2022 19:04:36 +0530
Message-Id: <20221017133440.321139-1-abhay.maheshbhai.maheta@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This series of patches adds support for Media Control Profile for LE Audio.
These patches primarily focuses on Media Control Client Role.

Abhay Maheta (4):
  lib/uuid: Add GMCS UUIDs
  shared/mcp: Add initial code for handling MCP
  profiles: Add initial code for mcp plugin
  monitor/att: Add decoding support for GMCS

 Makefile.am          |    1 +
 Makefile.plugins     |    5 +
 configure.ac         |    4 +
 lib/uuid.h           |   15 +
 monitor/att.c        |  513 +++++++++++++++
 profiles/audio/mcp.c |  430 +++++++++++++
 src/shared/mcp.c     | 1419 ++++++++++++++++++++++++++++++++++++++++++
 src/shared/mcp.h     |   61 ++
 src/shared/mcs.h     |   65 ++
 9 files changed, 2513 insertions(+)
 create mode 100644 profiles/audio/mcp.c
 create mode 100644 src/shared/mcp.c
 create mode 100644 src/shared/mcp.h
 create mode 100644 src/shared/mcs.h

-- 
2.25.1


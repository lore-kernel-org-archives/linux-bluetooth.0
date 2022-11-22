Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2838C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Nov 2022 03:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiKVDXu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Nov 2022 22:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbiKVDXs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Nov 2022 22:23:48 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3831123EA4
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 19:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669087423; x=1700623423;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ucrl8gKQOXQW7UCxNxIN4ZmC+JwU3y1FgyEse9qx/0I=;
  b=YlTuiFheZzaRhDffTbGXCODj1oL5XvbSZsaeyx+wtIBN+7F1mdEtn2e4
   MTVLIjlW0GdpGQyV35yrJ8Bo7lihJnnULqrbNFMx1XSg/hBf26/ztXHRy
   PazFZ38cY92MDvhy0fzTMXFrMhEOTuLfQQh8V4iUZUb+hUnfIq1kIM4kP
   sBW5PJLpCRiq5IrPoEX0jiVA4xAYGC/rkNIAfxzZCS83qK/7p0M/RGYW0
   qgD0Wu8EthRmzZQYsFiv48y32EYs9R2Lxv8lGzLSzFvHQXa1hBa4qA22I
   zxtoqmYFSyI2zSEXC2xYF2jwU28rZVvDcP0IcL3CjfKXdHOzrAmhSHCzm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="340583262"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="340583262"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 19:23:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="672331692"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="672331692"
Received: from intel-latitude-e5450.iind.intel.com ([10.224.186.32])
  by orsmga008.jf.intel.com with ESMTP; 21 Nov 2022 19:23:41 -0800
From:   Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH BlueZ V2 0/6] V2 of CSIP client role
Date:   Tue, 22 Nov 2022 08:55:24 +0530
Message-Id: <20221122032530.3842-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Version 2 Fixed few checkpatch warnings.

Sathish Narasimman (6):
  lib/uuid: Add CSIS UUIDs
  main.conf: Add CSIP profile configurable options
  shared/csip: Add initial code for handling CSIP
  profiles: Add initial code for csip plugin
  monitor/att: Add decoding support for CSIP
  tools: Add support to generate RSI using SIRK

 Makefile.am           |   1 +
 Makefile.plugins      |   5 +
 configure.ac          |   4 +
 lib/uuid.h            |   7 +
 monitor/att.c         |  73 ++++++
 profiles/audio/csip.c | 319 ++++++++++++++++++++++++
 src/btd.h             |   9 +
 src/main.c            | 113 +++++++++
 src/main.conf         |  24 ++
 src/shared/csip.c     | 554 ++++++++++++++++++++++++++++++++++++++++++
 src/shared/csip.h     |  44 ++++
 tools/advtest.c       |  80 +++++-
 12 files changed, 1231 insertions(+), 2 deletions(-)
 create mode 100644 profiles/audio/csip.c
 create mode 100644 src/shared/csip.c
 create mode 100644 src/shared/csip.h

-- 
2.25.1


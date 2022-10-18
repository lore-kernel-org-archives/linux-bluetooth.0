Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C381C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Oct 2022 04:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiJREis (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Oct 2022 00:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiJREir (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Oct 2022 00:38:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8A1A0272
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Oct 2022 21:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666067922; x=1697603922;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oqjgKqlv3KuCDuuk23fq+Hd9GRLQ0mq8wBzWkMYbONA=;
  b=PTZDE60pk4t9HLmdeI5oSGO2WDU9CshDN7zSzBJ6zD4Jipx+S5rSmVyh
   iMPe/Ulusxre/MHj7lIhSDobwL2fwNEx1pm+utKP3igpVu9A4E845WfvV
   egmkY81c6XbXcT8L8hlPOFAD8yx505bPoT8ygz9DSfgUlvkkspdkjRvJm
   KDp3nRHedpKGK1j7IB7Kl9eRtdX2sO0eX2MVkd+90JRcax+RTjsHMvf6k
   sztN0+hJTdlfjaNvq/SmwN2JLX+sQ4l1C7F8faj3fPBwLSEdHiAZstfmt
   Et6tArgHN2VTZoJYCBcSZsDBbU2pQNZpUCWFjjGkKrosr4H6zvyzdZI3Z
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="307079210"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="307079210"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 21:38:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="957608025"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="957608025"
Received: from bsbdt.iind.intel.com ([10.224.186.26])
  by fmsmga005.fm.intel.com with ESMTP; 17 Oct 2022 21:38:41 -0700
From:   Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
Subject: [PATCH BlueZ v3 0/4] Media Control Profile Client
Date:   Tue, 18 Oct 2022 10:08:27 +0530
Message-Id: <20221018043831.342821-1-abhay.maheshbhai.maheta@intel.com>
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


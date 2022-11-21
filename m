Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174B8C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Nov 2022 23:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbiKUXqq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Nov 2022 18:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiKUXqT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Nov 2022 18:46:19 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6CBD9B93
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 15:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669074278; x=1700610278;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6+Grnt0e3x2qRu1caqX37Fi3Hr14SE7thQMONqh5HLQ=;
  b=f4OMa5I5wVkaJgxz0q0KaOuFk4DeBvLhJPNuPZVb+tQKXzrBrmBiqkUz
   9tRSuv4TVCLVVtaYobLSOhpOi0f6YUKKpKo0lkk+c35JPPcfnNLZklmB6
   3WZBHmzw5qJI8kepDxzWRGk3m1oE2WMbBiq0SLRj0em7Boy2om0I+V03f
   BRMSVww8iQ5rCfcIP22yDzhyd/i6wAhZE0Ro/l+oMd+ziBRA3pIMH2+O4
   ZqH0xSiVIWxt1zJ6jPhlcILp3s62U74NqOmQqjn9CFyjBhajFnqOyLjkB
   y/r0b4zkgjszUqJLcdCspK8vh10FbyrqJlmARxB0hanzHaNgom/CT8D/z
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="377946587"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="377946587"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 15:44:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="783633432"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="783633432"
Received: from intel-latitude-e5450.iind.intel.com ([10.224.186.32])
  by fmsmga001.fm.intel.com with ESMTP; 21 Nov 2022 15:44:37 -0800
From:   Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH BlueZ 0/6] CSIP - Client Role
Date:   Tue, 22 Nov 2022 05:16:18 +0530
Message-Id: <20221121234624.2961-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The following patches are for CSIP (Co-ordinated set identification
profile) Client role. The patches also includes using SIRK and adding it
to ADV data. Configuring CSIP Server values.

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


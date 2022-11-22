Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB2DC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Nov 2022 10:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiKVKKy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Nov 2022 05:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbiKVKKv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Nov 2022 05:10:51 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28A2532D1
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 02:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669111845; x=1700647845;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2Td5TsGMxzSu9VK6mBYBCQ/pf6tLfSLTVLsAc/35u4M=;
  b=SEPdQGrpqNZ8p541QwygJIslKoDMKaI5awpjRC/8YYcdpwpPH8sT+rrB
   SSh/aA0gOXigNO7EZKIZQT/uvGnPEDCXgyq/HBozxv///nguqKh7LHb18
   D9gltZX9Vb447Lfba/U/pvGh1ELmLMxHzRB1RbLL4fZu8UUYBYZtymY2F
   pqx3DvylqB/ELo0n1VQEpfRWe4EuDQizMMaGsCt0NBEt3EIo/qmduVZ/2
   iP5QhK49Ua+g0gVorKLKvtrRavjzV9eWkID26Qd2pXBgQ39V3wFzrGMR0
   dMj2Bs0z4JqUe/0pO0mrzmO0sUiFKLo/Nsk3HDoHAfR0SZA6a+kN0OsnD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="378039330"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="378039330"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 02:10:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="672431859"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="672431859"
Received: from intel-latitude-e5450.iind.intel.com ([10.224.186.32])
  by orsmga008.jf.intel.com with ESMTP; 22 Nov 2022 02:10:44 -0800
From:   Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH BlueZ v3 0/7] Csip - Client role
Date:   Tue, 22 Nov 2022 15:42:25 +0530
Message-Id: <20221122101232.45320-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This version of patch updated with
1. Added btmon decoded log in commit message
2. Fixed few of scan warnings

Sathish Narasimman (7):
  shared/util: Update UUID database for Csip services
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
 src/shared/util.c     |   3 +
 tools/advtest.c       |  80 +++++-
 13 files changed, 1234 insertions(+), 2 deletions(-)
 create mode 100644 profiles/audio/csip.c
 create mode 100644 src/shared/csip.c
 create mode 100644 src/shared/csip.h

-- 
2.25.1


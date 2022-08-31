Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E7DECAAD1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 23:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiHaX7n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiHaX7l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Aug 2022 19:59:41 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE104E990B
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 16:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661990380; x=1693526380;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Pg/zB7IeizzUBpaB8HMUygYOYQKqyyWokQN+LSeHN1g=;
  b=IHp93VHDXRrga1vSTzljSqNslKM0vBUnW2sLO+7zJgB+4EDfL7/cWbLp
   LpeMBRGgGYqxiPKTZ+zD1RlFnZ+v8xUfBuoQbySPzqOQD37OH1Z7GlDaO
   abvy0HB+LUQ1RnBguqPJCMZ6BbElxmcDMqJzVkGkJTgEch3GTUJmCRpAr
   Ll8zwJcE2el0VzQu//BlQH+igMHU+dAXgqhWW5rI6QZr93hG3Rz6DgkVF
   C6nFVGdjU5O399aVnB5EEBf5KIlkfmheaQR1GkW+0801Y0DR871l3jyCE
   UWb/pgilcSHifxFmJCQE1BTrzQ4DypOsUcTMIUkToflgQBUs2aWGezt6H
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="357295535"
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="357295535"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 16:59:40 -0700
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="563228019"
Received: from sbhatia4-mobl2.amr.corp.intel.com (HELO bgi1-mobl2.attlocal.net) ([10.213.189.113])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 16:59:40 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH BlueZ v4 0/2] Add mesh testing support
Date:   Wed, 31 Aug 2022 16:59:30 -0700
Message-Id: <20220831235932.290032-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch set reserves MGMT events and opcodes for Mesh, and adds a new
unit tester for those features: mesh-tester

v2 - v4: Fix whitespace


Brian Gix (2):
  lib: Add mgmt opcodes and events for Mesh
  tools: Add mesh-tester to test Kernel mesh support

 Makefile.tools      |   12 +-
 lib/mgmt.h          |   47 ++
 tools/mesh-tester.c | 1441 +++++++++++++++++++++++++++++++++++++++++++
 tools/test-runner.c |    2 +
 4 files changed, 1501 insertions(+), 1 deletion(-)
 create mode 100644 tools/mesh-tester.c

-- 
2.37.2


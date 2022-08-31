Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406D3ECAAD4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 21:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiHaVse (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Aug 2022 17:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiHaVsb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Aug 2022 17:48:31 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0586FF72CB
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 14:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661982510; x=1693518510;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BMGDu7xANkI34Hhikn2BLQKKkdvopI4pyvFArX1LlVs=;
  b=noaxJe5GDUeWd4dqtZOoqMscYQLNhIYOP1w+OiYJf9K8KcJnnpmpERcm
   jQpi5WdyDbrYq7CekozXWraK8uaUoOwklqo0WjXbspmNYisAtottA9jR5
   dnnwQhe67TtiD3zylHMMyM1vUPrGysJq6k70w655ChQpN8pY6kh23Butk
   Zi/SEVC3ctXl77PjwD844mQAjUgh2Jsgog2NmqEgySHeim6uFb3DZU9RX
   2LRuNvWFiA5GjmFON/vs3KCG1GIgEDxQP1UphEYSuqzOsc7nUoplbxrMg
   olh1D1095nnBexN2j6rUzH4so8zzniFdWyJMMyL4Wp5ITnHcGUPKd23TM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="275953668"
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="275953668"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 14:48:28 -0700
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="857599875"
Received: from sbhatia4-mobl2.amr.corp.intel.com (HELO bgi1-mobl2.attlocal.net) ([10.213.189.113])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 14:48:28 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH BlueZ v3 0/2] Add mesh testing support
Date:   Wed, 31 Aug 2022 14:48:19 -0700
Message-Id: <20220831214821.274797-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch set reserves MGMT events and opcodes for Mesh, and adds a new
unit tester for those features: mesh-tester

v2 && v3: Fix whitespace


Brian Gix (2):
  lib: Add mgmt opcodes and events for Mesh
  tools: Add mesh-tester to test Kernel mesh support

 Makefile.tools      |   12 +-
 lib/mgmt.h          |   47 ++
 tools/mesh-tester.c | 1436 +++++++++++++++++++++++++++++++++++++++++++
 tools/test-runner.c |    2 +
 4 files changed, 1496 insertions(+), 1 deletion(-)
 create mode 100644 tools/mesh-tester.c

-- 
2.37.2


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1010BECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Sep 2022 21:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiIVVim (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Sep 2022 17:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiIVVie (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Sep 2022 17:38:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D7110251A
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Sep 2022 14:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663882713; x=1695418713;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ok1lcbu9fsT5h2DP2GDafj5x/VKi69vP91yY3jP7KmI=;
  b=kGeZkUqDDSRnnt8ox93duuL1fbQiJXqvmm8sZjusL/VibGYi7mGok0YG
   Dconyes6GYhZwcNLULsZMqjslnLfL8dY16Fhbug5Amu9qoQwhq9tlJLl6
   iZP1Lo+c+0QLsJe/76E9NLeOwFIr/8+13CWz/8VXpXgkdxXw2it1GkNlx
   WLlmDlsX3TR772qKXsx1qPNhkc2MOrZG5H2uKgWZrxtiwsFtQY+WT3sjV
   IyP80+MWL2FxFRh3NB9+3hRNHLAx0ZFj5MMxouDCQpxOSUWJKdFRErm4T
   vuA1WXdWduE8A/iZbWNjmOWGnfJ4DUIFwSHxEjgujocw/olmpCqzGYxd0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="364450477"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="364450477"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 14:38:33 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="571141900"
Received: from avarhadk-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.213.161.147])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 14:38:32 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH BlueZ v2 0/2] Mesh demon switched to using kernel Mesh MGMT
Date:   Thu, 22 Sep 2022 14:38:20 -0700
Message-Id: <20220922213822.600692-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patchset enables the mesh daemon (bluetooth-meshd) to use the new
MGMT mesh opcodes and events to send and receive Mesh packets. By
default, the daemon attempts to enable the experimental mesh
functionality, and query the kernel for active mesh support before then
enumerating the available controllers and selecting ojne that works.

If no kernel support is found, it will continue to use a raw HCI socket
for mesh support.

v2: Fix whitespace and spelling

Brian Gix (2):
  mesh: Improve PB-ADV timing for reliability
  mesh: Add new kernel MGMT based IO transport

 Makefile.mesh          |   9 +-
 mesh/main.c            |  39 ++++++++-
 mesh/mesh-io-api.h     |  11 ++-
 mesh/mesh-io-generic.c |  47 +++--------
 mesh/mesh-io-unit.c    |  13 ++-
 mesh/mesh-io.c         | 188 ++++++++++++++++++++++++++++++-----------
 mesh/mesh-io.h         |   4 +-
 mesh/mesh-mgmt.c       | 164 +++++++++++++++++++++++++++--------
 mesh/mesh-mgmt.h       |  12 ++-
 mesh/mesh.c            |   6 +-
 mesh/mesh.h            |   2 +-
 mesh/pb-adv.c          |   9 +-
 12 files changed, 360 insertions(+), 144 deletions(-)

-- 
2.37.3


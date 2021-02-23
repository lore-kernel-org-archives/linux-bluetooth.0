Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832E1C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 19:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A13D64E85
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 19:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbhBWTEP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Feb 2021 14:04:15 -0500
Received: from mga02.intel.com ([134.134.136.20]:37885 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233227AbhBWTEM (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Feb 2021 14:04:12 -0500
IronPort-SDR: HU05Dg7Z5vdq10cAo0EItxyKoD9H6UQhoBY1InXk3H6YqWosXgdhRLTJaC1zsIZpMdrzr3tW59
 Knqg7GTi5pXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9904"; a="172053197"
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="172053197"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 11:03:27 -0800
IronPort-SDR: sBHieU2wSHlxtlxb1i/vfDzeT0WqDb8Zhi5nq19u2M6fGspjH2RR9Dh/DzxGPlL23Hkjc2IW4F
 8hQZXCDh9CxQ==
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="432830948"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.209.105.235])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 11:03:22 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com, luiz.dentz@gmail.com,
        tedd.an@linux.intel.com, marcel@holtmann.org
Subject: [PATCH BlueZ 0/6] Cleanup: replace symbolic file permissions
Date:   Tue, 23 Feb 2021 11:02:46 -0800
Message-Id: <20210223190252.483784-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The kernel has moved away from using Symbolic File Permission macros,
and this is reflected in our checkpatch usage which flags lines which
still use them.  The preferred method is to use the well known octal
notation, for instance 0755 meaning:

User has read/write/execute permissions
Group has read/execute permissions
Other has read/execute permissions

Brian Gix (6):
  mesh: Cleanup deprecated symbolic file permissions
  obexd: Cleanup deprecated symbolic file permissions
  peripheral: Cleanup deprecated symbolic file permissions
  profiles: Cleanup deprecated symbolic file permissions
  src: Cleanup deprecated symbolic file permissions
  tools: Cleanup deprecated symbolic file permissions

 mesh/rpl.c                     |  2 +-
 obexd/plugins/filesystem.c     | 18 +++++++++---------
 obexd/plugins/ftp.c            |  4 ++--
 peripheral/efivars.c           |  3 +--
 profiles/input/suspend-dummy.c |  2 +-
 src/adapter.c                  | 32 ++++++++++++++++----------------
 src/attrib-server.c            |  2 +-
 src/device.c                   | 16 ++++++++--------
 src/sdpd-server.c              |  2 +-
 src/shared/btsnoop.c           |  4 ++--
 src/textfile.c                 |  2 +-
 tools/btsnoop.c                |  3 +--
 tools/create-image.c           |  3 +--
 tools/hcidump.c                |  2 +-
 tools/rctest.c                 |  3 +--
 15 files changed, 47 insertions(+), 51 deletions(-)

-- 
2.25.4


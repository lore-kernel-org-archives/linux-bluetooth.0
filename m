Return-Path: <SRS0=w0Ns=65=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C1CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 May 2020 23:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3CCE2076A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 May 2020 23:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgEOX7U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 May 2020 19:59:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:5741 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbgEOX7U (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 May 2020 19:59:20 -0400
IronPort-SDR: knaEgJ8+jCrbrxgWklYUJLjOCHzYp3B3veOMOZDw7itFAEsoetrZ0n6S2ZJQeck+gb0s4hFsy3
 x65+9yu1AGHQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 16:59:19 -0700
IronPort-SDR: KkUMKTLTZ5Zw3DRP8MVF3pB6LELnv2PqlQRGubL0OWbj41yItNsVYsOtYV0JumusqZZg1Lxzf0
 9v4qAp4AJSzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,396,1583222400"; 
   d="scan'208";a="342163576"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.252.132.104])
  by orsmga001.jf.intel.com with ESMTP; 15 May 2020 16:59:19 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ 0/2] mesh: Valgrind Clean-up
Date:   Fri, 15 May 2020 16:59:10 -0700
Message-Id: <20200515235912.565846-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

These two patches address all known outstanding valgrind issues with the
mesh daemon.  The first patch (1/2) fixes actual memory leaks that will
compound over time. The second patch (2/2) fixes less critical warnings
that some memory wasn't entirely freed before exiting.

Brian Gix (2):
  mesh: Fix valgrind memory leaks
  mesh: Fix valgrind memory leak warnings

 mesh/agent.c            |  1 +
 mesh/mesh-config-json.c | 16 ++++++++--------
 mesh/mesh.c             |  9 ++++++++-
 mesh/net-keys.c         |  6 ++++++
 mesh/net-keys.h         |  1 +
 mesh/net.c              | 12 +++++++++++-
 mesh/net.h              |  3 ++-
 mesh/node.c             |  1 +
 8 files changed, 38 insertions(+), 11 deletions(-)

-- 
2.25.4


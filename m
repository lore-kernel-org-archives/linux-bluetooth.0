Return-Path: <SRS0=vBm7=XV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F9CC4360C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Sep 2019 18:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B86421A4A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Sep 2019 18:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfIZSOz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Sep 2019 14:14:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:23148 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfIZSOy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Sep 2019 14:14:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2019 11:14:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,552,1559545200"; 
   d="scan'208";a="196460992"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.251.25.152])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Sep 2019 11:14:53 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com,
        michal.lowas-rzechonek@silvair.com
Subject: [PATCH BlueZ v3 0/3] mesh: Fix Remote/Local dev key usage
Date:   Thu, 26 Sep 2019 11:14:41 -0700
Message-Id: <20190926181444.4916-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

V3:  By popular demand, the name "remote" is now used for both DevKeySend()
and DevKeyMessageReceived().

In DevKeySend(), setting remote == true means that the Key Ring *must* be
used to encrypt the outgoing message, and a failure will be returned if
the requested destination address does not include a device key in the
local key ring. For remote == false requests, the request will be rejected
if the destination is an element on the local node.

In DevKeyMessageReceived(), the remote boolean will be set == true if it
required the key ring to decrypot the message.  If remote == false, this
means that the local nodes Device Key successfully decrypted the message,
and the message may be used to change or query privileged states.


Brian Gix (3):
  mesh: Add local/remote bools to DevKey transactions
  mesh: Use explicit Local vs Remote Device key usage
  mesh: Fix Key Ring permissions for local nodes

 doc/mesh-api.txt | 17 ++++++++++++++---
 mesh/manager.c   |  5 -----
 mesh/model.c     | 11 +++++++----
 mesh/node.c      | 40 +++++++++++++++-------------------------
 4 files changed, 36 insertions(+), 37 deletions(-)

-- 
2.21.0


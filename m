Return-Path: <SRS0=iTYz=VN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A94C7618F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jul 2019 22:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC8C2173B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jul 2019 22:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388105AbfGPW4u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Jul 2019 18:56:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:2095 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbfGPW4u (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Jul 2019 18:56:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2019 15:56:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,271,1559545200"; 
   d="scan'208";a="170073266"
Received: from bgix-dell-lap.sea.intel.com ([10.251.137.82])
  by orsmga003.jf.intel.com with ESMTP; 16 Jul 2019 15:56:49 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com,
        michal.lowas-rzechonek@silvair.com
Subject: [PATCH BlueZ 0/3] mesh: Propagate/Preserve Net Index for Access Layer
Date:   Tue, 16 Jul 2019 15:56:41 -0700
Message-Id: <20190716225644.11449-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Two major flaws are corrected by this patch-set:

1. The Spec defined Access Layer AID was being confused with the internally used
key_id which is used to identify Network keys for multiple networks,
sub-networks, and friendships. This confused ID was then being used instead
of the correct Network Key ID for outgoing messages.

2. The specification requires *responses* to all standard Server messages to
be sent with the same credentials as the received command that triggered them.
This requires more complete propagation of the Net Index value on received
messages, so that the same Network key is used in the reverse direction.

This additionally now uses the requested Net Index when sending Device Key
secured messages through the D-Bus interface.

Brian Gix (3):
  mesh: Add bound Net Index lookup for App Keys
  mesh: Normalize Access Key AID naming convention
  mesh: Propagate Net Index up Rx message chain

 mesh/appkey.c        |  59 +++++++++++++-------
 mesh/appkey.h        |   1 +
 mesh/cfgmod-server.c | 154 ++++++++++++++++++++++++++++-----------------------
 mesh/crypto.c        |  37 ++++++-------
 mesh/crypto.h        |   8 +--
 mesh/model.c         | 129 +++++++++++++++++++++---------------------
 mesh/model.h         |  10 ++--
 mesh/net.c           |  92 +++++++++++++++++-------------
 mesh/net.h           |  10 ++--
 mesh/node.c          |  10 ++--
 10 files changed, 276 insertions(+), 234 deletions(-)

-- 
2.14.5


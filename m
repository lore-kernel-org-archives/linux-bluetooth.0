Return-Path: <SRS0=BnFh=AL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11B7C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jun 2020 07:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99D9A2073E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jun 2020 07:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbgF3HTi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:19:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:22972 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730637AbgF3HTh (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Jun 2020 03:19:37 -0400
IronPort-SDR: 5gcKX30Q+hk/CVkuRMCQC9lDCEUB5CfJCuiBI7inioF+ztTewR/J8+ego2ZshPkNpPRyxnqapO
 yddVRCkvSL3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="133613599"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="133613599"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 00:19:37 -0700
IronPort-SDR: sQXfukDtX9jhiRNIQGjTCRjbIJnsAItUEe3TDvSB0a2DBp3vvSJ1SPABCpSkl2jVJuzff8YIpI
 SmdTrgGZnnsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="355698459"
Received: from sdkini-mobl1.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.110.226])
  by orsmga001.jf.intel.com with ESMTP; 30 Jun 2020 00:19:37 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 0/4] Add options to Models and VendorModels
Date:   Tue, 30 Jun 2020 00:19:32 -0700
Message-Id: <20200630071936.40437-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If a model does not support either subscription mechanism,
Config Server is supposed to return "Not a Subscribe Model" if a Config Client sends
a subscription add/overwrite message.

Similarly, if a model does not support publication, "Invalid Publish Parameters"
should be returned in response to Publication Set message.

Since config server is running even when an app is not attached, the only way to collect
these model capabilities is on Attach, Join, Create, Import methods when the
object manager collects app info.

To address this issue, signatures for properties "Models" and "VendorModels" on Element
interface change to include "options" dictionary:
    Models: signature change "aq" -> "a(qa{sv})"
    VendorModels: signature change "a(qq)" -> "a(qqa{sv})"
    
The defined keywords for the options dictionary are:
    "Publish" - indicates whether the model supports publication mechanism.
                If not present, publication is enabled.
    "Subscribe" - indicates whether the model supports subscription mechanism.
                If not present, subscriptions are enabled.
    
Inga Stotland (4):
  doc/mesh-api: Add dictionary to model properties
  mesh: Check app model settings of pub/sub support
  tools/mesh-cfgclient: Add options to "Models" property
  test/test-mesh: Add options to "Models" property

 doc/mesh-api.txt        |  40 ++++++++--
 mesh/mesh-config-json.c |  72 ++++++++++++++++-
 mesh/mesh-config.h      |   8 ++
 mesh/model.c            |  87 +++++++++++++++++----
 mesh/model.h            |   6 ++
 mesh/node.c             | 168 ++++++++++++++++++++++++++++++++--------
 test/test-mesh          |  21 ++---
 tools/mesh-cfgclient.c  |  25 ++++--
 8 files changed, 359 insertions(+), 68 deletions(-)

-- 
2.26.2


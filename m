Return-Path: <SRS0=z6V2=3H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10CFC32771
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Jan 2020 04:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD11024656
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Jan 2020 04:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgAREWf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jan 2020 23:22:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:11361 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgAREWf (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jan 2020 23:22:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 20:22:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,332,1574150400"; 
   d="scan'208";a="220926437"
Received: from ingas-nuc1.sea.intel.com ([10.251.138.89])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jan 2020 20:22:34 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 0/4] Add functionality to mesh-cfgclient tool
Date:   Fri, 17 Jan 2020 20:22:29 -0800
Message-Id: <20200118042233.15338-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This set of patches adds more functionality to mesh configuratioon tool
as well as a bit of code tightening.


Inga Stotland (4):
  tools/mesh: Refactor code for generating model ID
  tools/mesh: Add length checks for rxed messages
  tools/mesh: Add support for Vendor Model App Get/List
  tools/mesh: Implement model group subscription commands

 tools/mesh/cfgcli.c | 233 ++++++++++++++++++++++++++++++--------------
 1 file changed, 159 insertions(+), 74 deletions(-)

-- 
2.21.1


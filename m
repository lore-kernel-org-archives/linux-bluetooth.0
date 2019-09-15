Return-Path: <SRS0=ezyT=XK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B9AC4CECC
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Sep 2019 08:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FA62077C
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Sep 2019 08:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfIOIOP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 15 Sep 2019 04:14:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:4603 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfIOIOO (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 15 Sep 2019 04:14:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Sep 2019 01:14:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="385906885"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.251.80.76])
  by fmsmga005.fm.intel.com with ESMTP; 15 Sep 2019 01:14:12 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com,
        michal.lowas-rzechonek@silvair.com
Subject: [PATCH BlueZ 0/1] mesh: Require Dev Key authentication
Date:   Sun, 15 Sep 2019 01:14:07 -0700
Message-Id: <20190915081408.18116-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Per Mesh Working group discussions, we decided that calls that require
device keys require explicit knowledge of the key being used. This
includes looped-back calls to the local Config Server, meaning that
nodes wanting to change their own states, must be granted that
permission by possession of their own key, entered into the local key
database.

We will be removing automatic device key entry nto the key database
from all methods except the Create() method.

Brian Gix (1):
  mesh: Add local/remote bools to DevKey transactions

 doc/mesh-api.txt | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

-- 
2.21.0


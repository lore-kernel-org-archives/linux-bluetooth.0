Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024ACC433E6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 17:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD7D564D9E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 17:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344047AbhA0RmG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jan 2021 12:42:06 -0500
Received: from mga12.intel.com ([192.55.52.136]:56860 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344028AbhA0RmC (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jan 2021 12:42:02 -0500
IronPort-SDR: yLoQxg9OHGyR2ZwH5kfPdx5NDS0ukzIzmoyMepN4NNVgYAds+q96izDBOLei0+XxMt7dTMAsOp
 HPrBDJj9Omag==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="159278755"
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="159278755"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 09:41:21 -0800
IronPort-SDR: Sjt0du6eV+E8oVsM/XC4dZnf/5YUumfUB71Zrh8b0ISP++zzg22q0pB+dkklYsFH1+5HGdfASH
 YSTCPpAH3wiw==
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="410604369"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.212.3.187])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 09:41:20 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH BlueZ 0/2] Fix 32 bit Compiler Errors
Date:   Wed, 27 Jan 2021 09:40:48 -0800
Message-Id: <20210127174050.1536152-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In a couple places the sizeof() macro has been assumed to return a
(long unsigned) value, and so the string formater %lu has been used to
print out warnings derived from this assumption. While correct on 64 bit
systems, this is an incorrect assumption on 32 bit systems.

These two changes explicitly cast the sizeof return to long in the
affected cases.

Brian Gix (2):
  advertising: Make data size explicit for formats
  tools/mgmt-tester: Make data size explicit for formats

 src/advertising.c   | 2 +-
 tools/mgmt-tester.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.25.4


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD69AC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 23:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93DB161601
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 23:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbhA0XOp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jan 2021 18:14:45 -0500
Received: from mga02.intel.com ([134.134.136.20]:33573 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234802AbhA0XMy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jan 2021 18:12:54 -0500
IronPort-SDR: MjVy2giwmXRAGojS4y/VULtBTZh2l4qJ8Ts0vSExeL3e/KTZIq0gAteWUnIpAFUl79SEZERvD/
 4LDpW3XKyrjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="167245062"
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="167245062"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 15:10:23 -0800
IronPort-SDR: DrnPVEbw/o7TlH5yuvlAb+2MQvfLAKwGsvNZYYktf2iH6u9oGCkQ4U8uXF1WBR+9dl51fOyWtK
 W/+xQIaSJXzg==
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="403263464"
Received: from bjmaylan-mobl2.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.126.25])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 15:10:23 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com, denkenz@gmail.com
Subject: [PATCH BlueZ v3 0/2] Fix 32 bit Compiler Errors
Date:   Wed, 27 Jan 2021 15:10:03 -0800
Message-Id: <20210127231005.1579325-1-brian.gix@intel.com>
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

v2: Fix bluez.test.bot warnings

v3: Just use %zu format descriptor, which should be architecture agnostic.

Brian Gix (2):
  advertising: Fix formater for size_t data type
  tools/mgmt-tester: Fix formatter for size_t value

 src/advertising.c   | 2 +-
 tools/mgmt-tester.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.25.4


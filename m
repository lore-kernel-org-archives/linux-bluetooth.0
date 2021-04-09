Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90944C433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Apr 2021 12:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59A1161177
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Apr 2021 12:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhDIMUa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Apr 2021 08:20:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:65075 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231638AbhDIMU3 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Apr 2021 08:20:29 -0400
IronPort-SDR: atuNqu/fk0ifrG7Y06xWLhqiwlTVqWl4dajV8peobGIS1oRvq0fEOCA61Zd6m/l/44XkEyLc0b
 UeiU+VUiP8Bg==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="173229302"
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="173229302"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 05:20:16 -0700
IronPort-SDR: X4P6Bmv6l+8vDh8TomdqoRMYPLbEDsHmpNo1BNRj6HCy7GF9cDhJqv409gsCChpeGEbWJlFwB6
 g3ojQb8ePKSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="416239766"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga008.fm.intel.com with ESMTP; 09 Apr 2021 05:20:15 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 0/3]  Enumerate supported codecs and cache the data at driver
Date:   Fri,  9 Apr 2021 17:54:02 +0530
Message-Id: <20210409122405.29850-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

During driver initialization path, add support to query controller
for the local supported codecs and cache the details at driver. This information
can be made available to user space audio modules to select the codec for 
audio offload use cases

Kiran K (3):
  Bluetooth: add support to enumerate codec capabilities
  Bluetooth: add support to enumerate local supports codecs v2
  Bluetooth: cache local supported codec capabilities

 include/net/bluetooth/hci.h      |  20 ++++
 include/net/bluetooth/hci_core.h |  23 ++++
 net/bluetooth/hci_core.c         |  35 +++++-
 net/bluetooth/hci_event.c        | 185 +++++++++++++++++++++++++++++++
 4 files changed, 262 insertions(+), 1 deletion(-)

-- 
2.17.1


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D5EC4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Nov 2022 17:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiKBR7i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Nov 2022 13:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiKBR7h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Nov 2022 13:59:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121981F2CF
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Nov 2022 10:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667411977; x=1698947977;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E9v2TOfAXZymDOvPp51VcdrSlpEjvo4WI0QE/LVOyJs=;
  b=cpinhAaU9BRMWInOzs/7xWnI0xFZkt4jZWcJil/ZLHagAxOUiW7waTFh
   14TA+w7Ej6DP2YZ7Mw00mUBp/UoEbLWOGqYb7Qq7YwLC/EZf+eG+wfqH+
   0kTDsr357gl2uaNrCYq4GhEo6gODtWt9zpb5k65G+yE7N4T7s9uFWaeSm
   kHJyHEBEx1l3B/1Jzic2tsX2QORelI+vmnnBwzLSj6TaxKZOySr0hIXi4
   w2DLtVCxq6AEj3nY3hdqHKQ+P3psQLmVhvsA1dLJStXGtlA1hPP6JxYXz
   SqQUHBnKE0ZuLRjvuYdk6br4HPxCkh/VyqvqFaWl1ZxeaBLzSd4sKet2l
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="292798249"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="292798249"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 10:59:36 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="963626144"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="963626144"
Received: from xwang-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.69.185])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 10:59:36 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com, marex@denx.de
Subject: [PATCH 0/1] Fix MSFT filter enable
Date:   Wed,  2 Nov 2022 10:59:26 -0700
Message-Id: <20221102175927.401091-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch recodes the execution of msft_set_filter_enable() to use the
syncronous HCI cmd opcode method (__hci_smd_sync_status()). This
function is called from within a safe, blockable context that also calls
the syncronous read_supported_features() call.

I have tested this to my satisfaction, but would like a testing pass be
made by @Mateusz (mat.jonczyk@o2.pl) if possible.

Brian Gix (1):
  Bluetooth: Convert MSFT filter HCI cmd to hci_sync

 net/bluetooth/msft.c | 36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

-- 
2.38.1


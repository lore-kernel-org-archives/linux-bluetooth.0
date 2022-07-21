Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D15C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Jul 2022 22:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbiGUW5j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jul 2022 18:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiGUW5h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jul 2022 18:57:37 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0003B8E1CB
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 15:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658444256; x=1689980256;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hb2NETRlY/gn+OAuwfTxe9wo8mRHnSuPh/wskJ4/mj0=;
  b=g8RuOVNTm+S5b4731m+1hcLTd0/dusBJmXBPq3tDuvslzqiM1Lz4r/s/
   aId1uXy7LYmJFGblHLzCW3aDGZZM9vPP3ZozI5pgQ9BstBvT3EZ7YW0Sz
   BsKf8oph2CyBTzxS1JTFoVN3hq1Ms/SS5NKgUQboOHVpcz05Igf7czqLa
   W6NWEBLZMVv8z8lvceB4sFcWY+HWMLgUbyKNuSPNplu1P7i3wry0b1Lk5
   uTRyeAYGep9O1k/NFu+MmRgqtD+wzAt7NunbdHLW2chrZIjtbgcxXeFt/
   mvO/zv9z/eVnuGh36+aDUmP3q/ojOMEETmDrUD98quvvPnTRzOz/OVLM+
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="267586479"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="267586479"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 15:57:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="548961958"
Received: from chialing-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.213.171.1])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 15:57:18 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH 0/3] Clean-up stale/unused hci_request.c code
Date:   Thu, 21 Jul 2022 15:57:02 -0700
Message-Id: <20220721225705.602002-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This will be a growing patch-set of conversions and dead-code removal
towards the goal of retiring hci_request.c

The patch sets will be split amoung the work queues and delayed work
queues as initialized in hci_request_setup(), with the ultimate goal of
eliminating hci_request.c entirely.

Brian Gix (3):
  Bluetooth: Remove dead code from hci_request.c
  Bluetooth: Remove update_scan hci_request dependancy
  Bluetooth: Convert delayed discov_off to hci_sync

 include/net/bluetooth/hci_core.h |   2 -
 include/net/bluetooth/hci_sync.h |   1 +
 net/bluetooth/hci_event.c        |   4 +-
 net/bluetooth/hci_request.c      | 417 -------------------------------
 net/bluetooth/hci_request.h      |   7 -
 net/bluetooth/hci_sync.c         |  10 +
 net/bluetooth/mgmt.c             |  40 ++-
 7 files changed, 49 insertions(+), 432 deletions(-)

-- 
2.36.1


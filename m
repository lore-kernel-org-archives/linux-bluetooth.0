Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA991C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Jul 2022 23:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbiGUXWk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jul 2022 19:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiGUXWk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jul 2022 19:22:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B406F1D30F
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 16:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658445759; x=1689981759;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FsxsrY+rb+zDAhmSaKIpommxDF7vHsfNXHQaYSXvotg=;
  b=jKZcuPDo99CyaDLbUxLeFg20BFFVb6dr9JrfEdKZwgnmrnlCqau3P8d2
   exl74+UqN+ryVhvhUFbOrROiRZyoWKzBLwMywHO2HMVJMgwJlOXyYmsgc
   2sj+ZGjBNaCxrlL6e3cRBHpD2Af1DnmTuV5Nricc2+9KYNrN4U9ZewGdg
   1Uft/xfY+F1QYCAgkCdVRNLb1fE1SnI+GXwiJR9h9zDrln+UjpKpXky/5
   bxHkWCqC6UoImhZdvL7Vfmt5/ihhkq5v3pIXl8sje/VJbWurwWK2a7aJu
   T5Sm1mdD+V/ktoluVaiqjnj2SJ17AUgOu8GIf02/lBVMINjPip777wmz/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="312912918"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="312912918"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 16:22:39 -0700
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="631363081"
Received: from chialing-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.213.171.1])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 16:22:38 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v2 0/3] Clean-up stale/unused hci_request.c code
Date:   Thu, 21 Jul 2022 16:22:22 -0700
Message-Id: <20220721232225.624426-1-brian.gix@intel.com>
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

v2: Rebase off of correct branch

Brian Gix (3):
  Bluetooth: Remove dead code from hci_request.c
  Bluetooth: Remove update_scan hci_request dependancy
  Bluetooth: Convert delayed discov_off to hci_sync

 include/net/bluetooth/hci_core.h |   2 -
 include/net/bluetooth/hci_sync.h |   1 +
 net/bluetooth/hci_event.c        |   4 +-
 net/bluetooth/hci_request.c      | 393 -------------------------------
 net/bluetooth/hci_request.h      |   7 -
 net/bluetooth/hci_sync.c         |  10 +
 net/bluetooth/mgmt.c             |  41 +++-
 7 files changed, 50 insertions(+), 408 deletions(-)

-- 
2.36.1


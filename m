Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB92CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Mar 2022 18:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbiCaSJt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Mar 2022 14:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbiCaSJs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Mar 2022 14:09:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7256F7F70
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Mar 2022 11:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648750080; x=1680286080;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V2miUM0n5Cl+3i8ZDJR2btVC9Re4DhSw6auDQ6Krmb0=;
  b=VbYj/P6X9e2Hb4KqTmq37BHZddcOMgKYNr4Di49Jf2GwVL4qJEkL3gVS
   sIvGPPqorP1fF5eq8Jia4yjpq8jT2UIGuRQfQbawKff1HsI9oETQB0gwU
   mYKGgiJ6CRquNZPdbblkRqDCqgZTcCPDFFJVV57xQjDGOay5R5kSPasiB
   cz6BHOX8R5QPlLRJIKVxNHGGT9BWMS2uRAy7DoZC6+OViPExI8WH/N2Kq
   ZSZcv00pxZVti/2BGPIhFkN66ltR2+sq6EHvEM6BMLjNUNOeBvt/rj/rQ
   OzORIr+5FpKu4qgU2B3LxZuB3ohi1KHA9FUYFt6q/oZ5GPKQY9Y8Jssz9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="257495895"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="257495895"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 11:08:00 -0700
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="840896152"
Received: from coletonb-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.6.25])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 11:08:00 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH 0/3] Add Mesh functionality to net/bluetooth
Date:   Thu, 31 Mar 2022 11:07:46 -0700
Message-Id: <20220331180749.456913-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Housekeeping and implementation.

Brian Gix (3):
  Bluetooth: Keep MGMT pending queue ordered FIFO
  Bluetooth: Implement support for Mesh
  Bluetooth: Add experimental wrapper for MGMT based mesh

 include/net/bluetooth/hci.h      |   4 +
 include/net/bluetooth/hci_core.h |  18 +-
 include/net/bluetooth/hci_sync.h |   3 +
 include/net/bluetooth/mgmt.h     |  51 +++
 net/bluetooth/hci_conn.c         |   2 +-
 net/bluetooth/hci_core.c         |   1 +
 net/bluetooth/hci_event.c        |  61 ++--
 net/bluetooth/hci_request.c      | 115 +++++--
 net/bluetooth/hci_sync.c         | 104 ++++--
 net/bluetooth/mgmt.c             | 532 ++++++++++++++++++++++++++++++-
 net/bluetooth/mgmt_util.c        |  60 +++-
 net/bluetooth/mgmt_util.h        |  17 +
 12 files changed, 884 insertions(+), 84 deletions(-)

-- 
2.35.1


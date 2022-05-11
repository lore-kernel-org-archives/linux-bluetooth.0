Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79485C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 May 2022 15:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239167AbiEKPy0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 May 2022 11:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242074AbiEKPyX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 May 2022 11:54:23 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF02102BAF
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 May 2022 08:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652284462; x=1683820462;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/Rwws4/m61jlUMFq1+/k3gPsK4xEjY7VLAYVOp8MPaI=;
  b=FiRAVlnzlU5ecAuZCqzw2wud6+XMtXBshMMRPmphMTeLmmK6KO6cpiPA
   GkKCve+dzr+Sp8Tla1AVjjpZgiGhbplbYbDoMp6CpeTdfAnY9qCoxEAXy
   rKJIMbN+CrPLmGLmS2cDQwMFOY0FQVOyEq4mQgh0E0ldbgv22hLZD6S1s
   71J7TJKTWhpxefF6VGMtkFCgbEB11TFcJSNvKX+dw1BC1usKamv9tfN5X
   2V9OjC6oWzpOgz5Fe5X4maOILVi6nehGgNIGDx0OyhPyg/nxMibZdxo+h
   HUT2NV8E+shxiE+8AI9p+/+PgtrV8yLiBSmpn29SdwksQSsZnCpFijUtV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="251789349"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="251789349"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 08:54:22 -0700
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="670441680"
Received: from hrazimi-x1c10v.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.105.221])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 08:54:21 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v4 0/2] Add Mesh functionality to net/bluetooth
Date:   Wed, 11 May 2022 08:54:10 -0700
Message-Id: <20220511155412.740249-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Housekeeping and implementation

v2: Add checking for Packet Ownership when querying Tx queue state
    Add cleanup of Tx queue when MGMT socket closes

v3: Fix CI complaints

v4: More indent clean-ups and proper var types

Brian Gix (2):
  Bluetooth: Implement support for Mesh
  Bluetooth: Add experimental wrapper for MGMT based mesh

 include/net/bluetooth/bluetooth.h |   1 +
 include/net/bluetooth/hci.h       |   4 +
 include/net/bluetooth/hci_core.h  |  18 +-
 include/net/bluetooth/hci_sync.h  |   3 +
 include/net/bluetooth/mgmt.h      |  51 +++
 net/bluetooth/hci_conn.c          |   2 +-
 net/bluetooth/hci_core.c          |   1 +
 net/bluetooth/hci_event.c         |  61 ++--
 net/bluetooth/hci_request.c       | 116 +++++--
 net/bluetooth/hci_sock.c          |   1 +
 net/bluetooth/hci_sync.c          | 103 ++++--
 net/bluetooth/mgmt.c              | 552 +++++++++++++++++++++++++++++-
 net/bluetooth/mgmt_util.c         |  69 ++++
 net/bluetooth/mgmt_util.h         |  17 +
 14 files changed, 914 insertions(+), 85 deletions(-)

-- 
2.35.1


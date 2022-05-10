Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133B4C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 May 2022 21:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiEJVns (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 May 2022 17:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbiEJVnp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 May 2022 17:43:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B15F24F0DE
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 May 2022 14:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652219025; x=1683755025;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gIOytwYz47x9wsBQlgJrqv2WPaWIEQD4XaO598OeuE4=;
  b=XlyoubvPe9LxxohwQVTqcHbpf8ARBA2IZY/pb5YVhEPqfVX8FhBzs82b
   eu3byQ5bZ5R0lAeZTgrtneVIoorjg3uMq6HS3CZdFx7bC0rVLogfki2dC
   yA54t/DbbWHdtqEEf+5KkCqKdrDhN9BgFXgmpL+6P+Zsyp9eNq42SqIWX
   bqgaqYRwRoqwF7J9wAhKHrRuLLSJnKGd3KnNvdP0clq04iehDLPncgIXf
   0fmy9Cn02ZPdVzbv8WuYpie7b3NoEVQLCkoq/7oETH1YOSgZRCjxw9tkS
   REEWLGLNKKudUpO0P9039fnLwc6idVx+t2ddiKqjCjS6hJGtQ89PaSohF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="249410784"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="249410784"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 14:43:45 -0700
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="520222693"
Received: from tiyeh-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.70.46])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 14:43:44 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v3 0/2] Add Mesh functionality to net/bluetooth
Date:   Tue, 10 May 2022 14:43:23 -0700
Message-Id: <20220510214325.633935-1-brian.gix@intel.com>
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


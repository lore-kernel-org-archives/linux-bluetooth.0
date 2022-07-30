Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA37DC00144
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Jul 2022 00:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239373AbiG3Auw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Jul 2022 20:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiG3Auv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Jul 2022 20:50:51 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA76D72EE4
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Jul 2022 17:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659142249; x=1690678249;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=G2ubfTKmAQXrxNfLWFxtAUK/jcRFdbufYVOBPtCT//Q=;
  b=fHNtW6uI8Fwww7gS05oEdExtwLC3RtglWniTVkOLqhKc+829oSXFS8m7
   m4CY2mKV6tmJPq8I6fgRFsV/8f4Tn7v4BCAR7FGhKH+4iJUx2PcAQh8NW
   0pyFEVuriVgIHt4uAv6a/gDherjYewgng1ggqabH0swoc19UvL0RNUeO8
   qjNF8ivLCcJteo8h5vWZdvR+objVDnOUexSRNidp+O8dedFjsczHNmFzf
   KXEchcRKKEZm6V+x5jgvpZjF4okhy1jArK3SJ7+BevJoFacNCaB5tn9x/
   SC3CHv0n/ZKO0yck1xsVXYaFjbDvaa7/NJvCfEDIyteHN5R+WOqdCyXOt
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="268644784"
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="268644784"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 17:50:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="660458094"
Received: from agcodina-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.26.50])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 17:50:49 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v5 00/10] Clean-up stale/unused hci_request.c code
Date:   Fri, 29 Jul 2022 17:50:28 -0700
Message-Id: <20220730005038.894650-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.1
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

v2: Published

v3: Continuing work.  This does include one conversion
(SCO configure_datapath) that has been tested with mgmt-tester and
sco-tester, but has not been tested with a controller with an
off-loadable codec.

v4: Clean-up checkpatch warnings.

v5: Remove remaining procedures from hci_request.c/h. Not that other
entities (notably amp.c, hci_event.c and hci_core.c) are still using
the hci_request mechanism, however, the mgmt-tester unit test only
currently execute opcode 0x1408 - HCI_OP_READ_ENC_KEY_SIZE during normal
testing.

Brian Gix (10):
  Bluetooth: Convert le_scan_disable timeout to hci_sync
  Bluetooth: Rework le_scan_restart for hci_sync
  Bluetooth: Delete unused hci_req_stop_discovery()
  Bluetooth: Convert SCO configure_datapath to hci_sync
  Bluetooth: Convert Interleave Scanning timeout to hci_sync
  Bluetooth: Move Adv Instance timer to hci_sync
  Bluetooth: Delete unreference hci_request code
  Bluetooth: move hci_get_random_address() to hci_sync
  Bluetooth: convert hci_update_adv_data to hci_sync
  Bluetooth: Convert hci_abort_conn to hci_sync

 include/net/bluetooth/hci_sync.h |   10 +-
 net/bluetooth/hci_conn.c         |   86 +-
 net/bluetooth/hci_core.c         |    4 +-
 net/bluetooth/hci_event.c        |    2 +-
 net/bluetooth/hci_request.c      | 2002 +-----------------------------
 net/bluetooth/hci_request.h      |   61 -
 net/bluetooth/hci_sync.c         |  564 ++++++++-
 net/bluetooth/mgmt.c             |    5 +-
 8 files changed, 639 insertions(+), 2095 deletions(-)

-- 
2.37.1


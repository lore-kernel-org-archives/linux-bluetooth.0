Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD4FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Dec 2021 22:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347798AbhLBW3v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Dec 2021 17:29:51 -0500
Received: from mga04.intel.com ([192.55.52.120]:49807 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234846AbhLBW3v (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Dec 2021 17:29:51 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="235591263"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="235591263"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 14:26:28 -0800
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="513398893"
Received: from srami-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.228.98])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 14:26:28 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, brian.gix@intel.com, luiz.dentz@gmail.com
Subject: [PATCH 0/2] Kernel based Mesh support
Date:   Thu,  2 Dec 2021 14:26:17 -0800
Message-Id: <20211202222619.626678-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch set implements support for sending and receiving Mesh packets
in the kernel without assuming full control of the Bluetooth Controller.

The purpose of the patch-set is to allow co-existance and sharing of a
single controller between the Classic Bluetooth daemon (bluetoothd) and
the Bluetooth Mesh daemon (bluetooth-meshd).

Basic functionality is that once enabled, the bluetooth controller will
always at a minimum be performing a Passive Scan, and can at any time
request an ADV packet to be sent.

Brian Gix (2):
  Bluetooth: Add management API for Mesh support
  Bluetooth: Implement support for Mesh

 include/net/bluetooth/hci.h      |   5 +
 include/net/bluetooth/hci_core.h |  16 ++-
 include/net/bluetooth/hci_sync.h |   2 +
 include/net/bluetooth/mgmt.h     |  26 ++++
 net/bluetooth/hci_conn.c         |   4 +-
 net/bluetooth/hci_event.c        |  61 +++++----
 net/bluetooth/hci_request.c      | 119 ++++++++++++++----
 net/bluetooth/hci_sync.c         |  94 +++++++++++---
 net/bluetooth/mgmt.c             | 208 +++++++++++++++++++++++++++++--
 9 files changed, 456 insertions(+), 79 deletions(-)

-- 
2.31.1


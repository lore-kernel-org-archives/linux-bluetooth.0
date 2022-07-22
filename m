Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EFDC43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jul 2022 22:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbiGVWU6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jul 2022 18:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbiGVWU5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jul 2022 18:20:57 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208CE201BE
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 15:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658528457; x=1690064457;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ip7y5R8fBu3v7NnqKhxOrKd/arBESSfWwPQEcfBoCns=;
  b=LdBwRer07pHquySdQpBIF1E27unHqbgUPZQNpD6mN5bEf4ItWuMhLbkm
   qdkbpj6zYL2QudAO57h96OJobegcGLRMN2cuNFY4yV/kDq15sHx8aojEh
   +2Um57HX45KOQSjCkYcEG5XNkRkIkLlxj/anSoU71E2twIRratYiOTyNY
   7X9/kgTTDnOa+PPmVgSWloYKd8irZWOpEE0TjGGXTLKxdlGOFUTwmIJ21
   L33Ydy6s9nmJpmI2C6ZFblNQFobZcyNHBrdrtUjXNA6wEfaZLLkTyHJFy
   R1ych5UvhrurEwUlB3ovs+kBqJMmUYjrsGxROu18t5YWGAxgg9VMrmWoe
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="288595497"
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="288595497"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 15:20:56 -0700
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="926206662"
Received: from cviverox-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.148.195])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 15:20:56 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH 0/1] Clean-up stale/unused hci_request.c code
Date:   Fri, 22 Jul 2022 15:20:40 -0700
Message-Id: <20220722222041.812546-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Next in series of hci_request clean-up patches, on way towards
elimination of hci_request.c in favor of hci_sync.c

Brian Gix (1):
  Bluetooth: Convert le_scan_disable timeout to hci_sync

 net/bluetooth/hci_request.c | 98 +------------------------------------
 net/bluetooth/hci_sync.c    | 73 +++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 97 deletions(-)

-- 
2.36.1


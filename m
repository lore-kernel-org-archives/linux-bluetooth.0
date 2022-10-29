Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166EFC433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Oct 2022 16:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiJ2Qps (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Oct 2022 12:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiJ2Qpq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Oct 2022 12:45:46 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F405A2C1
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Oct 2022 09:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667061945; x=1698597945;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n0TyEp3p5QZdwthlRYIAoFNceprkdNiu49COIfoHpfk=;
  b=h9J/BxuHUZHYnhdjB8mUdCObPlwSO7eyx1NeMBR0DFgRJJFL2U2uJTVd
   bIgMxLNdJNjV2QJSANDG6Kzx/tjHAXl5zsQnLAWUH8IPLd+ICnKVo3UpK
   MLGfLet2f0KJSbHxg7qVzPL1w+FswsYdisWgUEhOvYq4zrL3cR7dGLFsx
   m6y07jmVYbmuX535PgJrhd5V6iZOVg/uYgMTXl/vAxQ9mtd62Up6BW3M0
   fgDTHahDf3iC1wfVQoELI+x3eimfjG8aAy04JvKfQw6m8y4CE53qHnlX5
   N6MM7VDu0A0rlTuo3DGCZae/iadFBjK63306Ip5nPa4uWfK/mGI837KA7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="289074306"
X-IronPort-AV: E=Sophos;i="5.95,224,1661842800"; 
   d="scan'208";a="289074306"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 09:45:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="666399472"
X-IronPort-AV: E=Sophos;i="5.95,224,1661842800"; 
   d="scan'208";a="666399472"
Received: from tester-latitude-7480.iind.intel.com ([10.224.186.120])
  by orsmga001.jf.intel.com with ESMTP; 29 Oct 2022 09:45:44 -0700
From:   Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
Subject: [PATCH BlueZ 0/5] To add support for Metadata, CID, VID
Date:   Sat, 29 Oct 2022 22:34:03 +0530
Message-Id: <20221029170408.175533-1-abhay.maheshbhai.maheta@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This series of patches adds support for Metadata, Company ID and
Vendor Codec ID during Endpoint Registration for LE Audio.

Abhay Maheta (1):
  shared/bap: Fix handling for Company ID and Vendor Codec ID

Maheta, Abhay (4):
  shared/bap: Add support to set stream metadata
  profiles: Add Support for Metadata, CID and VID
  media-api: Add CompanyID, VendorCodecID, Metadata
  client/player: Add support for Metadata, CID, VID

 client/player.c            | 185 +++++++++++++++++++++++++++++++++++--
 doc/media-api.txt          |  18 ++++
 profiles/audio/bap.c       |  20 ++++
 profiles/audio/media.c     | 100 ++++++++++++++++++--
 profiles/audio/transport.c |   4 +-
 src/shared/bap.c           |  25 ++++-
 src/shared/bap.h           |   4 +-
 7 files changed, 331 insertions(+), 25 deletions(-)

-- 
2.25.1


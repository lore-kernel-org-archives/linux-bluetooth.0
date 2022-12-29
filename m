Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87348C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Dec 2022 15:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbiL2P5D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Dec 2022 10:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbiL2P4e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Dec 2022 10:56:34 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5133F164A1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Dec 2022 07:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672329265; x=1703865265;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A79TZpi1+iYIEguY4DVGXyasuA43rY9di1w6X0LmY90=;
  b=Bdel2rVXPIxCMTa/oTp7IZjcZB3xKX+d82SoEyIcTKWCZcVGn8OzKw3G
   7nmxdDtlhVqDKN6RkeporaAQUimO4NIoftAjIg19F5lxCaobS5Gt3maOg
   bLmwLY5zxCQ+iCwqng3dKwkUeHF+gD2HKaooXJKvr8/5kO16xYjA3uVBz
   Rj1M23GFWDdYlDxwyJK+SO2uwypIg/u/uAhmULu42Zy6jgukIglLBWAdZ
   L3QUs+Da5qLiD2LWH3h7AtNR2ljKlpDaH7RNu0SzQ2cI7HTWIIOuH6zV7
   xiQHXy6kPaM7hsGesMpxUOkfzs6FQshR8T+TMqonBjK46RnXWj9HchIIX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="321139189"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="321139189"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 07:54:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="686024225"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="686024225"
Received: from tester-latitude-7480.iind.intel.com ([10.224.186.122])
  by orsmga001.jf.intel.com with ESMTP; 29 Dec 2022 07:54:23 -0800
From:   Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>,
        Abhay Maheta <mabhay125@gmail.com>
Subject: [PATCH BlueZ v3 0/6] To add support for Metadata, CID, VID
Date:   Thu, 29 Dec 2022 21:22:53 +0530
Message-Id: <20221229155257.341327-1-abhay.maheshbhai.maheta@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This series of patches adds support for Metadata, Company ID and
Vendor Codec ID during Endpoint Registration for LE Audio.

Abhay Maheta (6):
  shared/bap: Fix handling for Company ID and Vendor Codec ID
  shared/bap: Add support to set stream metadata
  profiles: Add Support for Metadata, CID and VID
  media-api: Add CompanyID, VendorCodecID, Metadata
  client/player: Add support for Company ID, Vendor ID
  client/player: Add support for Metadata in BAP Profile

 client/player.c            | 205 ++++++++++++++++++++++++++++++++++---
 doc/media-api.txt          |  18 ++++
 profiles/audio/bap.c       |  14 ++-
 profiles/audio/media.c     |  99 ++++++++++++++++--
 profiles/audio/transport.c |   4 +-
 src/shared/bap.c           |  31 +++++-
 src/shared/bap.h           |   4 +-
 7 files changed, 342 insertions(+), 33 deletions(-)

-- 
2.25.1


Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F5FC4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Dec 2022 12:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiL2MJz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Dec 2022 07:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbiL2MJw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Dec 2022 07:09:52 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCE813E3A
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Dec 2022 04:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672315790; x=1703851790;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j2sBWqjKZIHsxWFYMjrJWHZfy/n6qXjjCfkETVqiqxk=;
  b=V54azp2R0fAB3ZlFKveDPE2HDpJUXMtM+mkyq7KholHhbnduOGLRkiAx
   Dazo9g0VyDHCjusLciMPxMBqyuDQfScFlcVInFXf3zPJh3r4ut6EF1fOd
   cOnG+PUTFSl+pkR6tDbBLnHt0+dgaLq3mcyd8sFyOqrkOrVVUD5syWZpp
   oGWZCTlMmlOPYD1RHn0ZSx7qf+PZZ+Yh2RqGVedBj85bXWzLYPAVzzBRL
   OQ/PhNKfVfqbcPVk9anuFrtGv3qttWtnKbogwAJ6lVJKcGP8mMc3pFQ3z
   dmXLG44g5XcflOyjwsRM4BYeQzE1aQjM4cXNnibBWKXx9HuGwJq5EOHpK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="319744701"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="319744701"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 04:09:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="777680047"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="777680047"
Received: from tester-latitude-7480.iind.intel.com ([10.224.186.122])
  by orsmga004.jf.intel.com with ESMTP; 29 Dec 2022 04:09:48 -0800
From:   Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>,
        Abhay Maheta <mabhay125@gmail.com>
Subject: [PATCH BlueZ v2 0/6] To add support for Metadata, CID, VID
Date:   Thu, 29 Dec 2022 17:58:17 +0530
Message-Id: <20221229122821.340073-1-abhay.maheshbhai.maheta@intel.com>
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
  client/player: Add support for Company ID, Vendor ID in BAP Profile
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


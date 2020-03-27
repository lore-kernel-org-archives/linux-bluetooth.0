Return-Path: <SRS0=n6SA=5M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B99C2D0EE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 09:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE6C20714
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 09:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgC0JdF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Mar 2020 05:33:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:7378 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgC0JdF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Mar 2020 05:33:05 -0400
IronPort-SDR: 36+C2Une62+tR/YZAU3UVHDAijtQRmWuC5gq9QFMsO087bB1fewPpdVV8qmIwloPWXmHAb7XhJ
 JV604fwA22qg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 02:33:04 -0700
IronPort-SDR: uwl8/A4z6528v5xSlp4adnN2G+ktw42WCmXDW1UwkktdMT7G2or+Uy+gn4d5/TpUixW3rEx4+B
 PEd0Ibz4d+Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,311,1580803200"; 
   d="scan'208";a="447351389"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmsmga005.fm.intel.com with ESMTP; 27 Mar 2020 02:33:03 -0700
From:   Amit K Bag <amit.k.bag@intel.com>
List-Id: <linux-firmware.lore.kernel.org>
To:     linux-firmware@kernel.org
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com, Amit K Bag <amit.k.bag@intel.com>
Subject: [PATCH 2/2] linux-firmware: Update firmware file for Intel Bluetooth AX200
Date:   Fri, 27 Mar 2020 15:03:35 +0530
Message-Id: <20200327093335.20150-2-amit.k.bag@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200327093335.20150-1-amit.k.bag@intel.com>
References: <20200327093335.20150-1-amit.k.bag@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch updates new firmware file for Intel Bluetooth AX200
Also it is known as Intel CyclonePeak (CcP).

FW Build: REL0384

Release Version: 21.70.3.2

Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
---
 intel/ibt-20-0-3.ddc | Bin 27 -> 14 bytes
 intel/ibt-20-1-3.ddc | Bin 27 -> 14 bytes
 intel/ibt-20-1-4.ddc | Bin 27 -> 14 bytes
 3 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/intel/ibt-20-0-3.ddc b/intel/ibt-20-0-3.ddc
index 3cd54fe2c149616ff68aee097a466c534832f805..f24bb176758e6fce478820f1c2b7f7930bf88ce3 100644
GIT binary patch
literal 14
VcmZS9V3c5SVsvd_(PU(1000Ym0fGPk

literal 27
icmZSV{=>(t!6?Dv#OT_<qRGh2z{JPK*!_orfdK$Wjs&&<

diff --git a/intel/ibt-20-1-3.ddc b/intel/ibt-20-1-3.ddc
index 3cd54fe2c149616ff68aee097a466c534832f805..f24bb176758e6fce478820f1c2b7f7930bf88ce3 100644
GIT binary patch
literal 14
VcmZS9V3c5SVsvd_(PU(1000Ym0fGPk

literal 27
icmZSV{=>(t!6?Dv#OT_<qRGh2z{JPK*!_orfdK$Wjs&&<

diff --git a/intel/ibt-20-1-4.ddc b/intel/ibt-20-1-4.ddc
index 3cd54fe2c149616ff68aee097a466c534832f805..f24bb176758e6fce478820f1c2b7f7930bf88ce3 100644
GIT binary patch
literal 14
VcmZS9V3c5SVsvd_(PU(1000Ym0fGPk

literal 27
icmZSV{=>(t!6?Dv#OT_<qRGh2z{JPK*!_orfdK$Wjs&&<

-- 
2.17.1


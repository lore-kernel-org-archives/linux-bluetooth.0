Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425D0C77B75
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Apr 2023 05:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjDRF5N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Apr 2023 01:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjDRF5M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Apr 2023 01:57:12 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC9E40F0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Apr 2023 22:57:04 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33I5ui8E3022240, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33I5ui8E3022240
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 18 Apr 2023 13:56:44 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 18 Apr 2023 13:56:11 +0800
Received: from localhost (172.21.132.123) by RTEXMBS03.realtek.com.tw
 (172.21.6.96) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 18 Apr
 2023 13:56:10 +0800
From:   <max.chou@realtek.com>
To:     <jwboyer@kernel.org>
CC:     <linux-firmware@kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <alex_lu@realsil.com.cn>, <hildawu@realtek.com>,
        <karenhsu@realtek.com>, <max.chou@realtek.com>,
        <hsinyu_chang@realtek.com>
Subject: [PATCH] rtl_bt: Add firmware and config files for RTL8851B
Date:   Tue, 18 Apr 2023 13:56:04 +0800
Message-ID: <20230418055604.5650-1-max.chou@realtek.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.132.123]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS03.realtek.com.tw (172.21.6.96)
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Max Chou <max.chou@realtek.com>

This firmware/config is submitted for RTL8851B BT USB I/F.

Version: 0x0411_7851

Signed-off-by: Max Chou <max.chou@realtek.com>
---
 WHENCE                      |   2 ++
 rtl_bt/rtl8851bu_config.bin | Bin 0 -> 6 bytes
 rtl_bt/rtl8851bu_fw.bin     | Bin 0 -> 46376 bytes
 3 files changed, 2 insertions(+)
 create mode 100644 rtl_bt/rtl8851bu_config.bin
 create mode 100644 rtl_bt/rtl8851bu_fw.bin

diff --git a/WHENCE b/WHENCE
index 7cc9afd4..d15b3507 100644
--- a/WHENCE
+++ b/WHENCE
@@ -3820,6 +3820,8 @@ File: rtl_bt/rtl8852bu_fw.bin
 File: rtl_bt/rtl8852bu_config.bin
 File: rtl_bt/rtl8852cu_fw.bin
 File: rtl_bt/rtl8852cu_config.bin
+File: rtl_bt/rtl8851bu_fw.bin
+File: rtl_bt/rtl8851bu_config.bin
 
 Licence: Redistributable. See LICENCE.rtlwifi_firmware.txt for details.
 
diff --git a/rtl_bt/rtl8851bu_config.bin b/rtl_bt/rtl8851bu_config.bin
new file mode 100644
index 0000000000000000000000000000000000000000..91d3f4402289e7b0efd395c7fcc8b4789465aba6
GIT binary patch
literal 6
NcmWGtt=!JQ000Mk0jmH2

literal 0
HcmV?d00001

diff --git a/rtl_bt/rtl8851bu_fw.bin b/rtl_bt/rtl8851bu_fw.bin
new file mode 100644
index 0000000000000000000000000000000000000000..046fab7ee7460b2bb66cd1a72c087148e3b3a8a8
GIT binary patch
literal 46376
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
aW6K_mc?y?WA4&`=6^aA}vrPT{BmWPtpVMam

literal 0
HcmV?d00001

-- 
2.34.1


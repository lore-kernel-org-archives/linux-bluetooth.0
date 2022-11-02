Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DACC4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Nov 2022 10:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiKBKMj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Nov 2022 06:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiKBKMb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Nov 2022 06:12:31 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F81248DA
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Nov 2022 03:12:30 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id A4CD5FF80B
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Nov 2022 10:12:25 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ] main.conf: Add comment about LA Audio BAP UUIDs
Date:   Wed,  2 Nov 2022 11:12:24 +0100
Message-Id: <20221102101224.1463549-1-hadess@hadess.net>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 src/main.conf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/main.conf b/src/main.conf
index 2796f155e..fbe0a97be 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -125,6 +125,8 @@
 # 330859bc-7506-492d-9370-9a6f0614037f (BlueZ Experimental Bluetooth Quality Report)
 # a6695ace-ee7f-4fb9-881a-5fac66c629af (BlueZ Experimental Offload Codecs)
 # 6fbaf188-05e0-496a-9885-d6ddfdb4e03e (BlueZ Experimental ISO socket)
+# 00002bcb-0000-1000-8000-00805f9b34fb (BlueZ Experimental LE Audio BAP source)
+# 00002bc9-0000-1000-8000-00805f9b34fb (BlueZ Experimental LE Audio BAP sink)
 # Defaults to false.
 #KernelExperimental = false
 
-- 
2.37.3


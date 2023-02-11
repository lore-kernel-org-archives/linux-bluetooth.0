Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265BBC64EC4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Feb 2023 10:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjBKK5M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Feb 2023 05:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjBKK5J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Feb 2023 05:57:09 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0383A83D2
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Feb 2023 02:57:08 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 8E46F2404CC
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Feb 2023 11:57:07 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PDSGq0SlNz9rxR;
        Sat, 11 Feb 2023 11:57:07 +0100 (CET)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 3/9] lib: Add defines for MGMT setting bits for CIS feature support
Date:   Sat, 11 Feb 2023 10:53:47 +0000
Message-Id: <fd1422a2a4910aed0effee5557a7f2de50106762.1676112710.git.pav@iki.fi>
In-Reply-To: <3df45c4a6737b249b519d4c6128e2eb783198abc.1676112710.git.pav@iki.fi>
References: <20230127205205.20235-1-pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---

Notes:
    v2: no changes
    
    The kernel mgmt.h doesn't use BIT(n) macro here, so I didn't change that
    now to keep these defines identical.

 lib/mgmt.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 796190cd9..efbdfb4b1 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -96,6 +96,8 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_STATIC_ADDRESS	0x00008000
 #define MGMT_SETTING_PHY_CONFIGURATION	0x00010000
 #define MGMT_SETTING_WIDEBAND_SPEECH	0x00020000
+#define MGMT_SETTING_CIS_CENTRAL	0x00040000
+#define MGMT_SETTING_CIS_PERIPHERAL	0x00080000
 
 #define MGMT_OP_READ_INFO		0x0004
 struct mgmt_rp_read_info {
-- 
2.39.1


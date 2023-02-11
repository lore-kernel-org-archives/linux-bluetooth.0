Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E9DC64EC7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Feb 2023 10:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjBKK5N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Feb 2023 05:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjBKK5K (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Feb 2023 05:57:10 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7138F23112
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Feb 2023 02:57:09 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 262E0240769
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Feb 2023 11:57:08 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PDSGq5PjZz9rxM;
        Sat, 11 Feb 2023 11:57:07 +0100 (CET)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 5/9] tools/btmgmt: add MGMT setting bit names for CIS feature support
Date:   Sat, 11 Feb 2023 10:53:49 +0000
Message-Id: <34f7dbd9336538420154195bd0d353d8cbbeb2dd.1676112710.git.pav@iki.fi>
In-Reply-To: <3df45c4a6737b249b519d4c6128e2eb783198abc.1676112710.git.pav@iki.fi>
References: <20230127205205.20235-1-pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add names for CIS Central/Peripheral MGMT setting bits:

[mgmt]# info
Index list with 1 item
hci0:	Primary controller
	addr XX:XX:XX:XX:XX:XX version 12 manufacturer 2 class 0x7c0104
	supported settings: powered connectable fast-connectable discoverable bondable link-security ssp br/edr le advertising secure-conn debug-keys privacy configuration static-addr phy-configuration wide-band-speech cis-central cis-peripheral
	current settings: powered bondable ssp br/edr le secure-conn cis-central cis-peripheral
	name xxx
	short name
hci0:	Configuration options
	supported options: public-address
	missing options:
---

Notes:
    v2: add example command output

 tools/btmgmt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 29f86091f..323c26712 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -353,6 +353,8 @@ static const char *settings_str[] = {
 				"static-addr",
 				"phy-configuration",
 				"wide-band-speech",
+				"cis-central",
+				"cis-peripheral",
 };
 
 static const char *settings2str(uint32_t settings)
-- 
2.39.1


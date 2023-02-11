Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADEBC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Feb 2023 10:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjBKK5P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Feb 2023 05:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjBKK5L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Feb 2023 05:57:11 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B5F30D7
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Feb 2023 02:57:10 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id C7C0224072C
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Feb 2023 11:57:08 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PDSGr2n8Qz9rxL;
        Sat, 11 Feb 2023 11:57:08 +0100 (CET)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 7/9] media: Check adapter CIS support to add BAP in SupportedUUIDs
Date:   Sat, 11 Feb 2023 10:53:51 +0000
Message-Id: <a6149863ad36c97732955c165144762a6d6a8427.1676112710.git.pav@iki.fi>
In-Reply-To: <3df45c4a6737b249b519d4c6128e2eb783198abc.1676112710.git.pav@iki.fi>
References: <20230127205205.20235-1-pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Don't indicate BAP support in SupportedUUIDs, if adapter supports
neither CIS Central nor Peripheral.
---

Notes:
    v2: use btd_adapter_has_features

 profiles/audio/media.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 505c4b3a6..0e0c40dc7 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1279,6 +1279,10 @@ static bool experimental_endpoint_supported(struct btd_adapter *adapter)
 	if (!btd_adapter_has_exp_feature(adapter, EXP_FEAT_ISO_SOCKET))
 		return false;
 
+	if (!btd_adapter_has_features(adapter, ADAPTER_CIS_CENTRAL) &&
+	    !btd_adapter_has_features(adapter, ADAPTER_CIS_PERIPHERAL))
+		return false;
+
 	return g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
 }
 
-- 
2.39.1


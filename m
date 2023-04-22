Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A0FC7618E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Apr 2023 17:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjDVRGF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 22 Apr 2023 13:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjDVRGD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 22 Apr 2023 13:06:03 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9112926B0
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Apr 2023 10:06:02 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 0B6B7240102
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Apr 2023 19:06:01 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Q3d884YMyz6ty0;
        Sat, 22 Apr 2023 19:06:00 +0200 (CEST)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/2] bap: add Location parameter to SelectProperties
Date:   Sat, 22 Apr 2023 17:05:57 +0000
Message-Id: <a744467fc6dcaa243c0bb31bbea8a2d8ca9a7172.1682182441.git.pav@iki.fi>
In-Reply-To: <3cc705b0fa000b4cfc5071ae13f4c0fcb31bfc25.1682182441.git.pav@iki.fi>
References: <3cc705b0fa000b4cfc5071ae13f4c0fcb31bfc25.1682182441.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add relevant PACS Location field as a parameter to SelectProperties.

SelectProperties may set Audio_Channel_Allocation, which shall be chosen
from the bits set in Sink/Source Audio Locations (BAP v1.0.1 Sec. 4.4.1,
Sec 4.4.2). Hence, audio server needs to know the supported values,
which it previously could not.
---
 profiles/audio/media.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 540e91bc6..52c4bd80a 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -901,6 +901,7 @@ static int pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 	DBusMessage *msg;
 	DBusMessageIter iter, dict;
 	const char *key = "Capabilities";
+	uint32_t loc;
 
 	bt_bap_pac_get_codec(rpac, NULL, &caps, &metadata);
 	if (!caps)
@@ -932,6 +933,11 @@ static int pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 					DBUS_TYPE_BYTE, &caps->iov_base,
 					caps->iov_len);
 
+	loc = bt_bap_pac_get_locations(rpac);
+	if (loc)
+		g_dbus_dict_append_entry(&dict, "Location", DBUS_TYPE_UINT32,
+									&loc);
+
 	if (metadata) {
 		key = "Metadata";
 		g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &key,
-- 
2.40.0


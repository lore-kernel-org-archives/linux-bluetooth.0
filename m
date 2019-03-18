Return-Path: <SRS0=9Smc=RV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AD4C43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Mar 2019 16:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D446020863
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Mar 2019 16:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXtxw58R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfCRQTz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:19:55 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:38379 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfCRQTz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Mar 2019 12:19:55 -0400
Received: by mail-ed1-f46.google.com with SMTP id e10so10143368edy.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2019 09:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sKMClBLtGHiwkDq42U7Q+h9gDy4iXeeaKvDa3Ck2ikA=;
        b=NXtxw58R+Os4wQkB+fHGtRGABqYn+I199860aOQU/qWgybcmo2RurUF9nmckF9oT+f
         vNWogGEziogbJMxheI6vPR+WfLLcmQvFFmrd6TS2jHIoIn83KemhwjWoqDujBRCd7hrR
         ZYoYJ+CLhs5iPAV1B3ZxD08/ZAv7RuRTtVw7mnUthWXxxw132aQINsqEbJm/AuhXuFcH
         XNIgi+ZlMmVI99lGGmya7YdcUGIVl55AU75DhkcCSzvUToKO2DO+tBpHmtrmcyNRshp9
         LwQgCUXjsxNmrYQx1Dbf5qz1f9xY7ggMgyhj+4siro0pT0kxkm45rXjki6c2NoqSxi6I
         n2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sKMClBLtGHiwkDq42U7Q+h9gDy4iXeeaKvDa3Ck2ikA=;
        b=slHS03mjXy44wgQLx1yMbPTJ8jOAygs2ByyqrpBx5L0gm+CkuGiR1j+nGkof5Q52uI
         mPnxxNYmjh+UVUB18eFQGG5AY1Bk+5ekBu0x/mLuKw+yfTtvNSG7UI8apnrMKfY+/IGM
         viNRt/n4Vmb4jv6iUSsOJTIJuvs8KXLHwVze3+lQXSDYowmi1ieOc8Xlt3UbXfP5j/mR
         Ht8Hs/1JHnhCBhO02R/+jKcAr8lxJVIdt+ty2GJwEmkuzrDW5JIslWiH+HKWvptM+DYv
         zD2AMo4XejgignG5/Wo9UX+d2GV8cyE4lxYlCglrb4cE0GOAqnnaFEfTmq+hEj1XPDGr
         8fsA==
X-Gm-Message-State: APjAAAViaErd+TsK9bWwaPfzqm29WHn+dV71aEicr9g0sLNSY/fXBh2U
        dLdHxynTpuKIpUpSah7N+HNjD+UP
X-Google-Smtp-Source: APXvYqxdm8aPXPOR+DJwrPz/ntXHLYGAQRU/z8HcyBNwqznYVC84yUL2wkLy/iE0swWm4xbkuQI8OQ==
X-Received: by 2002:a17:906:6d56:: with SMTP id a22mr11539182ejt.211.1552925992937;
        Mon, 18 Mar 2019 09:19:52 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id n3sm2491210eja.56.2019.03.18.09.19.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 18 Mar 2019 09:19:51 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] shared/gatt-client: Add debug for error with included services
Date:   Mon, 18 Mar 2019 18:19:47 +0200
Message-Id: <20190318161949.21749-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This logs errors with included service so it is easier to noticed when
they are malformed.
---
 src/shared/gatt-client.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 1119d1a34..ec1041f66 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -532,12 +532,19 @@ static void discover_incl_cb(bool success, uint8_t att_ecode,
 				"uuid: %s", handle, start, end, uuid_str);
 
 		attr = gatt_db_get_attribute(client->db, start);
-		if (!attr)
+		if (!attr) {
+			util_debug(client->debug_callback, client->debug_data,
+				"Unable to find attribute at 0x%04x", start);
 			goto failed;
+		}
 
 		attr = gatt_db_insert_included(client->db, handle, attr);
-		if (!attr)
+		if (!attr) {
+			util_debug(client->debug_callback, client->debug_data,
+				"Unable to add include attribute at 0x%04x",
+				handle);
 			goto failed;
+		}
 
 		/*
 		 * GATT requires that all include definitions precede
@@ -545,8 +552,12 @@ static void discover_incl_cb(bool success, uint8_t att_ecode,
 		 * these entries, the correct handle must be assigned to the new
 		 * attribute.
 		 */
-		if (gatt_db_attribute_get_handle(attr) != handle)
+		if (gatt_db_attribute_get_handle(attr) != handle) {
+			util_debug(client->debug_callback, client->debug_data,
+				"Invalid attribute 0x%04x expect it at 0x%04x",
+				gatt_db_attribute_get_handle(attr), handle);
 			goto failed;
+		}
 	}
 
 next:
-- 
2.20.1


Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F14C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Apr 2022 20:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382024AbiDTURl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Apr 2022 16:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351311AbiDTUR0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Apr 2022 16:17:26 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B725E46668
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Apr 2022 13:14:39 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c23so2856283plo.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Apr 2022 13:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=unP3oOLZzZNN5SF2bW2yygikeJ7QdH3xEez4jSep3nY=;
        b=U+Ns67IwzErw5jW3hMtAQe/Pll5rrS+e+D1zNxzJKumHBddukx6nOwdNMxeq2YZjxg
         GLQyYWLzz/SiCACBsmSK5ltDaKFiSoo7Zd+l+cTJZxhquNfr1CKyOw7H0hAoGehADBi5
         dx9WMm3N7WirAowsLw4/r3ttAHF2B0DTZnlehIWJB2eZLGpK/Ky0AZivhuDrh4X2jvR1
         caPjkXT5sOpdHdfuabv2zRMgLlq2X/eH7MB/S8vkEeZxSPJw8YHSAxgjlwFGhUAm8KDT
         VODSicgstzKlHfEnE5EmZIuw1De/drox85EyWaXaE/NfcPLsBUfoMK0ND5k21bHTZGA4
         PWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=unP3oOLZzZNN5SF2bW2yygikeJ7QdH3xEez4jSep3nY=;
        b=Zt8sdDdIanIHKI049PeiMK4s4LZIqNzZJ2TcH+ReIDbQolJ08Evw+Ipi2ApT/hAfll
         p8ma5xe4tZqpFw0Qny6f8sBbsTSVqAczR1iIxW5v6Xxf4QwH5Byo9HA0/GctSWGOe2zc
         P1cvdb5TyhTTy+FWvMPrB71GizYCdugn9UTLziSRsux47O4kw5R74hSR6ll159b5kAMd
         x/FNYol7mWzYhOM/eo4OCz2rfN3Lfsx1SfBVXpZfsW7vEl/cKZFjFtOYS5PYhKXBb7WF
         PNVRt9kBk6rm2KN9Zg5mtMoUy33AWLH5O71h+jVO4IVHVOTozSY2xfii56+aOXQ227zR
         zvAA==
X-Gm-Message-State: AOAM531pQ8uXVP3NI2V6//AATKglotSon5TNWPRzfLDby2c1Us1pDJH4
        9zRQe596Z3ffTO4Fw4e6M4G/795Zdsw=
X-Google-Smtp-Source: ABdhPJwCAYCCTQmaa47yzM2OCFatigFi9usFNj0pMrQxlNM+Jl4niilUXXIXYjhoiYOi6OKVXV7EGg==
X-Received: by 2002:a17:90b:1c86:b0:1bf:2a7e:5c75 with SMTP id oo6-20020a17090b1c8600b001bf2a7e5c75mr6385949pjb.145.1650485678743;
        Wed, 20 Apr 2022 13:14:38 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b3-20020a17090a800300b001cd4989feb7sm35855pjn.3.2022.04.20.13.14.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 13:14:38 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] hog-lib: Check if Report ID is set before prepending it
Date:   Wed, 20 Apr 2022 13:14:37 -0700
Message-Id: <20220420201437.2855806-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Before prepending the Report ID check if it is non-zero:

BLUETOOTH SPECIFICATION Page 16 of 26
HID Service Specification

Report ID shall be nonzero in a Report Reference characteristic
descriptor where there is more than one instance of the Report
characteristic for any given Report Type.

Fixes: https://github.com/bluez/bluez/issues/334
Fixes: https://github.com/bluez/bluez/issues/320
Fixes: https://www.spinics.net/lists/linux-bluetooth/msg97262.html
---
 profiles/input/hog-lib.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index b611f6b4a..e69ea1ba4 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -348,7 +348,14 @@ static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 	ev.type = UHID_INPUT;
 	buf = ev.u.input.data;
 
-	if (report->numbered) {
+	/* BLUETOOTH SPECIFICATION Page 16 of 26
+	 * HID Service Specification
+	 *
+	 * Report ID shall be nonzero in a Report Reference characteristic
+	 * descriptor where there is more than one instance of the Report
+	 * characteristic for any given Report Type.
+	 */
+	if (report->numbered && report->id) {
 		buf[0] = report->id;
 		len = MIN(len, sizeof(ev.u.input.data) - 1);
 		memcpy(buf + 1, pdu, len);
-- 
2.35.1


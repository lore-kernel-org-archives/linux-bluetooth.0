Return-Path: <SRS0=2LFz=ID=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD52C433E9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 23:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6595464FC9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 23:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhCEXAX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Mar 2021 18:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbhCEXAG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Mar 2021 18:00:06 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7D7C06175F
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Mar 2021 15:00:06 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so2746261pjb.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Mar 2021 15:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RCIARyL+yI78OnrOxU9Vg4raZwfK51cZztn+ESGZXKY=;
        b=J4RBZP6VW9smkE9y7j0qeWgt/sbf/6ZdyW8VsfnK7u5LxQk0/OYsZ1A56/kV8RNDL5
         uY703I+HOecWzeMx8zSzT5CktQDLsa6wUw0h1w3KBn3IEOAVnzPEEON2PHCCOJfWimJg
         DaQD3tuVqJCP2jjAOj86XzQCigQSrn+M80z8sxZ6CZFl0yNsYa76I7eNVyi87JGCU5q2
         A1pmvpXnzRVwqitkfybjgu9iHSYlEVrdzIbjn0t9rTNBmYaicSJzX2LGj6LfGlapJljx
         AQMvQUWN0NGnZD8VW++8uOlQZEZBV4Kaz+AdrBW6K5BxEB5wRsQZD2tTueOUKVDX+LeT
         7QZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RCIARyL+yI78OnrOxU9Vg4raZwfK51cZztn+ESGZXKY=;
        b=lE9TLnDtpb0mzmrOqdDg/FQLsTSoK1lYiVRRTK/4thIEj6vMTlaKfla3hcdSV/uJsq
         8NaXgBNQlTxnRXDMe6F+D9nNScwI1KPU12Skwbe5KLCfXwCfSW3Ll9hMSHaigmBWp0B3
         AJpb96FAvwNkOfUH5Qi7FrEumaJGOr6SJUmoMm8vB96lftf1DYf7MYFOJVXrtIXG2FpA
         vuGemwcJ71rq/Ao79DcPK3VrjpLtV0bHsE9hlKSTK75qkkbwmh2YSWJ47QJspSYb1Tpo
         /tMzBpFI9C8w/iTejeBk02JOjA/2G7u8Jn8iaziYnoLj1PoAdRALd6LdAoDbp7GAWi2E
         xl5A==
X-Gm-Message-State: AOAM532EjOR/vHTr33/7+q0ThgNZjQgagdjbR5fKpxdB44dvdI5Ylxwf
        K0i6Si/RQ3geNj/KDGVJ0uAYUOlyXR/SUA==
X-Google-Smtp-Source: ABdhPJxMVwQrTy8KPzbpFAm2UOdLymWj4kYRiqBHJHisVNtqzVcEdctG2/J3+wkRZoCP2lazLE6PjQ==
X-Received: by 2002:a17:90a:29a3:: with SMTP id h32mr12922596pjd.209.1614985205729;
        Fri, 05 Mar 2021 15:00:05 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e1sm3483546pfi.175.2021.03.05.15.00.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 15:00:05 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] main.conf: Enable passing false to DeviceID
Date:   Fri,  5 Mar 2021 15:00:03 -0800
Message-Id: <20210305230004.4010887-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for setting DeviceID to false so plaforms can disable
DeviceID.

Fixes: https://github.com/bluez/bluez/issues/101
---
 src/main.c    | 8 +++++++-
 src/main.conf | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/main.c b/src/main.c
index b66e2b8cb..572dc939c 100644
--- a/src/main.c
+++ b/src/main.c
@@ -188,10 +188,16 @@ static void parse_did(const char *did)
 	int result;
 	uint16_t vendor, product, version , source;
 
-	/* version and source are optional */
+	vendor = 0x0000;
+	product = 0x0000;
 	version = 0x0000;
 	source = 0x0002;
 
+	if (!strcasecmp(did, "false")) {
+		source = 0x0000;
+		goto done;
+	}
+
 	result = sscanf(did, "bluetooth:%4hx:%4hx:%4hx",
 					&vendor, &product, &version);
 	if (result != EOF && result >= 2) {
diff --git a/src/main.conf b/src/main.conf
index ad36638b7..f47cab46d 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -26,7 +26,7 @@
 # Use vendor id source (assigner), vendor, product and version information for
 # DID profile support. The values are separated by ":" and assigner, VID, PID
 # and version.
-# Possible vendor id source values: bluetooth, usb (defaults to usb)
+# Possible vendor id source values: bluetooth, usb (default) or false (disabled)
 #DeviceID = bluetooth:1234:5678:abcd
 
 # Do reverse service discovery for previously unknown devices that connect to
-- 
2.29.2


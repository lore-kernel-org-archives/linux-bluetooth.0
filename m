Return-Path: <SRS0=Mp0c=ZZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27804C432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 01:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E056320717
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Dec 2019 01:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KjObmp2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfLCBEw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Dec 2019 20:04:52 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33990 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfLCBEw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Dec 2019 20:04:52 -0500
Received: by mail-pl1-f194.google.com with SMTP id h13so892449plr.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Dec 2019 17:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BXe7pwRrQbnwA35nRKUJbHIgxLQzSL9KPqmYLwImFic=;
        b=KjObmp2hWin28jpFmOdK/7S8ugklkrYGViJ69cEbsbnfvKzsYlbaOSxTsS2PQ76g7K
         t1PDDHEQMrh5VsOBePCBeCKz69kHOJPyTPIl3AM6tOwDApFat727wJdn0jFIyK7k+i1+
         ncP7Ro7VWPIdMeyuCq4+z24G5XdViaJ4CljSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BXe7pwRrQbnwA35nRKUJbHIgxLQzSL9KPqmYLwImFic=;
        b=ElYyqi0yMPTjhfyHCjks17ffrzwC/iXDA66PstPP86PzlQs2M+4BHnbhMlYw1GLNFw
         6/hfdpwM5d5B2ymPUoOY0IQw3RkTZsxkLDQTE/nF7fa6+fTKc5XLncEYL6EKo9e5pnSi
         cfjS1QBy21Tfclg0IN2vBMUvtK7549JMU8FphGLd6RfDDpgj68Chu3Y1o5pRdQ1EQlvY
         cXFWFh8vv7Un0lGVD15KNUHPEMj1+QTQZQ7Iky/DaBmB7fKO2RiHzT+fcxXvDIEgbZIC
         177/FarYTaMVig9/dVqwfJ9iFfFE1be+WEtzccsYZzSVrgMg1u8r3oEqjkq+GWirnnV+
         7BeQ==
X-Gm-Message-State: APjAAAUyKst7vXoZ81ZOBXAjRn3ASFynF8Zvr2Ek/GpN89qZywGD1jP7
        RjZKYEuVacPjTy/nbmIt5E8KPw==
X-Google-Smtp-Source: APXvYqzSkBODkbZ4yAhJkBg0aPk+k8hBA6dpC489e5rQ/ELRxvdYsoaNVGkUzlIU4MiMUPXtchl1zg==
X-Received: by 2002:a17:902:14f:: with SMTP id 73mr2274536plb.19.1575335091524;
        Mon, 02 Dec 2019 17:04:51 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id 143sm741808pfz.67.2019.12.02.17.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 17:04:27 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        alainm@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v2 1/4] lib: Add ba2strlc to match kernel printk format
Date:   Mon,  2 Dec 2019 17:03:57 -0800
Message-Id: <20191203010400.216538-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When the kernel prints the bluetooth address (via %pMR), it prints the
address in lower case. ba2strlc should be used in cases where we should
match the kernel casing (i.e. addresses assigned to /dev/uhid and
/dev/uinput)

---

Changes in v2:
- Split into its own commit

 lib/bluetooth.c | 7 +++++++
 lib/bluetooth.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/lib/bluetooth.c b/lib/bluetooth.c
index effc7f49d..7cba509d8 100644
--- a/lib/bluetooth.c
+++ b/lib/bluetooth.c
@@ -81,6 +81,13 @@ int ba2str(const bdaddr_t *ba, char *str)
 		ba->b[5], ba->b[4], ba->b[3], ba->b[2], ba->b[1], ba->b[0]);
 }
 
+/* Match kernel's lowercase printing of mac address (%pMR) */
+int ba2strlc(const bdaddr_t *ba, char *str)
+{
+	return sprintf(str, "%2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x",
+		ba->b[5], ba->b[4], ba->b[3], ba->b[2], ba->b[1], ba->b[0]);
+}
+
 int str2ba(const char *str, bdaddr_t *ba)
 {
 	int i;
diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index eb279260e..756dce164 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -325,6 +325,7 @@ void baswap(bdaddr_t *dst, const bdaddr_t *src);
 bdaddr_t *strtoba(const char *str);
 char *batostr(const bdaddr_t *ba);
 int ba2str(const bdaddr_t *ba, char *str);
+int ba2strlc(const bdaddr_t *ba, char *str);
 int str2ba(const char *str, bdaddr_t *ba);
 int ba2oui(const bdaddr_t *ba, char *oui);
 int bachk(const char *str);
-- 
2.24.0.393.g34dc348eaf-goog


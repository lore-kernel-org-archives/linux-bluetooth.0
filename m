Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CECC6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 10:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjCWKbi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 06:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjCWKag (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 06:30:36 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F03238442
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:27:37 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ek18so84301748edb.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1679567256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3tKJg36pKhaz0q4z4JJnvDg/ansCdesQ1ZGxEBivzI=;
        b=YUldwR6SvnhMUV8um+fDWE9oFoA5s9ZvtI6Ja9B6eWI4APx3LqCR47jeZUvfzjtZQx
         HJVylUgu1xX0ltonv5NbaY8LSWQ/WUqsV78G4I82IWn9R6AEZQr7P36wvkrh8G8blwmM
         hZmMlzGGUxp8nzcdNSPfY+5l8fP2cI8DDI9TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679567256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3tKJg36pKhaz0q4z4JJnvDg/ansCdesQ1ZGxEBivzI=;
        b=FKhwtvVXsuHLeDlOzKEGtt1Rjwgs0HITfzZPd28UF3pQWq4kqVfMdrtnbVnF+s9kSi
         DY4HTcGjqAJeDKDgfJcV6NxS/WR34lqBnX2OFBfbIVSsiWnGH8BNu/hroy2BLAtCSGTJ
         X7qSJOVifecBESak+7Jmt+aTxOHFAmYVkmaCeU/lsdTW79fhs4VtvjkmqqEhFAedsgrx
         LJzZwDvRAI6td4fdM8DS2KUiDun/wRlKJ/jkNmr/6YUSBnT9taCFH4d0oAD+/jsSe77b
         bcc6Tu/WAVCHgBz1/rmxz25V5/JpoOIUE1S8BQhxfN+YvDD0FcAiRdHLuao077qol+h1
         Ykcg==
X-Gm-Message-State: AO0yUKWpPOWs6d2YfudxjS/X4hodAvjFgPVqH0OasXEtGfKL4vhJx+h7
        XBYxb+2e+5+lYehxM0PJKV+y2NVbe6wQ9Sv6N5w=
X-Google-Smtp-Source: AK7set9VCsZ9qgc+3jQb/1aq6HNXvUwKWsFhtLaI9r04+2SXLgJ+ZAC1N1y+duwF/7YysHQHA/SI/g==
X-Received: by 2002:a17:906:14c5:b0:931:af6a:ad0f with SMTP id y5-20020a17090614c500b00931af6aad0fmr9599149ejc.76.1679567255804;
        Thu, 23 Mar 2023 03:27:35 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:4f8c:7da4:48b2:8bd2])
        by smtp.gmail.com with ESMTPSA id u25-20020a50c2d9000000b004faf34064c8sm8880564edf.62.2023.03.23.03.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:27:35 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 2/2] l2test: Fix setting mode for BR/EDR l2cap socket
Date:   Thu, 23 Mar 2023 11:27:32 +0100
Message-Id: <20230323102732.566440-3-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323102732.566440-1-simon.mikuda@streamunlimited.com>
References: <20230323102732.566440-1-simon.mikuda@streamunlimited.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

BT_MODE_* enums are used only for socket SOL_BLUETOOTH, option BT_MODE
Otherwise we should use L2CAP_MODE_* enums.
---
 lib/l2cap.h    |  2 ++
 tools/l2test.c | 22 +++++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/lib/l2cap.h b/lib/l2cap.h
index 9197800df..62cc04b57 100644
--- a/lib/l2cap.h
+++ b/lib/l2cap.h
@@ -184,6 +184,8 @@ typedef struct {
 #define L2CAP_MODE_FLOWCTL	0x02
 #define L2CAP_MODE_ERTM		0x03
 #define L2CAP_MODE_STREAMING	0x04
+#define L2CAP_MODE_LE_FLOWCTL	0x80
+#define L2CAP_MODE_ECRED		0x81
 
 #define L2CAP_SERVTYPE_NOTRAFFIC	0x00
 #define L2CAP_SERVTYPE_BESTEFFORT	0x01
diff --git a/tools/l2test.c b/tools/l2test.c
index 595f1dab2..61b2e778e 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -155,6 +155,24 @@ static struct lookup_table bdaddr_types[] = {
 	{ NULL,		0			},
 };
 
+static int bt_mode_to_l2cap_mode(int mode)
+{
+	switch (mode) {
+		case BT_MODE_BASIC:
+			return L2CAP_MODE_BASIC;
+		case BT_MODE_ERTM:
+			return L2CAP_MODE_ERTM;
+		case BT_MODE_STREAMING:
+			return L2CAP_MODE_STREAMING;
+		case BT_MODE_LE_FLOWCTL:
+			return L2CAP_MODE_LE_FLOWCTL;
+		case BT_MODE_EXT_FLOWCTL:
+			return L2CAP_MODE_FLOWCTL;
+		default:
+			return mode;
+	}
+}
+
 static int get_lookup_flag(struct lookup_table *table, char *name)
 {
 	int i;
@@ -287,9 +305,11 @@ static int getopts(int sk, struct l2cap_options *opts, bool connected)
 
 static int setopts(int sk, struct l2cap_options *opts)
 {
-	if (bdaddr_type == BDADDR_BREDR)
+	if (bdaddr_type == BDADDR_BREDR) {
+		opts->mode = bt_mode_to_l2cap_mode(opts->mode);
 		return setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, opts,
 								sizeof(*opts));
+	}
 
 	if (opts->mode) {
 		if (setsockopt(sk, SOL_BLUETOOTH, BT_MODE, &opts->mode,
-- 
2.34.1


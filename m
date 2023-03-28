Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A3DC76195
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Mar 2023 05:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjC1F11 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Mar 2023 01:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjC1F10 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Mar 2023 01:27:26 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD259268A
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 22:27:25 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ew6so44771679edb.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 22:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1679981244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmpttvszH23PKP6qf48ggrRNacQmH9loXc/WEU8w3DY=;
        b=QEL9SIu02CNFqfO3H3OE0L78sFxXO+YuIBeezQEfuwt1O1hI1y7R1xFnqyHStpS5BJ
         lMzEG5XACaiZfjtgRkcj2b7hRgtECOUVpNYAA8duSPNf3C0ZTT0b94GtuxeyJ9C+EjgZ
         EksPyWjFCHnHdxAA+PrnMi6ns+26Mb2VQATPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679981244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmpttvszH23PKP6qf48ggrRNacQmH9loXc/WEU8w3DY=;
        b=uuPSCqvuYBnkrYNa4TiK/TSM6AsYlMudM0lPAR30inTSuAIGmiBOxaeDUsxgtEA+MF
         vjMQIJBJrUEYrVLf7wnuwH/7tUARZjkaPewxrJ52pVY2MN28b5Aj5AiAPGMJlBeHOthX
         lEquMDiodyfExoCm9079PzgERWV9Z81l7cEbBv2lfoKYb5PZ2b5frNuhL9GUmhRxxgMH
         xu8JotQeqTZ+JScFYpQNjS5qYe02khUOsQ9SLt7xjBM25EQaUiejG9SDSqNRta+vGCAi
         x/Cgi16ArnWen4QqwEXnQnbVBokV4o6VBqDzXUHUZ7MeSEIuNy/W3aCZ3q7kyL3FkHmN
         87eA==
X-Gm-Message-State: AAQBX9ddpQJtReMVcJ1QqThzlC4hCnD1h2PS8oRqeTpFHMMKw1T7ihHE
        fAqRSi0gWm5UO7MpchsT+5nZsKjpaw7iBGdj0To=
X-Google-Smtp-Source: AKy350bLw2fjspfiP3BzIFa2+BVN4VwGeI7OBQ7D1MTZalTB71E/KbsyGeuIT6f2uXrsjA5pWfga5w==
X-Received: by 2002:aa7:d314:0:b0:502:62:7c with SMTP id p20-20020aa7d314000000b005020062007cmr13405049edq.24.1679981244080;
        Mon, 27 Mar 2023 22:27:24 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:1167:5b7f:c0f0:e6ec])
        by smtp.gmail.com with ESMTPSA id b44-20020a509f2f000000b004c09527d62dsm15427109edf.30.2023.03.27.22.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 22:27:23 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 2/2] l2test: Fix setting mode for BR/EDR l2cap socket
Date:   Tue, 28 Mar 2023 07:26:19 +0200
Message-Id: <20230328052619.1357253-3-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230328052619.1357253-1-simon.mikuda@streamunlimited.com>
References: <CABBYNZLyQkvU1uzV8WF9n54FC43OvFzNne6XJcAUj2yCB8dVbw@mail.gmail.com>
 <20230328052619.1357253-1-simon.mikuda@streamunlimited.com>
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
index 232247b78..e86ac917c 100644
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


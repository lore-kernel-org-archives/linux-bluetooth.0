Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E37C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jan 2022 21:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiAGVcT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jan 2022 16:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiAGVcT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jan 2022 16:32:19 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43A4C061574
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jan 2022 13:32:18 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so7631778pjp.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jan 2022 13:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aubdL8fH9LEcChMAezCjyfhn6YTlYrlcqkCBSfORTi0=;
        b=DOrZ4PshTPE5HDcXjYYIwCG0JMYG/HL565h6FdQh+VXijJ2NsTOJcbe1EmvPIwSK2x
         NGtOdG+sXVFyY3vMW8+ltCUqx8MKH++jWCUembwcpbga6UdI6bNsz/c2g4bZez8KO9z2
         ICsaR+/JdKZHE2MDIIqZC9A8YzVjXAhfc8t/7fmR69Fyyo3vXWrlgf5XuAvyagF8duFV
         mP5nKcoyiWGnoLvTS49ojwK7iMCtV+BsmhbTRXXKJgSYkBGRbRAZvboQp6gYHRXZERHJ
         UzIVOimwzB/+vMS+vLRrSMDATGzxZrxhZ+fwX9DiQdPZOXAVh9aBTbtuF3/JrDYkWBL3
         YpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aubdL8fH9LEcChMAezCjyfhn6YTlYrlcqkCBSfORTi0=;
        b=bmR2WFc1oSenXsEqjJc5Wpf7I3MlMSn9iVnqqTDZ6nXsdbVs+V0JQBXDzrVGLG/Ny+
         Kf6ObR7vZTHtTPFncunaCsDOMZ++FvDBmGZDXj92ZU1Rpis021f3sAt8lb+zmTodRC+u
         E9B/FT0sb+7lx/mtk50Lo4mM6bxMroEJZb9gXM6EoR1h8FpPfkEHU3MRui/Zd5Yfq5tu
         L4aiP/y02dUGwb2YH4m9VbjfXbikQcHw4kmsn9Qk/Quyr/7Yr45HuuExB7qq2IfxxaL8
         Fw925Nq1gLvoBnQxMIGx2NpTvDmJhysSZhcCZ4UHs76G8FbsOb9fMYNVkKk/94eI/qM6
         jx3w==
X-Gm-Message-State: AOAM533+cQN93ddrBmDh3RpnADnn6gWQMaIZgArk7oagYyRw0XpuPdP8
        zHasFPtnpKg2Khqn/X3vArUMnwFSI6k=
X-Google-Smtp-Source: ABdhPJydUCWW5iSZITukVgsKKJHbmjeAEBgUY/dNPTHVi9I1WpCb3/QWn7bRnzghc8qcwYzrIIxtKQ==
X-Received: by 2002:a17:902:c410:b0:149:577c:2b08 with SMTP id k16-20020a170902c41000b00149577c2b08mr63874386plk.108.1641591137954;
        Fri, 07 Jan 2022 13:32:17 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g9sm7012184pfj.123.2022.01.07.13.32.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 13:32:17 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] avdtp: Fix runtime errors passing NULL to memcpy
Date:   Fri,  7 Jan 2022 13:32:16 -0800
Message-Id: <20220107213216.3754372-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Passing NULL to memcpy is considered undefined behavior which leads to
the following runtime errors:

profiles/audio/avdtp.c:2709:2: runtime error: null pointer passed as
argument 1, which is declared to never be null
profiles/audio/avdtp.c:2709:2: runtime error: null pointer passed as
argument 2, which is declared to never be null
profiles/audio/avdtp.c:3326:2: runtime error: null pointer passed as
argument 2, which is declared to never be null
profiles/audio/avdtp.c:500:3: runtime error: null pointer passed as
argument 2, which is declared to never be null
---
 profiles/audio/avdtp.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index f2b461330..da4114e0f 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -497,7 +497,9 @@ static gboolean avdtp_send(struct avdtp *session, uint8_t transaction,
 		single.signal_id = signal_id;
 
 		memcpy(session->buf, &single, sizeof(single));
-		memcpy(session->buf + sizeof(single), data, len);
+
+		if (data)
+			memcpy(session->buf + sizeof(single), data, len);
 
 		return try_send(sock, session->buf, sizeof(single) + len);
 	}
@@ -569,7 +571,7 @@ static void pending_req_free(void *data)
 
 	if (req->timeout)
 		timeout_remove(req->timeout);
-	g_free(req->data);
+	free(req->data);
 	g_free(req);
 }
 
@@ -2687,7 +2689,7 @@ static int send_req(struct avdtp *session, gboolean priority,
 	return 0;
 
 failed:
-	g_free(req->data);
+	free(req->data);
 	g_free(req);
 	return err;
 }
@@ -2705,8 +2707,7 @@ static int send_request(struct avdtp *session, gboolean priority,
 
 	req = g_new0(struct pending_req, 1);
 	req->signal_id = signal_id;
-	req->data = g_malloc(size);
-	memcpy(req->data, buffer, size);
+	req->data = util_memdup(buffer, size);
 	req->data_size = size;
 	req->stream = stream;
 
@@ -3323,7 +3324,9 @@ struct avdtp_service_capability *avdtp_service_cap_new(uint8_t category,
 	cap = g_malloc(sizeof(struct avdtp_service_capability) + length);
 	cap->category = category;
 	cap->length = length;
-	memcpy(cap->data, data, length);
+
+	if (data)
+		memcpy(cap->data, data, length);
 
 	return cap;
 }
-- 
2.33.1


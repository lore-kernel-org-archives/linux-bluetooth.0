Return-Path: <SRS0=34D5=X2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1014CECE587
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Oct 2019 14:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B6C20815
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Oct 2019 14:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="lkm2njoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388712AbfJAOKC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:10:02 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44069 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731280AbfJAOKC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Oct 2019 10:10:02 -0400
Received: by mail-lf1-f66.google.com with SMTP id q11so9980016lfc.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Oct 2019 07:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=55DCSgxFc7hVW6DQSPmxTSYgVif+Jlg6vTznFg7x+yo=;
        b=lkm2njoPOaEe9sPemis4Vac6FJmr7RksvcmjV3G/FAGMwASLMqhVSYvUByWHBcC/s8
         AdK123GDLYIoRpQC8+4OedPTh6i4cyTm0iKpEk+O3hJ3884d92Lj/4ClRDxoQGgTKFLA
         5gve82c4da26rceTwXjDDPH6dvrFmnrFgWhfx5kHMvkbWtVXR8nrAzhPHZtQshfGsAtO
         dETu31mPIq0BJic7Qfq/mXkcYFC0SpFzq56oGkgOunNhFgP6EAK9SVKyhl5OcqF0iGcD
         5c8rkmxNvCGxauzf0AkpqVO5RMs8koLJCyLfUjCOekK2n9XhD1YrI2jtSax3AKKXbzHf
         mC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=55DCSgxFc7hVW6DQSPmxTSYgVif+Jlg6vTznFg7x+yo=;
        b=kv1Q9REHBY2R6pFlbjS2izlqU5+2NAVyqEWS91cVee/3wmcmoyt13jHmOy69SFLsrZ
         jGP5+61z1ic0dpytWp2wAgcjrZo8ffP7enyGcB0CQ5gF5fWdtcyd970U6SM0wsO9GfFz
         Z+eeMAdh1P4ex+P96xKL6kEUiwlxkNFqR+2SVqz9PVnM9SA9oQ9q3cAXZ1zNYS564ExC
         rNqV1SRatfFwbahg/HIRgxIdgKl8Ym9jhbmw96NLK1MBwWD7g/BKSjmt9rZeJxcgnNEO
         vYGlpjLf+DX0IRUfC0wxHEMGwSR5+8mNHFnH3GhB4OpU2/C0JB9R1FDvHJim6S/wpX3g
         fRmw==
X-Gm-Message-State: APjAAAW8eNI6k0ncZoro/kiejPPq+hyFjI+vZf1llaA+1qlycJPpRbwZ
        zSxyMxx6O5Oy02V9QMqaRTQydMTItH4=
X-Google-Smtp-Source: APXvYqyVFs5cB2Ucr9D7rW6yEpNudSNNrVvrYaXHiinewcN+SqyEqQqM2u3GTMVDeCcenCICE5prkg==
X-Received: by 2002:ac2:4945:: with SMTP id o5mr15528191lfi.70.1569938999968;
        Tue, 01 Oct 2019 07:09:59 -0700 (PDT)
Received: from ix.int.codecoup.pl ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id k15sm4117794ljg.65.2019.10.01.07.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 07:09:59 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH V2 1/3] monitor: Extract TTY data processing to separate function
Date:   Tue,  1 Oct 2019 16:09:39 +0200
Message-Id: <20191001140941.8005-1-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>

---
 monitor/control.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/monitor/control.c b/monitor/control.c
index 39a413be1..4022e7644 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -1300,23 +1300,8 @@ static bool tty_parse_header(uint8_t *hdr, uint8_t len, struct timeval **tv,
 	return true;
 }
 
-static void tty_callback(int fd, uint32_t events, void *user_data)
+static void process_data(struct control_data *data)
 {
-	struct control_data *data = user_data;
-	ssize_t len;
-
-	if (events & (EPOLLERR | EPOLLHUP)) {
-		mainloop_remove_fd(data->fd);
-		return;
-	}
-
-	len = read(data->fd, data->buf + data->offset,
-					sizeof(data->buf) - data->offset);
-	if (len < 0)
-		return;
-
-	data->offset += len;
-
 	while (data->offset >= sizeof(struct tty_hdr)) {
 		struct tty_hdr *hdr = (struct tty_hdr *) data->buf;
 		uint16_t pktlen, opcode, data_len;
@@ -1358,6 +1343,26 @@ static void tty_callback(int fd, uint32_t events, void *user_data)
 	}
 }
 
+static void tty_callback(int fd, uint32_t events, void *user_data)
+{
+	struct control_data *data = user_data;
+	ssize_t len;
+
+	if (events & (EPOLLERR | EPOLLHUP)) {
+		mainloop_remove_fd(data->fd);
+		return;
+	}
+
+	len = read(data->fd, data->buf + data->offset,
+					sizeof(data->buf) - data->offset);
+	if (len < 0)
+		return;
+
+	data->offset += len;
+
+	process_data(data);
+}
+
 int control_tty(const char *path, unsigned int speed)
 {
 	struct control_data *data;
-- 
2.21.0


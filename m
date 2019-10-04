Return-Path: <SRS0=a/5L=X5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0106AC4360C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Oct 2019 05:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61662133F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Oct 2019 05:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="1qibn2cJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731496AbfJDFno (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Oct 2019 01:43:44 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37487 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730957AbfJDFno (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Oct 2019 01:43:44 -0400
Received: by mail-lf1-f65.google.com with SMTP id w67so3568558lff.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Oct 2019 22:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=55DCSgxFc7hVW6DQSPmxTSYgVif+Jlg6vTznFg7x+yo=;
        b=1qibn2cJleXgOV4FSFo5Her+T3of+EySfBy8pbDKRIHi1v++jhM1xu08xH2r3dnACy
         lyj+sZ2JjUvlrMH+fQWsUcp9xXGcmWrjt0qFRQFhaShK3MS8QAwmGUD/57VC/VL2UM+I
         j8VkhCuq9x3TRR4gyOOCC1T3NrHrzhqTyJuqbY7L5Tok8aNI/DyHc7eop81/WNagqh0C
         rib2VsME/zkEA+8D9tPmsTT/YuobJD73blMK1DFtBV3tykEn3yPr4kBrH+gVlQSsmpzr
         nQ0gYA8hNkZqTebSUQbdF0FPCR1gTD9u36yYbc61kN3opX8y+Uo0m+ajVn+AgNzIJajp
         TKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=55DCSgxFc7hVW6DQSPmxTSYgVif+Jlg6vTznFg7x+yo=;
        b=cMeh9GCGIaXAPlWhXvyHiZkPKc82oPichvpTftIO+eZDyhGhAC7sCBsdUus2dMOWcl
         wXaevCWwIZtKlmehqjNIhBU3wQWZ8moj4uY77ldeXPdPAzElPlhNbD8ArilBuMSF+m0r
         1RbQLil25j/QnApjniKrL132ksDl//X89d8/ijN4B7JMXHiKe7Axzb/9MaHEqj0AjLI/
         e/8sV5WdwLPmqo14VeXDRb6UM0zT0zPTSHoGp1KksfV2ZK6856n2PGGDA/lxiJAuUBCn
         zwQnJDfB9EVho5aT8HYcHhpW1dcfS8rQArMGm+0vRmX+LsVaD/1yraILeBvoKFbmG/s/
         F9+Q==
X-Gm-Message-State: APjAAAWvK9SF/lx0UFV09UF3Rof4A5LyRLzvlG7rQy8CPDgn39Bb95RY
        ja25Rxb4pSeH9IChdhEtUzdrzqF+Wjg=
X-Google-Smtp-Source: APXvYqxWsLMDaNWGxx56CNINPi09OVGfNf42gSRMhL3OX+8BKppUjj8yM5/Pej4gU+koDIh8csj/bw==
X-Received: by 2002:a19:711e:: with SMTP id m30mr7932003lfc.63.1570167821726;
        Thu, 03 Oct 2019 22:43:41 -0700 (PDT)
Received: from ix.int.codecoup.pl ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id q88sm1024828lje.57.2019.10.03.22.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 22:43:41 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH V3 1/3] monitor: Extract TTY data processing to separate function
Date:   Fri,  4 Oct 2019 07:43:32 +0200
Message-Id: <20191004054334.5479-1-szymon.janc@codecoup.pl>
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


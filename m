Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7290C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 20:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66CAE2240A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 20:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlHsQ+Er"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbgKTUHa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Nov 2020 15:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbgKTUH3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Nov 2020 15:07:29 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9990C0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 12:07:29 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id v21so4160646plo.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 12:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=+Kn0LlPza5fInle5gl6ExVZWBDlTbtXt7CPfXJUezIA=;
        b=OlHsQ+Erf4H4Jvw7P53dhXPpLYiJDl0oO0TTpEJRePXsSfaPjru/urGR9TTiNiK5+H
         6xq1M4Smo7vz34dDnoInhi5INjWOfSI6P7PVkJ2yHqNwxd3xWcqkBNqSXGLGY0iyIEBI
         R7WjQft3SPmCKOhTT8KhH8uf34uYidJ6f8e0IX3EhIO/hX/sbkk9I2UgRhjMKMgX240u
         02/cYqZbV4iJIGDsOa6z5se0kJK+YdbkEjqg2/Q+GCzlQWtHShwshMXCxeakx1C/6rqH
         6sUo/6H6IawRuJvGH1gKYjsY4vI3ZH3tqTv0U5q6dRW/TYKehA9Z5xycMk6jWb8zL0mA
         7Mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=+Kn0LlPza5fInle5gl6ExVZWBDlTbtXt7CPfXJUezIA=;
        b=p7S9DfVwaZ6i8n61ylJD/5Cy9DVMn3dWeLMke1XN8rPuB8DAySikYJVwvjdG2Icn3U
         QPUhWEUm013DisQLsTFKKwd27B0SBF3T4Kd8/bwxgb/lDY7q2JaLP7Y02rF0Ov8OSz46
         4mC4k3iLGM0k49eGJ4lBElEeIyQXcc/D8eKAMw55RwQCaL41uvSVOdMnzG7S9meN91BN
         OLByzF+5VBOMbWqkQNQ7fu8c2dpsrY3i3nn2YAv4BR6YZXGw/C1VRNFJCas9VIBdvYZe
         qm4WPxAvfizbzH2x3kXBu55FJLbK/HuQ/BDNPbJOczpy1T3mBc8tw2+qgbXjC5ZBi96J
         hLJA==
X-Gm-Message-State: AOAM533bIxZ7UOgSODRXQf5pObXMrvoX2ZJC2YDfoteQVVXpqCMg6LbE
        ufqIuAu1xC0ruSnSOi1ZgUrA/U25/bWd/Q==
X-Google-Smtp-Source: ABdhPJzhrKst+43P5Unf2TBiYUq+pHwIgicYP+craXNrLMN/x/EUgYBc6tYni2DgTe9xyU6dhbKIYA==
X-Received: by 2002:a17:902:b7c6:b029:d8:e447:f7ef with SMTP id v6-20020a170902b7c6b02900d8e447f7efmr14525329plz.1.1605902848926;
        Fri, 20 Nov 2020 12:07:28 -0800 (PST)
Received: from han1-mobl3.jf.net (c-73-164-224-32.hsd1.or.comcast.net. [73.164.224.32])
        by smtp.gmail.com with ESMTPSA id t5sm3979267pgt.15.2020.11.20.12.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 12:07:28 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Google-Original-From: Tedd Ho-Jeong An <tedd.an@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     tedd.an@intel.com
Subject: [PATCH 1/6] monitor: Fix potential memory leak
Date:   Fri, 20 Nov 2020 12:07:07 -0800
Message-Id: <20201120200712.491219-1-tedd.an@intel.com>
X-Mailer: git-send-email 2.25.4
Reply-To: tedd.an@intel.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If the mainloop_add_fd() returns with failure, the destroy callback is
never called so any reosurces need to be released never freed/closed.

This potential leakage is checked with valgrind after failing the
mainloop_add_fd() function manually.

   ==258684== 1,500 bytes in 1 blocks are definitely lost in loss record 3 of 3
   ==258684==    at 0x483BB1A: calloc (vg_replace_malloc.c:760)
   ==258684==    by 0x123F1A: open_channel (control.c:1058)
   ==258684==    by 0x125B09: control_tracing (control.c:1540)
   ==258684==    by 0x122764: main (main.c:255)
   ==258684==
   ==258684== LEAK SUMMARY:
   ==258684==    definitely lost: 1,500 bytes in 1 blocks
   ==258684==    indirectly lost: 0 bytes in 0 blocks
   ==258684==      possibly lost: 0 bytes in 0 blocks
   ==258684==    still reachable: 48 bytes in 2 blocks
   ==258684==         suppressed: 0 bytes in 0 blocks

This patch frees/closes the resources if the function returns with
failure.
---
 monitor/control.c | 20 +++++++++++++++++---
 monitor/hcidump.c | 14 +++++++++++---
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/monitor/control.c b/monitor/control.c
index 962da4980..d1ba97d37 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -1071,7 +1071,12 @@ static int open_channel(uint16_t channel)
 	if (filter_index != HCI_DEV_NONE)
 		attach_index_filter(data->fd, filter_index);
 
-	mainloop_add_fd(data->fd, EPOLLIN, data_callback, data, free_data);
+	if (mainloop_add_fd(data->fd, EPOLLIN, data_callback,
+						data, free_data) < 0) {
+		close(data->fd);
+		free(data);
+		return -1;
+	};
 
 	return 0;
 }
@@ -1148,7 +1153,11 @@ static void server_accept_callback(int fd, uint32_t events, void *user_data)
 	data->channel = HCI_CHANNEL_MONITOR;
 	data->fd = nfd;
 
-        mainloop_add_fd(data->fd, EPOLLIN, client_callback, data, free_data);
+	if (mainloop_add_fd(data->fd, EPOLLIN, client_callback,
+						data, free_data) < 0) {
+		close(data->fd);
+		free(data);
+	}
 }
 
 static int server_fd = -1;
@@ -1399,7 +1408,12 @@ int control_tty(const char *path, unsigned int speed)
 	data->channel = HCI_CHANNEL_MONITOR;
 	data->fd = fd;
 
-	mainloop_add_fd(data->fd, EPOLLIN, tty_callback, data, free_data);
+	if (mainloop_add_fd(data->fd, EPOLLIN, tty_callback,
+						data, free_data) < 0) {
+		close(data->fd);
+		free(data);
+		return -1;
+	}
 
 	return 0;
 }
diff --git a/monitor/hcidump.c b/monitor/hcidump.c
index 690b9b913..fac9c8a08 100644
--- a/monitor/hcidump.c
+++ b/monitor/hcidump.c
@@ -184,7 +184,11 @@ static void open_device(uint16_t index)
 		return;
 	}
 
-	mainloop_add_fd(data->fd, EPOLLIN, device_callback, data, free_data);
+	if (mainloop_add_fd(data->fd, EPOLLIN, device_callback,
+						data, free_data) < 0) {
+		close(data->fd);
+		free(data);
+	}
 }
 
 static void device_info(int fd, uint16_t index, uint8_t *type, uint8_t *bus,
@@ -393,8 +397,12 @@ int hcidump_tracing(void)
 		return -1;
 	}
 
-	mainloop_add_fd(data->fd, EPOLLIN, stack_internal_callback,
-							data, free_data);
+	if (mainloop_add_fd(data->fd, EPOLLIN, stack_internal_callback,
+							data, free_data) < 0) {
+		close(data->fd);
+		free(data);
+		return -1;
+	}
 
 	return 0;
 }
-- 
2.25.4


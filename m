Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8406BCD98C9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Oct 2023 21:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjJJV65 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Oct 2023 17:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjJJV65 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Oct 2023 17:58:57 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543E498
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 14:58:56 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c77449a6daso52999485ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 14:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696975135; x=1697579935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6oUHI/XemOwFByi9CcHJ6Rkka7yVy2KN4Ko9d/nmv6s=;
        b=H/BtUtYKfzO1815HhlZkuShv537aZtcMMAo0qXx3D4CNpWBvyzYONCDV7UYqCyTIH1
         MB6BATULf5N9sxpylZo2W0y623v296ukE1E44tdDWUC/70iQyMRwXH0qRkisqKFkLcjd
         0zFD/O+gdRhnkWPpKGHaCJQkJmn4BtY54j655SXOh654c6WV4ZhHJvO8VC2HgdxgBGnU
         u+rkBmHj4rr8UoUJTmjOiRXsSFGjhBKbJ+AHInDAxFVqk9xzwxmLM03eEGxwTynAkTNE
         qGq4yfu1uXZp1iPElcaA2rE14hJCkQQTQz88/UQdBi4shYQiyNRS74xVv6wu/TRmtxX9
         1I4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696975135; x=1697579935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6oUHI/XemOwFByi9CcHJ6Rkka7yVy2KN4Ko9d/nmv6s=;
        b=PDaQBzTEftc0YPWVRAINCBdi2B9iCU3J2v0RL38NoEYycqZAeoZs9QdDgxFZwzvvVB
         MXgMydwr1N6xMXgv+EI1Q7HP6JYFBvP7sMtw76yUHqFlOpYuPtGKMZJ+zWi02XIE6lUf
         cdA/2BbO5xXz2HgcOnL8B0eguegEKG+loNlH1XmQpfkVn7i7yhB1AxTN42VwXKaggdVT
         BYOnBEqaST+cx2X7i8MRwGEYJBvxw+0fejl/UGbku9HSVHJho9dDZSkr3IWoNBo/uqIJ
         dhjeVkiQVgdEjNwXJVxcF0mMUeJLkmEyFy7N5wfQcy5tELNPCZieYx0N5cvuHK40a5R/
         CtJw==
X-Gm-Message-State: AOJu0YwbsDki39XZLjhyMBu/5q5O6bQv5AxViez3SLjma3iQD+Wr1S+M
        bue0EWKJIe43x84LXZ1dO1KYKxAbsaHzwQruHu8=
X-Google-Smtp-Source: AGHT+IEn8InqC9MoVUjwulnAGbIQFghvVsGrf23TEj5Dj4QTeu85tM+yPnw6N/24Gh20BzumbVA1Gw==
X-Received: by 2002:a17:903:2445:b0:1c7:4ab6:b3cc with SMTP id l5-20020a170903244500b001c74ab6b3ccmr24190047pls.54.1696975134901;
        Tue, 10 Oct 2023 14:58:54 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id t24-20020a1709028c9800b001c73f51e61csm12305322plo.106.2023.10.10.14.58.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 14:58:54 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] input: Fix smatch warning
Date:   Tue, 10 Oct 2023 14:58:52 -0700
Message-ID: <20231010215853.629963-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following warning:

profiles/input/device.c:165:26: warning: Variable length array is used.
---
 profiles/input/device.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 4310dd192e11..6c64ff1c1c52 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -20,6 +20,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <sys/ioctl.h>
+#include <sys/uio.h>
 
 #include "lib/bluetooth.h"
 #include "lib/hidp.h"
@@ -162,32 +163,33 @@ static bool hidp_send_message(GIOChannel *chan, uint8_t hdr,
 {
 	int fd;
 	ssize_t len;
-	uint8_t msg[size + 1];
+	struct iovec iov[2];
 
 	if (!chan) {
 		error("BT socket not connected");
 		return false;
 	}
 
+	iov[0].iov_base = &hdr;
+	iov[0].iov_len = sizeof(hdr);
+
 	if (data == NULL)
 		size = 0;
 
-	msg[0] = hdr;
-	if (size > 0)
-		memcpy(&msg[1], data, size);
-	++size;
+	iov[1].iov_base = (void *)data;
+	iov[1].iov_len = size;
 
 	fd = g_io_channel_unix_get_fd(chan);
 
-	len = write(fd, msg, size);
+	len = writev(fd, iov, 2);
 	if (len < 0) {
 		error("BT socket write error: %s (%d)", strerror(errno), errno);
 		return false;
 	}
 
-	if ((size_t) len < size) {
+	if ((size_t) len < size + 1) {
 		error("BT socket write error: partial write (%zd of %zu bytes)",
-								len, size);
+								len, size + 1);
 		return false;
 	}
 
-- 
2.41.0


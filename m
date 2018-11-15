Return-Path: <SRS0=SE7D=N2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9304DC43441
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Nov 2018 11:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59680223DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Nov 2018 11:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=augury.com header.i=@augury.com header.b="hrThhU2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59680223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=augury.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbeKOWBF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Nov 2018 17:01:05 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43877 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbeKOWBF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Nov 2018 17:01:05 -0500
Received: by mail-ed1-f68.google.com with SMTP id f4so3749233edq.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Nov 2018 03:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=augury.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7FGBAskoCWNsaeOsiPleSn35zqdxlj38jE9raQT+5Os=;
        b=hrThhU2FjmAmB+gv33/Ju/eYpXDlgzzB+t58RhJ0K2/5v5GwogKhk9rc9yquhtIl7n
         Wc/zKDNyf/abs3JKxvnOSJUUd5ET+werIJ73bkwZOW7DLuAQwS8staECBfQrYAk8tYjn
         2kuKJnetrb71W2gkffpQ/FCE9gwy++Mh4t+5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7FGBAskoCWNsaeOsiPleSn35zqdxlj38jE9raQT+5Os=;
        b=NOP/11nx5igzRXxQA8cQSGW5/0mFpWQ5GTkqDusdli1A/geUzBFxzhqE0Bp0OanOck
         +Qqu+rpBa/28aRwy+9giVqhKq42Tkopt6mnrzwcyNQyN5d0vv7Z59TuHpRNXZ7JuEVSZ
         nGlig47Tdl+gR5GzgQXmHJ+zEi0wI3sbyk1973UOghoQJVgVEDRd7DrmUnHrNG47oNMp
         K99KK6/fHcd94TewXA4E7Xq2xAJGwcIFlAAJEHHSmHogs7/cRkr27+h130pku9e0HdvD
         EMbRkDdu6XY9CE1wGMquWPds/v3Q+mhOqfJGlqpNOSSvN6Go4e54veBdt1jRyizQrekm
         Y5Bw==
X-Gm-Message-State: AGRZ1gKxj0wHmbE/NHcR9JGhfsGoCgbw4xLnrIIPk8msBCh1syOW79Mw
        QXzlgCDI353F8+KESS6skGCRwA93/r+3ikt1XZ/oOMQEg+84X02QXUfPXv7eULOyXKG5ERwgBLP
        YgBmJgguqZgGrVBwKrfcGxt3ssdWcXcwVuoy4mbsPC4YjgZ8wVVWUJNRy4/M0GfGvMp3SfYo4mc
        rCQrA=
X-Google-Smtp-Source: AJdET5efHYxDCP6I0QJL8e1y/KGrJAPcl2j/+VJNbn7n7DbaKo3i+OOotQBFBuKEHILMN4uWV1dppA==
X-Received: by 2002:a17:906:16ca:: with SMTP id t10-v6mr5067682ejd.200.1542282811319;
        Thu, 15 Nov 2018 03:53:31 -0800 (PST)
Received: from localhost.localdomain ([213.57.91.122])
        by smtp.gmail.com with ESMTPSA id c11-v6sm2053663ejz.70.2018.11.15.03.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 03:53:30 -0800 (PST)
From:   Gal Ben-Haim <gbenhaim@augury.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Gal Ben-Haim <gbenhaim@augury.com>
Subject: [PATCH BlueZ] shared/io-mainloop: Try to write to the pipe only if there are readers
Date:   Thu, 15 Nov 2018 13:53:24 +0200
Message-Id: <20181115115324.10215-1-gbenhaim@augury.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

bluetoothd receives a SIGPIPE and terminates if writing to a pipe that
was acquired by AcquireNotify and there are no readers. it can be
reproduced by terminating the reader process without closing the reader
end of the pipe.

poll is used to check for a POLLRDHUP event before write and an EPIPE
error is returned if the peer closed its end of the pipe.
---
 src/shared/io-mainloop.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/shared/io-mainloop.c b/src/shared/io-mainloop.c
index 2306c3479..4a70449fc 100644
--- a/src/shared/io-mainloop.c
+++ b/src/shared/io-mainloop.c
@@ -27,6 +27,7 @@
 
 #include <unistd.h>
 #include <errno.h>
+#include <poll.h>
 #include <sys/socket.h>
 
 #include "src/shared/mainloop.h"
@@ -305,7 +306,14 @@ ssize_t io_send(struct io *io, const struct iovec *iov, int iovcnt)
 	if (!io || io->fd < 0)
 		return -ENOTCONN;
 
+	struct pollfd fds[1];
+	fds[0].fd = io->fd;
+	fds[0].events = POLLRDHUP;
 	do {
+		if (poll(fds, 1, 0) > 0 && fds[0].revents & POLLRDHUP > 0) {
+			return -EPIPE;
+		}
+
 		ret = writev(io->fd, iov, iovcnt);
 	} while (ret < 0 && errno == EINTR);
 
-- 
2.19.1


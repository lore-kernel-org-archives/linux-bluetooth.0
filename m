Return-Path: <SRS0=SE7D=N2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B18EC43441
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Nov 2018 08:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57B82089D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Nov 2018 08:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=augury.com header.i=@augury.com header.b="JD+V67sU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57B82089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=augury.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbeKOSpP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:45:15 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37632 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbeKOSpP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Nov 2018 13:45:15 -0500
Received: by mail-ed1-f66.google.com with SMTP id h15so11190502edb.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Nov 2018 00:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=augury.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GP1n/ABYcjlevNKeIFCvGWwG4yCknH2VDA5FhrqjwZ8=;
        b=JD+V67sURCoRU7cUvbegr8VcS33tyS9X0Vji5Zh9DRytOAWJFbsk1IY2mkX4bYnLP5
         q4XbxFye2XYZAfsN44WJWA/jEtENUpL9iySs70OhwsEASfc213wJALlMNV9w3TvK49js
         Z7Pgkpz35hoLpyvHguJF2QHqst8l5+pZPPzsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GP1n/ABYcjlevNKeIFCvGWwG4yCknH2VDA5FhrqjwZ8=;
        b=Z+sdeFQG/8ItGP6i3WUfJUkLN1O/oGBLJGpw+Lfp+PIfNjCnxAe94ILDvyeWUxMarU
         L+Z6x+bVqHal8vh0pcX+WOx7M8tRYIMqpyxfl5PJkiGsidI0MTjQR/Yc0Y52fzXzd5kq
         xN109S1g0FNjR4B29eIoTuCTvR9a2gl357u4YWovB1qbKF/mXxb6UvoD6L074OWU4qcJ
         frSW7v8REBFZnUA72jzws0BM9i0snam0YKihibmzcp2pWkTGXxeuXfYG1CC2QUSMYWrk
         5VDwsHKY9MqGb1jx9/KIHkj7elxpOD/qNBWM9VM9fN74J3LGfyFTQbzk8N5o+fHVNRFX
         NhKg==
X-Gm-Message-State: AGRZ1gLo+TXtaGRkTlg6l/fj0z/5oUtIV+yXp0hBw9FKFtXku3fEF7yT
        JAOGRfqvwdgnNLlptUOTVsqP0+5ya0I+FTIZqfWFJdhwpRdUwlRXH7gKX9IzU99YvUG8qoxfJdE
        mZdbQ8dowpfsNnBmMNzjdWBTqbR8Q5ffq0/ki3cKmNic8mKgehu3P38QOKlog83QqACk20fakmr
        1EJ6s=
X-Google-Smtp-Source: AJdET5cb0ln1dHfLQ+n71jshFqdq/seZa9svdF3tmt6SkL5KWlozFTokpKP3cSfMUYBec9g9bUzAhw==
X-Received: by 2002:a17:906:4dd5:: with SMTP id f21-v6mr4665680ejw.127.1542271101788;
        Thu, 15 Nov 2018 00:38:21 -0800 (PST)
Received: from localhost.localdomain ([213.57.91.122])
        by smtp.gmail.com with ESMTPSA id d27-v6sm942581eja.20.2018.11.15.00.38.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 00:38:21 -0800 (PST)
From:   Gal <gbenhaim@augury.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Gal <gbenhaim@augury.com>
Subject: [PATCH BlueZ] gatt: Ignore SIGPIPE
Date:   Thu, 15 Nov 2018 10:38:17 +0200
Message-Id: <20181115083817.20986-1-gbenhaim@augury.com>
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

Ignoring the SIGPIPE will cause the write operation to return a
"io_send: Broken pipe" error which will be logged.
---
 src/gatt-client.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 234f46ed7..236f38ad5 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1137,6 +1137,9 @@ static DBusMessage *characteristic_create_pipe(struct characteristic *chrc,
 	if (pipe2(pipefd, O_DIRECT | O_NONBLOCK | O_CLOEXEC) < 0)
 		return btd_error_failed(msg, strerror(errno));
 
+	/* Ignore SIGPIPE, a broken pipe error will be returned if the pipe has no readers */
+	signal(SIGPIPE, SIG_IGN);
+
 	dir = dbus_message_has_member(msg, "AcquireWrite");
 
 	io = io_new(pipefd[!dir]);
-- 
2.19.1


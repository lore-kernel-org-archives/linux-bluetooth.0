Return-Path: <SRS0=Z/iR=N3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680A9C43441
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Nov 2018 19:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16DC52087A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Nov 2018 19:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=augury.com header.i=@augury.com header.b="qNWC2EK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16DC52087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=augury.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbeKQF2i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Nov 2018 00:28:38 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53819 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725729AbeKQF2h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Nov 2018 00:28:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id f10-v6so23047828wme.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Nov 2018 11:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=augury.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5eO2sjIh+NTZFkj6UFvRs1KxnPlyQpZQtrRuOOyN6p0=;
        b=qNWC2EK1t0rtBuB8yEPZsEmn9c1J7IzkvxGp1gzUFc5DhnsqlfyQphmkP4kcC7GFbn
         lPL1zm/y40I/AbuJqlMV3S+BUdHWYwaSF9gUW8UkzmC0NEQYUN0ieGm72EGzsMcvaoz7
         +cWPDyYiCRHxmMQjrSC5rIolR1B1W/gkCMPMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5eO2sjIh+NTZFkj6UFvRs1KxnPlyQpZQtrRuOOyN6p0=;
        b=NxfbvASsGdopWa+VXYn6/cu5fwz0ZJrqAZL7H0EY2//lLCHLYG/jDL8Rrn6W5WW7E0
         FHCyyZJeYj/OcSgYTXcAFncGe5xo+7bWcJodX4FuHd1AK6qCrlGMo6G4OlJbYgD4c+2q
         H77DKs09Eu6VZnlW47vX63NnPw6RY0Pg8uKKa0Bmap0URrZTIHnS+kCL/ZhGCr7CgiS7
         SAH9VLsWan9TumN1OKS6vT59fscbDuJRG46qjqNhsUjJDKwiKtg1n/vMnBb+XTzDcVDt
         ZZcjI33X2CybD//7GtPzHI0HN3VbQykUe+F/E4tJRGeV63o7dK6u2fxJ7O6yJjaFHg/U
         pGWQ==
X-Gm-Message-State: AGRZ1gL7X4yeCWVyliTpB5wto0aLx6s5cDDCSTayTxtJ4IqzgrogV8ix
        Aw6+uvlI1Vd4St0VhVhDDZimpRWQIqnukYfB+PXMFjRfIUpdjMHnqyZSqVVMaiqHcVrlU002w8o
        6xD9F020yb8gR62hremGpQQRBDR2+Zaijhr1c2aWy1etqfyguR5MIaO/b7LKk/gIwsgSj4Msq83
        T8HbA=
X-Google-Smtp-Source: AJdET5f6PO0anwFLGD0lAeIPx2zucAIhBDYaJuAF9TMOZSOI3yBkKOx8razlz1Npxnl/6Zo8Rxx7Xg==
X-Received: by 2002:a1c:9f01:: with SMTP id i1-v6mr9560077wme.8.1542395697729;
        Fri, 16 Nov 2018 11:14:57 -0800 (PST)
Received: from localhost.localdomain (bzq-79-182-246-1.red.bezeqint.net. [79.182.246.1])
        by smtp.gmail.com with ESMTPSA id 64-v6sm26679102wml.22.2018.11.16.11.14.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 11:14:56 -0800 (PST)
From:   Gal Ben-Haim <gbenhaim@augury.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Gal Ben-Haim <gbenhaim@augury.com>
Subject: [PATCH BlueZ] core: Ignore SIGPIPE
Date:   Fri, 16 Nov 2018 21:14:52 +0200
Message-Id: <20181116191452.17377-1-gbenhaim@augury.com>
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

Ignoring the SIGPIPE will cause the write operation to return an
error which will be logged as "io_send: Broken pipe".
---
 src/main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/main.c b/src/main.c
index 4716f5388..c62886593 100644
--- a/src/main.c
+++ b/src/main.c
@@ -691,7 +691,7 @@ int main(int argc, char *argv[])
 	uint16_t sdp_mtu = 0;
 	uint32_t sdp_flags = 0;
 	int gdbus_flags = 0;
-	guint signal, watchdog;
+	guint signal_source, watchdog;
 	const char *watchdog_usec;
 
 	init_defaults();
@@ -721,7 +721,11 @@ int main(int argc, char *argv[])
 
 	event_loop = g_main_loop_new(NULL, FALSE);
 
-	signal = setup_signalfd();
+	signal_source = setup_signalfd();
+
+	/* Ignore SIGPIPE, a broken pipe error will be returned from write 
+	 * attempts to a pipe with no readers */
+	signal(SIGPIPE, SIG_IGN);
 
 	__btd_log_init(option_debug, option_detach);
 
@@ -809,7 +813,7 @@ int main(int argc, char *argv[])
 
 	sd_notify(0, "STATUS=Quitting");
 
-	g_source_remove(signal);
+	g_source_remove(signal_source);
 
 	plugin_cleanup();
 
-- 
2.19.1


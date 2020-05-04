Return-Path: <SRS0=pLxO=6S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17858C3A5A9
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 May 2020 14:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1E38206D7
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 May 2020 14:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aAYwjdc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgEDO0a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 May 2020 10:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbgEDO0a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 May 2020 10:26:30 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1442AC061A0E
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2020 07:26:30 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id u12so6597465uau.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 May 2020 07:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OlsM6ooGBGjUeZHb1JOTfCPgeWFWdM4O9v+xvw3wiZc=;
        b=aAYwjdc1pQBbBSKSmEt05CR/Z0an0tYIaUSd3LszZyIfGn22HSQOjEl2aV9ds4icc/
         eraUGc6SKBWAH2VwUOf7xeUTLa3fIIjoP9dOsDqGLtILhOIO7rnQLAnu0rbXOMtV2upp
         mYGT8o+Elp4ELQrzRR47n3eg+QK4cZ0A31S+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OlsM6ooGBGjUeZHb1JOTfCPgeWFWdM4O9v+xvw3wiZc=;
        b=dDQdJPMr3XNahr7s868KGslKJAACE6XoSR38uD/uhoocxy9R2gO/wu1vF2nM0agH3o
         neGlLv+XV0zfSW3CQtsahd/9qLfOGRujFnbCsMefthXC80FGLk70VMumrNkNm8RaZ1XM
         IL3WXCG0xAgnE+zZfa/zfnpQmsZcAtxSKeSwLffavYY7Hwhn/sS6RCmPmV/lZCGWve9o
         Yd/fwr4zDL530sQA3KjCRg2r3JvD16qHtcCJ8vejRzXWz+4MGaZRNTeUMpZQB230jsVp
         FLIBB7oRcEdVYY3mpZgjP3MEfWtTyppH7sy4hPfMEi1fpxEh9pZAQIUMeu/GsHv/Pwkk
         KhkA==
X-Gm-Message-State: AGi0Pub1mo9KrPoaeHAFWiF+lg5vQuHVNZ4syA1N+LqL9aBybRQVTW0q
        gGYylC7Y6IRZxbBabqtitcMSoZKuYS8=
X-Google-Smtp-Source: APiQypIdHZVZMVcooJKzjA9z77/vpzKt2zVy5bH+QqOsQhLwUHUoaYlxv+Ue1ifiwwGH0/KCr3Dovg==
X-Received: by 2002:ab0:298f:: with SMTP id u15mr1224103uap.138.1588602388849;
        Mon, 04 May 2020 07:26:28 -0700 (PDT)
Received: from alain.c.googlers.com.com (161.138.243.35.bc.googleusercontent.com. [35.243.138.161])
        by smtp.gmail.com with ESMTPSA id x24sm4688316vsq.15.2020.05.04.07.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 07:26:28 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH v1] doc:adding definitions for load default params mgmt op
Date:   Mon,  4 May 2020 14:26:25 +0000
Message-Id: <20200504142625.213143-1-alainm@chromium.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change adds the definition for the load default parameter command.
In particular, this command is used to load default parameters for
various operations in the kernel. This mechanism is also expandable to
future knobs that may be necessary.

This will allow bluetoothd to load parameters from a conf file that may
be customized for the specific requirements of each platforms.

---

 doc/mgmt-api.txt | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 39f23c456..71d528706 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3137,6 +3137,65 @@ Read Security Information Command
 	Possible errors:	Invalid Parameters
 				Invalid Index
 
+Load Default Parameter Command
+=============================
+
+	Command Code:		0x0049
+	Controller Index:	<controller id>
+	Command Parameters:	Parameter_Count (2 Octets)
+				Parameter1 {
+					Parameter_Type (2 Octet)
+					Value_Length (1 Octet)
+					Value (0-255 Octets)
+				}
+				Parameter2 { }
+				...
+	Return Parameters:
+
+	This command is used to feed the kernel a list of default parameters.
+
+	Currently defined Parameter_Type values are:
+
+			0x0000	BR/EDR Page Scan Type
+			0x0001	BR/EDR Page Scan Interval
+			0x0002	BR/EDR Page Scan Window
+			0x0003	BR/EDR Inquiry Scan Type
+			0x0004	BR/EDR Inquiry Scan Interval
+			0x0005	BR/EDR Inquiry Scan Window
+			0x0006	BR/EDR Link Supervision Timeout
+			0x0007	BR/EDR Page Timeout
+			0x0008	BR/EDR Min Sniff Interval
+			0x0009	BR/EDR Max Sniff Interval
+			0x0080	LE Advertisement Min Interval
+			0x0081	LE Advertisement Max Interval
+			0x0082	LE Multi Advertisement Rotation Interval
+			0x0083	LE Scanning Interval for auto connect
+			0x0084	LE Scanning Window for auto connect
+			0x0085	LE Scanning Interval for HID only
+			0x0086	LE Scanning Window for HID only
+			0x0087	LE Scanning Interval for wake scenarios
+			0x0088	LE Scanning Window for wake scenarios
+			0x0089	LE Scanning Interval for discovery
+			0x008a	LE Scanning Window for discovery
+			0x008b	LE Scanning Interval for adv monitoring
+			0x008c	LE Scanning Window for adv monitoring
+			0x008d	LE Scanning Interval for connect
+			0x008e	LE Scanning Window for connect
+			0x008f	LE Min Connection Interval
+			0x0090	LE Max Connection Interval
+			0x0091	LE Connection Connection Latency
+			0x0092	LE Connection Supervision Timeout
+
+	This command can be used any time, but will not take effect until the
+	next activity requiring the parameters.  In the case the parameters are
+	used during initialization of the adapter, it is expected that the
+	parameters be set before the adapter is powered.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+	Possible errors:	Invalid Parameters
+				Invalid Index
 
 Command Complete Event
 ======================
-- 
2.26.2.526.g744177e7f7-goog


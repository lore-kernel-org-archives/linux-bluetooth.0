Return-Path: <SRS0=TohX=3J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D76EC32771
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Jan 2020 20:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B88217F4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Jan 2020 20:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AhUwJ6QL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgATU1V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Jan 2020 15:27:21 -0500
Received: from mail-vs1-f53.google.com ([209.85.217.53]:32782 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgATU1V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Jan 2020 15:27:21 -0500
Received: by mail-vs1-f53.google.com with SMTP id n27so385081vsa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jan 2020 12:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o9zdJ1Y4kcP1Ijp/RMF/JHrUzcD2Y95mk1j7rH7aLRw=;
        b=AhUwJ6QLuWQ2HeQVCgYupY8w+qiCcmmSTpXmduTcV32JS0ldhDRswI2hqRdPTkax69
         HvnrP0sX+GCrabgUQkb6VFGtGIxMIVccNvk0ySUpLrCRrOP9DF8gtu0TbrxSp4GXUJ6g
         VB9r4Qn4dv8Eex12zINJR9JGOfeKSiud0WqZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o9zdJ1Y4kcP1Ijp/RMF/JHrUzcD2Y95mk1j7rH7aLRw=;
        b=HMIUsKEZDQLgcJ33W2BpL4Bi5I0ErtRbJY4A1OBzYod8GVlH58K5PHg9fO1sqXJjSC
         2OX5aunMJjofM5i6zw16ax2F0scLUkZh7i8wcWQR2bgjh3yeh47mCxRfnEN+/dc78cPz
         uG2D98/kVU7UWniR5mImcoeFYsMS880WI+bb5uq3qk+5UdDInrw4fKtNfcSXV39uo8xb
         0f/6jKtAMG2asIXZ5/gb4p1o/kHDlCm70TUVRFuZkqb33z6Aja20PneRl12ODJn9VSyo
         7s9S/szX6qs8/HgmIaU3HZ7Bq4E0bor6NXjeRNEkJpx747YmRkXf/wWQiQsCM62SXd73
         mTxw==
X-Gm-Message-State: APjAAAVVz8wrTj0hdDldC6VIVwMBcJh0u/Fg1OmoAfvojoRIabWM7fF5
        3ijOPGOdSqo4ZiCNqR7qC7g7LLs0qwM=
X-Google-Smtp-Source: APXvYqy6I12z6HxsU3Zqo7NYzy/IefEtRaLqke+vZybAqPBHQtixrLtXLlRPtC56AAU4tEUnM6kyoA==
X-Received: by 2002:a67:fe50:: with SMTP id m16mr628840vsr.114.1579552039905;
        Mon, 20 Jan 2020 12:27:19 -0800 (PST)
Received: from alain.c.googlers.com.com (69.104.231.35.bc.googleusercontent.com. [35.231.104.69])
        by smtp.gmail.com with ESMTPSA id i20sm10146645vkn.51.2020.01.20.12.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 12:27:19 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [Bluez PATCH] doc: Add definition for Set Kernel Debug Level
Date:   Mon, 20 Jan 2020 20:27:08 +0000
Message-Id: <20200120202708.111383-1-alainm@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This command is used to by higher level applications to dynamically
control the debug logging level of the kernel module.  This is
particularly useful to collect debug information from customers filing
feedback reports for issues that are difficult to reproduce outside of a
customer's particular environement.

---

 doc/mgmt-api.txt | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 1e59acc54..f2dba64d1 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3047,6 +3047,31 @@ Load Blocked Keys Command
 	Possible errors:	Invalid Parameters
 				Invalid Index
 
+Set Kernel Debug Logging Level Command
+=======================
+
+	Command Code:		0x0047
+	Controller Index: <controller id>
+	Command Parameters : Debug_Logging_Level (1 octet)
+
+	This command is used to set the kernel debug logging level. This
+	can be by higher level applications to facilitate dynamically
+	controlling	the logging level produced by the Bluez kernel module.
+
+	Supported Debug_Logging_Level values:
+		0 : No Logging
+		1 : All debug information.
+		All other values are reserved for future use.
+
+	When the kernel receives a value higher than the maximum supported
+	value, the kernel module shall set it's logging level to the highest
+	value it supports.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+	Possible errors:	Invalid Parameters
+				Invalid Index
 
 Command Complete Event
 ======================
-- 
2.25.0.341.g760bfbb309-goog


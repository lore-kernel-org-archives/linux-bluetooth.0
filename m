Return-Path: <SRS0=PvgB=3K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12525C33CAF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jan 2020 23:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD88A24655
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jan 2020 23:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e5nz2+Ve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgAUX1I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jan 2020 18:27:08 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:35294 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgAUX1I (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jan 2020 18:27:08 -0500
Received: by mail-pg1-f172.google.com with SMTP id l24so2373686pgk.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2020 15:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XDXJBvUeOgV88OWGa2XPbQbbGEVCn6SWMUGnOE5Vb6A=;
        b=e5nz2+Ve0TcVCotp/I8zldnTPDkGbJ51XM0BwnjjZ1MBMLU0GdB571GAhEa9qXKzL9
         EJbEl9cNde0enUgUTuzzmaS+yanv7F+8d+L78ZNNkBd8ZxrSRTgPXlnAFE6gpx14rAuZ
         qTJIpPC0MH78+qyC4ecOIyKarlB26sorxLrW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XDXJBvUeOgV88OWGa2XPbQbbGEVCn6SWMUGnOE5Vb6A=;
        b=JzFtvYJ1wHjsxu7WXMUwg25nMUjZihR7y1JW5McSTQt/zE3yH5t1dj+mwam1Wa7mvT
         b9jMpfYOQgRdMe/yxev3MvQqxBlF6wxGAFvfW6Rpo30Gwe7ovShiB8BF8wh2PvbytF3D
         ZzXhlT9IMPyPZsCSzKqC22b4XQjsXSM3jaHX8r1Lp4g5VfnbWR7f5K6MO7AWaeU/DN+E
         uxL81JvgZjwyBfTEezfEfdg84DCjxh3F/J4U9Mg8CGvJhcslh3mvs3Qq93sbH8eQYzSq
         ZGiWz2ZcHFbqc96hNm9BNHnunfK8Bumt7bwVHbBETguTKJUrLUZBBO1tN7U9z9lPsW9P
         erYg==
X-Gm-Message-State: APjAAAVsTgQtD+Yf5Ikg4oXtdKPU7NcZpYyBLsCIf1M0yJgNLWnWB14x
        MPK+yr9tklcwKjw4BBtIxntpLQ==
X-Google-Smtp-Source: APXvYqwA3fKNDfLbDkbxvT8eLuvMdwAhW2Kd0FnPUC+4rV24XEpGHYBW0lBlNknftde3LxWmFCHH2Q==
X-Received: by 2002:a63:7045:: with SMTP id a5mr8271460pgn.49.1579649227766;
        Tue, 21 Jan 2020 15:27:07 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id l8sm498320pjy.24.2020.01.21.15.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 15:27:07 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, marcel@holtmann.org, alainm@chromium.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v2 1/3] mgmt: Add docs for Set Wake Capable
Date:   Tue, 21 Jan 2020 15:26:58 -0800
Message-Id: <20200121152640.BlueZ.v2.1.I999b93b65e613324dbbd16a1cf493be72fa06ad1@changeid>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200121232700.158933-1-abhishekpandit@chromium.org>
References: <20200121232700.158933-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add docs for new management operation to mark a device as wake capable.

---

Changes in v2:
* Separated docs/mgmt-api.txt into its own patch

 doc/mgmt-api.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 1e59acc54..8a73a9bb9 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3047,6 +3047,25 @@ Load Blocked Keys Command
 	Possible errors:	Invalid Parameters
 				Invalid Index
 
+Set Wake Capable Command
+===========================
+
+	Command Code:		0x0047
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Wake Capable (1 Octet)
+	Return Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Wake Capable (1 Octet)
+
+	This command sets whether a bluetooth device is capable of waking the
+	system from suspend. This property is used to set the event filter and
+	LE whitelist when the system enters suspend.
+
+	Possible errors:	Failed
+				Invalid Parameters
+				Invalid Index
 
 Command Complete Event
 ======================
-- 
2.25.0.341.g760bfbb309-goog


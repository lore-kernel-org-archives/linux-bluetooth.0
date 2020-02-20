Return-Path: <SRS0=cA0y=4I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4789C7619D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Feb 2020 00:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CB82465D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Feb 2020 00:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCMZ6EHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgBTA21 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Feb 2020 19:28:27 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:46832 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbgBTA20 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Feb 2020 19:28:26 -0500
Received: by mail-pg1-f171.google.com with SMTP id y30so956936pga.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2020 16:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yIpwUuffQHTqZM/RXQAXvfjnVggdrcZ7xnQhEPrhbJY=;
        b=XCMZ6EHOBP1V5HtpXht2p8wpObX0Q//V7TQXpHAnQROvfrIWnFMj/3lDgQoBpQ1eaI
         aVZRVYIC1qYO0ah67SqeFUJTEWyJMGWfs2SVg9iuyyulb1GIgQmiOQj+kEXg9hFByb/H
         VOy9fGzGa+dr3N/D6vUSZTcg/MmpXV7KqPFB80fjoF9wCWjA31AGvXWpSPTA8oprg7L/
         vI4PD5SV1v5KGPN1FutI4VgUGQzrVv9XZ3EIoiRK+MXTDOOrLiuqojMflaeYaYG+kCVH
         7ykEQhd6zijl4KUo6/5HM3hZ5tV/iXPuI+kRxDShVeBIp0jHLHeLfPaA32cebwjS1liq
         8Baw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yIpwUuffQHTqZM/RXQAXvfjnVggdrcZ7xnQhEPrhbJY=;
        b=eQEUcU9Ut2khAYeBJ/wbMlPazeW9Mrf7DWhwZlDyDtjRMfEvykyKM3fqIwlr2LOYLc
         rZb8vT5PTjfLXlo8PRaOITt9dOw16IScHphAxFV1wKohMU/TuechgY9ASIYHHdHWbKS6
         C3RVcQtCMLq8O3P1+pz2T2yCz3EO7AhiWpJnUxjijQ6pgO+GnVAp1lZwuTExsWcE/zXZ
         HdH/lYxaPJacAhhhVssdrJsGB2CQxqWXSyZXqP+HmEcr2d1Iso8l7jtQ2gHvohH0Phyb
         sadIOnvTEcCYR6Y62goyyKFgfSuUHk7UyuWD9j8+nBeBb4mWfgQKAsajnNTJ8zj9mwSA
         +rhQ==
X-Gm-Message-State: APjAAAW7EeCars1ouwErdp6PIdPk9FrRivAbURdK4YuNUN645/pCgVnq
        hONPd4UX3UMkhBMgj1jgHQCyC0HbJI4=
X-Google-Smtp-Source: APXvYqwReJ7+gkvQEcQmbneHtrbseH5zFvOEl67+Xx3sTxV10fsXb2kNtWFLSLMFP9RtnVjUDlEa4Q==
X-Received: by 2002:a63:3e05:: with SMTP id l5mr30428309pga.293.1582158505632;
        Wed, 19 Feb 2020 16:28:25 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id t11sm908557pjo.21.2020.02.19.16.28.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 16:28:25 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] doc/adapter-api: Add pattern filter
Date:   Wed, 19 Feb 2020 16:28:15 -0800
Message-Id: <20200220002824.8819-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a pattern filter which can be used to filter devices by
address or name prefix which is quite convenient on a crowded
environment.
---
 doc/adapter-api.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 2afd61bc3..acae032d9 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -119,6 +119,21 @@ Methods		void StartDiscovery()
 				if the adapter is already discoverable setting
 				this filter won't do anything.
 
+			string Pattern (Default: none)
+
+				Discover devices where the pattern matches
+				either the prefix of the address or
+				device name which is convenient way to limited
+				the number of device objects created during a
+				discovery.
+
+				When set disregards device discoverable flags.
+
+				Note: The pattern matching is ignored if there
+				are other client that don't set any pattern as
+				it work as a logical OR, also setting empty
+				string "" pattern will match any device found.
+
 			When discovery filter is set, Device objects will be
 			created as new devices with matching criteria are
 			discovered regardless of they are connectable or
-- 
2.21.1


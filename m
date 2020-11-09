Return-Path: <SRS0=/O/j=EP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47575C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 10:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBC33208FE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 10:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=heine.tech header.i=@heine.tech header.b="M6NZNwB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgKIK7l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Nov 2020 05:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgKIK7l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Nov 2020 05:59:41 -0500
X-Greylist: delayed 472 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Nov 2020 02:59:41 PST
Received: from mail.heine.tech (mail.heine.tech [IPv6:2a01:4f8:1c0c:5073::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CCBC0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2020 02:59:41 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CFC51182440;
        Mon,  9 Nov 2020 11:51:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heine.tech; s=dkim;
        t=1604919106; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=G2ux3i4RsgV35ymDMqz3u5foApzKgO/oHigfN/7eePI=;
        b=M6NZNwB1UWoVRgdTUOL99NTgsVEJG2xSWrDBr4E7r0c948cGKTZO0FQHlt9rEkoM1B5ixS
        sRjupxZm4W/uR3yTPMCmhv9KtYnw7tBxWJRxxU/oTWJr5g5LWsnk4e6glT7pywCxk3PPeT
        As41Aa8TM5inT2QnEvc4CxIc2Ifjx6g=
From:   Michael Nosthoff <bluez@heine.tech>
To:     linux-bluetooth@vger.kernel.org
Cc:     Michael Nosthoff <bluez@heine.tech>
Subject: [PATCH] doc/adapter-api: Add InProgess error to StartDiscovery
Date:   Mon,  9 Nov 2020 11:51:14 +0100
Message-Id: <20201109105114.27827-1-bluez@heine.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Signed-off-by: Michael Nosthoff <bluez@heine.tech>
---
 doc/adapter-api.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 1a7255750..464434a81 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -23,6 +23,7 @@ Methods		void StartDiscovery()
 
 			Possible errors: org.bluez.Error.NotReady
 					 org.bluez.Error.Failed
+					 org.bluez.Error.InProgress
 
 		void StopDiscovery()
 
-- 
2.25.1


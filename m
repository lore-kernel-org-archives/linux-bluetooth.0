Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC5CC433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 06:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20F0B2075E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 06:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CX0npRCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgHUGRB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 02:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgHUGRA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 02:17:00 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A5DC061385
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2020 23:17:00 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id j13so376121pjd.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2020 23:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=51rft0zd8lDE1RWSK7jDf9MZdT3wh7FXXkl7Ry3F10c=;
        b=CX0npRCU0PzecA4Px8UGqAWigN7MjREnLUFvogq/WcKTMyiSlyl9lr6y2H+thLXBMG
         wph736DPh8WGMxApMAfr6O5BSycP2LvkohTsL0as4yaxHjsRXSywatD8KOvcuTJg2TEj
         xNAL9b2JP2Kg7tAMngUimS11N2OR8tFlHsbX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=51rft0zd8lDE1RWSK7jDf9MZdT3wh7FXXkl7Ry3F10c=;
        b=RcWQbV4vG56MieykIrXT3CFccts2SYCTdjrT7a1LqzuxL5QgzSrVVZG8u43jaegBSM
         gtPalSQgJBoEXHC53lNFapTwWKU3z6uGNoH+QCfRsKX5BOV1bqkbISA+6pI8UrcZf49v
         VjGs/5/tNfQPY1xVjMv1mUu+9a3KYj85Aq7YyR0c2lz1A0GK5XCD2AkYxFFFGtKbQcOg
         wv7B9AzNyEWVVqSkOKUM9qIKMB7x0SYTEe6vzRGf/28Y8EatVTHz2zipN3bC1txa1m8L
         ON+IdwDkrWjAIYQoiXLxKNpI6JjupXsuT/P0t4bhhUcZtJ905b7vMi9OlQi+7jy6732a
         WXCg==
X-Gm-Message-State: AOAM532JPEYruXjiHXXdxleoHogxCAtphD7QgNCI4S8ZOghhFwBzipXg
        Sho8PRhlgjTED8kQLSwxzjn5uwFtaViw3g==
X-Google-Smtp-Source: ABdhPJwLOE3yFWfFPUGWgU8bWD3qlm2BVz3nriWt7I4JaOe7U1pwhJXt0YxCRKB6u3nJlCdVpuRQSg==
X-Received: by 2002:a17:902:7616:: with SMTP id k22mr1220002pll.25.1597990619465;
        Thu, 20 Aug 2020 23:16:59 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id h1sm927356pgs.77.2020.08.20.23.16.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 23:16:58 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Joseph Hwang <josephsih@chromium.org>
Subject: [PATCH BlueZ 2/2] doc/gatt-api: Add new error for StartNotify
Date:   Thu, 20 Aug 2020 23:16:43 -0700
Message-Id: <20200821061643.16278-2-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821061643.16278-1-sonnysasaka@chromium.org>
References: <20200821061643.16278-1-sonnysasaka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Joseph Hwang <josephsih@chromium.org>

When a device is disconnecting, StartNotify is not allowed. This adds a
new error type to the doc.

---
 doc/gatt-api.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 98fe7487c..04789c6d3 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -186,6 +186,7 @@ Methods		array{byte} ReadValue(dict options)
 			Possible Errors: org.bluez.Error.Failed
 					 org.bluez.Error.NotPermitted
 					 org.bluez.Error.InProgress
+					 org.bluez.Error.NotConnected
 					 org.bluez.Error.NotSupported
 
 		void StopNotify()
-- 
2.26.2


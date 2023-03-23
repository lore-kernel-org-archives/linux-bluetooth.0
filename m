Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D2AC76195
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 10:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjCWKcj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 06:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCWKcK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 06:32:10 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4B61C33D
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:29:03 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x3so84234603edb.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1679567342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTSY9/BynlPk9okaQr3cojHCjORIEnPdMAyqjbbvnLc=;
        b=fkSCbJva1GaZJmiNgJ0kvCGAv6wE/Wg1lnoSWvOJ80W3xefSas8xemgAzpdorMc18z
         C5HcXZH1SOW7W4cbOZcj1fPAIkJ/e/FVkew4QARI6ReWKW0cq3jg62yFmSq/78qHjmY1
         WSrpggz0UZE+nEptQHAzjx5jvhcRlTDtuNm3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679567342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTSY9/BynlPk9okaQr3cojHCjORIEnPdMAyqjbbvnLc=;
        b=WJRMNMsZ0tIDy1aXYkukBsz5GKp2NwL3G0GEulyugKQXxpnkKhtFNhtwYlliZnntqE
         u3xzqjkqnPgKAHRc1+lefdI8AV6Z1BeJNUajeSA1CqacPiwGwB3pihgL8gXNa+ard/BE
         xhorKdb/XD99eJ6DrtNnqJZlPuS6ukMEX2PuVDT6gzkjG2dNBFFh/pd1DdwkJN65agOU
         +FOn9TmA771Ar9HGhaN6TGgqCVgLpZvXQvcael6/eGF0JIkhGywJNINYdd9LBXqivxc4
         pUpd4QYdLYyDskC7VH1ubNlwJLtRQ++E0z5N82iVL9FUBKQIGzrJsT11vZWxXnkKKVqf
         ebeA==
X-Gm-Message-State: AO0yUKX1RynhuCygKwY7vPFGjcxo8GDEMiLoTeGl4dSeuplVoCJLeZS9
        MdVktjf88oLAxQITTExKUsBQWOdRhBzGhqGbuWo=
X-Google-Smtp-Source: AK7set8WymEerOf731K331yxh8MFe5uGd66viSn8vn3aeFXRM5D8mkqCta2U+eyRhT2SiyKo5OKL2w==
X-Received: by 2002:a17:906:ce23:b0:932:7f5c:4bb2 with SMTP id sd3-20020a170906ce2300b009327f5c4bb2mr10019155ejb.75.1679567341835;
        Thu, 23 Mar 2023 03:29:01 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:4f8c:7da4:48b2:8bd2])
        by smtp.gmail.com with ESMTPSA id s9-20020a170906454900b008f89953b761sm8459883ejq.3.2023.03.23.03.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:29:01 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 1/2] monitor: Fix crash when there is no write handler
Date:   Thu, 23 Mar 2023 11:28:57 +0100
Message-Id: <20230323102858.566934-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323102858.566934-1-simon.mikuda@streamunlimited.com>
References: <20230323102858.566934-1-simon.mikuda@streamunlimited.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 monitor/att.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/att.c b/monitor/att.c
index f9643b333..d3b82074f 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -2946,7 +2946,7 @@ static void print_write(const struct l2cap_frame *frame, uint16_t handle,
 		return;
 
 	handler = get_handler(attr);
-	if (!handler)
+	if (!handler || !handler->write)
 		return;
 
 	handler->write(frame);
-- 
2.34.1


Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DA3C761A6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Mar 2023 05:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjC1F1Z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Mar 2023 01:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjC1F1Z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Mar 2023 01:27:25 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F0C2133
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 22:27:24 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id i5so45032546eda.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 22:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1679981242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uccXy0FVhXokbSmWaaWl3qVSplN7fpEDxMT/b3r3wz8=;
        b=tVrt3PfBYFPTJ9exEeNKRNFkTneLBjZlkgssSQIPmuKkKxhUMx1A2C6q6w+Mq2XT0l
         Nl/+byz85I93hFuD3pK6eOLTVDnvnYrJCNrcNtuHoszkcXM0GvhECGwVrNQ/tJP7wuAH
         m2jixj7t3Ndp3QPpdF/JWO7ptqx0ZW7J8Ko88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679981242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uccXy0FVhXokbSmWaaWl3qVSplN7fpEDxMT/b3r3wz8=;
        b=InYVhdcnEZaqt+Z2Lc92pc54VZdEZ4gtjSLAU49aWl3V0u7Rp53YNHNvlI9oU0/XkQ
         aZCFe/XwGeD/CixUQzRsRt+71lCpvDIQjtM0RRTGFksW8oIsQ0c96cM5DTabHAT9NFBo
         tIUm1jUI/AIuYvjsn5tJTATD3w5jiI5NWt8OBiuboGJv9qIYgtH9mXGYwZ2EggjuZ5Gy
         bW1ahUts7IPYeto14OORSEDeKlp4ht2J8nAaa1zVoivHdqlq0z3cHmBvIboB91rfw3pS
         L1NevOSBK30V05y7Jgb0pZHX+ZieqSvK+vUj7dShO8fxLHKjHXwph8iqOHhnIGBJWD4J
         jmJw==
X-Gm-Message-State: AAQBX9d4wmZw417e2sah2wcyJGOTTBofigWEhRmpn6KhevoxqLq4AAJs
        6jdXgq8SAHQnuv+XjmuaQ/2ZvD0pmn2BYFGLnig=
X-Google-Smtp-Source: AKy350YWmvcmmzUpcxf56WhtXKdMc96ku0w5LE70WquGKBJy1YDmpBDqp4Ug+v2zbf/o3GWY4ZvVuA==
X-Received: by 2002:a17:906:48cb:b0:932:c50e:d6b4 with SMTP id d11-20020a17090648cb00b00932c50ed6b4mr14633050ejt.9.1679981242295;
        Mon, 27 Mar 2023 22:27:22 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:1167:5b7f:c0f0:e6ec])
        by smtp.gmail.com with ESMTPSA id b44-20020a509f2f000000b004c09527d62dsm15427109edf.30.2023.03.27.22.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 22:27:22 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 1/2] l2test: Enable hex input for PSM
Date:   Tue, 28 Mar 2023 07:26:18 +0200
Message-Id: <20230328052619.1357253-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230328052619.1357253-1-simon.mikuda@streamunlimited.com>
References: <CABBYNZLyQkvU1uzV8WF9n54FC43OvFzNne6XJcAUj2yCB8dVbw@mail.gmail.com>
 <20230328052619.1357253-1-simon.mikuda@streamunlimited.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 tools/l2test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/l2test.c b/tools/l2test.c
index 5aae4b687..232247b78 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -1416,7 +1416,7 @@ int main(int argc, char *argv[])
 			break;
 
 		case 'P':
-			psm = atoi(optarg);
+			psm = strtoul(optarg, NULL, 0);
 			break;
 
 		case 'I':
-- 
2.34.1


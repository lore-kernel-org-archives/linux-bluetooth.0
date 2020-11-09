Return-Path: <SRS0=/O/j=EP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BD2C388F7
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 11:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89DE6206ED
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 11:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRiQ1VsW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgKILYa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Nov 2020 06:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729756AbgKILYa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Nov 2020 06:24:30 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02EBC0613D3
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2020 03:24:29 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id g7so7916071ilr.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2020 03:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=xJ4YlAWluQ86dmbeFAo2/SLQDzgTt6SeaqqgNovwGCg=;
        b=gRiQ1VsWrU0oCR2tzzkai6FlAt8mPE9VCufKBrJ8tYjiJSbwghSmW+dL0783zxVy56
         HEsKK3Q+ifoTXxqRj6WljqPueyY5NJwmz3Hj5F2tp8ZkzmGucRc/BX3VZVLxaRsSHW9e
         QH1ikyIFSGJuZV3iGubuJDqPTNR5ksvQwdwqp9mgqEtjVquM19OrP0NTl9tHLlgTCpCx
         NTK1ADJAMQelM0hUr19asbuhK0pdd6ZOm6zUKjCWN1OSK2U5TWd05HradzCdayEe7p5x
         BLMxmPK+ohlHcm9hxeSWMJz2kh1r8nFUtTKiZYwghXcu6qVmtuj35TdePuqCN/dB5TU0
         Metw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=xJ4YlAWluQ86dmbeFAo2/SLQDzgTt6SeaqqgNovwGCg=;
        b=mkbTJZBi7FKOK3+eW3KwMg+72HJCkQTIfI40Big7CHdpvMt4iBFr/PIDHZEOisQ8pP
         YXGCC29HZiokepEEitqBuoYMBe4jFgWVJePtKGdbmRc5mgJmRTm5miVFwAR/nYjxbT2F
         XcDRU7GiDt8/fB0OGIynLfMMY7c1sfdCk80QxR4z/nixtq9M026sRwhWolGmld//7Hy6
         wMKz/9YxEZh0C7S6jqLSv7CLy0nNr+FM961tcRq7wlqVHhV8GPj3w5r8WaFiS7jNG4m0
         9sreVWFlgW8424d8zUi24Cdg3jGRWjJuOIK6rubUXIe06njOFxeJXoU3VcTgkSliivcN
         rBTg==
X-Gm-Message-State: AOAM532f07UektWfT+ClzF3HBAKMTZ4H/9qh/9K7/o1rz1Rmg1jkHYsD
        hMuvoRCGrqW3i0yUIk20jGqTwFQYrMU=
X-Google-Smtp-Source: ABdhPJxizgtUj8sEk3s7+pc6SYyGS56Uk7GzLSDQNugmBs0nNWlpdrwCbRvygXZFueShWuLjGPoXVg==
X-Received: by 2002:a92:b741:: with SMTP id c1mr9377147ilm.44.1604921069193;
        Mon, 09 Nov 2020 03:24:29 -0800 (PST)
Received: from [172.17.0.2] ([40.123.50.228])
        by smtp.gmail.com with ESMTPSA id t15sm5842733ili.64.2020.11.09.03.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 03:24:28 -0800 (PST)
Message-ID: <5fa926ec.1c69fb81.134d8.4ef1@mx.google.com>
Date:   Mon, 09 Nov 2020 03:24:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5443019563579417908=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bluez@heine.tech
Subject: RE: doc/adapter-api: Add InProgess error to StartDiscovery
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201109105114.27827-1-bluez@heine.tech>
References: <20201109105114.27827-1-bluez@heine.tech>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5443019563579417908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=380245

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============5443019563579417908==--

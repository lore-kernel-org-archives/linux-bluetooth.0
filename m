Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD891C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 19:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FE6A20857
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 19:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="twmKEcI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404058AbgKXTEy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Nov 2020 14:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390880AbgKXTEy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Nov 2020 14:04:54 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189B2C0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 11:04:54 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id b144so7522344qkc.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 11:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=CytuxqTV7c9H0mKCVt2fD7EAZ4yUXjv6HF8BNx+NaEc=;
        b=twmKEcI6Z9H/jPmNp4bFP/FZvwaQ4lkF9I89k1A2SiJn9ZVh829T3R2fKQNlMq4WJd
         TDRHbL+6M3RiCQQuvzeptb9XT4jdqi7iulhiQ6d8VrDhjpywn6+53RbUl01DhJmJt2fy
         PxbLVJsAJXkFeZAQE4CsoX6v00MYGpesCZdxjp5mdQL+/d2JAeQGP9SKL8HdKyof9aAP
         yro0XKBXqu4xWUL0Zq3IGc8has52LmY9979GqcGRRI59l52E18HpObA9ZgZAxarrLBKi
         80XzlcTotevbboC9fHK9Af4Kn2I8u+Dl12TrC8XmURufbHyFblRQSRwd6+BJGkFbRHD6
         Nf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=CytuxqTV7c9H0mKCVt2fD7EAZ4yUXjv6HF8BNx+NaEc=;
        b=rTL8kZNdsrL1FJZvdzFNZ4ASC51WrNJ6Sst2TKgmB/78LlYUG4+raedwXwi+cpaViD
         B+g6nGYJ8ACKFgQpvTX7UbCvfK58noE2kWrVNeBj0SAzT5dH27T+vnFWHr/AOmXuDKpR
         6j1creR9I0ODNQZzsK/EilB2PMPBH+Kl6umDo7a9IHtencZMwnz/zeE4nwgERdozE8/2
         fj5tZK1+nakCkAimJratOOqPkPV0sgmAPtjjNmqwWBSZeEjiFrd45Zkxp3+wsXZB8TjA
         Vod8XDoD0zJnkfbV9Xsf4H6O6DkwUbLJjyUXCWui4HEnPRix0PvVlIoa4Vezp7ptr1D2
         uryg==
X-Gm-Message-State: AOAM533Pc3TF0DkTbc7lZZr28nvF5tulxVUBs2oQ0O3ZHEFHiqatgfH8
        E+cuHowrQBKRRIsPd/ape3cySxEuJ1/8Qw==
X-Google-Smtp-Source: ABdhPJx3nzmpHtncPuf0PCkWFbXSjiI3uO1HhBx2UiPqS511a6qFYwu98SMROZZRGZEbtDE2sdA8KQ==
X-Received: by 2002:a05:620a:62b:: with SMTP id 11mr6548081qkv.229.1606244693089;
        Tue, 24 Nov 2020 11:04:53 -0800 (PST)
Received: from [172.17.0.2] ([20.36.179.225])
        by smtp.gmail.com with ESMTPSA id v15sm6015175qti.92.2020.11.24.11.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:04:52 -0800 (PST)
Message-ID: <5fbd5954.1c69fb81.1a799.7a8f@mx.google.com>
Date:   Tue, 24 Nov 2020 11:04:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6369109100804832132=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, danielwinkler@google.com
Subject: RE: Bluetooth: Add new MGMT interface for advertising add
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201124100610.v5.1.I5f4fa6a76fe81f977f78f06b7e68ff1c76c6bddf@changeid>
References: <20201124100610.v5.1.I5f4fa6a76fe81f977f78f06b7e68ff1c76c6bddf@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6369109100804832132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=390431

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============6369109100804832132==--

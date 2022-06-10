Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63FCC43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jun 2022 17:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349546AbiFJRDr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jun 2022 13:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346733AbiFJRDp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jun 2022 13:03:45 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243C235DE6
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 10:03:41 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id cx11so24526051pjb.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 10:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=JYJgDgq34iLrU/4lRbKJjo6n80/D8pwo5vaPqr97cr0=;
        b=Rw5JZTXXTS8x6Qn6zYJCTFK3/soknYdonYw/FQpSCxVwLYsAmBRqQp9IrofGhb1QHF
         SnuVYUqOc/nE5Q86EpvnLZnUABCI54y2uNPhchl7fh5vmx6iYGPluOxBLLGx3UQSKOQD
         OvFgP/H3eWnRz5KYjevyqgc/38GxxJiuKu8cq8/k/gNybhqCq24tM3zDmdJdOJzXPYRL
         yu3P8j/Pazj+t7iotu2wRwo0fPuaMfHKza5igRrSTCTXDIN7zu79UcWXjjFOj9H3PEgK
         +03tqxQ6z4c7OgcgmTnEh8iGW9XQKnAvuGgcEkaOSPuDh+mkK+51qk68T5LcdRzpC8lt
         bI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=JYJgDgq34iLrU/4lRbKJjo6n80/D8pwo5vaPqr97cr0=;
        b=FYX2tGQPNe7KGupdzP1wvAcPIBlHwA2yQmln3s9cS+jB/AuZoBx6P7mJr49j89X4K2
         Bu5j9xmAeIA/9k58YSkd6CH57Z61/uoAI9kKKL76sQtU4chn7pAfzjHapPzMdqVWONls
         GvAHN+FPLIa7g/HHkl0RwqbQrwA8X/KxikNjLM6B3W1x5qoIKOMecDzAtYCT9XFPIUDf
         AfWepBKk6csyKJPCbYtfixR2mP9ksH0C4qdGTmAUMYGxvyZa3McNZJZVJzpm0UP9hbrA
         tH804rLY1ZWimCREA7dPj9a2wHp5sHcK01oq89zSZY9+yhvBo8uNJgMN5nDQQnnwwE5J
         ZK8g==
X-Gm-Message-State: AOAM530uFDIDELTugAyh6iNIMCscAWRQmzIumFGbtYQp5EPXAMa7tM2D
        vtSVhgq6ZL/o1Xemeq6gQD/GNyrW9lQ=
X-Google-Smtp-Source: ABdhPJwPlxtybXWH2RUUV6n+1MOHuYtFggwQnXwt1aFb0j8fvqinIVIZoCQJYJLmcpwZHKMrUDwJag==
X-Received: by 2002:a17:90b:682:b0:1e3:142:a562 with SMTP id m2-20020a17090b068200b001e30142a562mr645946pjz.91.1654880620372;
        Fri, 10 Jun 2022 10:03:40 -0700 (PDT)
Received: from [172.17.0.2] ([20.98.67.233])
        by smtp.gmail.com with ESMTPSA id w144-20020a627b96000000b0051bc3f9a1f6sm17812481pfc.55.2022.06.10.10.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 10:03:39 -0700 (PDT)
Message-ID: <62a3796b.1c69fb81.8afdb.1f4b@mx.google.com>
Date:   Fri, 10 Jun 2022 10:03:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8012987317882420346=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jonas@dptechnics.com
Subject: RE: Fix bug where bluetooth-meshd stops sending
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220610152902.21677-2-jonas@dptechnics.com>
References: <20220610152902.21677-2-jonas@dptechnics.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8012987317882420346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=649335

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       PASS      0.36 seconds
Prep - Setup ELL              PASS      51.48 seconds
Build - Prep                  PASS      0.59 seconds
Build - Configure             PASS      9.86 seconds
Build - Make                  PASS      1784.55 seconds
Make Check                    PASS      12.38 seconds
Make Check w/Valgrind         PASS      531.01 seconds
Make Distcheck                PASS      281.18 seconds
Build w/ext ELL - Configure   PASS      10.16 seconds
Build w/ext ELL - Make        PASS      1768.46 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============8012987317882420346==--

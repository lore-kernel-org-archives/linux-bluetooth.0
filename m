Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2A6C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Aug 2021 05:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EB8E61042
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Aug 2021 05:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbhHTFgH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Aug 2021 01:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbhHTFgG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Aug 2021 01:36:06 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486BFC061575
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Aug 2021 22:35:29 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id bk29so4016538qkb.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Aug 2021 22:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=m6cmBeK4ZWjNkJfUMoy8altjeVfsaAKm5WRRpL09NjA=;
        b=lic+4RANkVFwL8yCqJbebm9NhM/26BJcZBmbl3u8HnIHHPNmLynucVOw7rjtk9i2UJ
         5HPbpjPd8DJNK58Fny6MgNy9e4PwkupbwYtfdh8eN4wsdrsybBI7ZcU78en2XWauRXwT
         EJMzIEXYnC88jplKzXwbkHVYkjVQ7oUR3eZ8J18nuXX3jr9QVHkEdEZ9FcyO3lzlCaX3
         suhCZ6CIJZF25wnbbyVIJUzaAoZUEqg298UBsup+cv99NTaAdUeEmmMy6m6Xa0RR/k90
         rZMs09psahO1800DpQlv2Rh2RGRh/Us+vkmrzqU6ZwqfZ6iKp3bqNO4cuFVzcXlf0+Kt
         6YvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=m6cmBeK4ZWjNkJfUMoy8altjeVfsaAKm5WRRpL09NjA=;
        b=ZSm74Io8wMzPfuTHiAwZBvMsdkfjI3OL/r3vDQcaJuw5HEsKeOdxXWXuHGqppCDpK2
         LGH0Lk7o5aoblBb9a8Ca1bfJH2fWaXaOfD6XrynJzGL4aDTLmvuKhtCyDYGBZ7FGReXk
         VuVFJUnoS3h96BSRxLbvj6RGeZPtTqCS0ejcvoZGNtIBboMPA/DdirwI/5LHBebAvMIA
         wzf4g/eVs35xLOkdpujBKh0YnLSafDA+gjmkIlGxD2DDy2fBVzQSVR5pr3aoXi51yxbX
         etloxoF/7Wc8fjwYLws01ogqCxSAKvP/nRIGoXayV2TQzZqJzj/bwtxv8fjmjycz21fX
         b0kg==
X-Gm-Message-State: AOAM5305SprwIcvDaSjLmtDIuJSxanD3HrF/OyGR1Tj8n+FRI0mW+ZcL
        DT6pGDVLAwcElF3KZKPb2Ip6qVdaJdwYmQ==
X-Google-Smtp-Source: ABdhPJycN3u+WTMN26MdUEfWW5Fcb7KGwCHjVOTQj7MsN7zUthLP5swJFK7ARwsjTgIc+txDQ0tGmA==
X-Received: by 2002:a05:620a:2150:: with SMTP id m16mr7141017qkm.396.1629437728318;
        Thu, 19 Aug 2021 22:35:28 -0700 (PDT)
Received: from [172.17.0.2] ([20.69.250.128])
        by smtp.gmail.com with ESMTPSA id z1sm2143751qtj.35.2021.08.19.22.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 22:35:27 -0700 (PDT)
Message-ID: <611f3f1f.1c69fb81.758dd.ffdf@mx.google.com>
Date:   Thu, 19 Aug 2021 22:35:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1581392715498042278=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] tools: userchan-tester: Add test case for the closing channel
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210820050705.76853-1-hj.tedd.an@gmail.com>
References: <20210820050705.76853-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1581392715498042278==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=534645

---Test result---

Test Summary:
CheckPatch                    PASS      0.40 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      48.16 seconds
Build - Prep                  PASS      0.14 seconds
Build - Configure             PASS      8.45 seconds
Build - Make                  PASS      203.34 seconds
Make Check                    PASS      9.51 seconds
Make Distcheck                PASS      238.94 seconds
Build w/ext ELL - Configure   PASS      7.95 seconds
Build w/ext ELL - Make        PASS      190.48 seconds

Details
##############################
Test: CheckPatch - PASS
Desc: Run checkpatch.pl script with rule in .checkpatch.conf

##############################
Test: GitLint - PASS
Desc: Run gitlint with rule in .gitlint

##############################
Test: Prep - Setup ELL - PASS
Desc: Clone, build, and install ELL

##############################
Test: Build - Prep - PASS
Desc: Prepare environment for build

##############################
Test: Build - Configure - PASS
Desc: Configure the BlueZ source tree

##############################
Test: Build - Make - PASS
Desc: Build the BlueZ source tree

##############################
Test: Make Check - PASS
Desc: Run 'make check'

##############################
Test: Make Distcheck - PASS
Desc: Run distcheck to check the distribution

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============1581392715498042278==--

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB5EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jun 2022 22:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239753AbiFBWqp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jun 2022 18:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238667AbiFBWqo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jun 2022 18:46:44 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C48698
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jun 2022 15:46:43 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id l1so4552880qvh.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jun 2022 15:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=grJQwBMvmxP+1i/wRm5iyw5Fbyi85SE6xnE1uG3iyZQ=;
        b=NL3AvYtjYsRpgr5sewVE5lK2Qgz5rObDiqq59FRfhPdwPtw3Hg87jbSrQYB+e9rmbl
         aMxg9H70Rp/fTiiQwg2u6JOWPIWOQs4n2+8fYCzOlrRQFak4KxC3Oo41UevUnjDYaixU
         wUZgMb6jiWtrytydaknVBNNr6L1QWUyL1hjn39oZjY/38jDipBF6Xa6LSW6LipbNyl1R
         XyqXCytLcbjXvkZM4mgucymyi3YMzyEA8g8SeStj3cS6z2o740lGMbg8Q8asjNt1fGMX
         5Tx6xsyHsbwhnY9uU/ELD4OScxiDO/SdbpgoLKEKZfZn4jMv3TmM/R1XDWMmW87+K4Dx
         TfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=grJQwBMvmxP+1i/wRm5iyw5Fbyi85SE6xnE1uG3iyZQ=;
        b=sfty2zDS/JNdkJWvxjf528J7uHXB4mjyUSMj2KpvLkHCmVnWrl3P5qN/VdSerccH0P
         WlZnzKJfYhR6LvyZvGOLH8Tq5eFDk3zkvjGGj7sGCeh4idB5bde7nig4Us6MIeMhInpy
         eHHujmy2a2IjkcpMyGTfJ2uKpUpQGVbiO3NHUItHNph+0Gv6TBrMseK9ech75WpNmdrO
         GjMGewGg5rUuySYiGZyng8Iohu5tHOESW5w3BFYD6QWNX/7F61xW3YWoHfFI/5hcxsRD
         M+NlBPozEZXTCzFgsQe+wivooRkSgQhnjAaGrkHUjyVsn6KNJUlGPw4pYPBHMub/h0Wy
         Xg2w==
X-Gm-Message-State: AOAM532d2jo8mDO+EtVVZXfH1yeYo/75UJ3CdGZNq6a5O1kl+Rkhz/Fe
        yejiXPb6hseXFWWyx+hcShHIj5+gxfVEgg==
X-Google-Smtp-Source: ABdhPJyvln+uT5SlVrl54XtTQiRWkfjn0AB9q4hVqIarTQZGG5apd27N9bMdEftnh8fNyMr8+khK0Q==
X-Received: by 2002:a05:6214:626:b0:462:34f8:8ef8 with SMTP id a6-20020a056214062600b0046234f88ef8mr48643018qvx.102.1654210002277;
        Thu, 02 Jun 2022 15:46:42 -0700 (PDT)
Received: from [172.17.0.2] ([20.1.192.161])
        by smtp.gmail.com with ESMTPSA id z8-20020ae9f448000000b006a648c16204sm3617448qkl.85.2022.06.02.15.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 15:46:41 -0700 (PDT)
Message-ID: <62993dd1.1c69fb81.64927.0701@mx.google.com>
Date:   Thu, 02 Jun 2022 15:46:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2025066604064620090=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] monitor: Stop spamming logs when GATT db cannot be loaded
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220602212229.1486206-1-luiz.dentz@gmail.com>
References: <20220602212229.1486206-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2025066604064620090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=646996

---Test result---

Test Summary:
CheckPatch                    PASS      1.49 seconds
GitLint                       PASS      0.99 seconds
Prep - Setup ELL              PASS      51.03 seconds
Build - Prep                  PASS      0.75 seconds
Build - Configure             PASS      10.26 seconds
Build - Make                  PASS      1462.12 seconds
Make Check                    PASS      12.17 seconds
Make Check w/Valgrind         PASS      518.04 seconds
Make Distcheck                PASS      272.21 seconds
Build w/ext ELL - Configure   PASS      10.15 seconds
Build w/ext ELL - Make        PASS      1433.88 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============2025066604064620090==--

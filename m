Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DDBC38159
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Jan 2023 02:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjASCqZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Jan 2023 21:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjASCqX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Jan 2023 21:46:23 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D476C568
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jan 2023 18:46:19 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id gz9-20020a17090b0ec900b002290bda1b07so3082539pjb.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jan 2023 18:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9bxMFXbUOJioPRz+ZZKaZMcT2GEEi5KUShgsS1vlXAg=;
        b=VzZbIFsoF8GLprtuQKFxvy6PnZexf5SL6TUSil6g2Y9/n3lG+NkaBRfZjfv5dtx4Oh
         tytM7QXxZeWNg2au2y/yQglLj+XQQy2zd6QQ62Y07ltUzif6WCivHw8tWC/QTx4DBJz/
         TcOm43QjmKsAyGTWRmPn2VXsUEVpigVQuVdwgJZnjh83Bk/iOEdUYtwIo5pVhe34a7/i
         Afuss5XtaeKHI7uJkr8a+WXH+AMLI7p9YiK7EG2agThEFUdP4nW/urijkDyy6VcRKZnY
         Beh8s/XMEFqGpLDmJvg8Q98Cc9RtI61OssfcNewuGi8/AHpmyyVH+/KXi/ssXlx1gZeu
         UsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bxMFXbUOJioPRz+ZZKaZMcT2GEEi5KUShgsS1vlXAg=;
        b=SSH8H8703NcvLSShTD+rUQUGmU1nH0qrXuInbQ9LJAz3llDYH5EoDTeEbZMEfYNEcg
         mr9xsasyRvBQTCj2g/LLYZJDIoFZCccw0YST3had9wFqvj0RXu1A2Dvm+6k9fdwnbF7t
         4XurpaaqeGoHytqmVKQl08ZhVYFCzFp0uEUtL9MoDgAbgRU8KF/Js9pdqCuVhGvmOW7Z
         jjk5S6vFLciRwp8R4iRcKK+CjegqSm4xzOv78o6tVT40v76oJr5/v/376HxF0kPQ556d
         q3iTYP1TAGqcsY09py23x2KE9uHhwPAjHUCHhzi+9Bjzl+qjTDknBzCuwbhjfBi406pM
         uwDg==
X-Gm-Message-State: AFqh2krJr1zf1sw9Pm6V01HGUa9mpG7dw78vsqUfBEKm6RQ4FkBmBPzL
        luGroWMkSHIyC7PIGeBn6fD9YM10sx0=
X-Google-Smtp-Source: AMrXdXtqyb+F9d9m0EW8Sxgz5p1hf44yQsYnyRSacGL44tBZ9VKUzYKqJ5YFYAchjgrKVMegaD26FQ==
X-Received: by 2002:a17:902:d411:b0:192:f12a:42de with SMTP id b17-20020a170902d41100b00192f12a42demr8366108ple.42.1674096378822;
        Wed, 18 Jan 2023 18:46:18 -0800 (PST)
Received: from [172.17.0.2] ([13.88.61.227])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b00189f69c1aa0sm23614949plp.270.2023.01.18.18.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 18:46:18 -0800 (PST)
Message-ID: <63c8aefa.170a0220.6b620.6f9a@mx.google.com>
Date:   Wed, 18 Jan 2023 18:46:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7472762376426786517=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
Subject: RE: L2CAP: Fix null-ptr-deref in l2cap_sock_set_shutdown_cb
In-Reply-To: <20230119020406.3900747-1-iam@sung-woo.kim>
References: <20230119020406.3900747-1-iam@sung-woo.kim>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7472762376426786517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=713488

---Test result---

Test Summary:
CheckPatch                    PASS      1.74 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 FAIL      0.45 seconds
BuildKernel                   PASS      43.01 seconds
CheckAllWarning               PASS      46.26 seconds
CheckSparse                   PASS      51.28 seconds
CheckSmatch                   PASS      136.55 seconds
BuildKernel32                 PASS      40.25 seconds
TestRunnerSetup               PASS      579.35 seconds
TestRunner_l2cap-tester       PASS      20.05 seconds
TestRunner_iso-tester         PASS      21.75 seconds
TestRunner_bnep-tester        PASS      7.20 seconds
TestRunner_mgmt-tester        PASS      136.12 seconds
TestRunner_rfcomm-tester      PASS      11.25 seconds
TestRunner_sco-tester         PASS      10.28 seconds
TestRunner_ioctl-tester       PASS      12.13 seconds
TestRunner_mesh-tester        PASS      9.21 seconds
TestRunner_smp-tester         PASS      10.40 seconds
TestRunner_userchan-tester    PASS      7.64 seconds
IncrementalBuild              PASS      38.50 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============7472762376426786517==--

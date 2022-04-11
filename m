Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51315C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Apr 2022 10:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345148AbiDKKNX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Apr 2022 06:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345245AbiDKKM6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Apr 2022 06:12:58 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3F83A711
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Apr 2022 03:10:44 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id a11so15732861qtb.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Apr 2022 03:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Ugl/cvIpYLjRSgPUnwnAhxpqRLKhyWnrRORllHmqwGw=;
        b=T4PQ5Kb5qeYNy9jxmKQHyvSFG/eYyAr2qlkXxZCOTVehfg6VRbhL2EaYDpJ1yAr6BP
         /2a6GukioVwl5/WSgQOOhD5+2Ka8qrwGwgdnC6L6BEnldx4hugX8Y0x+FecYCRivMFzg
         UFXXPmiUc/1BXA5RBx8L5h1YcigYtg1y2JNThB052DDiyoWjnM1k69Dsy6E9XSHBEp4C
         E7j9PiUF4nL7irPZXvSEjvEngNDfeBcqQbKUTo3p7dxPs/ZW84D8BZkk4QBkpuFChPdb
         zfsRMsMHif/XNtIUAO7cPPTr61jlr0+wXiYIINmrrNn0lhnLY35U75M6ou4mx1EKIHj/
         a7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Ugl/cvIpYLjRSgPUnwnAhxpqRLKhyWnrRORllHmqwGw=;
        b=HuHOBcMgjOl1fSUCcel1hHsuxp7HmV+ah25jHgWxTp0SYoB13hm7XXsTk4vIwCeHMr
         HiGLLkERFX9fZJlGsnmrmoj+JtIBHNsFU32gvKpznSYXnFnmUWomwhDuZprlixz8Ns+5
         VvQeMwPs/JBqbSBb9ID7WPgZzVSp7zKMb2Gr3KJAxtvL+nWWzZLQpAmZtNg5uIZVpUMr
         OQVwcGOtLn7V7HoC7sWuKyxeU3Wn4HoEeP3XvQ8KaxHSbVEut6KJdOPcmDERJ4gUoH6w
         g0i+DqD2cItT1cGWQwzrBLOgwsqXV46mrFGz6CHjq8/hiDw7DV/7xYcIPvseZPJTd2tv
         Oscg==
X-Gm-Message-State: AOAM532Fjkninc13oMlwZE5ySR09KOIAOp0lPJ0NxR0WQyJAbkZTtO9/
        cl2GLckTUEXeX0GUBojGtIUs6WL+J5uyrg==
X-Google-Smtp-Source: ABdhPJxA9SHljfwcP4HM7VJzJbPOqJYSSeSOFOBPQ1gldoEWWzmMk/DkhJDH6oxZHqL78vkCBJkdVw==
X-Received: by 2002:ac8:124a:0:b0:2ed:fcf:e7db with SMTP id g10-20020ac8124a000000b002ed0fcfe7dbmr7752251qtj.140.1649671843113;
        Mon, 11 Apr 2022 03:10:43 -0700 (PDT)
Received: from [172.17.0.2] ([20.127.98.13])
        by smtp.gmail.com with ESMTPSA id t125-20020a372d83000000b0069c1df12422sm1866027qkh.84.2022.04.11.03.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 03:10:42 -0700 (PDT)
Message-ID: <6253fea2.1c69fb81.a41c5.65e0@mx.google.com>
Date:   Mon, 11 Apr 2022 03:10:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6702866410200602701=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, max.chou@realtek.com
Subject: RE: Bluetooth: btrtl: Add support for RTL8852C
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220411091957.838-1-max.chou@realtek.com>
References: <20220411091957.838-1-max.chou@realtek.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6702866410200602701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=630976

---Test result---

Test Summary:
CheckPatch                    PASS      1.75 seconds
GitLint                       PASS      0.99 seconds
SubjectPrefix                 PASS      0.82 seconds
BuildKernel                   PASS      41.54 seconds
BuildKernel32                 PASS      36.68 seconds
Incremental Build with patchesPASS      49.60 seconds
TestRunner: Setup             PASS      603.24 seconds
TestRunner: l2cap-tester      PASS      19.03 seconds
TestRunner: bnep-tester       PASS      7.62 seconds
TestRunner: mgmt-tester       PASS      125.70 seconds
TestRunner: rfcomm-tester     PASS      9.83 seconds
TestRunner: sco-tester        PASS      9.83 seconds
TestRunner: smp-tester        PASS      9.68 seconds
TestRunner: userchan-tester   PASS      7.88 seconds



---
Regards,
Linux Bluetooth


--===============6702866410200602701==--

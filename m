Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D8EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Apr 2022 04:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357707AbiD0Eki (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Apr 2022 00:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357713AbiD0Ekh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Apr 2022 00:40:37 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0316B1DA55
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Apr 2022 21:37:27 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id hh4so380416qtb.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Apr 2022 21:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=KnkpdXcActCoGHqeot0gFxqXQPiFvjZnQrRamwjxJGI=;
        b=MhREn+NZO30FSSJQeXwprojJHJFZIJ7isyk4RpPy+jCXjkF2sFtogVklMj7hlv3z95
         GhYnSFln2dwPZh6Imj6t4MCLJ7rFO7b68j9K+vkBiQWL+Mz/o+bi2DWh4l8tuo1WoDFE
         DdLgU6M8CAkPz7aceCZSKy+gngiimoe0+3Ffwvi1i7BNoxNyNZOfgM9debdJqMd0sT1l
         4imPGEp0hUxKnQydGBBC/xzlIld3Xo/JNIGIuCfUEtllxw81A5hew1NXe6Q7ec3FU0oo
         KvrXetVgDDzWsOQ20HOA/UyuMFq2A9rWp8LSmLU0tmQgyFwGIM3S5gJDPP8wqg55VPJi
         L+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=KnkpdXcActCoGHqeot0gFxqXQPiFvjZnQrRamwjxJGI=;
        b=JjjT1Eztqp+h//8AqrRyY7SVyGkn/EoLRPsosdYETDFAb1aKJoB0HbSdOi1CsAHzpX
         zh4bXbFtdjU5o9dMIFde3SSwbjn6YVsCDqfqEeqNtTRvfmHS1We8QUoTEw8beVAiA29I
         2xfKA6jXCHYcbGfvXA7WIq8kJvZLnuLQe3ar/jI0K1cOOxAtWGiHsZ/3p5kIPthWEMot
         HlQrlpyTY1mxwdUiWbVvJXDzwTWpLbD9LstzBuZikG3NejE6MoqQKKH2U1AYXiUxTuVy
         d+IdrjHXMBBjsPILf2b9/5NBOkovt8mIKICA589OXlX3yWeD7EMQFP8gaARx9xZ9WBkT
         d/6Q==
X-Gm-Message-State: AOAM533rNUNmRyPUKUX+iel10D9OYDyfulTMCdNuoSxIqM/gRJcrvT5l
        jo49J9FuEeNt16Yi7oAH/ste0B/6bYq+og==
X-Google-Smtp-Source: ABdhPJycwc2nEs17kOjuZvRB4X2Zi/3a6lWaAsp8RkCxDsi1xKQmu13mRXP/g5NOQGD/Reja+G9l3w==
X-Received: by 2002:a05:622a:54d:b0:2f2:b558:b91b with SMTP id m13-20020a05622a054d00b002f2b558b91bmr17459822qtx.162.1651034246014;
        Tue, 26 Apr 2022 21:37:26 -0700 (PDT)
Received: from [172.17.0.2] ([20.65.69.238])
        by smtp.gmail.com with ESMTPSA id bq37-20020a05620a46a500b0069f67110f37sm3571704qkb.117.2022.04.26.21.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 21:37:25 -0700 (PDT)
Message-ID: <6268c885.1c69fb81.7b342.59cf@mx.google.com>
Date:   Tue, 26 Apr 2022 21:37:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3523589415119219481=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, lnx.erin@gmail.com
Subject: RE: [net-next,v2] net: Add SO_RCVMARK socket option to provide SO_MARK with recvmsg().
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220427032212.28470-1-lnx.erin@gmail.com>
References: <20220427032212.28470-1-lnx.erin@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3523589415119219481==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=636000

---Test result---

Test Summary:
CheckPatch                    PASS      5.26 seconds
GitLint                       FAIL      1.08 seconds
SubjectPrefix                 FAIL      0.96 seconds
BuildKernel                   PASS      33.03 seconds
BuildKernel32                 PASS      29.22 seconds
Incremental Build with patchesPASS      39.41 seconds
TestRunner: Setup             PASS      495.09 seconds
TestRunner: l2cap-tester      PASS      18.12 seconds
TestRunner: bnep-tester       PASS      6.47 seconds
TestRunner: mgmt-tester       PASS      105.38 seconds
TestRunner: rfcomm-tester     PASS      10.06 seconds
TestRunner: sco-tester        PASS      9.79 seconds
TestRunner: smp-tester        PASS      9.70 seconds
TestRunner: userchan-tester   PASS      6.66 seconds

Details
##############################
Test: GitLint - FAIL - 1.08 seconds
Run gitlint with rule in .gitlint
[net-next,v2] net: Add SO_RCVMARK socket option to provide SO_MARK with recvmsg().
1: T1 Title exceeds max length (82>80): "[net-next,v2] net: Add SO_RCVMARK socket option to provide SO_MARK with recvmsg()."
1: T3 Title has trailing punctuation (.): "[net-next,v2] net: Add SO_RCVMARK socket option to provide SO_MARK with recvmsg()."


##############################
Test: SubjectPrefix - FAIL - 0.96 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============3523589415119219481==--

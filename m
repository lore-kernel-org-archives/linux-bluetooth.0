Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DB5CDB47E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Oct 2023 03:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjJSDia (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Oct 2023 23:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjJSDi3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Oct 2023 23:38:29 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3784126
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 20:38:25 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-77acb04309dso304232439f.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 20:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697686705; x=1698291505; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NifUUPMeoAD7aVH6ygXOOZl/svHziufzfBZbws+RpgY=;
        b=TflZoq9ufVzuDeR1DhzhagSM8I9TQs1hhgtiGlEgN7x4xuSrFOwXJHs8UqqlchkYTm
         MP8Urbv1b4VwrCOm5X7rroE4H1x87Klg14x4BMQ71YChEPy3ShpZguvOOrQvCgnpbGvi
         zAEPZjOU1QIyeURTIZTHU0XaGj2HJqFUJQ04Wn+hbCTbphvmUJULyR+BGcLVTsJJ/x/n
         N5bMSc0Y5yxdE46+fmv7Bvpsx3feY3qjz6gkFZjZb996NI0a8LtkkRp1mpnBWAnHnVgo
         ZsqnHdsMQJ4DRQIJsQ9A/AZHhBvgXwDrSClUWmn0XVYtMAac3lGE0/G24wjQeJvVwP6H
         zjmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697686705; x=1698291505;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NifUUPMeoAD7aVH6ygXOOZl/svHziufzfBZbws+RpgY=;
        b=m/vPa6P6iuv7V5Ga9oKytxLgQEuZ7YN4Uoahi5SRtT00dh7XfAhN7rX7ubkCnnjQRb
         3AeFdSmnvXF0t/4mqolVGxOzArnlTbksOCqWwa0a236aKgELnmU+Sehp23+N4ipSYuQ1
         OO2tNAK2CTdDVsjn7mG61MNtWS16QQcdnMUsaUax+PnXzW2Vs/lFNUUVz1bHFJvyOmyM
         8AmhnNv8QZyDfheJ4x5g6p/qJiu2nsWyqu03iOO/kgfFwA/cL8+DNuD1QCKn98LW16K0
         pzycaHM8zW7UPY+VE4AWWxdE/xnJS3i7G0SDXWJ0QpaaG0uDtwO06YSevd0dsHk393QZ
         nQ8g==
X-Gm-Message-State: AOJu0YwfVkSD6MSvx9KpvbG+QAZp2mFTXzE3cyGN8XVHMwxePophRPJd
        /VSuqmPxgP63Y73WdWEs6wphGO5hWbw=
X-Google-Smtp-Source: AGHT+IG7xix6I9UFpcAZGQMcuJcLJ43FUtOfZSTCFqWoqhSQboJZFGUehhErcvO81MuUhiQYTtLVyg==
X-Received: by 2002:a05:6602:2b0b:b0:787:34d:f1ea with SMTP id p11-20020a0566022b0b00b00787034df1eamr1479524iov.8.1697686705130;
        Wed, 18 Oct 2023 20:38:25 -0700 (PDT)
Received: from [172.17.0.2] ([40.83.3.208])
        by smtp.gmail.com with ESMTPSA id g3-20020a6b7603000000b0079fdbe2be51sm1555227iom.2.2023.10.18.20.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 20:38:24 -0700 (PDT)
Message-ID: <6530a4b0.6b0a0220.457b1.2062@mx.google.com>
Date:   Wed, 18 Oct 2023 20:38:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2418983055465223881=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, youwan@nfschina.com
Subject: RE: Bluetooth: btusb: Add return error code
In-Reply-To: <20231019023953.218624-1-youwan@nfschina.com>
References: <20231019023953.218624-1-youwan@nfschina.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2418983055465223881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=794552

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      35.14 seconds
CheckAllWarning               PASS      38.06 seconds
CheckSparse                   PASS      47.25 seconds
CheckSmatch                   PASS      118.38 seconds
BuildKernel32                 PASS      33.80 seconds
TestRunnerSetup               PASS      527.27 seconds
TestRunner_l2cap-tester       PASS      31.32 seconds
TestRunner_iso-tester         PASS      57.57 seconds
TestRunner_bnep-tester        PASS      10.54 seconds
TestRunner_mgmt-tester        PASS      224.89 seconds
TestRunner_rfcomm-tester      PASS      16.28 seconds
TestRunner_sco-tester         PASS      19.56 seconds
TestRunner_ioctl-tester       PASS      18.25 seconds
TestRunner_mesh-tester        PASS      15.22 seconds
TestRunner_smp-tester         PASS      14.49 seconds
TestRunner_userchan-tester    PASS      11.17 seconds
IncrementalBuild              PASS      32.42 seconds



---
Regards,
Linux Bluetooth


--===============2418983055465223881==--

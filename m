Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38631C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 02:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240681AbiKRCsw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 21:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240720AbiKRCsv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 21:48:51 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42188E292
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 18:48:50 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id w9so2372907qtv.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 18:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0FOeI5hHMvo1o5tMCA8sN/znWkibpelYCqG0xy2spSg=;
        b=dphyIngnsOjyveMQt7DNtGk1eGbPU7L2lRnM2siA3mOZdh8APcailpg0IwTZqyaKV/
         VY82a8aau5D60FTpw2i4eURh16UtxYh5H6/4GXwf1I8iN3yWl/48caxKqwl+0SJkqL6Y
         Q9ynw6TmhAMsjWC+iOt9l+ulSJd4OS+Gp8VaOL2OmPYPLDVJ6xKIbgV6SdDw7NYUHk6L
         fRIMV9p0+jn4aq7QR0TmByh6xUOCioZjCOcnfQIstJ4VOu4QlaS7IQ+TeOxZRMPCHyZk
         +T+4nyoWATssIkfyBCfAatFmUe9Nm1GiD1GGhQjN1v/IR3mDXKUynCMFhSeoConPjq2Q
         7Vkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0FOeI5hHMvo1o5tMCA8sN/znWkibpelYCqG0xy2spSg=;
        b=Gyo+tcPYI7LUF8hIoY2tA6KOqx4JOxTJ0BjdFqwhWU/NvfN/+ZBsTBKnQSOQi5Nkt4
         nvtx+Fx3Lz2PWmkxkPR1BnHyj3UbY4obW0tWOqMscxSbXnEBleR3VMW3pzmyGyWTBNDc
         OelcpiPFiUJT7mvnQ10pAWjND1wGTQv0V6ZqErhN2WQrMdiA/ewxsTiWS8+VriFooT8k
         5qey5w/A5ZEBVX86//EqszeZELBUX0TBsQIFKzrtq9GCkG6wostrkImOaLzlt1dC1hcu
         15Der8TqTI6BV5+TdqCBO7MsEqCAZ/PMxw0IoE1KsDsVfBkO0CJGkui9p+Lzhss7jas4
         x49g==
X-Gm-Message-State: ANoB5pnF8ivYCBVBMDeHOU0edUTunfLrs3Uotq/q4P2KfpFJF18GfKfy
        NcQ853FdwU2mPxBlR/cWM2sw+PEwUc9xmA==
X-Google-Smtp-Source: AA0mqf7f4NSowY+DYFt6vd7P64vIkJ9SIJuP1sb6QxaoBi9JQt9kfPcvMuou6ycSs/Jz7Jefxd/Rqw==
X-Received: by 2002:ac8:4908:0:b0:3a5:faa7:35e7 with SMTP id e8-20020ac84908000000b003a5faa735e7mr5069856qtq.66.1668739729648;
        Thu, 17 Nov 2022 18:48:49 -0800 (PST)
Received: from [172.17.0.2] ([172.173.167.69])
        by smtp.gmail.com with ESMTPSA id r5-20020ac85e85000000b00398df095cf5sm1315351qtx.34.2022.11.17.18.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 18:48:49 -0800 (PST)
Message-ID: <6376f291.c80a0220.d62a.6c10@mx.google.com>
Date:   Thu, 17 Nov 2022 18:48:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6991640247409050540=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [DNM,v3] Bluetooth: doc: test patch - DO NOT MERGE
In-Reply-To: <20221116052716.57521-1-hj.tedd.an@gmail.com>
References: <20221116052716.57521-1-hj.tedd.an@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6991640247409050540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=695798

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      34.22 seconds
BuildKernel32                 PASS      31.70 seconds
TestRunnerSetup               PASS      432.13 seconds
TestRunner_l2cap-tester       PASS      16.12 seconds
TestRunner_iso-tester         PASS      16.02 seconds
TestRunner_bnep-tester        PASS      5.61 seconds
TestRunner_mgmt-tester        PASS      107.66 seconds
TestRunner_rfcomm-tester      PASS      9.52 seconds
TestRunner_sco-tester         PASS      8.89 seconds
TestRunner_ioctl-tester       PASS      10.22 seconds
TestRunner_mesh-tester        PASS      7.03 seconds
TestRunner_smp-tester         PASS      8.82 seconds
TestRunner_userchan-tester    PASS      5.85 seconds
IncrementalBuild              PASS      32.14 seconds



---
Regards,
Linux Bluetooth


--===============6991640247409050540==--

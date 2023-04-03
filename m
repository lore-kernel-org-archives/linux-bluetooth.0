Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76419C761A6
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Apr 2023 13:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbjDCNNp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Apr 2023 09:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjDCNNn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Apr 2023 09:13:43 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E1B1D864
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Apr 2023 06:13:32 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso13667964pjc.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Apr 2023 06:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680527611;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a5Yz92Dd/VU9/dxfXCbbtkJzpe34r+NOPTuGg1Ve4PY=;
        b=OoQoJsuI2mBZykaI6f83ay9rrw9VSUOVQnRXMRPmNTmXlK4tYBnfR0d/ZByu6PPWC5
         UJpiNHR126jxX7fobaxRi7K32G10GMzsmb/2xJ+6ZmLSFN/7mW1WyseeJjKTV4jAb4Ov
         0/wj9ItgM9gU8e3Nd5cuUoi8LEeXPjveG0n9YV4WN58SQxYWROwiHeSYN9QzOquV7c8J
         OUdHGjnqrQZEjzdG7ny4ThWRVOGtvNnbSG3J0n2MJ8VUoYw5wL2QGHq2h3QhQSQfTAkB
         D8bpAvaX55debBaS+3n00ANBcQSPPfRYXGYsMP5NpChCX5LNpSpXW7EkWHfB5RTu6Yk/
         WrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680527611;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5Yz92Dd/VU9/dxfXCbbtkJzpe34r+NOPTuGg1Ve4PY=;
        b=4hfYvRPJdVLP+udWRjHEBcfwWFh1ErQib1DRFNWR2xROaiOuC0uwpgTH+MjZR1ZxmW
         OZoXrlfJAFv543NI6Q/I5Tx3O/TQNfMRJYC2DVh9rsO8zGbTcHB4wpsm7WxuqyC7Xoqi
         ad375/M0OwZNCwyC5bESqTVZB0ICEqqZy9eLqFDhwpLfzhSsTVNY8AzYfdhm3sCmg8lb
         nVJC9nYmf//Q7nGS+3BjDz2atMa20axq2ezVyh8kSETOYzpDeMKlwT99C6f2zE8zmA5a
         hlqKu4Ar4KKnVNrVx1LantZBuSzsKOB/CX2BhKLwQK9O2VEgYLHTQ+0fxTnkrzvfT8vK
         ua2w==
X-Gm-Message-State: AAQBX9eI31BZxBA9t+ep+4Xr5YdMgF2r1LegY5xka7D8OAh48E3JptOt
        Q6HndOF00wMQIBWX6fzYHp8Jfyfc1bg=
X-Google-Smtp-Source: AKy350Z7Fwoed3v6C0dprW/GI6kD0BtdHp+cmPaO0121sJcWpwGh8BnBTWxDT6z7JESTPS20ivSvHQ==
X-Received: by 2002:a17:903:6c4:b0:19c:fc41:2dfd with SMTP id kj4-20020a17090306c400b0019cfc412dfdmr31660786plb.29.1680527611400;
        Mon, 03 Apr 2023 06:13:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.133.132])
        by smtp.gmail.com with ESMTPSA id jl23-20020a170903135700b001a1faeac240sm6547549plb.186.2023.04.03.06.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 06:13:31 -0700 (PDT)
Message-ID: <642ad0fb.170a0220.20bcc.c29f@mx.google.com>
Date:   Mon, 03 Apr 2023 06:13:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1172470597567984163=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1] Bluetooth: btnxpuart: Deasset UART break before closing serdev device
In-Reply-To: <20230403122430.1024235-2-neeraj.sanjaykale@nxp.com>
References: <20230403122430.1024235-2-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1172470597567984163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=736375

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      31.38 seconds
CheckAllWarning               PASS      35.00 seconds
CheckSparse                   PASS      38.82 seconds
CheckSmatch                   PASS      108.88 seconds
BuildKernel32                 PASS      30.51 seconds
TestRunnerSetup               PASS      435.38 seconds
TestRunner_l2cap-tester       PASS      15.79 seconds
TestRunner_iso-tester         PASS      15.60 seconds
TestRunner_bnep-tester        PASS      5.01 seconds
TestRunner_mgmt-tester        PASS      107.86 seconds
TestRunner_rfcomm-tester      PASS      8.05 seconds
TestRunner_sco-tester         PASS      7.46 seconds
TestRunner_ioctl-tester       PASS      8.74 seconds
TestRunner_mesh-tester        PASS      6.42 seconds
TestRunner_smp-tester         PASS      7.32 seconds
TestRunner_userchan-tester    PASS      5.23 seconds
IncrementalBuild              PASS      28.77 seconds



---
Regards,
Linux Bluetooth


--===============1172470597567984163==--

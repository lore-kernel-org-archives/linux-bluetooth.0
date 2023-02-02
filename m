Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E405C05027
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Feb 2023 18:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjBBSgq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Feb 2023 13:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjBBSgo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Feb 2023 13:36:44 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9776A73E
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Feb 2023 10:36:18 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id cr22so2890783qtb.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Feb 2023 10:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A7EjDWs33ySw6frUD54yPEd8FVaqg/O7ZXEV+Dn4dbg=;
        b=p95hdLk7PjUZWpbkz+yKkJXfba2khUSr9vIbgrsR0IDbJ7xUwBiVIZgB8pw0l8e6Co
         ImehC14Dh+dpzIePCPsntIxPGmT2NO0JC+9ptL1dgW12fpH2K5XM4ce+S6a+W33fyR9p
         FVuz53WbHH0lApa/uk4hmNBbMqGBHleAsGfKxwJXpgL8wiMz726lzjI3VT9CEWvHdp+T
         S5btc8z27+unxgnHHVloa+v1t01l/5R47eQzQpejsom8aie433aps8oa/z8UM0Znacz8
         fHiIzHyvQN0qYoiIVW0jDfjYhbxa+FD6mpMpLGJAqLJLIcxbRjS8tstxCX9Q+J6N4pXQ
         TRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7EjDWs33ySw6frUD54yPEd8FVaqg/O7ZXEV+Dn4dbg=;
        b=N9IBh/UIcSPh+ShSb81Kd2u/5PPotNBMh8hnTE5vDKzOO96488PSoFnUtVVV5Fuuul
         dntxfNzRqC7br0lj6SajNfTgF6IcVUaWTDvc6Rl6Rx8gjUKulp9c18Ukv0QYlfLjHbp8
         7Z8E4ngX1lEQBFkuh2fVKvmZYvZsOWTdvZh9N/uYXy30aRHiQmq7Lk7vzcfiqheg1JUD
         sJhFcp699fa7sxJ2iG3bcjRQdLgv73xRQOijaqKzRrXECe+SyA91hR6JHPybj3yCuWmQ
         LjjM8otLjTbFJEutbQH1eCHkuM5we0OysLxR5hKWPSx3yMeL6RTzo/DBE0TYLjjwputn
         tFIQ==
X-Gm-Message-State: AO0yUKWa1ZC8EP53E6qp+Fd0tNTUEFtatuBvEcZvm1BdKodcB5y9ba56
        S/e+kncz2xtyDtpce22ig0/sskVXxuC7uA==
X-Google-Smtp-Source: AK7set+B4pI3TrkxFTRYkWf3VVM7pA5HVolWceC7bcvHTobbS/Ki1pEmGLqMpnqd+61hTkYjJAmQfw==
X-Received: by 2002:a05:622a:306:b0:3b2:365c:9a9e with SMTP id q6-20020a05622a030600b003b2365c9a9emr14111283qtw.61.1675362944123;
        Thu, 02 Feb 2023 10:35:44 -0800 (PST)
Received: from [172.17.0.2] ([172.177.255.80])
        by smtp.gmail.com with ESMTPSA id dw28-20020a05620a601c00b00728bbe45888sm250044qkb.10.2023.02.02.10.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 10:35:43 -0800 (PST)
Message-ID: <63dc027f.050a0220.50c76.1949@mx.google.com>
Date:   Thu, 02 Feb 2023 10:35:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0393869588242039062=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiangzp@google.com
Subject: RE: [kernel,v1] Bluetooth: hci_qca: get wakeup status from serdev device handle
In-Reply-To: <20230202094659.kernel.v1.1.I7d79501f333609addbb0b39803a7bafb99e5b728@changeid>
References: <20230202094659.kernel.v1.1.I7d79501f333609addbb0b39803a7bafb99e5b728@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0393869588242039062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=718272

---Test result---

Test Summary:
CheckPatch                    PASS      0.80 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      30.86 seconds
CheckAllWarning               PASS      34.19 seconds
CheckSparse                   PASS      38.46 seconds
CheckSmatch                   PASS      106.74 seconds
BuildKernel32                 PASS      29.81 seconds
TestRunnerSetup               PASS      431.37 seconds
TestRunner_l2cap-tester       PASS      16.26 seconds
TestRunner_iso-tester         PASS      16.50 seconds
TestRunner_bnep-tester        PASS      5.45 seconds
TestRunner_mgmt-tester        PASS      110.09 seconds
TestRunner_rfcomm-tester      PASS      8.63 seconds
TestRunner_sco-tester         PASS      8.06 seconds
TestRunner_ioctl-tester       PASS      9.33 seconds
TestRunner_mesh-tester        PASS      6.86 seconds
TestRunner_smp-tester         PASS      7.85 seconds
TestRunner_userchan-tester    PASS      5.73 seconds
IncrementalBuild              PASS      27.67 seconds



---
Regards,
Linux Bluetooth


--===============0393869588242039062==--

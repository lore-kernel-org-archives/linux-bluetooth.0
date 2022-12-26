Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E99BC4167B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Dec 2022 02:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiLZCfA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 25 Dec 2022 21:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiLZCe7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 25 Dec 2022 21:34:59 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398D426C3
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Dec 2022 18:34:58 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso13752467pjt.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Dec 2022 18:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2uJpKIyk0oPfdlaKEceIv0er/j+AAnWlZGGF1GcbEM0=;
        b=GMHTgV1vomjEHB6ovlEfQWij3tGaIRlc6ZfLxxc8fA+ZeaKMglfZSYmhLC5p1MrOUS
         L3cOD5oS7fAhZng0oZEiPjFMj2H0mCleKA7Dxs0VB4KIBnAoKEqu0qjghU3vB7sRjRr9
         +yynGEc9qKLzgAbsfl7MVpWKQde7NSoKVXopoh9pRhINyZobgQYrTstHFJGD9dyOwfq3
         jCe+YSQpA17H1IJNhHJ/wtKnRW5mqAmGGtsJBab4lXEhDqpzV7jUpWq5KY9fF6cqbp6I
         S3KOp+PzCDdpqollObIFgmbulUhPanwDeb1YcqasOoI1fL0FwrW/2OANxzBO50Z6Ae13
         AXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2uJpKIyk0oPfdlaKEceIv0er/j+AAnWlZGGF1GcbEM0=;
        b=xARY4CrXqjXOg9fuUld/4/eq7vV4mM5GrBUePD48/BWKRpv7L57Pbi+DkUHd8NzwbU
         oOPX7wNM4/NQ0ZckhG9tX5XBKEvcQgi1wEWKzoXJoKUy6cSmf2UKcHC0bIt06AL1zpfT
         qRdFnIGgsGmzWPdpLmvDuuG6NgCOnCxmMcWgM+JXgsljp3xB1S2lUukd+PNCJnieqagm
         UotEwPkey2taLp9adjwMiyExQpaYOU3nYVYvgvxnJik9QEd+fT75nO6gHyYDrIVlCHlV
         5jk0yHZMFTj4hlrCnDJTuOqiYXhglgYwTt7Gf9Mkmu88+/s0RUXWP6jGIwVIqW3OoWpk
         hUkA==
X-Gm-Message-State: AFqh2kr4m0wstNC+QHz8GX+5RgWr/kmnjjnHTL7PHFEFWxUON/FUVt/o
        2Ylru53M3ymrNyW2qQctOllaUa52CxU=
X-Google-Smtp-Source: AMrXdXuaOw5rJkjzXcFJTGHY3YEiv4ZpjZtAZqQHbPgYg4GvzxMvXbfUTBy2zMewqP8OnoD7lMoS/g==
X-Received: by 2002:a17:902:e944:b0:189:d8fb:1523 with SMTP id b4-20020a170902e94400b00189d8fb1523mr20739209pll.36.1672022097563;
        Sun, 25 Dec 2022 18:34:57 -0800 (PST)
Received: from [172.17.0.2] ([13.64.13.81])
        by smtp.gmail.com with ESMTPSA id p1-20020a170902e74100b00189b2b8dbedsm5875856plf.228.2022.12.25.18.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 18:34:57 -0800 (PST)
Message-ID: <63a90851.170a0220.af62e.b7b3@mx.google.com>
Date:   Sun, 25 Dec 2022 18:34:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8798388062068114775=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [DNM,v5] Bluetooth: doc: test patch - DO NOT MERGE
In-Reply-To: <20221226005532.119835-1-hj.tedd.an@gmail.com>
References: <20221226005532.119835-1-hj.tedd.an@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8798388062068114775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=706940

---Test result---

Test Summary:
CheckPatch                    PASS      0.86 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      42.20 seconds
CheckAllWarning               PASS      45.98 seconds
CheckSparse                   PASS      50.87 seconds
BuildKernel32                 PASS      39.72 seconds
TestRunnerSetup               PASS      566.74 seconds
TestRunner_l2cap-tester       PASS      19.82 seconds
TestRunner_iso-tester         PASS      21.81 seconds
TestRunner_bnep-tester        PASS      7.17 seconds
TestRunner_mgmt-tester        PASS      136.38 seconds
TestRunner_rfcomm-tester      PASS      11.21 seconds
TestRunner_sco-tester         PASS      10.38 seconds
TestRunner_ioctl-tester       PASS      12.38 seconds
TestRunner_mesh-tester        PASS      9.09 seconds
TestRunner_smp-tester         PASS      10.17 seconds
TestRunner_userchan-tester    PASS      7.61 seconds
IncrementalBuild              PASS      38.45 seconds



---
Regards,
Linux Bluetooth


--===============8798388062068114775==--

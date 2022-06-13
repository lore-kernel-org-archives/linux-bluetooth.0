Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CE0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jun 2022 23:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbiFMXEJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jun 2022 19:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiFMXEJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jun 2022 19:04:09 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4403631502
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 16:04:08 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gd1so6971336pjb.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 16:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=pwj/JSXOmZFr6N9sGZZvgEIFR39igWIQ706TxsdZj6o=;
        b=YPRYFGgIf3UbEdUe96NK1Uj0bm6bQ5vg3KYXTXSJDlNGce58DaMdgELicBYOq8ly4/
         H/IrpcVV/eayJ8HRrpmIWVbvoUy0FJ41239mp7CMXmmkon1QKtsCociFT5+bNIdUCagP
         hDPTIU/m99D7cvCPzGBOGVUt4d+xNQdGuoJduksZYh/pd0wf3/ENhzkRBU+QMlnFup73
         SH9boNlQtq+KyekVlYCeCNmr5dUQg6pkNupWqMyVNZeMmvIw0CV0mg6DCFM7UQsSl1zH
         i9hyTYusTZGlbIewUN7g0WaiCeHi+tHF9s7Ju+6fjghmCOtWPZbEkSvp5Fih6S9sDSao
         eUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=pwj/JSXOmZFr6N9sGZZvgEIFR39igWIQ706TxsdZj6o=;
        b=eJSO/tABYzLuE35cqTF217xN841Jov7hA3n81a8ZilymX2YzYybONJPkxk1oMkskNm
         2SDF0kOI6PUu2dAlMCgzXWHb9t9olijdvXrYdo4IMrifJjbVwvQdibcSQYGjUCGQr0wM
         DDM3N2QhO17hm1iuwQeC0rA+TSKecdVt7oH8G7vc/ywu48rImhRL9yHYnmxy7V6gX6Ha
         qGzBiMnblbmKFcOWvDyBjAYEQwUYj98xHh27PdDxkcSEkqF1z04WE4ZWNVSGdK5Tl6Wl
         hF9MesbKxA32U3ZL21Xd/xbHwKGjiu1yZrSkRywRaRApHhu6N7zm0/YWPQblkrO2LD86
         xxtw==
X-Gm-Message-State: AJIora/Lo1DZ62ULcUfdSopDdZSfU5TvATM/N3RIIRwhOICCbMV1yN0v
        UwOn5DJq6ZWrfUQzrpZihtZMvzkTWeQ=
X-Google-Smtp-Source: AGRyM1u37pASa/Gg4hG1zNWKOChxiU8NigiWSCtxgTVHJjeM0mZDy8H2RGhUBWJNZ9/Gguo3eq6zMw==
X-Received: by 2002:a17:90b:214b:b0:1e2:d777:934f with SMTP id kt11-20020a17090b214b00b001e2d777934fmr1104117pjb.193.1655161447469;
        Mon, 13 Jun 2022 16:04:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.245.141.221])
        by smtp.gmail.com with ESMTPSA id r8-20020a63b108000000b00404fd2138afsm6098510pgf.40.2022.06.13.16.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 16:04:07 -0700 (PDT)
Message-ID: <62a7c267.1c69fb81.47545.6fbd@mx.google.com>
Date:   Mon, 13 Jun 2022 16:04:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2612369225780395913=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiangzp@google.com
Subject: RE: Fix refresh cached connection info
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220613144322.kernel.v1.1.Ia621daca5b03278ee09314c59659b64c901408cf@changeid>
References: <20220613144322.kernel.v1.1.Ia621daca5b03278ee09314c59659b64c901408cf@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2612369225780395913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=649987

---Test result---

Test Summary:
CheckPatch                    PASS      0.86 seconds
GitLint                       PASS      0.46 seconds
SubjectPrefix                 PASS      0.30 seconds
BuildKernel                   PASS      38.53 seconds
BuildKernel32                 PASS      34.31 seconds
Incremental Build with patchesPASS      45.95 seconds
TestRunner: Setup             PASS      572.80 seconds
TestRunner: l2cap-tester      PASS      19.34 seconds
TestRunner: bnep-tester       PASS      6.96 seconds
TestRunner: mgmt-tester       PASS      116.57 seconds
TestRunner: rfcomm-tester     PASS      10.94 seconds
TestRunner: sco-tester        PASS      10.47 seconds
TestRunner: smp-tester        PASS      10.43 seconds
TestRunner: userchan-tester   PASS      7.09 seconds



---
Regards,
Linux Bluetooth


--===============2612369225780395913==--

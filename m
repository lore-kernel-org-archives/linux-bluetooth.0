Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C73C77B73
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Apr 2023 18:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjD3Sde (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 Apr 2023 14:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjD3Sdd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 Apr 2023 14:33:33 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BC7E5B
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Apr 2023 11:33:31 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-619ca08c166so4629126d6.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Apr 2023 11:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682879611; x=1685471611;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SsC30ePTSKpSLhzP2jnIZPuh09NUkFIYtg7U3jJBvzs=;
        b=B6NYCNOFkoJebz7RoBIqyNlOvNy3uwqXaz1oGcG8IlmmMk+Kj+aqpfwefhLZfDBjni
         ZZoJ0sGUwppL6ZZurzJpMByU6vyElFZdKn2L+ffuvRS5Iozn+KWe2nlmAQSc5fxW7TWa
         miOgIQrKK0cFLfPAvn9BFZguH49K6RwDmxLDN2I4v3eKkyD/qipX2cGtfqfp/++W/wEN
         QdLSylUukNXEhE5UXp1hjjx8CdOmB9M35A6JkV7PKzV734z0qmyRM5w+myASLLDbF9NU
         zJR6XJXouf8FTDf3o19iK8t8AaTYkLzuuTG75hkDaFDlLVuPA92iS4dra1IaoMrlEFZa
         xgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682879611; x=1685471611;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SsC30ePTSKpSLhzP2jnIZPuh09NUkFIYtg7U3jJBvzs=;
        b=KzGsPdMzF/c2B9yZp8y8yiGKEQeAxnLZys5nV/mQy9Og9v6rxMd+K6KqqiSFCNhxjH
         I2UNmu+FvbEfynsSDcL43J5/B+ejwYRyar+FwPo9rmoDPt5FaWMAogt+7TJ2x+71vsMo
         /urSzNyVn9zg2DLXKQOVlKtqiYSigeklSSQ+L1Uc+nGBQczaVsHJQTKZ10CkZULOhsrY
         GPAoT+pU+EZ6I3qJLLFwH9acHshbPGPDgsU1UGF2N+gHlYfyOihfsDaeBZT+tVJfFB4V
         Nt5y/hE4K+FMxgm0zCjJzFK3V81mLY+sFkXiCc6Sg1xcgtrCdD2jLhUrpqFUmGcZPMw2
         s69w==
X-Gm-Message-State: AC+VfDybTLGzlsSASXaMpNcsl9LBR22Q3sJWKRvVh+vpgxcP0/7+vT9O
        WW8s8Cc0V8RJ6iEumjxvngEYF/Kpyv8=
X-Google-Smtp-Source: ACHHUZ7zAR9VkBY27+rH6A/MTjxUMqxujHr+p6Jqpc+V0/uxsxfHigTFsO+LlXypAU/NPOkSkTrGmw==
X-Received: by 2002:ad4:5948:0:b0:616:5c8b:59d with SMTP id eo8-20020ad45948000000b006165c8b059dmr15876688qvb.20.1682879610715;
        Sun, 30 Apr 2023 11:33:30 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.120.55])
        by smtp.gmail.com with ESMTPSA id c7-20020a0cca07000000b005e90a67a687sm8019879qvk.65.2023.04.30.11.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 11:33:30 -0700 (PDT)
Message-ID: <644eb47a.0c0a0220.96c6b.e81e@mx.google.com>
Date:   Sun, 30 Apr 2023 11:33:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3212375016555370168=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, lrh2000@pku.edu.cn
Subject: RE: [v2] Bluetooth: Fix potential double free caused by hci_conn_unlink
In-Reply-To: <20230430180535.168270-1-lrh2000@pku.edu.cn>
References: <20230430180535.168270-1-lrh2000@pku.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3212375016555370168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=744077

---Test result---

Test Summary:
CheckPatch                    PASS      0.70 seconds
GitLint                       FAIL      0.56 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      31.08 seconds
CheckAllWarning               PASS      34.53 seconds
CheckSparse                   PASS      39.20 seconds
CheckSmatch                   PASS      109.45 seconds
BuildKernel32                 PASS      30.18 seconds
TestRunnerSetup               PASS      441.36 seconds
TestRunner_l2cap-tester       PASS      16.54 seconds
TestRunner_iso-tester         PASS      20.36 seconds
TestRunner_bnep-tester        PASS      5.30 seconds
TestRunner_mgmt-tester        PASS      111.39 seconds
TestRunner_rfcomm-tester      PASS      8.46 seconds
TestRunner_sco-tester         PASS      7.88 seconds
TestRunner_ioctl-tester       PASS      9.17 seconds
TestRunner_mesh-tester        PASS      6.77 seconds
TestRunner_smp-tester         PASS      7.77 seconds
TestRunner_userchan-tester    PASS      5.56 seconds
IncrementalBuild              PASS      28.59 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: Fix potential double free caused by hci_conn_unlink

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
15: B3 Line contains hard tab characters (\t): "	void hci_conn_del(struct hci_conn *conn)"
17: B1 Line exceeds max length (84>80): "	https://lore.kernel.org/linux-bluetooth/20230430171847.156825-1-lrh2000@pku.edu.cn/"
17: B3 Line contains hard tab characters (\t): "	https://lore.kernel.org/linux-bluetooth/20230430171847.156825-1-lrh2000@pku.edu.cn/"


---
Regards,
Linux Bluetooth


--===============3212375016555370168==--

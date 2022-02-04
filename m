Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE49C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Feb 2022 21:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243591AbiBDVzj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Feb 2022 16:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiBDVzj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Feb 2022 16:55:39 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A056C061714
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Feb 2022 13:55:38 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 71so5890969qkf.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Feb 2022 13:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=GdqFLn4N90fO2VIhXq/NF0o+9AjTvnHV+Ckx5rZ7kyI=;
        b=iPO3x3XBoZKLDFQboP27uH7yavXNy3ogryKq82uOAdTCcfQ5R23BTKQ3oPxtlm98oF
         25oDOLSGGTSbBBGf89M0kfMUmGiyx9PUoIuc3ta7IfpxSU8Fem57p01rppJzW/oKhLjU
         zhUuDDLJd5mN3O9bKhdabCrEpyfIUDPzmOJR7xSpmna+p8wy3p9R1Ge8VAUnjj+r210F
         HjXZcClqP/cGRqf/R7stmrzxz47jDLuze1XXqGG/Q5CW6u3GOXcBYaWrIB/cCvMdYIpM
         AijiS17IgA1jHfuRsDq8RuU4LykZdGN3P43O9EVXWgQLyRFmgyc310kO+oOTtng8Awiu
         giYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=GdqFLn4N90fO2VIhXq/NF0o+9AjTvnHV+Ckx5rZ7kyI=;
        b=ITHxvp1+fbYl6k9/iicPVyKgwYL0oInnFUdGPhyF82KzWpQLJc9y2NAYWspEbhHCYz
         nFOxku7cEIbITcLTMoAMprq2xAKb45Bz6dG5FboosCBp37udGOxdqzJuHMcMrup7Ga2J
         /8F8+3mzWaR+Gr84Ko/0VknCAFyEGT4ftyQEIYOGTJSUnE3MAGCOawD37Q/dQg6vUtzc
         uDbxfG1EPNCKjCJwhO81QJFkysD4nBFxxNz23DmaXDwACkEbGuD3wR9cK7Ox9NYlqdDT
         t2o2+2rgVdtdGP9h+YkcEVGs2wgzFfc9hp8wPRdc2/kmyh27/Jyjzpknn/d5ZfgPNvxE
         SGAQ==
X-Gm-Message-State: AOAM531bh56QIhpfnpj6lYPfVp39hGZBaK7kw6Px0Ob5UMFwwd+88UCO
        bDP8oQROCVxllw+st68Gctt2vvK/qieHuA==
X-Google-Smtp-Source: ABdhPJwNyXLqtwYejsC9nLgLuGdLB2DhqPF8DYose2V7ahADQRXrCLssRkiHow4Tg7HuLSAkrlW2ww==
X-Received: by 2002:ae9:e202:: with SMTP id c2mr661293qkc.103.1644011737608;
        Fri, 04 Feb 2022 13:55:37 -0800 (PST)
Received: from [172.17.0.2] ([40.65.222.231])
        by smtp.gmail.com with ESMTPSA id y15sm1744773qkp.22.2022.02.04.13.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 13:55:37 -0800 (PST)
Message-ID: <61fda0d9.1c69fb81.748ee.a550@mx.google.com>
Date:   Fri, 04 Feb 2022 13:55:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7877257709267742767=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_core: Fix leaking sent_cmd skb
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220204211236.2690926-1-luiz.dentz@gmail.com>
References: <20220204211236.2690926-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7877257709267742767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=611428

---Test result---

Test Summary:
CheckPatch                    PASS      1.53 seconds
GitLint                       PASS      1.01 seconds
SubjectPrefix                 PASS      0.91 seconds
BuildKernel                   PASS      30.69 seconds
BuildKernel32                 PASS      27.09 seconds
Incremental Build with patchesPASS      37.23 seconds
TestRunner: Setup             PASS      478.07 seconds
TestRunner: l2cap-tester      PASS      13.54 seconds
TestRunner: bnep-tester       PASS      6.13 seconds
TestRunner: mgmt-tester       PASS      105.48 seconds
TestRunner: rfcomm-tester     PASS      7.53 seconds
TestRunner: sco-tester        PASS      7.78 seconds
TestRunner: smp-tester        PASS      7.66 seconds
TestRunner: userchan-tester   PASS      6.39 seconds



---
Regards,
Linux Bluetooth


--===============7877257709267742767==--

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35771C41513
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Aug 2023 19:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjHNTj4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Aug 2023 15:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjHNTjh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Aug 2023 15:39:37 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62A110E5
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Aug 2023 12:39:36 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bba48b0bd2so31021165ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Aug 2023 12:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692041976; x=1692646776;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I24dcZ98sIcCcF+GBiZZ7KIFAaGibCxRTLVPU0yePxs=;
        b=ll/30/gRMijnnnSwAidEzVL9LmZedN5vEUBlSS8H1jOZS8+hs2kCPe7SUpEl+nVt6w
         kh6km+bH47QWNoifuW4DpH9nLeqMXQDO+zdWLFOV6CVvY8BnklYiyFqmAmp2XSvywPQk
         /LpJjvlV2Wr3jsw17VWC7KUxWVKer97XJRXMLKd9BlngIzNB3aylcTOjwyNn4WTWylRQ
         HMcIEAJJKucAGxp2D6JybXVixHSWXTvRNPeg7Z7Jphagbp1c8M/kciT9sjYK9Li8H5oC
         DtjiUvwYfIwcCzgTEE+Oqro361OXRBLpu06b2O0+3ANaZYdJg7sraj1Ha2ipUsv/6v5G
         uKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692041976; x=1692646776;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I24dcZ98sIcCcF+GBiZZ7KIFAaGibCxRTLVPU0yePxs=;
        b=UO5BYCIGIyInb03T22qdIcqevlDEpAg8/dfVHH4BI+SDaGxgqjDw/sjXuignVrkBUP
         FJf5ckDCfBW/5yjzgMAvyUu43/mwHevv1/bY0IiX7Ga3k2f8qq/lB6W4rk0/debYOgAd
         EHwR2wUoMczMJe+IqjMmkZR70Z5p8jaOzXz7EbgWxW0FRtdPoBc9ImuFGTpc+Sj+rADu
         Dt2DS0MWX3F6v7lduuyFzvACotMj0uAbOTxMAyUjgbSC8nRoIBBALxcgQM3s9YcNovIw
         EhcpGYH8dtdyeFuUgOFnUbCUi8bUxRmgKUXfI/3IFRuO35BCKixWc1sugQgAVitEFUQ6
         d7VA==
X-Gm-Message-State: AOJu0YyoNtsw2zhRpj7kgd9vXTHXBDg4PNgCwu4JtNJcZJQX9NcIWI4e
        M5N8P0qwAb59hNaufmyduBXtSl7LSng=
X-Google-Smtp-Source: AGHT+IGyohySXfVaJoPUKBY5P9gkuYq2ugbNt2WVtuN8fPjOKCMHNCDwJowZGNaJ3jswxin53j9SnA==
X-Received: by 2002:a17:902:ef89:b0:1bd:e877:a7bc with SMTP id iz9-20020a170902ef8900b001bde877a7bcmr2489613plb.7.1692041975817;
        Mon, 14 Aug 2023 12:39:35 -0700 (PDT)
Received: from [172.17.0.2] ([138.91.87.24])
        by smtp.gmail.com with ESMTPSA id u15-20020a170902e5cf00b001adf6b21c77sm9827420plf.107.2023.08.14.12.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 12:39:35 -0700 (PDT)
Message-ID: <64da82f7.170a0220.5b1d3.1870@mx.google.com>
Date:   Mon, 14 Aug 2023 12:39:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0184157531688226245=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v4] Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync
In-Reply-To: <20230814190101.2302448-1-luiz.dentz@gmail.com>
References: <20230814190101.2302448-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0184157531688226245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=776076

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      39.94 seconds
CheckAllWarning               PASS      44.49 seconds
CheckSparse                   PASS      49.60 seconds
CheckSmatch                   PASS      133.89 seconds
BuildKernel32                 PASS      38.64 seconds
TestRunnerSetup               PASS      586.21 seconds
TestRunner_l2cap-tester       PASS      33.98 seconds
TestRunner_iso-tester         PASS      71.24 seconds
TestRunner_bnep-tester        PASS      14.05 seconds
TestRunner_mgmt-tester        PASS      257.41 seconds
TestRunner_rfcomm-tester      PASS      20.04 seconds
TestRunner_sco-tester         PASS      23.36 seconds
TestRunner_ioctl-tester       PASS      22.60 seconds
TestRunner_mesh-tester        PASS      16.84 seconds
TestRunner_smp-tester         PASS      17.99 seconds
TestRunner_userchan-tester    PASS      14.07 seconds
IncrementalBuild              PASS      36.02 seconds



---
Regards,
Linux Bluetooth


--===============0184157531688226245==--

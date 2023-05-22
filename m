Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9EAC77B73
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 May 2023 15:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbjEVPc4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 May 2023 11:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjEVPcz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 May 2023 11:32:55 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2540DAA
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 May 2023 08:32:55 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-75b1219506fso59967485a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 May 2023 08:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684769574; x=1687361574;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V++lWvmZeKSCvvN3KEpfaVcN3n1p/u3T0naCNwr1+oM=;
        b=kDljaHQJBtt4YzEmOK7E4BO1IOcxh+QKgV8Lo21qdSdxkuM2kwImN5W3D+gtUhxQ3/
         +Yeikk8A+BgDzdHZBx494XCrRbitX1ZUhrc0q7ziZ3CzjuzxcY2/+iUdQgGMhftgYvbV
         qJ9MssMDomjmcUEIYsP3IX1Iclg6pKAuq8j6r5THpsjCUfUb7CRydvN2dA59wHYZfpdL
         YjCMGVIc2HuR1PMABteN5Fc50OtKgfSJER1q7hSDpn1UJ107T1uP3whmlXSubLpTdads
         9ToJuXNF/IrjF1JnicztfDS8/+mzjNk/QDgjgVzlS+5fktitziPVk0O1IC+7vLOYYOcd
         D2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684769574; x=1687361574;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V++lWvmZeKSCvvN3KEpfaVcN3n1p/u3T0naCNwr1+oM=;
        b=jpSlHoweyQj6TaFcvRWv5NOqqT8A4CVRKCmDpypO+y0AWUHkYQiPrM7QvPywdWz0eh
         aYay+zBRe5kJEBLq2MgkSi5lL98SBziqKjU0qpxAF3reN4RSa/Q6tckNYq6UDAgbzl+q
         CJ53xY6ZVT4/q3mpTRxrRhtuksTdqugd6nPRqJLHL5a+DcTqA2zL+6CiQ++dW9riU61K
         izKWjwT0juDL7xvNu+WC/2Y0emdkOv/8KYLJKpLSEk3f38RoSbnjVQVCHpPkye7lwZmM
         L6+u0cTX3zgy36NfpcPup+zdHkzroDnJzSwDz2PYCgTuIv1/EN182UMWmV8SLxCGXM4M
         VNFQ==
X-Gm-Message-State: AC+VfDwpPllNhlCwhqkelg10jHMnpTzPdhJXYOeZFhRcZxgZAiD6cZQN
        s1xcpp3fS8T4DG2ch5QNe4JxhmhMuXE=
X-Google-Smtp-Source: ACHHUZ7Ajl7MH2ACJOdLqbTag5OkK49avwRdPfkEfTb5ivjDu1+cwOCbfg+V/ZGftTV6A/C8btcsBw==
X-Received: by 2002:a05:620a:210f:b0:75b:23a1:8e5f with SMTP id l15-20020a05620a210f00b0075b23a18e5fmr1125723qkl.48.1684769573991;
        Mon, 22 May 2023 08:32:53 -0700 (PDT)
Received: from [172.17.0.2] ([52.184.138.35])
        by smtp.gmail.com with ESMTPSA id v18-20020a05620a123200b007590aa4b115sm1766312qkj.87.2023.05.22.08.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 08:32:53 -0700 (PDT)
Message-ID: <646b8b25.050a0220.31a5f.587d@mx.google.com>
Date:   Mon, 22 May 2023 08:32:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0981270425321449678=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yinghsu@chromium.org
Subject: RE: Fix l2cap_disconnect_req deadlock
In-Reply-To: <20230522143759.2880743-1-yinghsu@chromium.org>
References: <20230522143759.2880743-1-yinghsu@chromium.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0981270425321449678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=749808

---Test result---

Test Summary:
CheckPatch                    PASS      0.72 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 FAIL      0.36 seconds
BuildKernel                   PASS      32.39 seconds
CheckAllWarning               PASS      35.19 seconds
CheckSparse                   PASS      39.93 seconds
CheckSmatch                   PASS      111.87 seconds
BuildKernel32                 PASS      31.14 seconds
TestRunnerSetup               PASS      445.89 seconds
TestRunner_l2cap-tester       PASS      16.84 seconds
TestRunner_iso-tester         PASS      20.34 seconds
TestRunner_bnep-tester        PASS      5.39 seconds
TestRunner_mgmt-tester        PASS      111.90 seconds
TestRunner_rfcomm-tester      PASS      8.62 seconds
TestRunner_sco-tester         PASS      8.10 seconds
TestRunner_ioctl-tester       PASS      9.24 seconds
TestRunner_mesh-tester        PASS      6.83 seconds
TestRunner_smp-tester         PASS      7.85 seconds
TestRunner_userchan-tester    PASS      5.62 seconds
IncrementalBuild              PASS      29.53 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============0981270425321449678==--

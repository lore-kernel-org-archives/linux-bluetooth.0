Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33D3C76196
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Apr 2023 18:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjDGSfG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Apr 2023 14:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjDGSfF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Apr 2023 14:35:05 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52797BB98
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Apr 2023 11:34:45 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id ly9so3074305qvb.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Apr 2023 11:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680892482; x=1683484482;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jfNBAlm1kU01/HrJ2tbIEprpTIgLazb4JQl8sdcHS7E=;
        b=X26i7+lCUfpl/v5EsOFMiz3eD0uTxwJ/FpSnct1WQUgnbXRMIWGGSp2DP34A7f36up
         XNL81ISPwmoe/MHMx6wE4iQiyIjdOtWTHE1tpITAeo4pdEq65zeTkzlLAsTIKBEW7RDU
         FxLQrvZKwgDy2VeCMLqMvFWhasc5bbJWBl6+hVioXNB8ckEbB1DhPBPDZqloeDTj9I4v
         m6ZtzNK1QV16rouK2PNX5L0HdY5uQxkF+0Ebat6YwaALbB/YPKcajlmUT1iC+WEG9Ba6
         jL97Pu+N26PKdjF7z8we9u1tgRUa+liCS7gOD0h4TtACg6OWaTIxuaYwQyuVEFmRAaf3
         ecFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680892482; x=1683484482;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jfNBAlm1kU01/HrJ2tbIEprpTIgLazb4JQl8sdcHS7E=;
        b=dyLr++8bKsSUrhMkcHf6p3scLGIdI0cvNAIRIpxdXlgMH2Ko/MiZvltQ/8qskuoODZ
         V7kX4gvRBxrKRM8BLil+MOkCkQ1swc2beRyNUYzasLMU9obn9xx6OdkEviznB7ck3kIR
         CWJO/AK9+Q0YHL3u/6ENivsth1QUKzSmWzlDeBKz2+DXRunMmmso+Kvc/c39HGf8rL/6
         adlTvWeM+QZ7sNi82qO0EhRMGqLDPBvOXlrDdmZ84JaNc4ihLwZAJSXGNjxNZcAC3GAk
         FiemKNh9s4v1WxORBgmlDcPCJgGqYIN9qlvn7ZvpOVUJjFhP9g8egV+8gDaZ+zB9p1Y+
         iIBA==
X-Gm-Message-State: AAQBX9e31Iv6HtGNt3ONGNZjXCWhzF9ZbiesrJA+7ozwhs9MWIWWYSDO
        Xhx9om6vzmxi6enJ+Iut7v1nsnEqyUk=
X-Google-Smtp-Source: AKy350ZZj1fp/6J4m1aLn55gOhks9wjFP1SSnj5RdPT176p9IudcxP+yGq31KS3KB7JBvel4hwBo8A==
X-Received: by 2002:a05:6214:cc2:b0:5e8:63ae:a9a9 with SMTP id 2-20020a0562140cc200b005e863aea9a9mr4976622qvx.47.1680892482728;
        Fri, 07 Apr 2023 11:34:42 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.96.45])
        by smtp.gmail.com with ESMTPSA id t9-20020a37ea09000000b006fcb77f3bd6sm1466630qkj.98.2023.04.07.11.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 11:34:42 -0700 (PDT)
Message-ID: <64306242.370a0220.6d06e.66ff@mx.google.com>
Date:   Fri, 07 Apr 2023 11:34:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5344620318833476369=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: L2CAP: Fix use-after-free in l2cap_disconnect_{req,rsp}
In-Reply-To: <20230407180201.3229763-1-luiz.dentz@gmail.com>
References: <20230407180201.3229763-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5344620318833476369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=738043

---Test result---

Test Summary:
CheckPatch                    PASS      0.70 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      32.03 seconds
CheckAllWarning               PASS      35.10 seconds
CheckSparse                   PASS      40.39 seconds
CheckSmatch                   PASS      108.24 seconds
BuildKernel32                 PASS      31.21 seconds
TestRunnerSetup               PASS      445.76 seconds
TestRunner_l2cap-tester       PASS      16.46 seconds
TestRunner_iso-tester         PASS      16.15 seconds
TestRunner_bnep-tester        PASS      5.35 seconds
TestRunner_mgmt-tester        FAIL      113.09 seconds
TestRunner_rfcomm-tester      PASS      8.48 seconds
TestRunner_sco-tester         PASS      7.78 seconds
TestRunner_ioctl-tester       PASS      9.09 seconds
TestRunner_mesh-tester        PASS      6.64 seconds
TestRunner_smp-tester         PASS      7.67 seconds
TestRunner_userchan-tester    PASS      5.58 seconds
IncrementalBuild              PASS      29.77 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 494 (99.4%), Failed: 3, Not Run: 0

Failed Test Cases
Get PHY Success                                      Failed       0.127 seconds
Set PHY 1m 2m coded Succcess                         Timed out    2.070 seconds
Start Discovery LE - (Ext Scan Param)                Failed       0.121 seconds


---
Regards,
Linux Bluetooth


--===============5344620318833476369==--

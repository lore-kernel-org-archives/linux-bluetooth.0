Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21F4C77B7D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 May 2023 12:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbjEJMlG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 May 2023 08:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235768AbjEJMlG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 May 2023 08:41:06 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CB9114
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 May 2023 05:41:05 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3f39fd9eea1so8239241cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 May 2023 05:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683722464; x=1686314464;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gPiqQBNFbRm3TOll8DFtZV6HywvTxe7WITdyDrzP7VI=;
        b=QWuUGO7aX/iu59Y+4Vun8QHde+6lx6FqP7s1RgH0EyO3leUCiwCZ1kbMit8nVMWCNM
         a8DZ9P9nlxfx8x3uwXfLZWLIffBMfYN+5s6zvIl8ZZAmXjz3QYdxnPfTwhfVtZwR86cb
         oudsieyf4nLCMu2iRLfWcOkhZ7BVe6sQD+CB0vvwPDvBHTTrWlJof1gMChYz4md4nJgr
         RzN28PMtTcSkf9PopPW08uKWUdGjaBMo4/RXnx6EhSbL+8ehVoaFesnc2XzAN/oVeLzx
         8pFkmccTH3SagGuJ2s4dtqhckEo+EnWjgZpw/tn6SG8GeU49NZqK2Z58c6OtUmcBizGS
         6Tdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683722464; x=1686314464;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gPiqQBNFbRm3TOll8DFtZV6HywvTxe7WITdyDrzP7VI=;
        b=Zkmx1tes4xL33xBKAEpFHX5ltB9uOx0zQiWO2ugQtqf2WsCLZHRnTiXyuckShBptvs
         IARjJt1ifjOKGqDpV041bgtBT85v2XZ3d1KmxO+vKQAF62pJ5iWeRKC/hFnGJ+oNLT5T
         vhfxKw6Fc6sQGkwjyy4WnJDOLphjxUDf834IXTh0a2BaJgA3yZw3TpVBl6P3E1k7emAh
         1CkOXk1I8m9RZ6MmZKLK7WCuaAOInl29JmbHG0j83uG3wdbRBqX08fbZiioN6Nwv5eOj
         rIoebnN59zl0acuhFDvEho3h5qN62zRTyUNMWNLe8Vbi7flaGGbS0Z7IFkbIU5c07ULt
         HxWQ==
X-Gm-Message-State: AC+VfDwnw0ORPHoVohrPYeuBRVDo3AWzqGPw0rE75XWycNBDRtvGP+og
        D4Es3PHKk4wpv5cPG2h3WIwVUXwvX6g=
X-Google-Smtp-Source: ACHHUZ6Jh/jkDMb2VXKb9CKwuMQGEvyu9FzGTmqH9QjXD3a/c0O022j5o+K4e8GR3f3eLP2NN7ifTA==
X-Received: by 2002:ac8:7d4f:0:b0:3f3:9502:6152 with SMTP id h15-20020ac87d4f000000b003f395026152mr12099550qtb.49.1683722464158;
        Wed, 10 May 2023 05:41:04 -0700 (PDT)
Received: from [172.17.0.2] ([52.226.113.42])
        by smtp.gmail.com with ESMTPSA id w12-20020ae9e50c000000b0074d4cf8f9fcsm883878qkf.107.2023.05.10.05.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 05:41:03 -0700 (PDT)
Message-ID: <645b90df.e90a0220.17a93.5317@mx.google.com>
Date:   Wed, 10 May 2023 05:41:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8782888120808140058=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com
Subject: RE: Check for ISO support in controller
In-Reply-To: <20230510120843.10336-2-claudia.rosu@nxp.com>
References: <20230510120843.10336-2-claudia.rosu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8782888120808140058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=746414

---Test result---

Test Summary:
CheckPatch                    PASS      1.21 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 FAIL      0.39 seconds
BuildKernel                   PASS      31.86 seconds
CheckAllWarning               PASS      34.87 seconds
CheckSparse                   PASS      39.73 seconds
CheckSmatch                   PASS      108.64 seconds
BuildKernel32                 PASS      30.93 seconds
TestRunnerSetup               PASS      444.36 seconds
TestRunner_l2cap-tester       PASS      17.22 seconds
TestRunner_iso-tester         PASS      21.41 seconds
TestRunner_bnep-tester        PASS      5.66 seconds
TestRunner_mgmt-tester        PASS      116.60 seconds
TestRunner_rfcomm-tester      PASS      9.05 seconds
TestRunner_sco-tester         PASS      8.42 seconds
TestRunner_ioctl-tester       PASS      9.72 seconds
TestRunner_mesh-tester        PASS      7.12 seconds
TestRunner_smp-tester         PASS      8.35 seconds
TestRunner_userchan-tester    PASS      5.93 seconds
IncrementalBuild              PASS      29.12 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============8782888120808140058==--

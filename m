Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18683C7619A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Apr 2023 23:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjDKX6C (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Apr 2023 19:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDKX57 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Apr 2023 19:57:59 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455D840CA
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Apr 2023 16:57:58 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id lz6so6635132qvb.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Apr 2023 16:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681257476; x=1683849476;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=laiY7kwAt6m46H9pkEHsgYnF/1H/UgWUvqP1Vp/KhJ0=;
        b=T+MmjpMrvwOEeJLwHs6g/xI6K7j2o1PHmwLj63eSiw3t623IqU6QdOc8SaU2nf4T7P
         oB65INAR9rlgpI3dHRXyS7E38WKccEIjsS+/EJ1UajU2Yf8KSmd7AGbXTVRkcy9nZrCB
         CgaC6fWqAwbttCG7AkgCbfsMQJSiRwprkRBQW6g4StOpk6fFKwCLHJXeo5zBSn5wUmNr
         v2dvoEITjGub6O2QMcoa+wmHZ46QznGT/Hcle3DPugdVe4Bg5XgIAoP6AiWFHL8uyNDu
         tdJAtzunwa2s6vRjEhfM5gOf99K+RM4tNVdZPirZvVTxXuY/AoO0SlQmahiGWO5/qSRu
         D0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681257476; x=1683849476;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=laiY7kwAt6m46H9pkEHsgYnF/1H/UgWUvqP1Vp/KhJ0=;
        b=ieS8KUaELow7A1qGZxsODOsGiiYMB8gETLrFSQKuPvMXa4SM7jjs7BW7gUL/OinZkb
         qEgCOfhQ0kD5QPtHJJbPuEbrpTjmm623FktQlURld72MkxKoRpbQh0NDEovyaL6y4ZFl
         tFey9i4HxIXEsxdob/fxp/sV4xECgjMiM+sOALd9HSnWxb7ZCHNBSpX48WEKRu647Ln8
         HE0hk0kZONlgjhnvYaK5Ypax4LRPMidR4pIRqxpyjRmXxB/k1sspoF6i1dEtfATVJXp1
         2Rxf0yJkBISUk+OTfSAbQAzkOC43J4L+thDEmrqNznt3cjljGGh8HltbOmEBl2vuuif3
         XrWg==
X-Gm-Message-State: AAQBX9dOto6I13upriOG7l02CDRsXQA414UnAt0ZM5ovlOMh00fGiP2A
        bMO4JUF23Y/tbXJH/ivOzp4oryiVJYM=
X-Google-Smtp-Source: AKy350Yy0fMHztf7bOnt47SstRpakPI5hiCEy9O+tz0iTpljDry9KbVUXJg5SikOQ5JskJGptIZvKw==
X-Received: by 2002:ad4:5b89:0:b0:5df:5533:6fb3 with SMTP id 9-20020ad45b89000000b005df55336fb3mr20706004qvp.5.1681257476230;
        Tue, 11 Apr 2023 16:57:56 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.106.97])
        by smtp.gmail.com with ESMTPSA id m16-20020ad44a10000000b005dd8b9345a5sm4427369qvz.61.2023.04.11.16.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 16:57:56 -0700 (PDT)
Message-ID: <6435f404.d40a0220.f0a28.2597@mx.google.com>
Date:   Tue, 11 Apr 2023 16:57:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6380755875825366475=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC,1/2] Bluetooth: hci_conn: Add support for linking multiple hcon
In-Reply-To: <20230411231925.361066-1-luiz.dentz@gmail.com>
References: <20230411231925.361066-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6380755875825366475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=738959

---Test result---

Test Summary:
CheckPatch                    PASS      2.26 seconds
GitLint                       PASS      0.67 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      32.17 seconds
CheckAllWarning               PASS      35.04 seconds
CheckSparse                   WARNING   40.29 seconds
CheckSmatch                   WARNING   109.16 seconds
BuildKernel32                 PASS      31.14 seconds
TestRunnerSetup               PASS      448.37 seconds
TestRunner_l2cap-tester       PASS      17.18 seconds
TestRunner_iso-tester         PASS      17.80 seconds
TestRunner_bnep-tester        PASS      5.70 seconds
TestRunner_mgmt-tester        PASS      116.43 seconds
TestRunner_rfcomm-tester      PASS      8.92 seconds
TestRunner_sco-tester         PASS      8.20 seconds
TestRunner_ioctl-tester       PASS      9.61 seconds
TestRunner_mesh-tester        PASS      7.00 seconds
TestRunner_smp-tester         PASS      8.05 seconds
TestRunner_userchan-tester    PASS      5.84 seconds
IncrementalBuild              PASS      55.98 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============6380755875825366475==--

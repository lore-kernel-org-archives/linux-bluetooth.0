Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EF6EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Jun 2023 15:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjFSPgR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Jun 2023 11:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjFSPgQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Jun 2023 11:36:16 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2576C9
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jun 2023 08:36:15 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-55e1a9ff9d4so1763894eaf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jun 2023 08:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687188974; x=1689780974;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2w+WpT5EbZgU7kwhh5rKRJFXBsOKLHqbbBgCv2KCBms=;
        b=Mw8qaILnHEYgNYiPPrpTDueULLii/vANizMSBW+fDIvCF70gUW1QKf1T11kUD1IRWk
         hOv1dtlAc986aJ7iDmibWIGGhf87lzR7HJAsDYS/1xBRUOfrbTWVEVljIk3ja0+hwJb/
         B1eDjFBHiJUPDdW9RYVXWyWLB8i+E9jPVsfgwIXtDvxW5QWcGQEIapC/ACfPiIxUSlQH
         2457xZOeu+fhslcgUGagYLqdLWCQxfGEfDL3Iprgh+DT37H06HH8uZazEScDYlABuHWw
         FAAuzKDGZBUT7QdQNowQuiAzMdrmMXjI5VmM7YRQzhoeVh6FKp8nJ48FahoUrONmm6+i
         z3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687188974; x=1689780974;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2w+WpT5EbZgU7kwhh5rKRJFXBsOKLHqbbBgCv2KCBms=;
        b=lDgcJoXn/M4zxNhTDJwiyhJz32m7ry5FZKkCDUl3pG9OY4XHD+CzSkrGiQ0Ry4/W3T
         tCEeYPFpXYXTccrc7Di9i6OM7q2dfVqt5ffPEp5buWDg7JaUb2o2C7qV6QKhCMQBDUyl
         uaj1un93jfQq5gTkhzatFqo5aJzCHeYhRXElSAtzJBai1LnpUeLPR17NNyCiVStJTXz5
         6nroNcax05tSQnrHJnYM71ByqDWAVI0vO1/Og8taXwNJUNU6uUoD3cU1JJvexjYoSBAX
         AQT6dPPCQKnqX9FM/flyw7H9a2GtDOFoTe0brOvKDSQz+FaCSq2PYlJHeAxQG5uO+vY8
         JlQw==
X-Gm-Message-State: AC+VfDz16YvQb9L5FyG8VI078G+BEBlplYVtsMRk67JVgoQkCzgNhUy3
        yIl7MYNgLRfWp5SScPPqCWBasFQjhT4=
X-Google-Smtp-Source: ACHHUZ46xZJoETcMu5SiiX8jpBizxFKh20/UJVR46NMBHUVeOj6UCTjN2yP6OQKtvMCRErX/eyvl0w==
X-Received: by 2002:a05:6808:1787:b0:3a0:33a1:58db with SMTP id bg7-20020a056808178700b003a033a158dbmr550358oib.23.1687188972645;
        Mon, 19 Jun 2023 08:36:12 -0700 (PDT)
Received: from [172.17.0.2] ([70.37.167.48])
        by smtp.gmail.com with ESMTPSA id bx8-20020a0568081b0800b0039ecef77873sm66570oib.32.2023.06.19.08.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 08:36:10 -0700 (PDT)
Message-ID: <649075ea.050a0220.6a1be.061a@mx.google.com>
Date:   Mon, 19 Jun 2023 08:36:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0551492956909063905=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Support multiple BIGs
In-Reply-To: <20230619145316.3185-2-iulia.tanasescu@nxp.com>
References: <20230619145316.3185-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0551492956909063905==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=758407

---Test result---

Test Summary:
CheckPatch                    PASS      1.38 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      38.08 seconds
CheckAllWarning               PASS      41.61 seconds
CheckSparse                   WARNING   47.49 seconds
CheckSmatch                   WARNING   128.83 seconds
BuildKernel32                 PASS      36.09 seconds
TestRunnerSetup               PASS      526.77 seconds
TestRunner_l2cap-tester       PASS      18.75 seconds
TestRunner_iso-tester         PASS      27.75 seconds
TestRunner_bnep-tester        PASS      6.92 seconds
TestRunner_mgmt-tester        PASS      127.10 seconds
TestRunner_rfcomm-tester      PASS      10.27 seconds
TestRunner_sco-tester         PASS      9.31 seconds
TestRunner_ioctl-tester       PASS      10.88 seconds
TestRunner_mesh-tester        PASS      8.25 seconds
TestRunner_smp-tester         PASS      9.50 seconds
TestRunner_userchan-tester    PASS      7.09 seconds
IncrementalBuild              PASS      33.93 seconds

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


--===============0551492956909063905==--

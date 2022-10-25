Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC3FC38A2D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Oct 2022 22:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbiJYWKX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Oct 2022 18:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbiJYWKJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Oct 2022 18:10:09 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F692CE18
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Oct 2022 15:10:08 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id j21so9223884qkk.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Oct 2022 15:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qS+nBf+2rLkMA5kMswYev6j9Ri0V1BZambcewh32pYk=;
        b=M5cjsJ6UTuJ3uytEQdZ1M+pM8Z8o3Kl11ZxJgfVm0FLGsuuUJEtuFjSzVo0jo+QlEo
         EEZfxymVC47UGOF8LLQRdgNqPlk98zS+IyRDJBX4pHiSASbpTEA2KUEkt9XJbrbnpfRo
         r1UYc8XD6ADJBLjHU4ixHKa1YfBU+Lnt6icCydvWEfty+hvS7lXBEXc67JtlF1noW1+A
         JFv2MFC0Q6A24NfIyT11CEiuZLP3EP8/DWBOaOUjcHHgrWdbQEbSNj30jn26HZhsmKUP
         0i1NOZJA4Sj0jxq4lDKp3RkYZ4hTWUz4uysx8n8Xqaq/9FI2SLJUctp51+MCaYXGuHyn
         WCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qS+nBf+2rLkMA5kMswYev6j9Ri0V1BZambcewh32pYk=;
        b=XrSlOyhnqEwkfKnzuQ4jEi4cQtlNViQqlULbjTCO9vSR4LQFWKOpKvfdzlU0StQSSz
         e0XXnPHfNo0MNv8eiFqXn3ZUVmeJQM6Feyvrp1CnmfZsL0VtBAaLC91rYrj2Rc8qXWHN
         zv/6q0YuD9bgLUY9R+GKqpZRCmHSc/jihOAAahYcg8EHtxCoy4JH+SUVY5V2zEwGrFhv
         C31Up3ZdzKJmXGXtMeM6CPuRT9iiEmlXld2m75lspQcFsUmu0dWJMMPijZgOqLSQV1oB
         yyJn/mkGPnn+VltZHFAmyqAzP34NTmrtlTIOdM/O74xbxjB3xi6CLC9qK/Y8XdNRP9Z4
         p7CA==
X-Gm-Message-State: ACrzQf2N777wJDW2qcy39ZwHUF1U4gv6vI5P9APWpWyV9MvYmfcH1Usg
        p7Pgjj+8iQC/AxW0Dn3RXSpMSWc28TGiPQ==
X-Google-Smtp-Source: AMsMyM756aSnQazsFzCyBiTdLRCbxbZH7J330JB9w4NBgwrApD8nnB1m555IY2NrkYJbJgbRapDveg==
X-Received: by 2002:a37:bd47:0:b0:6e1:be21:e6e1 with SMTP id n68-20020a37bd47000000b006e1be21e6e1mr28112172qkf.473.1666735807728;
        Tue, 25 Oct 2022 15:10:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.7.183.50])
        by smtp.gmail.com with ESMTPSA id ci25-20020a05622a261900b00397b1c60780sm2173780qtb.61.2022.10.25.15.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:10:07 -0700 (PDT)
Message-ID: <63585ebf.050a0220.bfd96.7c23@mx.google.com>
Date:   Tue, 25 Oct 2022 15:10:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6447450814084496875=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [1/2] Bluetooth: btusb: Add CONFIG_BT_HCIBTUSB_POLL_SYNC
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221025211258.1385541-1-luiz.dentz@gmail.com>
References: <20221025211258.1385541-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6447450814084496875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=688821

---Test result---

Test Summary:
CheckPatch                    PASS      3.50 seconds
GitLint                       PASS      2.13 seconds
SubjectPrefix                 PASS      1.78 seconds
BuildKernel                   PASS      33.64 seconds
BuildKernel32                 PASS      30.60 seconds
Incremental Build with patchesPASS      52.41 seconds
TestRunner: Setup             PASS      505.03 seconds
TestRunner: l2cap-tester      PASS      17.27 seconds
TestRunner: iso-tester        PASS      16.03 seconds
TestRunner: bnep-tester       PASS      6.33 seconds
TestRunner: mgmt-tester       PASS      103.82 seconds
TestRunner: rfcomm-tester     PASS      10.11 seconds
TestRunner: sco-tester        PASS      9.52 seconds
TestRunner: ioctl-tester      PASS      10.75 seconds
TestRunner: mesh-tester       PASS      7.77 seconds
TestRunner: smp-tester        PASS      9.51 seconds
TestRunner: userchan-tester   PASS      6.61 seconds



---
Regards,
Linux Bluetooth


--===============6447450814084496875==--

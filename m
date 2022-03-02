Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D64C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Mar 2022 22:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243657AbiCBWRm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Mar 2022 17:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiCBWRl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Mar 2022 17:17:41 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4C9D204F
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Mar 2022 14:16:57 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id g7-20020a17090a708700b001bb78857ccdso6045180pjk.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Mar 2022 14:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=TaU9ENhNj0yhSiVX+DvnkwGgr4nlaHMox1SjVtDD0/M=;
        b=jeE+nEGBQl228MU2oAqHe9iPaL7pg3hBQt8IVOyrLi9WNZ6EHvf+HIGuh+lP/Qthek
         HEphYUcnDoLDU0GposP/4kgq8qbrjs26JQWoNI1yJxibXRwx0VSWrWotOyR+A0YSx5DR
         DTGYcrZB1UMHMabfUegpsvAFOAfw49sBolqZ22u6AuZQpuR7ZCBc9vSkhFbvvgRlbpn+
         UPue6rRir3FbBcHU9jDQBGfmTJ/sYhdQ3ofwM/9MAvulu7Ntrx8N0u4CjFjlSeoPyLrc
         67PQfo11h8dooMSOptpGqHbtDaIiWUZgL6T7ZE9iczSyGbnI/VkWHMuZDCfF9wiQcP4v
         7+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=TaU9ENhNj0yhSiVX+DvnkwGgr4nlaHMox1SjVtDD0/M=;
        b=69KcSPNYvy0eInEWL5Q0sEmHaxXAQzAcx1wEm0vCOMwfZIBmh/PgpBGKAJC5T0fNJy
         vN5FwOPoF/KjIbLqlkFq4wDa/qRlhKWYS+sMuGztIUvK2Q3lQouDW2EMTM49X3NH+GO+
         YtmsjakvBzNJJFq2CeQe6D55moxnpSYtzXH5q/cyE+U2O0cR6GwluhQ9fkXCi9eEEMTf
         tp2mlmc3qdNttyOzUWDTaSFNaiOO90CZMqwxzvMIcywv/I45pv/dawZ9JwBLGtSN3mXz
         A7v6w9vrtFlFUCRb4GjPr8EfCiXuTdK7jH0Fiw4+gIe2KJnf0xWJp0bynw3DAfFWvfvL
         MMCg==
X-Gm-Message-State: AOAM532p3iNAmWKP0PA/XyF4gEMBhL4RzUJHz+XYIvwYdh8oy6o2P5/f
        lU2FTzlJAm4qlZIb1cAMvjTbIVQAhbE=
X-Google-Smtp-Source: ABdhPJwTA+cpjuX9TTg8KMFZ0Zjig4UVYCTCCxzebQBpMysP8fpdlbkQJspxT/PdrWziKm5WUew4GA==
X-Received: by 2002:a17:90a:1188:b0:1bd:36d0:d7b2 with SMTP id e8-20020a17090a118800b001bd36d0d7b2mr1912677pja.223.1646259416633;
        Wed, 02 Mar 2022 14:16:56 -0800 (PST)
Received: from [172.17.0.2] ([13.83.218.124])
        by smtp.gmail.com with ESMTPSA id k130-20020a633d88000000b00378c359ea29sm138737pga.12.2022.03.02.14.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 14:16:56 -0800 (PST)
Message-ID: <621fecd8.1c69fb81.23697.09cc@mx.google.com>
Date:   Wed, 02 Mar 2022 14:16:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1495011494278007846=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: hci_sync: Fix not processing all entries on cmd_sync_work
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220302210245.392267-1-luiz.dentz@gmail.com>
References: <20220302210245.392267-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1495011494278007846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=619699

---Test result---

Test Summary:
CheckPatch                    PASS      0.87 seconds
GitLint                       FAIL      0.46 seconds
SubjectPrefix                 PASS      0.32 seconds
BuildKernel                   PASS      34.50 seconds
BuildKernel32                 PASS      30.26 seconds
Incremental Build with patchesPASS      42.30 seconds
TestRunner: Setup             PASS      545.20 seconds
TestRunner: l2cap-tester      PASS      14.76 seconds
TestRunner: bnep-tester       PASS      6.57 seconds
TestRunner: mgmt-tester       PASS      113.78 seconds
TestRunner: rfcomm-tester     FAIL      8.42 seconds
TestRunner: sco-tester        PASS      8.55 seconds
TestRunner: smp-tester        PASS      8.35 seconds
TestRunner: userchan-tester   PASS      6.92 seconds

Details
##############################
Test: GitLint - FAIL - 0.46 seconds
Run gitlint with rule in .gitlint
[v2] Bluetooth: hci_sync: Fix not processing all entries on cmd_sync_work
10: B1 Line exceeds max length (103>80): "Link: https://lore.kernel.org/all/CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i+RE+L2FTXSA@mail.gmail.com/T/"


##############################
Test: TestRunner: rfcomm-tester - FAIL - 8.42 seconds
Run test-runner with rfcomm-tester
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Basic RFCOMM Socket Client - Write 32k Success       Failed       0.178 seconds



---
Regards,
Linux Bluetooth


--===============1495011494278007846==--

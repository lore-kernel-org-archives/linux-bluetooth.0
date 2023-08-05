Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B164C00528
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Aug 2023 00:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjHEAAZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Aug 2023 20:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjHEAAY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Aug 2023 20:00:24 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6550B4694
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Aug 2023 17:00:23 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-63d058b9cafso16592776d6.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Aug 2023 17:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691193622; x=1691798422;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GEcjVy7OOUxxoKPeVRHy6MEY2FuYh9ceg+2N2U41J8Y=;
        b=sUlEqyasmRiVaGiZzG1BfMCKch6if8XQlD0UEE1Au7chZabt/M/Xhu2nRlsMLURMDy
         Gmdr2Mv8ypSsyL2aTgCw/WaoEIi5uLoSYyK3hp54A8IdF0IzbOukzHTTzeIENoWnlquT
         DWsLBsSx7nzPvkmp0rL8id0gDkxrXaLT3sgGVa4+AY2XVUY7nnGabSDOZi5JJcpXwWPB
         54SLWiyualIvpDDCZxIo+jTcGNSzqDdSWv8uUbyHPnCzN4DHJQGWnYyo1QvDCCO+D0Ux
         z+7l0IGIYG6jm9zVm6dLEOAikeK4O+Kn3WjSE/5v9soqTp3a/AWmbG9F3TP+cQ8n51BA
         VHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691193622; x=1691798422;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GEcjVy7OOUxxoKPeVRHy6MEY2FuYh9ceg+2N2U41J8Y=;
        b=kvY/acAzH11hK2emoCrjYG5EsviYgZ2G3Cv6jcso7HuSEkq/Km2BRiUqWvFqDxkSD4
         feOm1JSl0eOM2aJUHU0q08jctUOyUGpONCNZsseoeCJMqVRd7oHv8jwa2GQTX3ZCderm
         HYgWLNgzmvSGJDft5+3RoaBm0cY2Dbn3bVnAmD3g4jAeMtWXap6ABd2+xWuT8tQXW136
         tK38BY4A0K1/LKh+lld9kpxXpWn1W/TtQpLTMijk2yXELvK91ozB4qj38IONkcVdklXi
         /kIsEAAk4JScrkI4UXH5Oqnj738G4EMBfo+9wcNk9lR+gf22xQee6JvOF4t9i5bRxVsK
         YKoA==
X-Gm-Message-State: AOJu0YxX0Klz8nXMUIUxeNQGqYFHYTkqM5ndOciP5vQKABtT7+5MH5s5
        fC7ibppPWOS18Qw1OfDYEwNYDK2TStQ=
X-Google-Smtp-Source: AGHT+IHJjAksjIB7Y7kU8H9bqatvlz0tqEV4xJNfNH+RWzz5a7IcqSsXsyEHeRPpHz8srZH4oLBe1g==
X-Received: by 2002:ad4:4211:0:b0:63c:fdac:e7b5 with SMTP id k17-20020ad44211000000b0063cfdace7b5mr3195102qvp.57.1691193622418;
        Fri, 04 Aug 2023 17:00:22 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.11.235])
        by smtp.gmail.com with ESMTPSA id g25-20020a37e219000000b00767cbd5e942sm992363qki.72.2023.08.04.17.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 17:00:22 -0700 (PDT)
Message-ID: <64cd9116.370a0220.cc4ff.559c@mx.google.com>
Date:   Fri, 04 Aug 2023 17:00:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1506534237179241872=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_sync: Introduce PTR_UINT/UINT_PTR macros
In-Reply-To: <20230804232522.1151304-1-luiz.dentz@gmail.com>
References: <20230804232522.1151304-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1506534237179241872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=773296

---Test result---

Test Summary:
CheckPatch                    PASS      1.07 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      33.60 seconds
CheckAllWarning               PASS      36.49 seconds
CheckSparse                   PASS      41.77 seconds
CheckSmatch                   PASS      113.12 seconds
BuildKernel32                 PASS      32.13 seconds
TestRunnerSetup               PASS      491.95 seconds
TestRunner_l2cap-tester       PASS      23.51 seconds
TestRunner_iso-tester         PASS      46.53 seconds
TestRunner_bnep-tester        PASS      10.83 seconds
TestRunner_mgmt-tester        PASS      218.27 seconds
TestRunner_rfcomm-tester      PASS      16.14 seconds
TestRunner_sco-tester         PASS      19.37 seconds
TestRunner_ioctl-tester       PASS      18.16 seconds
TestRunner_mesh-tester        PASS      13.52 seconds
TestRunner_smp-tester         PASS      14.48 seconds
TestRunner_userchan-tester    PASS      11.23 seconds
IncrementalBuild              PASS      30.67 seconds



---
Regards,
Linux Bluetooth


--===============1506534237179241872==--

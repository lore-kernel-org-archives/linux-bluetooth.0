Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4884DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Mar 2022 23:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351746AbiC3XFC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Mar 2022 19:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbiC3XFB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Mar 2022 19:05:01 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0F7D4F
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 16:03:15 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id c4so19912721qtx.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 16:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=CVBbnDA8/2fjbQwLTR2H/Rimkid1LSS9MVXxfrbUiEs=;
        b=qiXq9sy4xB1GRBSIX4QYRtQ51Jq0KFMA0OCsDoyczVHhvG2b6tbhNv5eQbFl2g8UWi
         xLui6c3dyVi/f+6quzt1vKJ6kEe93k1Mwl5UiFmOJHu3HHhRn64T3LEMm92vMV8bdcsV
         KHvvWIv8kPYdrryRwY/tvePy4oE8HZ5p0r8VZHQny2PiATHRvhjN7ioM4hNAPOAuiBlx
         Wt5sh5p9/1M0jkcVYMCH+rqdmILfohNgoXqKAvIRmVY9/Dpu8xpatpAYV+ohZ1LwgDiK
         u6Zz6t15sl6m/K4tiK6qogh/WrcXIzZ89bcvgGz3jU8ztv8+g8Hz9kqJloFekeXifMYu
         kJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=CVBbnDA8/2fjbQwLTR2H/Rimkid1LSS9MVXxfrbUiEs=;
        b=hdc12B4XnxtJUaEe4GsQKBX4866J9ggXknmRnr8jASSg0oR5HSQtkOUtMAersXDkX2
         eVKiwGbbTTWMIHLxr/hFZBAfDP5Zmc2G1rOgNyk/Y93EXNmuB9On3wEikZk7/idd5ZsE
         Z3Snquh/Nm7mR3/CsOOIreT/dHowwc4MSqizZ3E72x+0txOgJYTa2InVWvao2CcK3KPL
         grx/BGmbsI+FKK6UBaOsXqKPlVqZxiARQFdGt98ypS0oVHIm+fpTQG4lISpHbmEekZvL
         MjfJqLEkgU58jdIFjhLlxkvTD3/cSDnPR5htlmu+kcE7OyAJWick72NdmBNxGYXlkMcB
         V90A==
X-Gm-Message-State: AOAM5316bWu4zSYyV1CKePcOPPZMFliosotAqq526oQjdsyE8D8phivH
        OkYqnjmYxR6gRUkTowb/1eN5FwiVL5Y=
X-Google-Smtp-Source: ABdhPJzhCPUjdOirHrEf9qHez33YiN9tSlhCVBf81XSr0UeX4m1mSdlTihPjmKH7f2nf04f+OiDP4w==
X-Received: by 2002:a05:622a:1344:b0:2eb:856d:777e with SMTP id w4-20020a05622a134400b002eb856d777emr1768506qtk.679.1648681394121;
        Wed, 30 Mar 2022 16:03:14 -0700 (PDT)
Received: from [172.17.0.2] ([20.98.218.96])
        by smtp.gmail.com with ESMTPSA id j1-20020a05620a288100b0067b1be3201bsm11152655qkp.112.2022.03.30.16.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 16:03:13 -0700 (PDT)
Message-ID: <6244e1b1.1c69fb81.3882a.c228@mx.google.com>
Date:   Wed, 30 Mar 2022 16:03:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6033300843153103326=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, rikard.falkeborn@gmail.com
Subject: RE: Bluetooth: btintel: Constify static struct regmap_bus
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220330223252.42136-1-rikard.falkeborn@gmail.com>
References: <20220330223252.42136-1-rikard.falkeborn@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6033300843153103326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=627655

---Test result---

Test Summary:
CheckPatch                    PASS      1.62 seconds
GitLint                       PASS      0.98 seconds
SubjectPrefix                 PASS      0.87 seconds
BuildKernel                   PASS      33.48 seconds
BuildKernel32                 PASS      29.99 seconds
Incremental Build with patchesPASS      40.13 seconds
TestRunner: Setup             PASS      494.49 seconds
TestRunner: l2cap-tester      PASS      16.50 seconds
TestRunner: bnep-tester       PASS      6.43 seconds
TestRunner: mgmt-tester       PASS      106.51 seconds
TestRunner: rfcomm-tester     PASS      8.49 seconds
TestRunner: sco-tester        PASS      8.29 seconds
TestRunner: smp-tester        PASS      8.33 seconds
TestRunner: userchan-tester   PASS      6.81 seconds



---
Regards,
Linux Bluetooth


--===============6033300843153103326==--

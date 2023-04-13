Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC59C77B6C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Apr 2023 01:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjDMBJY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Apr 2023 21:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjDMBJW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Apr 2023 21:09:22 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59C4618F
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Apr 2023 18:09:21 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id fg17so8959747qtb.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Apr 2023 18:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681348161; x=1683940161;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j/8wcYb7xa154IzcnIi8mG7n3A/6OCR3t3JcZvAr2mw=;
        b=Rqln5QhoMZJH3wWM5Qe073xY9IAbjzPrFUSBUw6EMWSufwAEuVS9E381DGJgyIqjC4
         A+AYo/hJVOoNQS8/CnTwcEV/gb9lDcNvMx9UWAN4NdgF5JnUqYfbQxR9nALRMyr7kEot
         XHF6WdEFt13fSS3HFisNrvthNU0f1/GhrH+AtD+s3cW2L0pudVxUe6HI/vQMirvF6Qwx
         dQ/OY1ir7E+9JQmG/Owz6cvrE4anQLlnxMDCbJgOn4hNHfv9q1qcdU/Y0N+nmvT3aZru
         21mST4J/ugmFOHiWyLTOmFX2KezmwUAC04x5/bCYVc1fZBeWe/Ol0ILnVvZUtexzHLsb
         XsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681348161; x=1683940161;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j/8wcYb7xa154IzcnIi8mG7n3A/6OCR3t3JcZvAr2mw=;
        b=jXqRUh/P3+FCEn8Ze+/BTnXBpIuNxMP7e2+2occ4Icyh0gkm+G1Hk+GaVt3xxxKEDq
         addqIqxCELYJ5eUV5rspQVzqV280UdDBVGIsIc285IOqvo0jTwJY0BLV/91G9jr+w3Zo
         ZE9ml+y+jH9h4cYt75drwKcLJc371/g4hnWg+wxOthvbTQgdF4kmnhc6YVq5ORrNr4r+
         c7mbQODjGBJFoV+47O2SkwIbkHsYDLG8Thp/IaiPLR3H0TSDB1PTovZu9406gOaTGD3x
         k6yzliPT+6e1uc/jT1tlZdWOy7oxg2N9vbqjLmrkaGAJzJuFNg2pMIIgAeJ0SN/xomPS
         gzIA==
X-Gm-Message-State: AAQBX9cLLYW/4VTFkIpaaXQHy2Dpr4NshK5ODb+R0VKeB8JB/I9GsjRr
        QgWj/eOCZi8XWRJjoopRqbPDVs90pjI=
X-Google-Smtp-Source: AKy350bOQ32VmDSG12zO0uFim23sKToCQ5bGzcVzNTgMmyCsINAwTVDdjfeKZGxmrEW9zI0myXmvtQ==
X-Received: by 2002:ac8:5710:0:b0:3dd:a248:5474 with SMTP id 16-20020ac85710000000b003dda2485474mr777741qtw.34.1681348160834;
        Wed, 12 Apr 2023 18:09:20 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.233.57])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a084700b006fcb77f3bd6sm85874qku.98.2023.04.12.18.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 18:09:20 -0700 (PDT)
Message-ID: <64375640.050a0220.61079.041c@mx.google.com>
Date:   Wed, 12 Apr 2023 18:09:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4107151553094953559=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, steev@kali.org
Subject: RE: Bluetooth: hci_qca: mark OF related data as maybe unused
In-Reply-To: <20230412-bluetooth-v1-1-377b9bf7b08e@kali.org>
References: <20230412-bluetooth-v1-1-377b9bf7b08e@kali.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4107151553094953559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=739309

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      33.84 seconds
CheckAllWarning               PASS      36.96 seconds
CheckSparse                   PASS      41.79 seconds
CheckSmatch                   PASS      115.54 seconds
BuildKernel32                 PASS      32.78 seconds
TestRunnerSetup               PASS      465.37 seconds
TestRunner_l2cap-tester       PASS      16.85 seconds
TestRunner_iso-tester         PASS      16.59 seconds
TestRunner_bnep-tester        PASS      5.41 seconds
TestRunner_mgmt-tester        PASS      112.48 seconds
TestRunner_rfcomm-tester      PASS      8.69 seconds
TestRunner_sco-tester         PASS      8.32 seconds
TestRunner_ioctl-tester       PASS      9.27 seconds
TestRunner_mesh-tester        PASS      6.83 seconds
TestRunner_smp-tester         PASS      7.94 seconds
TestRunner_userchan-tester    PASS      5.69 seconds
IncrementalBuild              PASS      31.06 seconds



---
Regards,
Linux Bluetooth


--===============4107151553094953559==--

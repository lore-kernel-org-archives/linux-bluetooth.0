Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CD4C7619A
	for <linux-bluetooth@archiver.kernel.org>; Sun, 16 Apr 2023 09:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjDPJBI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 16 Apr 2023 05:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjDPJBH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 16 Apr 2023 05:01:07 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2C319BB
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Apr 2023 02:01:05 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id hg14-20020a17090b300e00b002471efa7a8fso9558547pjb.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Apr 2023 02:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681635665; x=1684227665;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uDhqbFD2f57u4aSfu/F3Y0r7SFOROkh9m7djPfX1Osc=;
        b=OZRopsSZQ9m3du/et2bqUCjkKiE7D/3mvTe22HEwOWuoGMttYec4TizyloD7ECWNBh
         KrYh6KK3Nz/V8UsoUiediOuYUnb8s6+UczcFHRWnXv/cWlmKS1tGEQU+wqow1LGHktPd
         QydvZq0gatPiZIELf+pSB9YkjoimhVa1xAyoXJRBnTIcedwkcr4yk5NFPpwAUxoT0Ou6
         x5uRF2BfkhB6ZCM+7i4+ZwyoVxvyl5R2L0f22DLZXUQr1iqNrn5oNXjnH6tes+Xa3RHg
         W1xi+BMbB6gx9FZlb70cRvdX0kyiaKag6cDUkMZOXar7cWl+f9ES41vMtjUblfkO5PEW
         2hOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681635665; x=1684227665;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDhqbFD2f57u4aSfu/F3Y0r7SFOROkh9m7djPfX1Osc=;
        b=YlzIQefG7qFk21+dBkVKA/X3BDkF5DAO1s7pqORaZXM00GHP8SLa37RlL353ME/M1v
         8nuiIY6utH6Vr241Tay40DgXdQEhl8Te5GMF2HMLcTDpLOPOMmRTW2mOfxt5ebQNUqjI
         jfd+Ri0ibGAFDnLtf0NZRI9RWLKCJGVq8O6TKEsMokTPkrBrZotx7DIbnhx8gBhe4yFo
         sokTY1tJ3/UF9wqNa89NZSuixXRIsnd1QOmYdnoDN9K16c4grmnBZc0MiTaeDYTMLiGI
         df6cHoPttzw55b/OMFL5PMwdhfmBiS1XAP/ZelEStzOhjdDk2RRidRvhS9/Y1UVfnCp+
         /v9A==
X-Gm-Message-State: AAQBX9fnUOURLEg+MsoOHP+2bBx2+1QugQbx3sgnpyB17IYKsZTd6qZC
        D8pvYPHLh5nSBStazBhAgfofpABHRBo=
X-Google-Smtp-Source: AKy350bSzQqx4WzkaNeVTOiSJ97ZbRL35kNtHtd9Kkt9P1xFJUCid+9T0Wwt2et3UBIW/nR/22ntyw==
X-Received: by 2002:a17:902:db09:b0:1a6:82ac:f277 with SMTP id m9-20020a170902db0900b001a682acf277mr10218463plx.14.1681635664858;
        Sun, 16 Apr 2023 02:01:04 -0700 (PDT)
Received: from [172.17.0.2] ([52.160.111.22])
        by smtp.gmail.com with ESMTPSA id iw18-20020a170903045200b0019a91895cdfsm5664735plb.50.2023.04.16.02.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 02:01:04 -0700 (PDT)
Message-ID: <643bb950.170a0220.d499e.cc97@mx.google.com>
Date:   Sun, 16 Apr 2023 02:01:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3104967445265924236=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, lrh2000@pku.edu.cn
Subject: RE: bluetooth: Perform careful capability checks in hci_sock_ioctl()
In-Reply-To: <20230416081404.8227-1-lrh2000@pku.edu.cn>
References: <20230416081404.8227-1-lrh2000@pku.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3104967445265924236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=740182

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 FAIL      0.48 seconds
BuildKernel                   PASS      40.50 seconds
CheckAllWarning               PASS      44.13 seconds
CheckSparse                   PASS      49.42 seconds
CheckSmatch                   PASS      134.01 seconds
BuildKernel32                 PASS      39.14 seconds
TestRunnerSetup               PASS      559.05 seconds
TestRunner_l2cap-tester       PASS      19.48 seconds
TestRunner_iso-tester         PASS      25.39 seconds
TestRunner_bnep-tester        PASS      6.68 seconds
TestRunner_mgmt-tester        PASS      136.10 seconds
TestRunner_rfcomm-tester      PASS      10.90 seconds
TestRunner_sco-tester         PASS      10.13 seconds
TestRunner_ioctl-tester       PASS      11.56 seconds
TestRunner_mesh-tester        PASS      8.62 seconds
TestRunner_smp-tester         PASS      9.85 seconds
TestRunner_userchan-tester    PASS      7.30 seconds
IncrementalBuild              PASS      36.44 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============3104967445265924236==--

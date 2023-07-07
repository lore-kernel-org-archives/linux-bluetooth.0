Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B822EEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jul 2023 03:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjGGDtj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jul 2023 23:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGGDth (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jul 2023 23:49:37 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2321FC9
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jul 2023 20:49:36 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-767582c6c72so138439385a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Jul 2023 20:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688701775; x=1691293775;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oOu7PkyjYv7Mzr87fm6JVzEI4XwfKU1UpXmQM7xxsh4=;
        b=NkMjWSPUKQcJvj6mkPr2moJGfGDnm1NoiWFxQAo0huLzTYvrd5QaECKMwUuBk2Ti68
         VhpzV8Y22eABsdNNDIePY3N13VchCGbk3ZdQMzgdZNvFQNzvQl0yoIG/EoSWJHCG+4rU
         +o7vtKGDPwXEz4B+aPYbr3/xMXra4CQuTjbCOxyCoetnYTmdgJ6Z8vh1CO2QNF3ghfao
         Kx4aB2N6RXVJ6G3QtgbBjFAozKV3JBJcMP8Cl3aORpsXvGcb4hJXiBo4wbQeqHjJrQDl
         tUWoXCFAReXTlo4HohSa0usseo/FqGTt300AiEMKmub64mK/1QC39WZF81HxSz2pngsQ
         Rf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688701775; x=1691293775;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oOu7PkyjYv7Mzr87fm6JVzEI4XwfKU1UpXmQM7xxsh4=;
        b=YvRICezhoMXYAiF/MBE5jYwm858JrC4motsWqKrNNU08HdGx7EJAbIo73kv3DuDPdq
         oFbx58B61mmwsqAuuEbawJ0/lKA7gOOsz0pLlAGl9o8oEhK0a4AprVhyrCbfY31AKz56
         YbaIESp23LVG1BNOjJgFdz/2hec5NDeX40mW0AEdHpJLpnTDOGZzmpAlZlrL13rSx82a
         a5oN1F0Da86ixKG5VJcWWzj7uao4PReIgiqWOO+UIAJWQ5Mji/Px+cktAwA3BSrgkG/1
         67oNRJ7eQW8M7KvQgqSacfO7e2qqJJlXL6WW1m5QGvK+EevFIhZe056B1YFjIJ6iDe2/
         /Xyg==
X-Gm-Message-State: ABy/qLYAtoC/eHH2sXg2ucod5zKQ5ObBlrQCD1ObDz5kRDje4arrNUfr
        V3Pik88+v/YyLDati7Cl+HEL1SLGnwo=
X-Google-Smtp-Source: APBJJlGFG6AGev+Mk6e2gw6wBGcsGCPkrjoqW2c4BEGECB/xt2AcDMrnzA/FMMM12PTarC8RR+ka7g==
X-Received: by 2002:ac8:5ac9:0:b0:3fb:42cb:aa9 with SMTP id d9-20020ac85ac9000000b003fb42cb0aa9mr5250498qtd.45.1688701774713;
        Thu, 06 Jul 2023 20:49:34 -0700 (PDT)
Received: from [172.17.0.2] ([52.190.14.160])
        by smtp.gmail.com with ESMTPSA id t9-20020ac87609000000b0040091d8e63fsm1312604qtq.73.2023.07.06.20.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 20:49:34 -0700 (PDT)
Message-ID: <64a78b4e.c80a0220.961a7.4771@mx.google.com>
Date:   Thu, 06 Jul 2023 20:49:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0865002634999180643=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v2,1/2] Bluetooth: btusb: Add VID 0489 & PID e102 for MediaTek MT7922 USB Bluetooth chip
In-Reply-To: <20230707030442.25330-1-chris.lu@mediatek.com>
References: <20230707030442.25330-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0865002634999180643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=763292

---Test result---

Test Summary:
CheckPatch                    PASS      1.43 seconds
GitLint                       FAIL      0.93 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      33.72 seconds
CheckAllWarning               PASS      37.39 seconds
CheckSparse                   PASS      42.34 seconds
CheckSmatch                   PASS      113.62 seconds
BuildKernel32                 PASS      32.65 seconds
TestRunnerSetup               PASS      495.43 seconds
TestRunner_l2cap-tester       PASS      23.85 seconds
TestRunner_iso-tester         PASS      42.06 seconds
TestRunner_bnep-tester        PASS      10.76 seconds
TestRunner_mgmt-tester        PASS      219.06 seconds
TestRunner_rfcomm-tester      PASS      16.18 seconds
TestRunner_sco-tester         PASS      17.08 seconds
TestRunner_ioctl-tester       PASS      18.38 seconds
TestRunner_mesh-tester        PASS      13.87 seconds
TestRunner_smp-tester         PASS      14.56 seconds
TestRunner_userchan-tester    PASS      11.27 seconds
IncrementalBuild              PASS      37.09 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,1/2] Bluetooth: btusb: Add VID 0489 & PID e102 for MediaTek MT7922 USB Bluetooth chip

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (89>80): "[v2,1/2] Bluetooth: btusb: Add VID 0489 & PID e102 for MediaTek MT7922 USB Bluetooth chip"
[v2,2/2] Bluetooth: btusb: Add VID 04ca & PID 3804 for MediaTek MT7922 USB Bluetooth chip

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (89>80): "[v2,2/2] Bluetooth: btusb: Add VID 04ca & PID 3804 for MediaTek MT7922 USB Bluetooth chip"


---
Regards,
Linux Bluetooth


--===============0865002634999180643==--

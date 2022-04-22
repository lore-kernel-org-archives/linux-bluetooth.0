Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7AFC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Apr 2022 23:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiDVX0x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Apr 2022 19:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiDVX0q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Apr 2022 19:26:46 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818B618340
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Apr 2022 16:04:03 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id x20so7147462qvl.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Apr 2022 16:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=lyLdzjJKJtfegycWJZWfbUpZyIMkhW6iNv5rJwHPetY=;
        b=hJgp99P3UEIlzhSRcJQFaIb+ArD2BOBuXdG5i0L2TK88cSeqfK8KR9TAaE9o9fhUAK
         I2BYS9Irk7z5g60ybfWmG88NKzY/1DmMw1c+llT73VMdVlrNeX7IwOJKriBPyuoemMiF
         PGL2WlQCjyIMitc6ZayspNMw63Lbl9FYNWysxq84HTMakGWQSaGAiHIwl0xTneifgLxr
         b4h7uFu/mmGdaXbQbCu9lTZf7jVrBIhYmrG4vSGxieWrRIulTMo9BXBI/AxQ/JBifdrW
         wE+jApFsAa3mQLJHwdrwErxldL5DS6cmQw2JWSu3QBaX6N3hyDwgxI2/DbTAPtbuMng+
         T7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=lyLdzjJKJtfegycWJZWfbUpZyIMkhW6iNv5rJwHPetY=;
        b=Vz7O/nK0cu68Mn5GqawKKKG+F3ZNyzPoePLkmZilNUmzOBObyVsdB8CWHp0yaskL06
         vXmGkw8/e7HGF/4wKEDaVzFwJHdJAgl9lZ7IdnwcLCDgufLXLjl2Xh16NtjCzRleWDRz
         Q32YNcYaug519W9AJu1tOaqhKoQ294DyZWJVELRA308N7fzI5/ghxkHdAdowcjrq1mWk
         p759zz2KYbtOg7NIRhJXbodHJnzx/rHgB2zsTv9h6pNzFOkyYJbEyA42pMz4+/Ja/KzX
         nQDIs0MdZHzNs6fZ70vg3BVuPkz5vx2ant6oAT/QbpzstiOrEpVvpV9j0PDRikRgjgXE
         t9sA==
X-Gm-Message-State: AOAM531pIJ0Ex0HVYexl7KIF/392qQ7txECbFMHrJwvs2+8POwZnkqej
        aAnI2R1umTCnlq97B1IWITvC3xZC5xr/WA==
X-Google-Smtp-Source: ABdhPJz+SypNlXdn1Y1I3lXAcr4ieWr9uaNPLcHNphMVFHI5Lp+T3KOiM5uMJVG52YjdAf0klRtBNg==
X-Received: by 2002:ad4:574e:0:b0:44b:ca76:bc5e with SMTP id q14-20020ad4574e000000b0044bca76bc5emr5288655qvx.83.1650668642451;
        Fri, 22 Apr 2022 16:04:02 -0700 (PDT)
Received: from [172.17.0.2] ([20.122.132.169])
        by smtp.gmail.com with ESMTPSA id e26-20020ac84b5a000000b002f35d11c5dfsm1004143qts.65.2022.04.22.16.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 16:04:02 -0700 (PDT)
Message-ID: <62633462.1c69fb81.2350.78c9@mx.google.com>
Date:   Fri, 22 Apr 2022 16:04:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7922786543431831486=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3,1/3] Bluetooth: hci_event: Fix checking for invalid handle on error status
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220422195818.3640058-1-luiz.dentz@gmail.com>
References: <20220422195818.3640058-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7922786543431831486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=634792

---Test result---

Test Summary:
CheckPatch                    PASS      5.44 seconds
GitLint                       FAIL      0.97 seconds
SubjectPrefix                 PASS      2.52 seconds
BuildKernel                   PASS      32.05 seconds
BuildKernel32                 PASS      28.98 seconds
Incremental Build with patchesPASS      73.98 seconds
TestRunner: Setup             PASS      481.11 seconds
TestRunner: l2cap-tester      PASS      17.96 seconds
TestRunner: bnep-tester       PASS      6.28 seconds
TestRunner: mgmt-tester       PASS      105.22 seconds
TestRunner: rfcomm-tester     PASS      10.02 seconds
TestRunner: sco-tester        PASS      9.74 seconds
TestRunner: smp-tester        PASS      9.77 seconds
TestRunner: userchan-tester   PASS      6.63 seconds

Details
##############################
Test: GitLint - FAIL - 0.97 seconds
Run gitlint with rule in .gitlint
[v3,1/3] Bluetooth: hci_event: Fix checking for invalid handle on error status
13: B3 Line contains hard tab characters (\t): "	Sound Products Inc)"
25: B3 Line contains hard tab characters (\t): "	Sound Products Inc)"
27: B3 Line contains hard tab characters (\t): "	gateway SDP record: Connection timed out"
32: B3 Line contains hard tab characters (\t): "	Sound Products Inc)"
35: B3 Line contains hard tab characters (\t): "	Sound Products Inc)"




---
Regards,
Linux Bluetooth


--===============7922786543431831486==--

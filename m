Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B34DE810DD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 12:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjI0Mtz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 08:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjI0Mty (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 08:49:54 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38EBC0
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 05:49:52 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-77574c6cab0so73112285a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 05:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695818991; x=1696423791; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ze93lLPsI7B+SV+g8cIDXOmxTU9FOfFxUyL6xrFV5Gc=;
        b=ZBjUKHA1WkZ+m+rKcR+7rmJ6gKNLf7MW2rIRmeem1JbE0WbCm2bW0FYwPdLOTYRc2M
         7N/BoCMdpTfYWx9uFU+z4eoIgiLBSWHZ+sfDW0xuQDEDu/FH+VD14+rrdqycaIOwxq8j
         NxkFoEyl/YqgNa2cZCyGkNbUSvL7hvzxtlSOSfJcxlrpcg98ek54Y+BuXVqIZhPo3ea7
         X6rzVh0RcvJcphUexEIQNdNlmf0aXngExFHZDIBJy9Ie9/yRddlX57AXY1Qr75a33/p4
         6dlGersZxDXtKoSeGPXG5KgGbqaxRYO3AbgvCo8/X0U4MH6JEw+ZyQfDF3yd8+wWf6GF
         vIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695818991; x=1696423791;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ze93lLPsI7B+SV+g8cIDXOmxTU9FOfFxUyL6xrFV5Gc=;
        b=U1cJwGjTt2Mhn2PwW8w6ajjzHz2nji3oo8Gp8LpCni1hTRRSY28rbx0dehYqAIU4QV
         CEY7KJqjU3E3hMZE+Z986QGcw5VrRKTuCHTW9wx3sCce9WtsigO1lss5xFRa652yEBx6
         bH2kT82DI826Nh0QS9GjDrUbQeB3XVH67CcZ5tJQEgw+zDpXPMcpdVAOsPv9kZdpe6Qc
         YpF+4s8A98zg938k901BLAZ+f6ag00Gb15vrHqyjpaG7lPvK0Tzfn9jCv7YH9Ftj0pMa
         hfogpD9csPbPKYa+VyqqDpmQWkS/CpLS7RIAFEcWeR0TeBvtQsUokTjNIfKomIcbHPww
         wY1w==
X-Gm-Message-State: AOJu0YzzC7rJmPygHi882JK6sS9i+NKF1LFexRBoGl/VUJexEyvNweAw
        zdIUP1/yNMQSLbkdDRWWKB6GhoDsIUk=
X-Google-Smtp-Source: AGHT+IEbtrnZ5i+KiZlgrgoMpkJvQf7LnDPn7Y5bNZHQlIGEhJIe5n2WgjfOYv+fiFl9nmM1SV2BZQ==
X-Received: by 2002:a0c:da85:0:b0:64f:42e8:6f2 with SMTP id z5-20020a0cda85000000b0064f42e806f2mr2101604qvj.10.1695818991687;
        Wed, 27 Sep 2023 05:49:51 -0700 (PDT)
Received: from [172.17.0.2] ([52.190.17.163])
        by smtp.gmail.com with ESMTPSA id o20-20020a0cf4d4000000b00656329bb3b1sm3634754qvm.10.2023.09.27.05.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 05:49:51 -0700 (PDT)
Message-ID: <651424ef.0c0a0220.f32e3.d235@mx.google.com>
Date:   Wed, 27 Sep 2023 05:49:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8008574976419328627=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Fix invalid context error
In-Reply-To: <20230927113739.3332-2-iulia.tanasescu@nxp.com>
References: <20230927113739.3332-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8008574976419328627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=788074

---Test result---

Test Summary:
CheckPatch                    PASS      0.86 seconds
GitLint                       PASS      0.40 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      42.06 seconds
CheckAllWarning               PASS      45.51 seconds
CheckSparse                   WARNING   51.94 seconds
CheckSmatch                   WARNING   138.36 seconds
BuildKernel32                 PASS      40.26 seconds
TestRunnerSetup               PASS      608.56 seconds
TestRunner_l2cap-tester       PASS      36.41 seconds
TestRunner_iso-tester         PASS      64.40 seconds
TestRunner_bnep-tester        PASS      12.70 seconds
TestRunner_mgmt-tester        PASS      257.49 seconds
TestRunner_rfcomm-tester      PASS      20.99 seconds
TestRunner_sco-tester         PASS      22.93 seconds
TestRunner_ioctl-tester       PASS      22.83 seconds
TestRunner_mesh-tester        PASS      16.77 seconds
TestRunner_smp-tester         PASS      17.29 seconds
TestRunner_userchan-tester    PASS      13.45 seconds
IncrementalBuild              PASS      38.36 seconds

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


--===============8008574976419328627==--

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C206C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Nov 2022 03:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiKIDOc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Nov 2022 22:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKIDOa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Nov 2022 22:14:30 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E4415FD8
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Nov 2022 19:14:30 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id b124so17566549oia.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Nov 2022 19:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Gh+CstPnNnH0cEdaFvFagBVUn56vyXkXAc+0Kh0qUJo=;
        b=BRaOGckkIaWgE6pt20qm+k4DFn2n+dyMXyq5kNOdWFAx6pxOzhhjuaa4dplp9ZZhxa
         i4u8GOLWnPS8QiSMlc1BtRRuminwm2ZSlaH6AcK68HaP6uZ+KGDM8scYs+y32dgBvOss
         +4CBLs3RaD6PFldm1Gb7lWHlS8Rf2lV+WFxgAJnRDZjiTHX8sPNKsFqn71yKC7vpIb4U
         6aEI7XR7m8B30yjWmAm8rtxmBBzFiP2fOXM+F1owpc07gxXQu5m9XJA7DEFOsiPDOVF/
         1eJv+Q2VB+37sSmybfwebunInW22iU/reX0F5dUwPSNb2QaqoswxziJW0blg+Dn8EiR2
         wHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gh+CstPnNnH0cEdaFvFagBVUn56vyXkXAc+0Kh0qUJo=;
        b=nED3E1nzPPq8waOVurr2/YbjEtDJtMxESXuPADdLU9I5AibAquE3R6r7lNDtFFSg0C
         8q8qM/XSBfaWZLXoB0dXqV+WtCNJdC76KAlk/t4WtHSQw48DCAcaLr/igMEKeigMeCec
         ILKwXPcbr4beeul2ZHYvyRY/lKdcUorzCoIQj56ZCJ8+hj6RMhG5EkykSRAfAA9oc0uj
         QVzKVeIWjLH/P+eu2J0LzlgQ642lY2XWEW/Z9h7HIQSLb9zDxvzlT5/jFlF+MBFsMSb3
         Aqx5/jNWWhPDc/1i6zQuDuJ+fhr+SyE6PaXj3CPbvMiIEs/RsBnKAKEeECmrnSQdwss6
         vQNw==
X-Gm-Message-State: ACrzQf1gQYdZvctfoSj7lVqbLlhYDwe+t9guFoGvrvKCfH33dF4FqJCx
        VKapPF1YdGRCcVbT2vuiF9Yd77qtdyw=
X-Google-Smtp-Source: AMsMyM6YkSHIFjK5kJp64LMP7WWS8A56sWtOuw28e6HXtUAeOXovz9LFyZqrZh411gKP2IDgVcr9tg==
X-Received: by 2002:aca:de43:0:b0:35a:5ea8:eb0 with SMTP id v64-20020acade43000000b0035a5ea80eb0mr13346192oig.55.1667963669241;
        Tue, 08 Nov 2022 19:14:29 -0800 (PST)
Received: from [172.17.0.2] ([104.215.94.92])
        by smtp.gmail.com with ESMTPSA id w17-20020a9d77d1000000b006679a03a753sm4784334otl.11.2022.11.08.19.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 19:14:28 -0800 (PST)
Message-ID: <636b1b14.9d0a0220.b3f96.27d8@mx.google.com>
Date:   Tue, 08 Nov 2022 19:14:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3353481979671326436=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bobo.shaobowang@huawei.com
Subject: RE: [v2] Bluetooth: hci_conn: add missing hci_dev_put() in iso_listen_bis()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221109023906.1556201-1-bobo.shaobowang@huawei.com>
References: <20221109023906.1556201-1-bobo.shaobowang@huawei.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3353481979671326436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=693455

---Test result---

Test Summary:
CheckPatch                    PASS      1.36 seconds
GitLint                       FAIL      0.76 seconds
SubjectPrefix                 PASS      0.64 seconds
BuildKernel                   PASS      43.57 seconds
BuildKernel32                 PASS      38.12 seconds
Incremental Build with patchesPASS      53.91 seconds
TestRunner: Setup             PASS      637.45 seconds
TestRunner: l2cap-tester      PASS      20.17 seconds
TestRunner: iso-tester        PASS      20.31 seconds
TestRunner: bnep-tester       PASS      7.74 seconds
TestRunner: mgmt-tester       PASS      123.31 seconds
TestRunner: rfcomm-tester     PASS      12.07 seconds
TestRunner: sco-tester        PASS      11.46 seconds
TestRunner: ioctl-tester      PASS      13.28 seconds
TestRunner: mesh-tester       PASS      9.59 seconds
TestRunner: smp-tester        PASS      11.31 seconds
TestRunner: userchan-tester   PASS      8.16 seconds

Details
##############################
Test: GitLint - FAIL - 0.76 seconds
Run gitlint with rule in .gitlint
[v2] Bluetooth: hci_conn: add missing hci_dev_put() in iso_listen_bis()
13: B1 Line exceeds max length (89>80): "v1: https://lore.kernel.org/netdev/20221108112308.3910185-1-bobo.shaobowang@huawei.com/T/"




---
Regards,
Linux Bluetooth


--===============3353481979671326436==--

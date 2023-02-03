Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676C1C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Feb 2023 09:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjBCJzo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Feb 2023 04:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjBCJzm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Feb 2023 04:55:42 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B3565F2C
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Feb 2023 01:55:40 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id r9so3689014oig.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Feb 2023 01:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J9Z8d192dxW1hqoxUxMKdS6Vxjws6xR0tmi/KU+Gp3A=;
        b=LIPNJbVleEUGtIdaYdHNazAMxulRjdoJJ+YquaPtm7hE4S0AKidsAaBCDB6H1F06sU
         Vnbu2L4/dLq3zmpD0gp8fzQI1qHDOaJUxk9CSDnhpuziFwXztbGDcLjEpv1UbfouP7Zs
         NrRAOqTnKv9t1153oLcCK9hxV2MbAGf0kQtYT35ti570Ltd24CobR3P8doHltmFzuy7d
         ikpx2bveIxbyNDZ5lpEHdFgQXIrW2Gi6cQjZZQT4gkMLNqntpbwOnZyHBVNWUg0/R5jG
         jKa/Caissy8pOXL359XjeM1Nbzcp4cv9R/PzxvJJkNrinpMEU9ZdY9AMfxGExCN2w8pA
         61QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J9Z8d192dxW1hqoxUxMKdS6Vxjws6xR0tmi/KU+Gp3A=;
        b=U+iOStdlojNIFDN8YOPkzWChNoi85oWRCb4Vv2UCmYs0iIORMs5UQKmwTgz4Pb5uax
         29vw1yIdOK6OPBIlwXSWkG7T7jNo2pUTSGnbun5HndE4jN2jSV7+VVj9DWvo2Cxb+KIL
         IgSbzFPyb8EEjqsrBGkchwK2xXh/GaC0d+7Cb9wdzGBJys0pjGhuix/yBkaRII/xfPoK
         qz7sVy1o9QdC3kwWU+XxKgctmsnbuZ3uhv/2HShnJLuUb5C8ldnxigJpdgHqSoI1N3D6
         L2ocQCl0HMMznPsgFRYxVKy8Hu/d1TSYvq8Mj/1H/sgMbDXaNw1FjlIl0KoE+77DzYRs
         FdpA==
X-Gm-Message-State: AO0yUKWPfO9xJBqAlRCln/Ye4CStqqaxl4VmDW9diDSjExTRSKZrlxuK
        NzZ7VaRg+vtk+rQreIyuWDBGayxqJIY=
X-Google-Smtp-Source: AK7set/na0yuCwKSEPAH+HWISXoTg6yeO7+gcVQxwgzE14afGJ3arkSDCakiEi9jS5xPMh8Lem4njw==
X-Received: by 2002:aca:110b:0:b0:377:ff13:d07f with SMTP id 11-20020aca110b000000b00377ff13d07fmr4161500oir.38.1675418139580;
        Fri, 03 Feb 2023 01:55:39 -0800 (PST)
Received: from [172.17.0.2] ([104.210.133.18])
        by smtp.gmail.com with ESMTPSA id ay38-20020a056808302600b0037832f60518sm620348oib.14.2023.02.03.01.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 01:55:39 -0800 (PST)
Message-ID: <63dcda1b.050a0220.abe5.2881@mx.google.com>
Date:   Fri, 03 Feb 2023 01:55:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3879447008662786982=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel: Set Per Platform Antenna Gain(PPAG)
In-Reply-To: <20230203093332.4736-1-kiran.k@intel.com>
References: <20230203093332.4736-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3879447008662786982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=718490

---Test result---

Test Summary:
CheckPatch                    PASS      1.11 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      29.78 seconds
CheckAllWarning               PASS      31.18 seconds
CheckSparse                   PASS      36.11 seconds
CheckSmatch                   PASS      95.28 seconds
BuildKernel32                 PASS      27.59 seconds
TestRunnerSetup               PASS      390.39 seconds
TestRunner_l2cap-tester       PASS      15.62 seconds
TestRunner_iso-tester         PASS      15.92 seconds
TestRunner_bnep-tester        PASS      5.16 seconds
TestRunner_mgmt-tester        PASS      104.89 seconds
TestRunner_rfcomm-tester      PASS      8.49 seconds
TestRunner_sco-tester         PASS      7.94 seconds
TestRunner_ioctl-tester       PASS      8.92 seconds
TestRunner_mesh-tester        PASS      6.60 seconds
TestRunner_smp-tester         PASS      7.67 seconds
TestRunner_userchan-tester    PASS      5.43 seconds
IncrementalBuild              PASS      25.51 seconds



---
Regards,
Linux Bluetooth


--===============3879447008662786982==--

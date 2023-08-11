Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6442AC0015E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Aug 2023 18:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbjHKSUK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Aug 2023 14:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjHKSUK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Aug 2023 14:20:10 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6C730E8
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Aug 2023 11:20:08 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1c4af84667bso467070fac.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Aug 2023 11:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691778008; x=1692382808;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iCchsZ23rLw21lWnXB3JNeeMJa4aRNYmeYcW+LhGSP4=;
        b=ZpKNo4vvDBVHsETAzqFozX9Et+eg6zyHxW9YxDjeoyvcP8UHX78KgL4brvoiEnl18P
         ULa4bROlDH3FHcUi8INp/f/k4+rrUq8SjjysTBqHMwuMk0o5jZUbYZVclt8Uixq4XsvR
         QP2EgRRegirSntq7JWSbhoUVUameoq3T0MgtXUmsxhWX3BjtNbgCcS0O2rueP6tni35f
         OgdBeGiRUfYaQSM8lkmncWXixf7eGxZQl3oAatNFgNdiPPqXuwX8XSTJBe+1xdyTHkKU
         HyrEEI2FDCdTOqICY7zntZsAmqi0s2/P3jZgrooJrs0qQqekZMBEi+m3pZ0jRGNYW99Y
         a0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691778008; x=1692382808;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iCchsZ23rLw21lWnXB3JNeeMJa4aRNYmeYcW+LhGSP4=;
        b=QHPuqCGSPMqD2Fak4inKK1bLTaIeVF0AAjDmHuQYOA98FO5Ca7+kYlMDYk5PjQ6UYl
         KJEWSm271fGV7OKzxYVPqaq5n0PGQ8UQbsFqqG1IUt4mJSKcGhV9ynS9URVKXPWsdG8k
         3jpbv7xTDGOoA6enscbcCwqDEM2LxQ84yvHrBondgyCt4W9tXIu7bfSIsijHGlHUYbE8
         oY2PTm+8/Eaa6x2hqYEuCGZaloorreisj1b8NUNq7Ux6j9VDVTueT1QzDT0IRv+Hf+N3
         w2ACdOhGXGdSygwXuxLRvuyn02NmYRwfT8CA2ZVO2t7mUNK4qeOYmee5CGf18OYAFpj4
         o4/A==
X-Gm-Message-State: AOJu0YwyaegxjIsQqsfEtk0mAp1jbgjOnoVy1zfdn3JEv6KzTQfhIoqX
        M6QGa7eJOpPzuoypBPBZh/A7X5arKdM=
X-Google-Smtp-Source: AGHT+IESQRj2alCPG0s3t+o9nykpmTLULJwQ/zNTtilq/OBVYwMpNbKeTSKM3Gt1DEbywqpb+WBB3A==
X-Received: by 2002:a05:6870:468e:b0:1bb:867e:caeb with SMTP id a14-20020a056870468e00b001bb867ecaebmr2966804oap.51.1691778008080;
        Fri, 11 Aug 2023 11:20:08 -0700 (PDT)
Received: from [172.17.0.2] ([104.210.140.149])
        by smtp.gmail.com with ESMTPSA id k4-20020a056870350400b001bf120a44f7sm2233587oah.33.2023.08.11.11.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 11:20:07 -0700 (PDT)
Message-ID: <64d67bd7.050a0220.51e14.06bd@mx.google.com>
Date:   Fri, 11 Aug 2023 11:20:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4585918083283993347=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync
In-Reply-To: <20230811174633.1818931-1-luiz.dentz@gmail.com>
References: <20230811174633.1818931-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4585918083283993347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=775448

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      44.80 seconds
CheckAllWarning               PASS      48.41 seconds
CheckSparse                   PASS      54.47 seconds
CheckSmatch                   PASS      145.66 seconds
BuildKernel32                 PASS      42.36 seconds
TestRunnerSetup               PASS      639.62 seconds
TestRunner_l2cap-tester       PASS      31.76 seconds
TestRunner_iso-tester         PASS      72.96 seconds
TestRunner_bnep-tester        PASS      14.73 seconds
TestRunner_mgmt-tester        PASS      274.49 seconds
TestRunner_rfcomm-tester      PASS      21.91 seconds
TestRunner_sco-tester         PASS      24.41 seconds
TestRunner_ioctl-tester       PASS      24.53 seconds
TestRunner_mesh-tester        PASS      17.87 seconds
TestRunner_smp-tester         PASS      19.13 seconds
TestRunner_userchan-tester    PASS      15.05 seconds
IncrementalBuild              PASS      39.65 seconds



---
Regards,
Linux Bluetooth


--===============4585918083283993347==--

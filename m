Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84D1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Feb 2022 14:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbiB1ODp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Feb 2022 09:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiB1ODo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Feb 2022 09:03:44 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2CC31DEE
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 06:03:05 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id ba20so12618497qvb.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 06:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=bpWkaj2wDyBYwo1LJ1CrQZd4hZgakDm8gh30Z3ZMxKI=;
        b=OHod6FtZBcbAriH4QwseMuOxxibeiYLBkFHiODexuB/oGcMKeHVGoNN5eAdjoMghYr
         FgQ9QqOn1FWbkIS05w2JiK+bU94xm3j1ol7YEk4RyIgOD+orB/UHbXgMeo+s1ksgIGcl
         3m8yeciZotVTEbptM5Ump2JmiUtXaHUt39GTxwhURWjEojar3tELNdfp5n2vdx20vI+S
         k1zRknnFO0Xs5qHi+Rh15HO6Qx5tbN9Su3t174jiqPvfnpMYL8+ynM4KWnKrnYmMI+Gy
         4A6XwmK3+yV3DPzYXI5ON+ngAffHqSCcTAtI28pJ9RDhmhIUt/c4D0lbm1PGcpiplf/D
         jiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=bpWkaj2wDyBYwo1LJ1CrQZd4hZgakDm8gh30Z3ZMxKI=;
        b=2OeZUjQhnB8Bx4XU6ttVPWXRaiV9RENBoKRCgDdb+Q58+vhknjp4ATERMNe+UUk8mE
         sPb1804XgQeRM7at5A3unamw8y7asV13vXL4kwuDSTnxSC6qklrpbhOizuvkzLvqvFrQ
         DnDTArwHEdp6VygGvp7iAbfSbgY0P4dQp8Gc32z9830zkJ2KJM3PLmf8Ux4Wv0V/+Qie
         eg/d25n2HI0WOe8LlQQhx/7ZBQCmVRDKuAX1Bo9VkqiiQYo7RHmQIDG1W9hIzl0Baqu5
         1yy9YlSJmw9JKQSBlfBXhOiv7PBuwQ+u3m8V7W9d7NjnYgHwaSwLHxFnyjQCOXml42St
         XZOg==
X-Gm-Message-State: AOAM533Q3636dvF/B74xn1GpXHYwXx2AOYpneW28On/0ILUtDeKEfTPa
        mEcGlmHFl6V9jXRI0uFDrV8YW6fhnPK8gw==
X-Google-Smtp-Source: ABdhPJxgtDbIL+1jI9wJtuoA1iTVMO6Vorvpmtb9oFiZZP88vPnDl5qxMvejERQUy4V39XIwgxio/w==
X-Received: by 2002:a05:622a:18d:b0:2de:8f67:b7c4 with SMTP id s13-20020a05622a018d00b002de8f67b7c4mr16265955qtw.265.1646056984823;
        Mon, 28 Feb 2022 06:03:04 -0800 (PST)
Received: from [172.17.0.2] ([20.119.233.100])
        by smtp.gmail.com with ESMTPSA id g7-20020a376b07000000b006492f19ae76sm5046963qkc.27.2022.02.28.06.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 06:03:04 -0800 (PST)
Message-ID: <621cd618.1c69fb81.576d5.a45d@mx.google.com>
Date:   Mon, 28 Feb 2022 06:03:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2036761179641257601=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hdegoede@redhat.com
Subject: RE: Bluetooth: hci_bcm: Add the Asus TF103C to the bcm_broken_irq_dmi_table
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220228113841.476174-2-hdegoede@redhat.com>
References: <20220228113841.476174-2-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2036761179641257601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=618701

---Test result---

Test Summary:
CheckPatch                    PASS      1.64 seconds
GitLint                       FAIL      1.09 seconds
SubjectPrefix                 PASS      0.81 seconds
BuildKernel                   PASS      29.88 seconds
BuildKernel32                 PASS      26.63 seconds
Incremental Build with patchesPASS      36.71 seconds
TestRunner: Setup             PASS      475.23 seconds
TestRunner: l2cap-tester      PASS      13.80 seconds
TestRunner: bnep-tester       PASS      6.17 seconds
TestRunner: mgmt-tester       PASS      105.19 seconds
TestRunner: rfcomm-tester     PASS      8.00 seconds
TestRunner: sco-tester        PASS      7.81 seconds
TestRunner: smp-tester        PASS      7.68 seconds
TestRunner: userchan-tester   PASS      6.42 seconds

Details
##############################
Test: GitLint - FAIL - 1.09 seconds
Run gitlint with rule in .gitlint
[resend,1/1] Bluetooth: hci_bcm: Add the Asus TF103C to the bcm_broken_irq_dmi_table
1: T1 Title exceeds max length (84>80): "[resend,1/1] Bluetooth: hci_bcm: Add the Asus TF103C to the bcm_broken_irq_dmi_table"




---
Regards,
Linux Bluetooth


--===============2036761179641257601==--

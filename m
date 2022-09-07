Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5780DECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Sep 2022 08:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiIGI0C (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Sep 2022 04:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiIGI0A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Sep 2022 04:26:00 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244EE8E4DB
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Sep 2022 01:26:00 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id o13so4343729qvw.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Sep 2022 01:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=pHAVQeKIXx7e9RTZtV21FA6yBp7C04EmfWG8s/kQdiQ=;
        b=c6J2uQJcYi/i1MF3ous5AHIwJBy7D5/Nz+ntgQvKjnlYx2+C70Psa0ijeXUmjS0Sw4
         nnmhxy8mHkKvfu05kY5kdNfQnSXhAEeCLejOMGbb59CVg6Z1S3umnivG6hFgUlRTrDd5
         3ZD0aWXGpiaQ9di9EJUEDGI420kwtV+XsMcDLX4oX7UvKoSnHkB4PNqtFhIAOUnWFFFa
         mvHbocF1M2msoKW07icjSBOv3JxZrRUYdc4oFY4Q55mswCcSo6YCEwisSkfeWIKZJLJv
         nMOTId6ZFtBKIwCHCj1rZBcXyerPsslhLNMUHNIJJHtgXJslV2rXA88vOOsXNr2022mT
         Xbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=pHAVQeKIXx7e9RTZtV21FA6yBp7C04EmfWG8s/kQdiQ=;
        b=DDyqgaGKrLSidNLGIPhBpv3sgAwE+Q69Umv23PB+7NAPTXtAVBLuD3qx50KQxv9wyf
         9CheF9PdBPI9HBI+9uPXpo7CHbG7STK2XPWT2vNWfMxtABfdWtt4KmLB4smjLMNxl9yQ
         HyPjDrjZnuxpcBzXaI9XJ0ihLYX5qE1h19wfzHIO3+/jJhkUXPVpiJQEV1YmRmSMdSyu
         JGQrLsH5daEzI+9sN1+Jm0J7tluUY96bKuj/FRQ55cpaK8lUC/tyMNcr/hChIR0qeEez
         bh/BZ6/8EkGZwkeLrY6NpsAytmQEYpCCWN7ranmFvOha7d9zEqg9pfKnowTu3xWO310z
         S4Vw==
X-Gm-Message-State: ACgBeo1xOAC2MjOLo4GF20nbB6YPkulEsdB+pow302IWq72lpGrgrLI/
        HqrO+riopbx9K8TfLy1yZMf+kjOchnE=
X-Google-Smtp-Source: AA6agR5AP0XgGrKZzZknEPBi0EQrna33BA5ONOS1Quk12ICMp+O42oD9EDOhDA9iI+YgE8i931ZWkw==
X-Received: by 2002:a05:6214:f01:b0:477:7bdb:a020 with SMTP id gw1-20020a0562140f0100b004777bdba020mr1819506qvb.67.1662539159167;
        Wed, 07 Sep 2022 01:25:59 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.23.228])
        by smtp.gmail.com with ESMTPSA id s6-20020a05620a29c600b006bbda80595asm14391330qkp.5.2022.09.07.01.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 01:25:58 -0700 (PDT)
Message-ID: <63185596.050a0220.6a3ec.0a13@mx.google.com>
Date:   Wed, 07 Sep 2022 01:25:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6429820337127221320=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel: Mark Intel controller to support LE_STATES quirk
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220907071945.9925-1-kiran.k@intel.com>
References: <20220907071945.9925-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6429820337127221320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=674745

---Test result---

Test Summary:
CheckPatch                    PASS      1.91 seconds
GitLint                       PASS      1.02 seconds
SubjectPrefix                 PASS      0.85 seconds
BuildKernel                   PASS      36.62 seconds
BuildKernel32                 PASS      30.13 seconds
Incremental Build with patchesPASS      44.68 seconds
TestRunner: Setup             PASS      500.11 seconds
TestRunner: l2cap-tester      PASS      16.90 seconds
TestRunner: iso-tester        PASS      15.85 seconds
TestRunner: bnep-tester       PASS      6.28 seconds
TestRunner: mgmt-tester       PASS      100.95 seconds
TestRunner: rfcomm-tester     PASS      9.91 seconds
TestRunner: sco-tester        PASS      9.36 seconds
TestRunner: smp-tester        PASS      9.32 seconds
TestRunner: userchan-tester   PASS      6.46 seconds



---
Regards,
Linux Bluetooth


--===============6429820337127221320==--

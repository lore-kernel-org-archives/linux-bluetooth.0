Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8096CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Oct 2022 03:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJTDrB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Oct 2022 23:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJTDrA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Oct 2022 23:47:00 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4BE181943
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Oct 2022 20:46:59 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1324e7a1284so23121498fac.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Oct 2022 20:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rhFXyPeN/ymgBDMUIg6fhEZ+LyinTQMNRF0tNYg+gsM=;
        b=QRINEhDqk47iZxRnbxMRl8gUcG9wXKUXD2b4GAYR9Zr8NZTitQr/iIDxyTn9joakJ8
         fhfe6BUh6JKQmv0HsP0f/i98wrYCbINbzmCKDVpcO/f7iokO9fhc+IqaoMZFrIM33sEs
         8kdLFozFKp4kS+vUfv6Nyb4DibgOshV/nzgixr2EPom4bn7HksTNvW76PfjWbhVuAFR0
         lody2M2mQjt3Xrw4pATy0tGrLNCLo0HNT+XWubyam9L8mHDLy7EK8nTlY18yLHQlX4Hp
         ItylUnJ6ZN1qgkmhT0NRTbRCZiuhNgOV3kFNNvrK4MC8F0OsouhAO6Il2fAX2xUnyrwd
         GjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhFXyPeN/ymgBDMUIg6fhEZ+LyinTQMNRF0tNYg+gsM=;
        b=vVFwJXy6IQE30VhZQSFSC1prSokw+BXpdcWR6XUZIY2pKUAfQ0qdhN+IZGD2RSxn/B
         Eu6X4dgHCXR5/dEphr7cuFKFqlY1CI+OKY7oH7JFO9EYpNOx+5m32tav53KuLCT7oQu9
         w7avPp81Y27H38W5uyjyG83/2sz0l83RMK5WVrxtLYIEZ27aQGe6mV4D5O1qSwHM8It5
         rRMYKccdvPSpgv893ezrvqfotnYUx8H+PyXhitmvLcGUQ0IzdFYCJ8MvJ4LEZPGfark0
         3mgEJRA+sQYZ+URsMlKMsYZhIe4c7kPEmiUfLDRuprITDwGuOn0SMQGZX8rcNu7uIy7t
         aj5g==
X-Gm-Message-State: ACrzQf2dek1Uazd8h5U9m6BDpIqlwwrTm7f+kku8ZuK5dTOO6YA3PO4y
        wws0e26maF5KxD4DO5W2kED+EV4pNmg=
X-Google-Smtp-Source: AMsMyM6PTKnE8PlquPDQv4xIyXb7GJYbYa3m7eTVFgQPk7XQJZs3gyuUfpYJ6ab6PcFzlI+4GMJQvA==
X-Received: by 2002:a05:6870:c68b:b0:127:36e4:d437 with SMTP id cv11-20020a056870c68b00b0012736e4d437mr7413061oab.40.1666237618440;
        Wed, 19 Oct 2022 20:46:58 -0700 (PDT)
Received: from [172.17.0.2] ([20.165.71.166])
        by smtp.gmail.com with ESMTPSA id s4-20020a056870248400b00136cfb02a94sm8342055oaq.7.2022.10.19.20.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 20:46:58 -0700 (PDT)
Message-ID: <6350c4b2.050a0220.3189.1f84@mx.google.com>
Date:   Wed, 19 Oct 2022 20:46:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7229798453504415142=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yangyingliang@huawei.com
Subject: RE: [v3] Bluetooth: hci_core: fix error handling in hci_register_dev()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221020021656.2092938-1-yangyingliang@huawei.com>
References: <20221020021656.2092938-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7229798453504415142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=686951

---Test result---

Test Summary:
CheckPatch                    PASS      1.41 seconds
GitLint                       PASS      1.02 seconds
SubjectPrefix                 PASS      0.69 seconds
BuildKernel                   PASS      42.72 seconds
BuildKernel32                 PASS      37.57 seconds
Incremental Build with patchesPASS      58.28 seconds
TestRunner: Setup             PASS      625.48 seconds
TestRunner: l2cap-tester      PASS      19.61 seconds
TestRunner: iso-tester        PASS      21.09 seconds
TestRunner: bnep-tester       PASS      7.99 seconds
TestRunner: mgmt-tester       PASS      122.80 seconds
TestRunner: rfcomm-tester     PASS      12.63 seconds
TestRunner: sco-tester        PASS      11.65 seconds
TestRunner: ioctl-tester      PASS      12.91 seconds
TestRunner: mesh-tester       PASS      10.05 seconds
TestRunner: smp-tester        PASS      11.33 seconds
TestRunner: userchan-tester   PASS      8.13 seconds



---
Regards,
Linux Bluetooth


--===============7229798453504415142==--

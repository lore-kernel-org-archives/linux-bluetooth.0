Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DB7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Apr 2022 06:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359502AbiDTGVG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Apr 2022 02:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiDTGVF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Apr 2022 02:21:05 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C7B396BC
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 23:18:20 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id l127so1031777pfl.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 23:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=DonBWLiI6LuOnRRMQMF+LJ/sy6B51o7hSDZZDrBPtq0=;
        b=DAkxFBcCdfXWxjEQG2RcY7NaSLoHy9w4R0l0b4FzL7OJVbhXACh+XQeSwtNVLGwgqf
         bd1x4k0HX0dA9A5QdMLhxm+9VAf40+F+vKeGShtuwDm9Uha9s74hBAKBk4gr9Kxpr1De
         ySFNpLrOlP6wrvLMnaSB74Sj+nOlCzERXL3lNjbJRYpFHHaR5Y8miDRs1gVBvTXxreZt
         znfTMX/hCbV++F2qIn6+ctJpccRuLwdpgHElxWMGKI838h4I9ZtdSldz2r7yiNOkZcje
         21n9VZJciUW4+FNEVkgQDaQ+OwI+NQhjrf9RLV2fOtohQ8qsuXa9Xaw+5aOFmabOEwlo
         yuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=DonBWLiI6LuOnRRMQMF+LJ/sy6B51o7hSDZZDrBPtq0=;
        b=PXb9cMXLtgHAS+wPhJuCaB3HtwtYSpAwL4UBGmf7OFi1cuWUZZvVoXFJhGFrwS1GRj
         havnqmALhoKCoOsKJnLiv91atmbzaDHDN93JzW4gwiabNGtYySYfj61LqNDLT7A9/Fa2
         mekUxX3c6Ak7CGUXNpoUeTVkRXM4zr3yUdiFD4t37v4JgrIDd5MqHbK6MfsGZncJ0xZc
         ZdcXHLEF2VgGZx6yBA47P5fcVabtm1+xSllQE4Wj523pN8CyjWaZlYMT0b+Yiida7PGv
         eD1MAAId+Y7Nxg2N0jk2hzJax67KMVxRIk3Vz10AW1RK/M4H3FQSeQo5b2QLf7mM3lcc
         qm9Q==
X-Gm-Message-State: AOAM531m4LirYUq468krkfhqkPdvHVktvHBCtEDp41BNfAdTCLh4ZWB7
        KmDGYXhr/KeM54vvX28DCSCvKTKT9Ag=
X-Google-Smtp-Source: ABdhPJzb1sh4Ggg/pdcvFfF/R77XH0oOQ9uoy0SP9PtRaUYIPSkR0o6Cg5zRwCcrX8C1p7VeowpLBA==
X-Received: by 2002:a05:6a00:b4d:b0:509:1ed1:570e with SMTP id p13-20020a056a000b4d00b005091ed1570emr21752337pfo.19.1650435499732;
        Tue, 19 Apr 2022 23:18:19 -0700 (PDT)
Received: from [172.17.0.2] ([13.93.143.40])
        by smtp.gmail.com with ESMTPSA id e10-20020a17090a630a00b001c685cfd9d1sm17725823pjj.20.2022.04.19.23.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 23:18:19 -0700 (PDT)
Message-ID: <625fa5ab.1c69fb81.cc197.adac@mx.google.com>
Date:   Tue, 19 Apr 2022 23:18:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4893248645408534237=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tangmeng@uniontech.com
Subject: RE: Bluetooth: btusb: Add one Bluetooth part for the Realtek RTL8852BE
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220420052402.19049-1-tangmeng@uniontech.com>
References: <20220420052402.19049-1-tangmeng@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4893248645408534237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=633626

---Test result---

Test Summary:
CheckPatch                    PASS      0.87 seconds
GitLint                       PASS      0.44 seconds
SubjectPrefix                 PASS      0.31 seconds
BuildKernel                   PASS      38.50 seconds
BuildKernel32                 PASS      34.90 seconds
Incremental Build with patchesPASS      48.09 seconds
TestRunner: Setup             PASS      573.67 seconds
TestRunner: l2cap-tester      PASS      19.10 seconds
TestRunner: bnep-tester       PASS      6.96 seconds
TestRunner: mgmt-tester       PASS      121.05 seconds
TestRunner: rfcomm-tester     PASS      10.85 seconds
TestRunner: sco-tester        PASS      10.50 seconds
TestRunner: smp-tester        PASS      10.58 seconds
TestRunner: userchan-tester   PASS      7.38 seconds



---
Regards,
Linux Bluetooth


--===============4893248645408534237==--

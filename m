Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C511C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Feb 2022 23:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356076AbiBCX4k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Feb 2022 18:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiBCX4j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Feb 2022 18:56:39 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E4DC061714
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Feb 2022 15:56:39 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id g13so4047315qvw.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Feb 2022 15:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=VIhY7i72XU/+tJVcJn8NSVj8VXyLdqeVFFTISQ6P3pM=;
        b=DpHRU6ZZaE0/1iRO1p6mcHC7jZWU7pRhfHRqDtvy5S7c/L6SL5ebNosKRcr/YugNH5
         QjIsS79vMuxvIIvzLcVuPFCMaEAcaTnHRw20eu0fF1SUCGDAlbWot+ZrDSLeWlWMtPar
         VsLswz/sZ2mbUjQhTNGSl2FijD6wx0GepQHFZzFEWuRZIg6DavkD+WJ2qpsWr/2zsLbU
         YaNHtq7xBmKKjZDvZi5fats2fLwUlgqOpZyt710W6oRSpVvY1weEvsZ+PeOLptXq0Us9
         r7hpvSVex2Q28ZD3kIm0ic7xGWIDE4eocoscq0CJjCgFnNdgG8OLaL+HlMMQp7KeTtX5
         Rb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=VIhY7i72XU/+tJVcJn8NSVj8VXyLdqeVFFTISQ6P3pM=;
        b=IZ6k/YptupiW5Sv6N/zRUHmy7OJs3vB8e6QVfNwvdJHVaFMOE5wLwK5hsnglcDV1S9
         0C+LPJSwChc8a3c0mBMCxc2loEx3wfcF1BP6UoR29Wbzpn4bcZb/hz8XKOtrPsdyizMx
         KWugJiuwivDpPB6mKG77FFm9yhvx6yMi6ag/1fuz1d52fF8xrQ2UYaBYhL3wLhrBOifn
         j2y+ZLckXnjZcts22x2/v6xeQJbE8WPy9x05d3Gmq43hCri8+Hj6Mcld1Dhe0Dvqvl35
         YSwk2gm9FSNwegtC+QuznprZs0jGt2PXXA9Mht4uONxn/7E+NWNe0LArTo961PveKwVv
         jrlA==
X-Gm-Message-State: AOAM532VDS3Rtr7cCoGhrQuT5NIS70fS1dTA1HBjXL2cLaRXJ3BqGq2F
        npxdC+XkQ+6rSAC10h5OGmGUkw5Q43Y=
X-Google-Smtp-Source: ABdhPJxPO60x492xChW88waHaTeoiMnZPvRCd05SIUHiZr+B5s49EIWjzeKuXmICst1B0i3BwMgL3A==
X-Received: by 2002:ad4:4ee9:: with SMTP id dv9mr238764qvb.47.1643932598727;
        Thu, 03 Feb 2022 15:56:38 -0800 (PST)
Received: from [172.17.0.2] ([20.36.176.222])
        by smtp.gmail.com with ESMTPSA id h6sm210546qko.7.2022.02.03.15.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 15:56:38 -0800 (PST)
Message-ID: <61fc6bb6.1c69fb81.465ea.1326@mx.google.com>
Date:   Thu, 03 Feb 2022 15:56:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0725370332229665096=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kuba@kernel.org
Subject: RE: [net-next,v2] net: don't include ndisc.h from ipv6.h
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220203231240.2297588-1-kuba@kernel.org>
References: <20220203231240.2297588-1-kuba@kernel.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0725370332229665096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=611162

---Test result---

Test Summary:
CheckPatch                    PASS      2.48 seconds
GitLint                       PASS      1.04 seconds
SubjectPrefix                 FAIL      0.84 seconds
BuildKernel                   PASS      29.87 seconds
BuildKernel32                 PASS      27.10 seconds
Incremental Build with patchesPASS      36.95 seconds
TestRunner: Setup             PASS      475.73 seconds
TestRunner: l2cap-tester      PASS      13.66 seconds
TestRunner: bnep-tester       PASS      6.22 seconds
TestRunner: mgmt-tester       PASS      105.59 seconds
TestRunner: rfcomm-tester     PASS      7.60 seconds
TestRunner: sco-tester        PASS      7.76 seconds
TestRunner: smp-tester        PASS      7.59 seconds
TestRunner: userchan-tester   PASS      6.50 seconds

Details
##############################
Test: SubjectPrefix - FAIL - 0.84 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============0725370332229665096==--

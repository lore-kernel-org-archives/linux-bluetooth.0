Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E091C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Jul 2022 17:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiGURT4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jul 2022 13:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGURT4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jul 2022 13:19:56 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5767E817
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 10:19:55 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id b25so1772029qka.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 10:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=KeTSi0OBlEyInoVh7tkVcejLOLP+DUtm3m3xrsHHDoQ=;
        b=RGGPFqK/zUp0KsN9tNUx8uq4vgWn/F2Q+Peh7RBobEH2DVpGM8ZhQQpsMRK75hnLSo
         JmWeSIcddstg46dOQnGlU13z3UCDnTdxzubc9vXm09aIGkvOYTrlLBuGihvOZXzjhQFn
         3Jksog5NB163wbZoFlURjHurNlPApC8R0X1jB0vGMTQp1jTkT/ir7WbCxyHjd4MUtbKG
         HNyDxmI56eVj30B9nlSWATLEQQVuKNDN6zOMnUdKk4gq7lOFgdhuPM/vqYtFLgC/lR7P
         9d1Q/+3Nhv+cd+w4GSnNRKsDpG2W12DZ7dDFd/rA55sYAz15PQHcgEhadhaDYsnrNOtx
         V0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=KeTSi0OBlEyInoVh7tkVcejLOLP+DUtm3m3xrsHHDoQ=;
        b=7P1qEHLVM/P2h/g7/PEfkjZIIjVYBMGjegbdClVdsQhXQdV2Sy5VuWnm33HQTZDakJ
         QdqStZsHvMPn1/wTmb/m7FsqrGFckL+HHA1qJczLRRKaYTa3JOiw019grg0ojGj/ZLxB
         UNvVDerPnTo5rxA4JTUhEwuhsW3BfBFpjAzstyZfRlvUXB6aKk8h9WnjaolYup1Bbc86
         x+fYDcTT2sgelXCz4E7xf3GBS0eGEx2mJP3EARsMqQmFczPD4DT6FbDK99COXgzexDzo
         tlvaEqaabzrGej2Gqzp5BEwkEu7XF1TdWqp5DxIscjr3U/DTNj2I8vTrHzjbrjMkpT+5
         ObzQ==
X-Gm-Message-State: AJIora9K25LWvEhdg381B1OF9bTSVQRnQ1EI+fIeWJTDg8oNQc1P6ds1
        YDhBgiLSvguZWF6ejFTMxpwmypBQAHSWsg==
X-Google-Smtp-Source: AGRyM1seEjhAxo6llewmnU8uZJIFrLvl4+uzMoxo0ep60M8XPbkJZQWf6SBvyaonQgd+ynZJRDwE0Q==
X-Received: by 2002:a05:620a:2053:b0:6b5:ee04:9b6f with SMTP id d19-20020a05620a205300b006b5ee049b6fmr14079412qka.731.1658423994140;
        Thu, 21 Jul 2022 10:19:54 -0700 (PDT)
Received: from [172.17.0.2] ([40.87.71.197])
        by smtp.gmail.com with ESMTPSA id w27-20020a05620a0e9b00b006b61b2cb1d2sm1658850qkm.46.2022.07.21.10.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 10:19:53 -0700 (PDT)
Message-ID: <62d98ab9.1c69fb81.241b9.4ea2@mx.google.com>
Date:   Thu, 21 Jul 2022 10:19:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4003854992217872567=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: L2CAP: Fix use-after-free caused by l2cap_chan_put
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220721161050.305799-1-luiz.dentz@gmail.com>
References: <20220721161050.305799-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4003854992217872567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=661930

---Test result---

Test Summary:
CheckPatch                    PASS      2.01 seconds
GitLint                       PASS      0.96 seconds
SubjectPrefix                 PASS      0.80 seconds
BuildKernel                   PASS      34.13 seconds
BuildKernel32                 PASS      29.84 seconds
Incremental Build with patchesPASS      48.38 seconds
TestRunner: Setup             PASS      532.15 seconds
TestRunner: l2cap-tester      PASS      17.50 seconds
TestRunner: bnep-tester       PASS      6.00 seconds
TestRunner: mgmt-tester       PASS      100.59 seconds
TestRunner: rfcomm-tester     PASS      9.52 seconds
TestRunner: sco-tester        PASS      9.29 seconds
TestRunner: smp-tester        PASS      9.28 seconds
TestRunner: userchan-tester   PASS      6.13 seconds



---
Regards,
Linux Bluetooth


--===============4003854992217872567==--

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E78C77B7D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 May 2023 17:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjERRbn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 May 2023 13:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjERRbd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 May 2023 13:31:33 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5687510DF
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 May 2023 10:31:16 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7700622925fso58401939f.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 May 2023 10:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684431075; x=1687023075;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ropeubzv+KhwXNGImgpet1/Ptf7CfT5b8hw5sFhcGuI=;
        b=QpQae/ctZ5OmidVdb/pNFVwQCMNv+JFX1HktRLENRECRW0TxfmBLBBMikABjzLjg7n
         nir+je9R5fb/5ZRo+Dw5PHTOG0hFU/DjlprHQVBaBW7r2ITXZPOWPnENNgNhnDFMPEKQ
         XbxXIfecJnibuel9DxNun0NcyxLJOeFGwEO5h2ADC6fZXLOkKBBX8LlykWd/QCjxNCr/
         /hCxs8QX/nrMCCzhfxja/lrHiwHOc+7c5ffg2UbRpjFknDDEA+inc8hWhXnQZYyfWv7t
         6JQp8wV3rJ1htuyfQYUPKx91eflAJNQiu7GnxodOhYe4yP37eDiMp8jCC0C/F/rcrDtz
         HYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684431075; x=1687023075;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ropeubzv+KhwXNGImgpet1/Ptf7CfT5b8hw5sFhcGuI=;
        b=OsheN2NezHIvulzjWxPsdxXFjKGq+mqtNGHE9ME3Trh1NTgq6eFkPxhSXAjsb57WEZ
         7UYY+ny5el8qyeaHNdR7cD4e+8cjm277oIaBaOR/pMbLXiyeZF6SSUlvblwVdzXsjKUg
         icmfTBCrmPVQie/yZJXYKx1xSf/AWF8yE2aYy32ZyKcZX4Mwp/IUzbaclyYfbewx/60e
         FTRkeywuRB+CDKfkXgM95iVT3MU3vF021h87JrTLiVSX7uWm3byAyRSjjhu0OdDMCSre
         aKgawFKKsr7S+owrVlryepvg2lzhiFGiV25FV3Hn1fFv+HlrulIuBODc2NNgDvMwbhbt
         MIGw==
X-Gm-Message-State: AC+VfDwAJjH/NM9ARXT5Pv2iJVVz2qawff6byCw84tCQopb5TTTF2Ocf
        Gkr/RXz56OVtWfIBpVqcJ307to/0KJg=
X-Google-Smtp-Source: ACHHUZ4txALbaQPcxpXdBj9MOPy7aC+M5CwcBJ5IkAkSt5h7HpALSxqNbHldAziM3GAyXPLHiW0v8Q==
X-Received: by 2002:a6b:620e:0:b0:76c:5641:136 with SMTP id f14-20020a6b620e000000b0076c56410136mr6343387iog.0.1684431075393;
        Thu, 18 May 2023 10:31:15 -0700 (PDT)
Received: from [172.17.0.2] ([40.122.243.241])
        by smtp.gmail.com with ESMTPSA id q16-20020a02c8d0000000b0041a9e657035sm615823jao.48.2023.05.18.10.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 10:31:15 -0700 (PDT)
Message-ID: <646660e3.020a0220.9c89f.0b55@mx.google.com>
Date:   Thu, 18 May 2023 10:31:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3436485566738360660=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v3] Bluetooth: btnxpuart: Fix compiler warnings
In-Reply-To: <20230518164347.2531983-1-neeraj.sanjaykale@nxp.com>
References: <20230518164347.2531983-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3436485566738360660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=748984

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      31.85 seconds
CheckAllWarning               PASS      34.59 seconds
CheckSparse                   PASS      39.11 seconds
CheckSmatch                   PASS      109.45 seconds
BuildKernel32                 PASS      30.46 seconds
TestRunnerSetup               PASS      437.95 seconds
TestRunner_l2cap-tester       PASS      16.53 seconds
TestRunner_iso-tester         PASS      20.16 seconds
TestRunner_bnep-tester        PASS      5.28 seconds
TestRunner_mgmt-tester        PASS      111.51 seconds
TestRunner_rfcomm-tester      PASS      8.48 seconds
TestRunner_sco-tester         PASS      7.91 seconds
TestRunner_ioctl-tester       PASS      9.16 seconds
TestRunner_mesh-tester        PASS      6.71 seconds
TestRunner_smp-tester         PASS      7.80 seconds
TestRunner_userchan-tester    PASS      5.61 seconds
IncrementalBuild              PASS      29.00 seconds



---
Regards,
Linux Bluetooth


--===============3436485566738360660==--

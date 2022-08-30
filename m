Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB45EECAAD5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Aug 2022 03:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiH3Dpl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Aug 2022 23:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiH3DpK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Aug 2022 23:45:10 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D560D72
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 20:44:47 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id d18-20020a9d72d2000000b0063934f06268so7288150otk.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 20:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=HG4A5Got2WGDRD4E4UKrQc6x81EfUmJdMcNk1WUvotw=;
        b=IW6c+TJaXq8lCIj5NKptzBpP+FUJ6TwuKGhvoD0UweP6oYf1pgz+yRnCQokCDLnKe+
         shccpH/0oo1hqw9p/sP7m8D3JE2pZcUlHsa4/QTOsoeLmGRGrw30nwRz2WUZFl7MGEB1
         IzYe8Xn9dmn6YRN5IIbIaGvzVrpLz5RxEEccsw2xza5XsO6ljNXKyoVGg7/YKVRlTDXm
         Sn8kpKKMvF84VgokuP9pHmFYBehrXoXmZX/MQizL+ryHVDUtmtki6cqcuGspDwahKAfm
         EL2knm+/XMtofnCaoi3QjLijk88UFTMac7juRErg9ievb8J0xnz1amXspbog6MSvetmH
         fX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=HG4A5Got2WGDRD4E4UKrQc6x81EfUmJdMcNk1WUvotw=;
        b=dfe9QSKtTFpAysvuR2jKrDpFZ5+fjgvUGzmO8F6GxYUaldkqPdPtMOqIS7x0c7guQj
         yE6mOiUgqz9viTx4PxUoEX9faAfovBLp2ktNMJZuy8S9u/gn+t+BaMkXvSmsWW3mihnh
         7InF8QDUhLFGTewFOawVaKVwC43uMrX92xWbake5yhsvlBasGCvX7mf9Uh1Ohtr51F10
         dvpR9oUc4/w8L9LLjaYY4P3UozzhsVpVNrbnoWEXwA9oFjXFcnQpJyIOx2O2LliaxtmW
         X07U1TqKkRoo6lEfSvNgqLRzM3iT2DT5Oxremv3auhRFtw6/shvQCoZUl7ePGIUA7eE1
         YRKw==
X-Gm-Message-State: ACgBeo0zc+MkAZMLgi0NPwTBbcB4jM8XhABMdfp1xK/sehMjPy4QMNNI
        RYNVWNDGDRrbFK2v6tjKSOVmxgCtsvs=
X-Google-Smtp-Source: AA6agR7GyJq4PQO4Wau0RtK7zS08evNVqXUIw/f3OuRGq7e6DmWzOQJBcELLbMMOmZ6+a3Q9z6MSCg==
X-Received: by 2002:a05:6830:6385:b0:61d:357:2077 with SMTP id ch5-20020a056830638500b0061d03572077mr7678293otb.359.1661831086589;
        Mon, 29 Aug 2022 20:44:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.225.176.141])
        by smtp.gmail.com with ESMTPSA id e20-20020a4ab994000000b00441c26f8fadsm6080704oop.12.2022.08.29.20.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 20:44:46 -0700 (PDT)
Message-ID: <630d87ae.4a0a0220.efd17.fc61@mx.google.com>
Date:   Mon, 29 Aug 2022 20:44:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1074565701279190571=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, abhishekpandit@google.com
Subject: RE: Bluetooth: Call shutdown for HCI_USER_CHANNEL
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220829195805.1.Ic8eabc8ed89a07c3d52726dd017539069faac6c4@changeid>
References: <20220829195805.1.Ic8eabc8ed89a07c3d52726dd017539069faac6c4@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1074565701279190571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=672250

---Test result---

Test Summary:
CheckPatch                    PASS      1.82 seconds
GitLint                       PASS      0.76 seconds
SubjectPrefix                 PASS      0.61 seconds
BuildKernel                   PASS      40.97 seconds
BuildKernel32                 PASS      34.06 seconds
Incremental Build with patchesPASS      51.14 seconds
TestRunner: Setup             PASS      570.93 seconds
TestRunner: l2cap-tester      PASS      18.81 seconds
TestRunner: iso-tester        PASS      18.14 seconds
TestRunner: bnep-tester       PASS      7.05 seconds
TestRunner: mgmt-tester       PASS      113.87 seconds
TestRunner: rfcomm-tester     PASS      11.04 seconds
TestRunner: sco-tester        PASS      10.56 seconds
TestRunner: smp-tester        PASS      10.38 seconds
TestRunner: userchan-tester   PASS      7.54 seconds



---
Regards,
Linux Bluetooth


--===============1074565701279190571==--

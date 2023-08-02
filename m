Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FF6C00528
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 07:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjHBHgd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Aug 2023 03:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjHBHgQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Aug 2023 03:36:16 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C68630C4
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Aug 2023 00:35:54 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-55b22f82ac8so430308a12.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Aug 2023 00:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690961753; x=1691566553;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=50kCy6BvAmc3da1qrtnxyyZUrkaAJyNbKGex+Q0v1uQ=;
        b=oSYQK8uBouk6kkh0uG773PIMvNRJ/gRzDCtJRYcUvkpGUqg9C2OUo7kQMPx3WDeM2Y
         Bbp8eaViuSDpfAUHUyR9jvYQoTChwCAcCLrSYdA6CtMI9hpnsI2fieEyzZaI6hB+2aU9
         TymMQeoB+y7LiqGK96u5L9rEnXGdiZ+nE2Zt3j60r3kUAXk811aHL2ehXL0lE76OeGs2
         npv6cvfcO753UfZzPv9pkshTbigariipooOKT+gpdRL+BitWhmpHmve9XJ3I5CunxBBo
         EjfBq/NOefWppfy5PMlbFZeT1372FShdjtadmfA/kJOhS0auB1+5wj621QZrBl+UfPKR
         21CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690961753; x=1691566553;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50kCy6BvAmc3da1qrtnxyyZUrkaAJyNbKGex+Q0v1uQ=;
        b=DxeMW82lKFpipCMWk1pNZmbqG8Wka3EvkXb5stN3uTX16B/bb2rc0Ehv9bWCPVx8Dp
         u78o59Lwmq1AbAVC5QLsDCRiD9BtGTCVNdhjbEwVUYbRQlgip7SwdnQzG5/u+N1f/wqD
         AAqDZ+CmxDxubyqAHrTupfnPqtbW9qQEQJVtgLrY2wq1vzA8PUW3v6li7JrWa0ZtUmkQ
         cm8AS3okaPjSFL3vdbpy6SDa2DnC6HnE/PaCyfhacmGWnJzONagp/CwpccJaTF+jR5Qc
         Paa95UkLIf0QglM9lqsGkngrIbCIZuFbArohDKrmfwMBRxCnxV4XlsnMKaIfGEs2JytB
         QPPA==
X-Gm-Message-State: ABy/qLa558OeqvaFOQNUrmkuqjIniX4bH/zdYwaQwxsQElu2NV0HIKit
        aG7v1i8km/Io/KYY1KnmPN4ceJASCEs=
X-Google-Smtp-Source: APBJJlEQKLiSqPVIz3TkfkXocUo0I2p6xmywsqzYWJ7pCCfDV3TLfu1hEG841BaUHKy9RaHp0ctryw==
X-Received: by 2002:a17:90a:5504:b0:268:1237:1943 with SMTP id b4-20020a17090a550400b0026812371943mr18676910pji.18.1690961753448;
        Wed, 02 Aug 2023 00:35:53 -0700 (PDT)
Received: from [172.17.0.2] ([13.87.244.207])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090ae00200b00267e299f71dsm572729pjy.7.2023.08.02.00.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 00:35:53 -0700 (PDT)
Message-ID: <64ca0759.170a0220.f8e23.106f@mx.google.com>
Date:   Wed, 02 Aug 2023 00:35:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5532712771018481465=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luca.weiss@fairphone.com
Subject: RE: Add WCN3988 Bluetooth support for Fairphone 4
In-Reply-To: <20230802-fp4-bluetooth-v3-1-7c9e7a6e624b@fairphone.com>
References: <20230802-fp4-bluetooth-v3-1-7c9e7a6e624b@fairphone.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5532712771018481465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=772019

---Test result---

Test Summary:
CheckPatch                    PASS      1.41 seconds
GitLint                       PASS      0.49 seconds
SubjectPrefix                 FAIL      0.45 seconds
BuildKernel                   PASS      34.12 seconds
CheckAllWarning               PASS      37.35 seconds
CheckSparse                   PASS      42.35 seconds
CheckSmatch                   PASS      114.38 seconds
BuildKernel32                 PASS      32.91 seconds
TestRunnerSetup               PASS      502.09 seconds
TestRunner_l2cap-tester       PASS      23.78 seconds
TestRunner_iso-tester         PASS      43.12 seconds
TestRunner_bnep-tester        PASS      10.73 seconds
TestRunner_mgmt-tester        PASS      218.39 seconds
TestRunner_rfcomm-tester      PASS      16.22 seconds
TestRunner_sco-tester         PASS      17.27 seconds
TestRunner_ioctl-tester       PASS      18.37 seconds
TestRunner_mesh-tester        PASS      13.81 seconds
TestRunner_smp-tester         PASS      14.59 seconds
TestRunner_userchan-tester    PASS      11.37 seconds
IncrementalBuild              PASS      36.70 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============5532712771018481465==--

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F004C4167D
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Nov 2023 07:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjKFHAY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Nov 2023 02:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjKFHAW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Nov 2023 02:00:22 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BD813E
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Nov 2023 23:00:19 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-66d060aa2a4so29373936d6.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Nov 2023 23:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699254018; x=1699858818; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YdzonsWueQjep1otcIoDfeOUsPqxve5R4PTSpO2qB04=;
        b=UkSdQTRWyS12uG88nSYQb0e3xFroJG5mMeCqodOdpwjIpUiOsGxrtlQqbwDzYNNL4a
         B0ElbjvrBKokMTwnoF1paKph/bBEVKgf/FceakkSTbgLer2sQNvo2MfrJ5bgsnhQXd3Y
         SUJXu1OgjsgcEyUWxwuGaaBmR4v+1cBF+3ni+SyBU/wY0afgcqJCBB16X95zZRnIBBjz
         jzQqKe/UEg9qlIUE7Zcvf36/T0JD87kWokF7mi9FhDI/Gzw+7ujCrdECWdGiqK5eLC82
         +LbnsQpd4oYjN6jBwlgymH1B5tPtT9hEahonWjDIangwj9+NFvjdMdFzbkLvODBl4wt6
         ZlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699254018; x=1699858818;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YdzonsWueQjep1otcIoDfeOUsPqxve5R4PTSpO2qB04=;
        b=ipZhMJbM++TtESUkETTOH064If1jpv8TKXffccqHai27mcb+1N/kHijG2biqp3Sk39
         3U6H5xU2FA7lVmtnoUvica8G48kufbG3PxTYCs0nm35WLo7LKYcHRmGikD5qic0oYA3D
         XzH+9OwAZHvoqXE/m68O9vew164pmJJQ34/WV0NHhfd1LXsHSbS6IdxJeVe0zCSWPCtm
         RTkfu4rQs5XEiLviRgcUgmLG0i7mFpNFoPgddNPkBWyT6LVSEeVHHsO1wB1LwCh8bWKW
         p3zVX4zwSkxid9sAuiYoqCleDIanYfj2Z5kj1tW7fSo0q8mtXs9CLIJD8u81FmnREWIo
         haAA==
X-Gm-Message-State: AOJu0Ywnkvsx/5hC5SA12sSMy5uxADSSeXG6kiINPS/Y9XNjj36cgSqh
        l1zAhIhpFZDK+8EWJTC27CxZi1amOzJEow==
X-Google-Smtp-Source: AGHT+IG62bAmQxAHWKVQ8SVjWl4j3NGeJBd3pOW3Xkd9V1URJXb7vJSwcAXSakAM736Dp2kk5/OHJQ==
X-Received: by 2002:a05:6214:19c3:b0:670:63bc:a2ca with SMTP id j3-20020a05621419c300b0067063bca2camr30792122qvc.28.1699254018436;
        Sun, 05 Nov 2023 23:00:18 -0800 (PST)
Received: from [172.17.0.2] ([20.55.46.112])
        by smtp.gmail.com with ESMTPSA id s10-20020ad4524a000000b00670c15033aesm3158108qvq.144.2023.11.05.23.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 23:00:18 -0800 (PST)
Message-ID: <65488f02.d40a0220.2aac2.bfe5@mx.google.com>
Date:   Sun, 05 Nov 2023 23:00:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4669335043164123822=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: Bluetooth: Support SCO offload for QCA2066
In-Reply-To: <1699251565-28759-2-git-send-email-quic_zijuhu@quicinc.com>
References: <1699251565-28759-2-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4669335043164123822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=798985

---Test result---

Test Summary:
CheckPatch                    PASS      1.25 seconds
GitLint                       FAIL      0.94 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      27.61 seconds
CheckAllWarning               PASS      30.20 seconds
CheckSparse                   PASS      35.48 seconds
CheckSmatch                   PASS      98.58 seconds
BuildKernel32                 PASS      29.28 seconds
TestRunnerSetup               PASS      427.69 seconds
TestRunner_l2cap-tester       PASS      23.08 seconds
TestRunner_iso-tester         PASS      46.62 seconds
TestRunner_bnep-tester        PASS      7.08 seconds
TestRunner_mgmt-tester        FAIL      180.03 seconds
TestRunner_rfcomm-tester      PASS      11.19 seconds
TestRunner_sco-tester         PASS      14.49 seconds
TestRunner_ioctl-tester       PASS      12.27 seconds
TestRunner_mesh-tester        PASS      8.76 seconds
TestRunner_smp-tester         PASS      9.78 seconds
TestRunner_userchan-tester    PASS      7.43 seconds
IncrementalBuild              PASS      31.31 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1,1/2] Bluetooth: hci_conn: Check non NULL before calling hdev->get_codec_config_data()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (89>80): "[v1,1/2] Bluetooth: hci_conn: Check non NULL before calling hdev->get_codec_config_data()"
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 496 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
Pairing Acceptor - SMP over BR/EDR 2                 Timed out    2.358 seconds


---
Regards,
Linux Bluetooth


--===============4669335043164123822==--

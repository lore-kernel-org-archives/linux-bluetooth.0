Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CBAC6FD19
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Mar 2023 15:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjCMPdm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Mar 2023 11:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjCMPdl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Mar 2023 11:33:41 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD971A48F
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 08:33:40 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id q6so5164339iot.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 08:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678721619;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WSGualRuVLvvbdGlMyPwJmtghXKtFI9+f6GE52zX2Nk=;
        b=EH+XobiXiSnvvTCI86kGzzovcknwHG4B8B5mPJvfXR1+BY0zbtWN+YesQC5Fv3IetD
         D3MwfxPZxJlMVF+WaSm8C609O04RM1bQ6oIrqfgAMLxhykYc8LzsL5VqV85Sl5FpozX+
         UEDRvtg38hNk/cLcWqeSh8+uUg8oM1U2eN9XcpdXz9cSXN4B9s2fQ/yP2jBPdTXKHXzG
         /CDKfGHyO0VJoVzejeKBIOzxWmvts2facau2iTZ3f0d0ZUyH3BB2Xku7mwOBW4djIKJH
         X1VBb9ZY2dpDvms/hAJ1UZrJgS4/dsqH8w8tWtdqznNSCDdHnrLZCzx2CNsgIl2xcm+U
         YAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678721619;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSGualRuVLvvbdGlMyPwJmtghXKtFI9+f6GE52zX2Nk=;
        b=ut0+6eCaVAsnUJ7odG2Z+xleJqCKjDtgscNz8ZPzKFN5z4qNeKdXJ2er3yCuevnPvD
         ESf/eCZHfUQPP16EZnJHWEEzJg050eYqpdvxT8SQxccBHlW8SJfmP4uwQawYhWKrwNIr
         pVUwutPUT1Mfv1i2JjDFd0kO290T1FmioOTFyumqIX98dcsZwbSU8QZ/MxQSEGA64RW8
         FqWpQU1zaYr72GKMZvSWr6LE4OCgMsa7mDC6aiAib57UgxRc83U3HwgWqlmk26AmCHmm
         q8+Nn9TU3zoyDOLwoB2FJzGfho/ghtfvmdMBX01edKWzSG4xuCbUTSrcsS3nKV3p/KsG
         o6xw==
X-Gm-Message-State: AO0yUKV0hULLE4gTUwpWC7LBi3tcI7dPSBGnMUj7dJBSPs1Rtt/grAxC
        CDjAplWr8bnERrGPtMTE+b3Aw63mVOg=
X-Google-Smtp-Source: AK7set/UROGHimONjiOUyzcY2s97TJu0BiXEhk3F7RyX2g4saphRfFO2l96tjxrazCHoqi/H85RqRg==
X-Received: by 2002:a5d:898a:0:b0:74c:aa1d:c1a1 with SMTP id m10-20020a5d898a000000b0074caa1dc1a1mr19880410iol.3.1678721619571;
        Mon, 13 Mar 2023 08:33:39 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.92.117])
        by smtp.gmail.com with ESMTPSA id y2-20020a02c002000000b0036cc14af7adsm2587674jai.149.2023.03.13.08.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 08:33:39 -0700 (PDT)
Message-ID: <640f4253.020a0220.c5c16.3306@mx.google.com>
Date:   Mon, 13 Mar 2023 08:33:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4922004137457062156=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: Add support for NXP bluetooth chipsets
In-Reply-To: <20230313144028.3156825-2-neeraj.sanjaykale@nxp.com>
References: <20230313144028.3156825-2-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4922004137457062156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=729478

---Test result---

Test Summary:
CheckPatch                    PASS      4.08 seconds
GitLint                       FAIL      1.13 seconds
SubjectPrefix                 FAIL      0.57 seconds
BuildKernel                   PASS      32.11 seconds
CheckAllWarning               PASS      35.46 seconds
CheckSparse                   PASS      40.17 seconds
CheckSmatch                   PASS      108.38 seconds
BuildKernel32                 PASS      31.69 seconds
TestRunnerSetup               PASS      447.01 seconds
TestRunner_l2cap-tester       PASS      17.47 seconds
TestRunner_iso-tester         PASS      17.68 seconds
TestRunner_bnep-tester        PASS      5.80 seconds
TestRunner_mgmt-tester        PASS      113.07 seconds
TestRunner_rfcomm-tester      PASS      9.23 seconds
TestRunner_sco-tester         PASS      8.41 seconds
TestRunner_ioctl-tester       PASS      9.93 seconds
TestRunner_mesh-tester        PASS      7.26 seconds
TestRunner_smp-tester         PASS      8.25 seconds
TestRunner_userchan-tester    PASS      5.99 seconds
IncrementalBuild              PASS      37.51 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v10,2/3] dt-bindings: net: bluetooth: Add NXP bluetooth support

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
19: B1 Line exceeds max length (87>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============4922004137457062156==--

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02577C77B7E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Jun 2023 09:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjFAJ5e (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Jun 2023 05:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjFAJ5V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Jun 2023 05:57:21 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F086186
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Jun 2023 02:57:13 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-62603efd2e3so6206976d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Jun 2023 02:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685613432; x=1688205432;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HJplrBL5oJ6UqgDqFtXz8+X1q3vl67HVQn8MGAMceq4=;
        b=VbfJiClkB14D+zIFms+iTXvz4mgnE20LJuXCl02M4YxUGoxTA0mJWzfFthM0B8Tr4v
         dwCUPNrhgDfyZ0W0ZCvsMKzo9yuJQtAALsrZGE+ngaSe53crPuonXZMQASEfr9JUokDW
         Brn5OCyqZzQD0imYht4ZI5P3t3MDU0rfFhliSxSpzdeh7rzY0SzUx2XyS4HgaZloxl5J
         KXNd65httZ5gR/Jt00KKH7cJ1q6Bej1VLYPMqmRrvbAP5MomHGwDIf72OpF28BfeFrGT
         RoucHCLn0jUGWZTXEAVWFqEBzFFQMjq4zJEFFyKaOKOyfjkP9BzmVtitx48c2rwATfQr
         MmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685613432; x=1688205432;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJplrBL5oJ6UqgDqFtXz8+X1q3vl67HVQn8MGAMceq4=;
        b=k3YwoXUJyjESCg/3uD9SacaUQmyIlDTUzYNh9xe5SqKcCBgaaUKTm0IOiH5BIRvF8I
         uvK1aPfGlrYE7qOYSRDtv3YgPj8ilR3cH0FU4PzMD+nktje8831uF0ET+/rZ1go+j+Qe
         OVlwgtfJ8xi5l0Pw8S3HB/FKK2cQjjjRojcMrpF/nKyIv86ZjxrIhVuytE3hPlEZcWGZ
         Mvg+podi6hyRPXS0omVug0Kvt+rzdyt/q9dRiJEXo3zAeVSW1CNIApGxMypfnYtVZvQa
         4LlZPRgQI8978vTywxyTYlXeuY15dUTIfFjfZCLkpFd5HIU20XshzsAetjkVDCvt5cUM
         cziw==
X-Gm-Message-State: AC+VfDzm72fJv9+V0ZrJ13678VQm0a/8RFGPvTR+oVu4WKkz4kOL1S4I
        ty58ks1VjlfFtkj4+44KllCZFfz0nQc=
X-Google-Smtp-Source: ACHHUZ6Cfc6npYq0diHiGIJTrXQChpuy9KPRGsfXDhGxB0Xd2vEHvm+kdlwC5REwFvaWDcXU0fbXiQ==
X-Received: by 2002:ad4:5b8c:0:b0:623:6822:ff6e with SMTP id 12-20020ad45b8c000000b006236822ff6emr8668768qvp.7.1685613432314;
        Thu, 01 Jun 2023 02:57:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.124.86])
        by smtp.gmail.com with ESMTPSA id ej8-20020ad45a48000000b006263a9e7c63sm2894622qvb.104.2023.06.01.02.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 02:57:12 -0700 (PDT)
Message-ID: <64786b78.d40a0220.e7677.a462@mx.google.com>
Date:   Thu, 01 Jun 2023 02:57:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2222692187884021064=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_tjiang@quicinc.com
Subject: RE: [v8] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA2066
In-Reply-To: <20230601091355.18097-1-quic_tjiang@quicinc.com>
References: <20230601091355.18097-1-quic_tjiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2222692187884021064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=752993

---Test result---

Test Summary:
CheckPatch                    PASS      1.10 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      32.01 seconds
CheckAllWarning               PASS      35.53 seconds
CheckSparse                   PASS      40.10 seconds
CheckSmatch                   PASS      112.17 seconds
BuildKernel32                 PASS      31.08 seconds
TestRunnerSetup               PASS      442.96 seconds
TestRunner_l2cap-tester       PASS      16.80 seconds
TestRunner_iso-tester         FAIL      22.34 seconds
TestRunner_bnep-tester        PASS      5.37 seconds
TestRunner_mgmt-tester        PASS      112.84 seconds
TestRunner_rfcomm-tester      PASS      8.59 seconds
TestRunner_sco-tester         PASS      7.94 seconds
TestRunner_ioctl-tester       PASS      9.22 seconds
TestRunner_mesh-tester        PASS      6.89 seconds
TestRunner_smp-tester         PASS      7.81 seconds
TestRunner_userchan-tester    PASS      5.63 seconds
IncrementalBuild              PASS      29.71 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 80, Passed: 75 (93.8%), Failed: 5, Not Run: 0

Failed Test Cases
ISO AC 6(i) - Success                                Failed       0.219 seconds
ISO AC 7(i) - Success                                Failed       0.218 seconds
ISO AC 8(i) - Success                                Failed       0.217 seconds
ISO AC 9(i) - Success                                Failed       0.218 seconds
ISO AC 11(i) - Success                               Failed       0.219 seconds


---
Regards,
Linux Bluetooth


--===============2222692187884021064==--

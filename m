Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14340C77B7F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 May 2023 11:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbjEPLbq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 May 2023 07:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjEPLbp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 May 2023 07:31:45 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D591BF6
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 May 2023 04:31:42 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-44fb148ccbcso4996096e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 May 2023 04:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684236701; x=1686828701;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w3w5pgL5Z2TSQDwcExVfKsnua1wxJKDclo5tRFGTOCc=;
        b=c7ssq9NhDU4iI4CnWX4n3QZanSUSZ1+/6xhrMepW8Qbi6UwHneiK1DKaXYlPQHnjqZ
         Nbvw+X5cqFWhSi369QFEV4lO4NZS1V8h3FKlTDlwFxTzOWNF5KozR1GIhgAXdn6mnsHk
         dbfy+2TZ5P3GgSuAtMAmzXd/1KB7gsJ/rQg4tRr4WTPfkWQ4P2XZL3WUuO/dJqQwpCSe
         ZAivdA4TQyPaA17AI19wCRKtp1vcBg3n/CEG5FT3St8K6fueojMSg4FgLvDqpuxIzueV
         NHtpqvo8te/zOQIfpT40K8Is7vaCYc9TfOMU1bU7iPrn6sSGiLIMNsOwLs+Qvk1rNOS1
         tAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684236701; x=1686828701;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w3w5pgL5Z2TSQDwcExVfKsnua1wxJKDclo5tRFGTOCc=;
        b=SYxds4GNE4Hlrd0yM8XZ4mpRsit6uJD+wbDAl4Xd+MHDtxkb0X45C8uWiH2r13YBbo
         4ZXYIaaS53GnPZoHsbF4siHD9UgdZY51Fe6mlL00/MbCsk7vLbHTRnBfoBsrbz6hFGqF
         l7EBhyHopsBGWlnWy3olV6S7XEQAZQhCRi0Oqw4sxrLPNByaK7dZOTrDlk88Hnmxp1tb
         +H0TWeuTaYz8hYQKeObDkQwWdC5elxPesn80ApbBkXaGMUW6hfH8bwL6KPVqakEBIcjH
         6cyNJmdYFqFtmFYJ3N38jqWnHBVJDHRZzKwWMr9S/83ktKsoWvpkdpXHveVfIxyJvRh5
         Gmmg==
X-Gm-Message-State: AC+VfDyb/TpYHiDSPklvmrIslAuhSkKsviV4Gl0KYVPaF8XdtZ18rSIc
        E74yH2bTRYww+civjVHeWgAQnbAdcB7i+w==
X-Google-Smtp-Source: ACHHUZ5CW3fS8d6ZbneZosKHWnN9gI0+VOkbp4QbvpgJxOTJyHvD6W2+qg4NFB8++N+IYQstAuPLeg==
X-Received: by 2002:a67:fac8:0:b0:436:1156:ff5d with SMTP id g8-20020a67fac8000000b004361156ff5dmr9259895vsq.29.1684236700891;
        Tue, 16 May 2023 04:31:40 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.73.8])
        by smtp.gmail.com with ESMTPSA id h13-20020a05620a13ed00b007578b6d060bsm515467qkl.126.2023.05.16.04.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 04:31:40 -0700 (PDT)
Message-ID: <6463699c.050a0220.5f4d4.2464@mx.google.com>
Date:   Tue, 16 May 2023 04:31:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2754477107705708923=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_tjiang@quicinc.com
Subject: RE: [v3] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA2066
In-Reply-To: <20230516104102.30775-1-quic_tjiang@quicinc.com>
References: <20230516104102.30775-1-quic_tjiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2754477107705708923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=747936

---Test result---

Test Summary:
CheckPatch                    FAIL      1.54 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      32.68 seconds
CheckAllWarning               PASS      36.26 seconds
CheckSparse                   WARNING   40.98 seconds
CheckSmatch                   PASS      110.76 seconds
BuildKernel32                 PASS      31.97 seconds
TestRunnerSetup               PASS      456.37 seconds
TestRunner_l2cap-tester       PASS      17.27 seconds
TestRunner_iso-tester         PASS      21.45 seconds
TestRunner_bnep-tester        PASS      5.68 seconds
TestRunner_mgmt-tester        PASS      117.50 seconds
TestRunner_rfcomm-tester      PASS      9.33 seconds
TestRunner_sco-tester         PASS      8.43 seconds
TestRunner_ioctl-tester       PASS      9.87 seconds
TestRunner_mesh-tester        PASS      7.24 seconds
TestRunner_smp-tester         PASS      8.28 seconds
TestRunner_userchan-tester    PASS      6.00 seconds
IncrementalBuild              PASS      30.11 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA2066
WARNING: DT compatible string "qcom,qca2066-bt" appears un-documented -- check ./Documentation/devicetree/bindings/
#280: FILE: drivers/bluetooth/hci_qca.c:2372:
+	{ .compatible = "qcom,qca2066-bt", .data = &qca_soc_data_qca2066},

total: 0 errors, 1 warnings, 161 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13242913.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btqca.c:629:17: warning: restricted __le32 degrades to integerdrivers/bluetooth/btqca.c:713:24: warning: restricted __le32 degrades to integer


---
Regards,
Linux Bluetooth


--===============2754477107705708923==--

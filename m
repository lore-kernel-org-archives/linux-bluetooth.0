Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C32C7619A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Mar 2023 01:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjC0BLe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 26 Mar 2023 21:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjC0BLa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 26 Mar 2023 21:11:30 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AF6558D
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Mar 2023 18:11:29 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id s7so3857277ilv.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Mar 2023 18:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679879488;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aqQkrDzm8caCH1uMWRZhPrKK4sQSaiTmc5EzeXO2SVs=;
        b=hEfbj6Di1Owb6MG0MWgkCUxJ8vXZ0xORNbEA9xDPK3Oo1wYZ6fJdCBiUjanTiwCd3R
         eZHXeIxdfLsUTRKFqHxAT4QVHuWSy7jALeGYN2/QpMSeSj2pvSia/FYeWXmO8ic+FYj1
         142gDiLf8xgh3SyJIfHmDFonM9Og01rdacye0YSfOyenUnRDDoXx87uJ1xnmCBL6Vd1o
         64vdAnvYZzkNMKU1HDi6gtm6MHAqKht2lLrzMm0OdoM1u5zoh8eJb7BZq/XNtrI34iuV
         MQEWlW0Lu2mcZDXnMykVG9PTAqraxvJ0Dpo89qx7QT9nmpgVjFtcMGam6icFE3TprOCZ
         WzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679879488;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aqQkrDzm8caCH1uMWRZhPrKK4sQSaiTmc5EzeXO2SVs=;
        b=NyLmY9iwHiPh2j7gLGrPZSLdRd7Uc5zKnEl2bttfBmmSTP5cOpOMTNVkBdJzanA/M2
         BFwUY4mDCBUpfVzksb0FTfugto9kQorb9S0hfQvSmmrcw01dKkdrzX6R1rOJHn9Qm+ff
         P1s4ssOAHM5fz9x10srECIHlT4tH8CRsS/HN9gEJSMdx09ngokqKopWagHcBaMkADBy9
         2MuhYj39Wtm7RDKL4O9URbhaNSRECsrnNbleFM6G6YdsPx5anokZfeSS/zm7yUYFlONQ
         UzsbzCouiwDQuG1KSR6rx4MfvT6AHZoARC6mRBYUIdoLJ+xdQHfN+j2PKwILb3mDwGCv
         faYA==
X-Gm-Message-State: AAQBX9c3JZf0KQ8frZITLjznNhu1bdkQLdYuPBZWPOcFn02KhojS23xI
        mIKF0z4oXYZ+Md+FnQhqfIczPk+1Ovw=
X-Google-Smtp-Source: AKy350YWy0vKFblVgT0f7oBtlaYQUAXyhr73W3/BAr/pUMEkK0W8GeuUw14bgdZswRhXkPFsZQQf/w==
X-Received: by 2002:a92:4a11:0:b0:325:dc18:af32 with SMTP id m17-20020a924a11000000b00325dc18af32mr6423311ilf.7.1679879488296;
        Sun, 26 Mar 2023 18:11:28 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.93.1])
        by smtp.gmail.com with ESMTPSA id y19-20020a056e02119300b00325de773339sm2080894ili.64.2023.03.26.18.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 18:11:28 -0700 (PDT)
Message-ID: <6420ed40.050a0220.f942a.21ac@mx.google.com>
Date:   Sun, 26 Mar 2023 18:11:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2781016950477082335=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, steev@kali.org
Subject: RE: Add WCN6855 Bluetooth support
In-Reply-To: <20230326233812.28058-2-steev@kali.org>
References: <20230326233812.28058-2-steev@kali.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2781016950477082335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=733986

---Test result---

Test Summary:
CheckPatch                    FAIL      2.87 seconds
GitLint                       PASS      1.11 seconds
SubjectPrefix                 FAIL      0.67 seconds
BuildKernel                   PASS      30.98 seconds
CheckAllWarning               PASS      34.08 seconds
CheckSparse                   WARNING   39.50 seconds
CheckSmatch                   PASS      107.10 seconds
BuildKernel32                 PASS      29.91 seconds
TestRunnerSetup               PASS      433.39 seconds
TestRunner_l2cap-tester       PASS      15.87 seconds
TestRunner_iso-tester         PASS      15.76 seconds
TestRunner_bnep-tester        PASS      5.15 seconds
TestRunner_mgmt-tester        PASS      101.93 seconds
TestRunner_rfcomm-tester      PASS      8.16 seconds
TestRunner_sco-tester         PASS      7.44 seconds
TestRunner_ioctl-tester       PASS      8.72 seconds
TestRunner_mesh-tester        PASS      6.40 seconds
TestRunner_smp-tester         PASS      7.40 seconds
TestRunner_userchan-tester    PASS      5.24 seconds
IncrementalBuild              PASS      40.97 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v8,3/4] arm64: dts: qcom: sc8280xp: Define uart2
WARNING: line length of 109 exceeds 100 columns
#149: FILE: arch/arm64/boot/dts/qcom/sc8280xp.dtsi:1220:
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,

WARNING: line length of 105 exceeds 100 columns
#150: FILE: arch/arm64/boot/dts/qcom/sc8280xp.dtsi:1221:
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>;

total: 0 errors, 2 warnings, 20 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13188465.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btqca.c:640:24: warning: restricted __le32 degrades to integer


---
Regards,
Linux Bluetooth


--===============2781016950477082335==--

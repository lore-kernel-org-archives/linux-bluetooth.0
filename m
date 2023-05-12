Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31195C77B75
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 May 2023 14:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241271AbjELOhB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 May 2023 10:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241197AbjELOhA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 May 2023 10:37:00 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2002E1BD7
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 May 2023 07:36:58 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64388cf3263so7174791b3a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 May 2023 07:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683902217; x=1686494217;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iAmRvMv7hHo27KaXjDIlTzqbfySOUtH9LUPEdMWSI/I=;
        b=gXw6YD3tcUzx/+gG6MHGkVKNvl6QQgbnWEoOXFeTdjckE89HPVADCr3WdDy4fAAwbZ
         QJa/Px2XOf4WzW5jrxLsdMi+a/Zt7HmX68HKXN6Vo94VyqR4FLrS1o/cWdMXtSNKn4DE
         LNuR3aybWrx5qpzoQIMT0Q7defghmL8nKaJIWSC2BHbB5fw4vyxLrPCw7JGqmGJklzto
         5TMIIgW37vkoEJzDS9jgUXNRCOzgoBoeLmOowbJXhmGShF13bzBm5yEE0AkcuQHef/uM
         pCvvLU7Jx789znkU//aDWPDizcirTGxTlcZTULDtSzWVYfz/P0IU4VvnIT2/AIPjAaWw
         mOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683902217; x=1686494217;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iAmRvMv7hHo27KaXjDIlTzqbfySOUtH9LUPEdMWSI/I=;
        b=c9uJAxWG6oqxG7ANFDMweKBia1Y7aBDIVKh2jnVXQOffJsCmf5lYyCTW4is47b8swi
         1pmH5MlHen47ZMhf82fgTxDKo3J04f1dRFh/JYAwWbY0lrx4H+DqXvLZmM6KI6tB1odP
         eBZ8cdVYp0G63RP/ytMgiooiuC81HQyVbqRLfn8gmvCNcwg5K9b7oTxtEykyyvai7swn
         2ZGO3BpMnHNac7KZdOKar4F9+UrHfdixIGr+vKmFkSgPjtLrFSLKp5493dgT1hjqwfZ8
         3Hh/G6iB+nTiMIb/PeWrQOqvZaan5/T0d8xeN1bIeKN4MZPVdNLgHDnEBcoznK6jxckj
         qV3g==
X-Gm-Message-State: AC+VfDyLkVoJAmEZN/avB3P/+IJwOh5bkO87JFPdkzYD82VjRcK+sZyP
        AygPME2ib3aiLpD9OapQ0mpJGb3g2AI=
X-Google-Smtp-Source: ACHHUZ7nuzGU37YL/rZRaakj2mpSP02NG49SJ1pG/BLul8J0OM2lulhTuFqtgQ1wpTXv3e8ARGmYnQ==
X-Received: by 2002:a05:6a00:2e21:b0:63f:1adb:bf61 with SMTP id fc33-20020a056a002e2100b0063f1adbbf61mr35140635pfb.18.1683902217265;
        Fri, 12 May 2023 07:36:57 -0700 (PDT)
Received: from [172.17.0.2] ([13.64.10.201])
        by smtp.gmail.com with ESMTPSA id f17-20020aa78b11000000b00642ea56f06fsm7198370pfd.0.2023.05.12.07.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 07:36:57 -0700 (PDT)
Message-ID: <645e4f09.a70a0220.68dc3.e86c@mx.google.com>
Date:   Fri, 12 May 2023 07:36:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8793806951572548460=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luca.weiss@fairphone.com
Subject: RE: Add WCN3988 Bluetooth support for Fairphone 4
In-Reply-To: <20230421-fp4-bluetooth-v2-1-3de840d5483e@fairphone.com>
References: <20230421-fp4-bluetooth-v2-1-3de840d5483e@fairphone.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8793806951572548460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=747119

---Test result---

Test Summary:
CheckPatch                    FAIL      3.13 seconds
GitLint                       PASS      0.99 seconds
SubjectPrefix                 FAIL      0.58 seconds
BuildKernel                   PASS      41.86 seconds
CheckAllWarning               PASS      47.77 seconds
CheckSparse                   WARNING   52.98 seconds
CheckSmatch                   PASS      140.37 seconds
BuildKernel32                 PASS      40.50 seconds
TestRunnerSetup               PASS      581.07 seconds
TestRunner_l2cap-tester       PASS      20.59 seconds
TestRunner_iso-tester         PASS      26.60 seconds
TestRunner_bnep-tester        PASS      6.86 seconds
TestRunner_mgmt-tester        PASS      140.69 seconds
TestRunner_rfcomm-tester      PASS      10.80 seconds
TestRunner_sco-tester         PASS      10.23 seconds
TestRunner_ioctl-tester       PASS      12.14 seconds
TestRunner_mesh-tester        PASS      9.53 seconds
TestRunner_smp-tester         PASS      9.84 seconds
TestRunner_userchan-tester    PASS      7.56 seconds
IncrementalBuild              PASS      55.33 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,3/4] arm64: dts: qcom: sm6350: add uart1 node
WARNING: line length of 113 exceeds 100 columns
#146: FILE: arch/arm64/boot/dts/qcom/sm6350.dtsi:769:
+				pinctrl-0 = <&qup_uart1_cts>, <&qup_uart1_rts>, <&qup_uart1_tx>, <&qup_uart1_rx>;

WARNING: line length of 109 exceeds 100 columns
#150: FILE: arch/arm64/boot/dts/qcom/sm6350.dtsi:773:
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,

WARNING: line length of 103 exceeds 100 columns
#151: FILE: arch/arm64/boot/dts/qcom/sm6350.dtsi:774:
+						<&aggre1_noc MASTER_QUP_0 0 &clk_virt SLAVE_EBI_CH0 0>;

total: 0 errors, 3 warnings, 81 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13239341.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,4/4] arm64: dts: qcom: sm7225-fairphone-fp4: Add Bluetooth
WARNING: line length of 113 exceeds 100 columns
#220: FILE: arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts:652:
+	pinctrl-1 = <&qup_uart1_sleep_cts>, <&qup_uart1_sleep_rts>, <&qup_uart1_sleep_tx>, <&qup_uart1_sleep_rx>;

total: 0 errors, 1 warnings, 121 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13239343.patch has style problems, please review.

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
drivers/bluetooth/btqca.c:649:24: warning: restricted __le32 degrades to integer


---
Regards,
Linux Bluetooth


--===============8793806951572548460==--

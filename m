Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E333BC7618E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Apr 2023 14:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbjDUO6A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Apr 2023 10:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjDUO5z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Apr 2023 10:57:55 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F73B9EE0
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Apr 2023 07:57:50 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-74d0dbd7c58so115349085a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Apr 2023 07:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682089069; x=1684681069;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zxzfXiWcWm8SZaFpXIvLQ6xMxQ1FgJAxXWxFhYaobuU=;
        b=cqwVgrKI96lW92UPGj+x7USU3BVvWoe8yvQXcTZnNywcp1C9ZnXFotcuTDVagHT52t
         Jk6kggxpMFRnhu3ZkIwxYRa8emkYBpTi2q6p0/0XOvIlk8gjPFOrQzC1nyJPGfNF0Vwq
         dKlS739k2h5pbK1nRhcgtaKTeBEurGLa1a/JsqbNlfqO/rPJ+k9WTUlTMlhJScZc6pOH
         EJsIRnXOInogbmxjK0mtqouIqVskiOp5Rc1H6TY7QuwWo4NBY1+38S0twTW5nb8eTq0O
         M0INKRQuBKbDEppw3YJpNZiky9rDFb4ad9m7IO4G5G+Dh7C7Eshw3IoAruxsq2mmRUQA
         BnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682089069; x=1684681069;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxzfXiWcWm8SZaFpXIvLQ6xMxQ1FgJAxXWxFhYaobuU=;
        b=DTCTkkynkQxqSOPBzsdJPijyjP8KbDNDDJv0ikVw4KRHuXQ8RaS3Pn900Sqvph7c6Z
         p+rbnmPOU6WgFbZWCkUNca989jS5SIuy/fIjAaC7mycEuxei6DKR69WzcwEaH/2utVqQ
         Ylz97HbzlOYqbe6I1Gjy/QUh61fRx+pECMC8CClaLbaGE1N9N1eGBA7Fa6oTuPNqC+0n
         WJzvW9xXsBZDvNpPaYo1vl02WSID+HyGfKQDoZIIv5vR8qJJnz/dIHFYIlUg4dMwuTr8
         9F1OIKMXsnmLg6CAzQzqMAdomeszABiIZEfGo/sBXKVdlN2hgpS0NDBGjXYLL1FZocZS
         dWag==
X-Gm-Message-State: AAQBX9c6I37bhgXEV7xcyvpu22O+fjkQtTQM/tiDqX0hQVhL9l0yAfYe
        2uNxIK530f1bP4+shKF9HoKCHtCIH0nQPw==
X-Google-Smtp-Source: AKy350ZY13vjoguE57TCXgycKGYTW14iMblYPXWM2Qvuj8/dsAak912ksHYbMxPTSi0Q4FMLbVzhhA==
X-Received: by 2002:a05:6214:20e2:b0:5f1:6892:7437 with SMTP id 2-20020a05621420e200b005f168927437mr6020303qvk.26.1682089069300;
        Fri, 21 Apr 2023 07:57:49 -0700 (PDT)
Received: from [172.17.0.2] ([40.75.96.212])
        by smtp.gmail.com with ESMTPSA id d8-20020a0cfe88000000b005ff569bca72sm924167qvs.93.2023.04.21.07.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 07:57:49 -0700 (PDT)
Message-ID: <6442a46d.0c0a0220.b11b9.4aee@mx.google.com>
Date:   Fri, 21 Apr 2023 07:57:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6423509529967983679=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luca.weiss@fairphone.com
Subject: RE: Add WCN3988 Bluetooth support for Fairphone 4
In-Reply-To: <20230421-fp4-bluetooth-v1-1-0430e3a7e0a2@fairphone.com>
References: <20230421-fp4-bluetooth-v1-1-0430e3a7e0a2@fairphone.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6423509529967983679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=742153

---Test result---

Test Summary:
CheckPatch                    FAIL      3.44 seconds
GitLint                       PASS      1.39 seconds
SubjectPrefix                 FAIL      0.72 seconds
BuildKernel                   PASS      31.98 seconds
CheckAllWarning               PASS      34.99 seconds
CheckSparse                   WARNING   40.10 seconds
CheckSmatch                   PASS      108.76 seconds
BuildKernel32                 PASS      30.86 seconds
TestRunnerSetup               PASS      437.84 seconds
TestRunner_l2cap-tester       PASS      16.93 seconds
TestRunner_iso-tester         PASS      20.79 seconds
TestRunner_bnep-tester        PASS      5.51 seconds
TestRunner_mgmt-tester        PASS      114.50 seconds
TestRunner_rfcomm-tester      PASS      8.93 seconds
TestRunner_sco-tester         PASS      8.29 seconds
TestRunner_ioctl-tester       PASS      9.56 seconds
TestRunner_mesh-tester        PASS      7.03 seconds
TestRunner_smp-tester         PASS      8.02 seconds
TestRunner_userchan-tester    PASS      5.85 seconds
IncrementalBuild              PASS      42.88 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[RFC,3/4] arm64: dts: qcom: sm6350: add uart1 node
WARNING: line length of 113 exceeds 100 columns
#147: FILE: arch/arm64/boot/dts/qcom/sm6350.dtsi:769:
+				pinctrl-0 = <&qup_uart1_cts>, <&qup_uart1_rts>, <&qup_uart1_tx>, <&qup_uart1_rx>;

WARNING: line length of 109 exceeds 100 columns
#151: FILE: arch/arm64/boot/dts/qcom/sm6350.dtsi:773:
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,

WARNING: line length of 103 exceeds 100 columns
#152: FILE: arch/arm64/boot/dts/qcom/sm6350.dtsi:774:
+						<&aggre1_noc MASTER_QUP_0 0 &clk_virt SLAVE_EBI_CH0 0>;

total: 0 errors, 3 warnings, 81 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13220105.patch has style problems, please review.

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


--===============6423509529967983679==--

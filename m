Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB76EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jul 2023 21:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjGFVCD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jul 2023 17:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjGFVCA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jul 2023 17:02:00 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7FC1BE1
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jul 2023 14:01:57 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7654e1d83e8so108028985a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Jul 2023 14:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688677317; x=1691269317;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t6cYDrFY2xb40PXauDcVkaq7P7niGrfnbPKarJSpnxs=;
        b=hBIB82Nc0qc0wSUdbIijUa05VuxNuULd8cZxIY+GZU7lLQzo3si4K/Yl3cKUIS0JZ+
         q38Vozt7Y3PGWCOYoCytHS7FjJFFKjJZqcFQBQnZkq8bvtv+p4Y/TQQoIDAK15+oX726
         EhZytw3M5HujB+T0fYSDEXAlyc60vCuXhO+5rcLLW/AV6/+uQzCRpjgr6KiitTdsBzzu
         Mu0CjMs2XHcCbjMdmRNkAPloVP3/V90chaD2nZ6/Ms4Xpxl8HfrXlycNOqcpqnGzEUlA
         PRQVgZsRXKP9QtgsV2eJvgRBVNddtxvQ59A5eookGN8EA70MWMjQjlgdPIF/P6ZgQUky
         qH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688677317; x=1691269317;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t6cYDrFY2xb40PXauDcVkaq7P7niGrfnbPKarJSpnxs=;
        b=NdEZ3wpi1D4gGpl6igmSmeRgzFLrXhsQfBstA1kzg/aRMqMpk7h0be4S6ytyNsNrp/
         jSBva5IHjNir6KhD5r+YYlcbXb2jK+id32SwjgsYsVRnsV0URYjd5QxyL5C3ExK16cWd
         5EJn+Fl+UzU1kjnEAh8cRBVrirYozBayEU/MScVvpaA/K8RRao0mMy1YgRJdk2wKMmTS
         ucQ/kU7QbxmKkLc2E1pCD6As/0ElYBl2YvdSAmsgNH1OjN3f4K25AhDr9tXhwHhaLku2
         m42HItrvIYJJ0oBTFE9gUrIQ8Ntlee3zD88oY5qcf0LsvMm7NnoL2kytLTno+DB1UyDS
         q93w==
X-Gm-Message-State: ABy/qLaIyW10De3AJ2/BFb3Xiyu2SNTgTbQ39obCPpJVuorT94pEaZ9I
        6I9iSUjTPYPqrXLiIByDCDwxsvkY8f8=
X-Google-Smtp-Source: APBJJlHGFg6QD6Fdc0wqn0RaDdCsjYp91zenwDXfkS7JsssZaI6V0E93hp55QKly3FtrhUmKvskWrQ==
X-Received: by 2002:a05:620a:1720:b0:765:65bd:614e with SMTP id az32-20020a05620a172000b0076565bd614emr3045386qkb.51.1688677316661;
        Thu, 06 Jul 2023 14:01:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.185.158.49])
        by smtp.gmail.com with ESMTPSA id f15-20020ae9ea0f000000b00765a676b75csm1147513qkg.21.2023.07.06.14.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 14:01:56 -0700 (PDT)
Message-ID: <64a72bc4.e90a0220.4cee.43aa@mx.google.com>
Date:   Thu, 06 Jul 2023 14:01:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2599600361350335769=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neil.armstrong@linaro.org
Subject: RE: bluetooth: qca: enable WCN7850 support
In-Reply-To: <20230620-topic-sm8550-upstream-bt-v2-1-98b0043d31a4@linaro.org>
References: <20230620-topic-sm8550-upstream-bt-v2-1-98b0043d31a4@linaro.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2599600361350335769==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=760534

---Test result---

Test Summary:
CheckPatch                    FAIL      4.44 seconds
GitLint                       PASS      1.67 seconds
SubjectPrefix                 FAIL      0.88 seconds
BuildKernel                   PASS      34.19 seconds
CheckAllWarning               PASS      37.46 seconds
CheckSparse                   PASS      42.81 seconds
CheckSmatch                   PASS      114.67 seconds
BuildKernel32                 PASS      32.91 seconds
TestRunnerSetup               PASS      497.93 seconds
TestRunner_l2cap-tester       PASS      24.12 seconds
TestRunner_iso-tester         PASS      42.81 seconds
TestRunner_bnep-tester        PASS      10.71 seconds
TestRunner_mgmt-tester        PASS      221.34 seconds
TestRunner_rfcomm-tester      PASS      16.28 seconds
TestRunner_sco-tester         PASS      17.04 seconds
TestRunner_ioctl-tester       PASS      18.19 seconds
TestRunner_mesh-tester        PASS      13.65 seconds
TestRunner_smp-tester         PASS      14.71 seconds
TestRunner_userchan-tester    PASS      11.50 seconds
IncrementalBuild              PASS      51.69 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,4/5] arm64: dts: qcom: sm8550: add UART14 nodes
WARNING: line length of 109 exceeds 100 columns
#139: FILE: arch/arm64/boot/dts/qcom/sm8550.dtsi:1064:
+				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,

WARNING: line length of 105 exceeds 100 columns
#140: FILE: arch/arm64/boot/dts/qcom/sm8550.dtsi:1065:
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>;

total: 0 errors, 2 warnings, 42 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13294165.patch has style problems, please review.

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
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============2599600361350335769==--

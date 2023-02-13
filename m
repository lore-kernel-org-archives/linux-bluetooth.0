Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B7BC636CC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Feb 2023 15:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjBMPkZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Feb 2023 10:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjBMPkY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Feb 2023 10:40:24 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCBC199C3
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Feb 2023 07:40:22 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id oa11-20020a17090b1bcb00b002341a2656e5so1055802pjb.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Feb 2023 07:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7HwbnU2qeL3RZcx2lfjqO5hK+nMqyoPT7MCzNnHOrY8=;
        b=Qxg8TO73gfDiNRqnxANxizMPEjCXdB7Pa8YcNyn9rEkcq/qsFNmIDjmROJOSLnAhhy
         zLRBJYOD7BkplAItx7teR9t0DAMdPD25skLLf2HayEzGQT/67cii+MZbTv5odO+bcJgF
         KtFunqeaiM47OVZKS3RK+BRh8OhWy2HcNBjbRa/LMAOMR0HJS0DD2PdEpbiFrjQJ2qss
         w5ysohbD0+MnCn4mZQMGEp0CpXM6YmajFBVqXiSLw4oUsT1hdKY+kCAxg+yTO7QauDUM
         kGZQulSyTXDNdKxOeXwlbIvZ8A8jqMpAIhvjVvVdl+TG98nYcOYZClEKBRaXxbMIQqzQ
         n10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7HwbnU2qeL3RZcx2lfjqO5hK+nMqyoPT7MCzNnHOrY8=;
        b=FEf5oZwtCHEzTt/H5aFFmvwApQdwtooxCJq2ep+eGSSejQj3AWwuDxkjCK1jn7e88Q
         sw3mA56XNClhkLCScuOWdt+HKelwXRurULcV5QLc43bljhU1GROxARUb67qcND910hnl
         5ILEIeui1jI7pHTXztUkqZEcrFCrMT7hQ2IQdS9ld+kiuWmXPqLu/AdkoqQVFc3NR7/A
         Y3to30fkFCWVxtZ1kSjFeGwSU1BkgxrbhIsHRNdhlbpGhQMCOFCsW7Pf7HaQ0pXUspXf
         LQFjQQ87qb5mJr10IqK2iX21XhSKEhzS83VVPK5gNDgsi02udpsMidhplOv1LH6h1ILx
         IW0A==
X-Gm-Message-State: AO0yUKVI1g/TdvlN0nsuvh5Tz1aarpUt4GWRBEvMOQMrptXqTfM4RzF0
        PYiqDJwKoB2mrKpOURmHLPzpImzJj2I=
X-Google-Smtp-Source: AK7set/xFrH0z2UMVpFGoFnjN40biWvnvtx4n194njnyi64e5MkRBMSBKprZFPLwjxcAehd2CWO/Qg==
X-Received: by 2002:a17:902:da83:b0:196:8db5:fd67 with SMTP id j3-20020a170902da8300b001968db5fd67mr31084933plx.2.1676302821973;
        Mon, 13 Feb 2023 07:40:21 -0800 (PST)
Received: from [172.17.0.2] ([13.87.244.133])
        by smtp.gmail.com with ESMTPSA id v6-20020a1709028d8600b0019906c4c9dcsm8359637plo.98.2023.02.13.07.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 07:40:21 -0800 (PST)
Message-ID: <63ea59e5.170a0220.0b49.f2eb@mx.google.com>
Date:   Mon, 13 Feb 2023 07:40:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7932428026696458084=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: Add support for NXP bluetooth chipsets
In-Reply-To: <20230213145432.1192911-2-neeraj.sanjaykale@nxp.com>
References: <20230213145432.1192911-2-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7932428026696458084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=721320

---Test result---

Test Summary:
CheckPatch                    FAIL      5.33 seconds
GitLint                       FAIL      1.14 seconds
SubjectPrefix                 FAIL      0.61 seconds
BuildKernel                   PASS      41.88 seconds
CheckAllWarning               PASS      46.09 seconds
CheckSparse                   PASS      51.78 seconds
CheckSmatch                   PASS      137.50 seconds
BuildKernel32                 PASS      41.24 seconds
TestRunnerSetup               PASS      595.73 seconds
TestRunner_l2cap-tester       PASS      19.94 seconds
TestRunner_iso-tester         PASS      22.36 seconds
TestRunner_bnep-tester        PASS      7.57 seconds
TestRunner_mgmt-tester        PASS      146.06 seconds
TestRunner_rfcomm-tester      PASS      11.53 seconds
TestRunner_sco-tester         PASS      10.51 seconds
TestRunner_ioctl-tester       PASS      13.45 seconds
TestRunner_mesh-tester        PASS      9.63 seconds
TestRunner_smp-tester         PASS      10.75 seconds
TestRunner_userchan-tester    PASS      7.85 seconds
IncrementalBuild              PASS      49.44 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3,3/3] Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#199: 
new file mode 100644

total: 0 errors, 1 warnings, 1392 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13138551.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3,2/3] dt-bindings: net: bluetooth: Add NXP bluetooth support

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
9: B1 Line exceeds max length (109>80): "v2: Modified description, added specific compatibility devices, corrected indentations. (Krzysztof Kozlowski)"
15: B1 Line exceeds max length (85>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth/nxp,w8xxx-bt.yaml"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============7932428026696458084==--

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF04DC43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jun 2022 13:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbiF3NcL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jun 2022 09:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234682AbiF3NcK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jun 2022 09:32:10 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8B8344D0
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 06:32:09 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id u14so27006611qvv.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 06:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=P8j/aDZZG2cSlZhLFElCoFW78ySneIz5W6q1kJhEi/A=;
        b=E/3FfLih+iYpppz1a7PuoMwwGTygaT3ggnJIMZOtF6tXzXqjnCePfFW6C+sjxogvoX
         sQDEaT8Ew+hkorbXdS0Q/TF6vKAw9rEcwY+XvcmjtHxgLAGEiPJkDb43iGYGyf1cwVZp
         dRg7o8Ym3iFJ5iF+/OPEtFW/5L+5NiO4tttJYcAeLi8xotzvVj1IC08WWGzWM84aAu8t
         6jEBdexDKPcxEnUA4M7u2fwe+qVBdPek+QAs1bQGt+vEAeQetxNbRia9usdcTX/aJRny
         w4+2qFslkjWV8HrgSmEp94PRc5nc+8R4iycTG96icIS9JYa8NI4NeTcB5yEFBakrZfTr
         RLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=P8j/aDZZG2cSlZhLFElCoFW78ySneIz5W6q1kJhEi/A=;
        b=5wBc+lHG1iQ+9oraYDG7vzIVI9pWfvy9WitEBsNVx3Q74dOzIWM7Qb0bU5OBaofbvL
         wVI2JbeiwL6mW3Qttoz0sQW+jTFoou3Osk3RxFGb8WMl3nXP8PusSmzbww8sM9ers1Y4
         W7qzbV6VPcZC69O3uMeD0y3X09jBbmzfDixRzfM9OVvx2tn0oXsc8TSkNw2z9wmYievV
         v/Erxw9/ehMCSF9Qn0TsvjFhpR7oHjh6Vw1uwSxeOcltaOI1iNfxmGnu1rffQuTZXSvU
         FK41nlIed9wEEqoJI39tiv9QhudrzRlls3r6eaG63rYtxF9kqh+s6FvoMcJcF7B42pyN
         HyHg==
X-Gm-Message-State: AJIora8uQ6Sk0QkS/wRTrBNVwyHMfKc415yBITWj+lcflYyg+YD1iVvx
        2jDfO+e62T5Y1lAw5LA+7u4EmvRx2JE=
X-Google-Smtp-Source: AGRyM1tbFC0TwMDWVMy+i15VbGDi91htuJ77v0rSrzmeIHtIR2gAQTPsHFsOpTFZWw3V7JGz8B8yRg==
X-Received: by 2002:ac8:58c4:0:b0:31c:8f90:34d4 with SMTP id u4-20020ac858c4000000b0031c8f9034d4mr7732423qta.381.1656595928066;
        Thu, 30 Jun 2022 06:32:08 -0700 (PDT)
Received: from [172.17.0.2] ([20.1.154.103])
        by smtp.gmail.com with ESMTPSA id q11-20020a05620a0d8b00b006a32bf19502sm15090553qkl.60.2022.06.30.06.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 06:32:07 -0700 (PDT)
Message-ID: <62bda5d7.1c69fb81.23f33.0fcb@mx.google.com>
Date:   Thu, 30 Jun 2022 06:32:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4761552081833594372=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hakan.jansson@infineon.com
Subject: RE: Bluetooth: hci_bcm: Improve FW load time on CYW55572
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <e3f949c067ad07a1dd34247efc49f3d913c4f7c6.1656583541.git.hakan.jansson@infineon.com>
References: <e3f949c067ad07a1dd34247efc49f3d913c4f7c6.1656583541.git.hakan.jansson@infineon.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4761552081833594372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=655422

---Test result---

Test Summary:
CheckPatch                    PASS      7.99 seconds
GitLint                       FAIL      4.87 seconds
SubjectPrefix                 FAIL      1.73 seconds
BuildKernel                   PASS      31.43 seconds
BuildKernel32                 PASS      27.63 seconds
Incremental Build with patchesPASS      61.44 seconds
TestRunner: Setup             PASS      466.49 seconds
TestRunner: l2cap-tester      PASS      16.78 seconds
TestRunner: bnep-tester       PASS      5.81 seconds
TestRunner: mgmt-tester       PASS      98.95 seconds
TestRunner: rfcomm-tester     PASS      9.25 seconds
TestRunner: sco-tester        PASS      9.05 seconds
TestRunner: smp-tester        PASS      9.13 seconds
TestRunner: userchan-tester   PASS      6.10 seconds

Details
##############################
Test: GitLint - FAIL - 4.87 seconds
Run gitlint with rule in .gitlint
[v2,5/5] Bluetooth: hci_bcm: Increase host baudrate for CYW55572 in autobaud mode
1: T1 Title exceeds max length (81>80): "[v2,5/5] Bluetooth: hci_bcm: Increase host baudrate for CYW55572 in autobaud mode"


##############################
Test: SubjectPrefix - FAIL - 1.73 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============4761552081833594372==--

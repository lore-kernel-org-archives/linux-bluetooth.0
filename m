Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989C7C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 05:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240851AbiKRF36 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 00:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiKRF34 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 00:29:56 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9573B87A49
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:29:55 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id fz10so2544458qtb.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vsJHmyzKWkANuYT731CQPe1OtYuPhWoJ95Uaqv5alTk=;
        b=PdJtqHfH1XjbN1QPDPdgJQFuiEJKABydmQ6Qs+FETSbsyAe/CLW75XWKSg1r68CJx+
         Pj726LkoAG1aN0CMjCY1GYkVeOUTn7bI6DDUxxaYwx1IJypQAz2PTvCMi8SiE8Y+JOAp
         KgpeMzpOH0pfpZ1PFYliQwrFirMf/D6CYpLTpJQLqCxV6gb9EC69y58kyJrQ7bMA9JpT
         932RXAUKewFNqaaCOYIiT9zboGjKpL825p8kSSodKLNo5dGy7o0Dq9qUN2cHXhtqwQL5
         dPdLgBFIDcqyi0Y/WEq9TmR9FttEKkxPVhXsxvmcmCzH8G2iO1iWWAVSubTynVv8qV/L
         z5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vsJHmyzKWkANuYT731CQPe1OtYuPhWoJ95Uaqv5alTk=;
        b=4I2WwPKE8kUmipMiE5ZGb7UXfWpA3oYKWJeSer7QIWaDt/KoXOaa0b/HVaDrTjfvrr
         Xf4s/FpW85gJM2B2n8TXbuF83hiXyyImJ6ik5L/CfcE0XhPxKU1a4KbjdAMNmWUyjunU
         r8C3fMe17fv3roXtAfDLVaEjR0WzUoVOOsytQrEE7Y76O/1KxhwIZUyhygz2IRflPcam
         DwbXm81U2QYm1HAM0A+JSuVqyZyfjsPnZRSoQn2jTO8Vs2wczGSt2fxSurDjLSjXhPYp
         JLFlRVNzXnwIL42R497/CAHM5r6LHa+taUqMYgfy8wQ2UDrUei2++k570CPqOBXjSLlN
         SLNA==
X-Gm-Message-State: ANoB5pkwqWkuT6chEnUzgb6mjwaeSVDtvKUgPpaqLGruG539iGjEludg
        N0n7fN0yPb0tzxEySN10NLaY9+gE5Ic=
X-Google-Smtp-Source: AA0mqf5rp6R+QDa0yC3xoEEEcPqf7Te8HYFOoDMlCPVIWhwW2yhuFzjojY7NOmeICwq6f9ZGRAAUAQ==
X-Received: by 2002:ac8:546:0:b0:3a5:62d0:db58 with SMTP id c6-20020ac80546000000b003a562d0db58mr5162001qth.190.1668749394624;
        Thu, 17 Nov 2022 21:29:54 -0800 (PST)
Received: from [172.17.0.2] ([20.122.146.120])
        by smtp.gmail.com with ESMTPSA id cj23-20020a05622a259700b0039a9b55b829sm1509669qtb.29.2022.11.17.21.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 21:29:54 -0800 (PST)
Message-ID: <63771852.050a0220.b92db.757b@mx.google.com>
Date:   Thu, 17 Nov 2022 21:29:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5261583113833368533=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1] Bluetooth: btusb: Fix enable failure for a CSR BT dongle
In-Reply-To: <1666868760-4680-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1666868760-4680-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5261583113833368533==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=689388

---Test result---

Test Summary:
CheckPatch                    PASS      0.70 seconds
GitLint                       PASS      0.38 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      33.35 seconds
BuildKernel32                 PASS      29.35 seconds
TestRunnerSetup               PASS      415.53 seconds
TestRunner_l2cap-tester       PASS      15.67 seconds
TestRunner_iso-tester         PASS      14.97 seconds
TestRunner_bnep-tester        PASS      5.26 seconds
TestRunner_mgmt-tester        PASS      103.28 seconds
TestRunner_rfcomm-tester      PASS      9.08 seconds
TestRunner_sco-tester         PASS      8.54 seconds
TestRunner_ioctl-tester       PASS      9.86 seconds
TestRunner_mesh-tester        PASS      6.68 seconds
TestRunner_smp-tester         PASS      8.41 seconds
TestRunner_userchan-tester    PASS      5.63 seconds
IncrementalBuild              PASS      30.54 seconds



---
Regards,
Linux Bluetooth


--===============5261583113833368533==--

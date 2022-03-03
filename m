Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A22DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Mar 2022 02:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbiCCCjI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Mar 2022 21:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiCCCjH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Mar 2022 21:39:07 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7120D74
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Mar 2022 18:38:23 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id i14so2968167ilv.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Mar 2022 18:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=tbtI9/vicxIW4T5k8zQZdslCGqL4uxN66M46uOAKQqM=;
        b=hxqt8jMa9Fv/jC3HAwHBmSHCHEnkXcofaUIzwK5GLK5LyoUD5QJ54X+dU31EYKpvDy
         tOoZl4ZKJBgygwHf4TwNfnaulzkdgJFKgUhhaR0JjP2xBELf7WhCtbRm6ukQVXo+Ic/1
         /fL7VHhjGsc/c0rQih9Hw3V2ovUDjSyEwcIS647LGJlcBMQF/J2N0LX1HwVjvN2ipyiT
         p2j6gG5LcI23rLnxmF6cxQUHbi7ny6uyWu3AMeipK03SINODaKdmgPq1X5obytfb+SHF
         5UhWHMW3fIcFi6YfnD5tJUv1epPBRtMHcxNlojWHU4YHsMeGjh6miKSp9BjoxXsDhw3m
         QR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=tbtI9/vicxIW4T5k8zQZdslCGqL4uxN66M46uOAKQqM=;
        b=Aa2WfGQEymWly8WbjdR4Xb1YoWc/oxvv7kjlKHx54zzxLfNNEu0LlpaKlIhKGCkyqk
         XckLQJ5ZLtqnY6WDtBW+zcP7tCOaqHKYNP4GvyQapXRNJa2bAPOG5hFQOeNA58sg2wpr
         bqIqIPDc7g3P8vffV/PAGUPoDzDzeayavlbrtS+VqZGD3FBajl8FDxK1es1etBLREaOa
         fzgYEXLd98+35Ik8/BU+u+PoE+EEX0dpmxmOBBjj2ZXrk4tCcrVmiu5IhkDuOgWBcxsT
         mu9ZTi67d4AR3EgNRZiPixEqWCvF5g1ZNqviEoovvX93l1TUlNYOOdEtLmVMcAps+//A
         dHcg==
X-Gm-Message-State: AOAM532jHkMv8OzXRfvnw3uYzpXFd7jVtJtyc8XUelwim5/uT7MRO5hN
        5sD9202ICg8sOVVMCKK+Dn72+GdApR8=
X-Google-Smtp-Source: ABdhPJzemq1Dc+wICptWo+SIOju/3rdIBay7Yy9hop6x1fkSnxlGV9iJdYoa2J7qfDUkNfDwyl2sYA==
X-Received: by 2002:a05:6e02:1c8b:b0:2b8:ba1d:859b with SMTP id w11-20020a056e021c8b00b002b8ba1d859bmr31332238ill.233.1646275102913;
        Wed, 02 Mar 2022 18:38:22 -0800 (PST)
Received: from [172.17.0.2] ([40.69.153.201])
        by smtp.gmail.com with ESMTPSA id k4-20020a5e9304000000b00640dfe71dc8sm449985iom.46.2022.03.02.18.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 18:38:22 -0800 (PST)
Message-ID: <62202a1e.1c69fb81.a6f0c.20a0@mx.google.com>
Date:   Wed, 02 Mar 2022 18:38:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0050027324030908742=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: Fix not checking for valid hdev on bt_dev_{info,warn,err,dbg}
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220302230858.444141-1-luiz.dentz@gmail.com>
References: <20220302230858.444141-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0050027324030908742==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=619731

---Test result---

Test Summary:
CheckPatch                    PASS      1.17 seconds
GitLint                       PASS      0.70 seconds
SubjectPrefix                 PASS      0.66 seconds
BuildKernel                   PASS      34.09 seconds
BuildKernel32                 PASS      29.89 seconds
Incremental Build with patchesPASS      39.38 seconds
TestRunner: Setup             PASS      581.60 seconds
TestRunner: l2cap-tester      PASS      11.15 seconds
TestRunner: bnep-tester       PASS      4.70 seconds
TestRunner: mgmt-tester       PASS      91.13 seconds
TestRunner: rfcomm-tester     FAIL      5.91 seconds
TestRunner: sco-tester        PASS      5.97 seconds
TestRunner: smp-tester        PASS      5.89 seconds
TestRunner: userchan-tester   PASS      4.85 seconds

Details
##############################
Test: TestRunner: rfcomm-tester - FAIL - 5.91 seconds
Run test-runner with rfcomm-tester
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Basic RFCOMM Socket Client - Write 32k Success       Failed       0.125 seconds



---
Regards,
Linux Bluetooth


--===============0050027324030908742==--

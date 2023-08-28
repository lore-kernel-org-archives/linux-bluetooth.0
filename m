Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3953C83F11
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Aug 2023 20:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbjH1Ul2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Aug 2023 16:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjH1UlP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Aug 2023 16:41:15 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24E010D
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Aug 2023 13:41:12 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-403e7472b28so24643881cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Aug 2023 13:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693255272; x=1693860072;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cMDlNN7trt7Non/B0zsAm1YMmGieCc1AiU/AXSQ0fLQ=;
        b=TQ0xsCnaBFWXxwDWH+eCLblj2GFZ1ym9cx+znoKQgUjGdDnYRpxXAKH8VBY9pKbroe
         XZAd+iB2OaKCe1S+LqOeMoPiHW//BMkRwawgy64n6QAHLCB0gEC267Nu7Vio8ypZpSNK
         FsWo4dB+9tMlUunOeYt1l+rK5npnOr9U1G3OEqPIYIa7KzreGOJRjdmzMw14tVvlmDvM
         hK8M3EH6QQvFSg3Sm8b6AEpMEl/Sou0o6Fq3jvuTV4W7OVPeb9u4wZh/DqT0dc2rRhCu
         ogiwXk+XGXY2Uj+HjhzN9lH66cGwkkhOhZwKIIWH9TOWX08Bvbg9q3l6vMy1NmgcChB1
         KCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693255272; x=1693860072;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMDlNN7trt7Non/B0zsAm1YMmGieCc1AiU/AXSQ0fLQ=;
        b=Iiv7I5WI0LdnG9w19iqnBCXfqrWT9OVle4fDr9SWDWjMmTg+uNs8z3fb1h/SBzMDr0
         r8I/gk37iD38i59Ol9q1mBK+igjjNDCssrzCoMWi1/7DXHncuE9qWrx1qGv/VHrp5n8y
         UwdtftUtcO5DOGwb6lMUjqLnvlzOo5ZFrGttpMpQuzfqLHhu7j9yeX0IUk8jPJNTvRf7
         uyhtUy8XDPpIOmdKzkikFaYRMQZyDEiXwW6Kq/OiKpFj5cXVZs/vVquHPZJRq1I0LEJA
         y9TY1C0sjrkeJdQEqjvyMXPUZ/z2aeZ+NTB7dSUo+Jiei5IqO3XtnYb1Sz87+fOE0FJn
         6/yA==
X-Gm-Message-State: AOJu0Yx7e5KLbtxkrektpmwfGwTWM8lAZAn5i2UfkQbi44o03w40QY/D
        XHqEWuxSudRMfySHASXWkzAH9wgwLdE=
X-Google-Smtp-Source: AGHT+IHTbj//O44umKQcCOYYGe4PI2mpLNBeZNM3K9AdIK4uAsGpYDpAfFMZ16sTJRe0tPfYXhuGJQ==
X-Received: by 2002:a05:622a:12:b0:411:f7e6:3be5 with SMTP id x18-20020a05622a001200b00411f7e63be5mr18717693qtw.30.1693255271946;
        Mon, 28 Aug 2023 13:41:11 -0700 (PDT)
Received: from [172.17.0.2] ([20.185.158.51])
        by smtp.gmail.com with ESMTPSA id a10-20020ac8434a000000b004109d386323sm2587252qtn.66.2023.08.28.13.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 13:41:11 -0700 (PDT)
Message-ID: <64ed0667.c80a0220.c39d9.98d4@mx.google.com>
Date:   Mon, 28 Aug 2023 13:41:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2616462471458023817=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: ISO: Fix handling of listen for unicast
In-Reply-To: <20230828200545.580103-1-luiz.dentz@gmail.com>
References: <20230828200545.580103-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2616462471458023817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=780043

---Test result---

Test Summary:
CheckPatch                    PASS      0.80 seconds
GitLint                       PASS      0.38 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      40.26 seconds
CheckAllWarning               PASS      43.02 seconds
CheckSparse                   PASS      49.13 seconds
CheckSmatch                   PASS      132.29 seconds
BuildKernel32                 PASS      38.42 seconds
TestRunnerSetup               PASS      578.01 seconds
TestRunner_l2cap-tester       PASS      32.91 seconds
TestRunner_iso-tester         PASS      71.51 seconds
TestRunner_bnep-tester        PASS      12.99 seconds
TestRunner_mgmt-tester        PASS      256.16 seconds
TestRunner_rfcomm-tester      PASS      19.73 seconds
TestRunner_sco-tester         PASS      23.00 seconds
TestRunner_ioctl-tester       PASS      22.33 seconds
TestRunner_mesh-tester        PASS      16.91 seconds
TestRunner_smp-tester         PASS      17.63 seconds
TestRunner_userchan-tester    PASS      14.12 seconds
IncrementalBuild              PASS      36.69 seconds



---
Regards,
Linux Bluetooth


--===============2616462471458023817==--

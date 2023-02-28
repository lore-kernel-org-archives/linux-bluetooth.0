Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D1BC64EC7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Feb 2023 11:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjB1Lce (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Feb 2023 06:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjB1Lcd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Feb 2023 06:32:33 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8995A3
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Feb 2023 03:32:32 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id s12so9920156qtq.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Feb 2023 03:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677583952;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Mcd7RrtByBZPxC19CV7dp8nM8d22290UkmwmOr7iOGI=;
        b=db4S8SQTjQZXv7x93+0MJeQwWzxTiiXHis96ZUh4Lr/nQ/0MthAu045QZGG5OAYZiM
         xdqcAH+p1I9Y9eVC7gTfV087mqPYHhepvVo6QyqB+QXlGVDnAsiAuHl6/7zgdK0ZTa8n
         osIFi6hRKOTVf8gpW37/JkrzleS3u67XZOq96sMD53u5iJ1n19d8K2vayNq9R+EBBzUk
         k2pejCTwGObNokO0nczNIWGPABf8+GmX2w9Fm1FTFhR++apxWW3vV8h//hGuyMM4yIYA
         ybe2C51JbaJ8DvbMPSPm/NAax525ZggwwqXrOLO+8AARo4Gmsg7G+p7NUrlIdyso6mz+
         VvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677583952;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mcd7RrtByBZPxC19CV7dp8nM8d22290UkmwmOr7iOGI=;
        b=esohwZB8LLWNTh6u1jSRI5CqoKuT2RMo3td/gUxfDwmHP+K3I3mWVjoOAHF+kxzRD8
         O35iuGPdj+WZxsYw7fgHmeFSPux6n7M8Bnuryn2sXAU5Sq05cFNr3Ag+ph+aaOAzNjtb
         Qsri+EkTSK4IJx9/Wa2gw8mc4LOepdWgdpubTlZrg0NJ0eKOgsVhMz0R8/RIdS9A9/rv
         SYcww35CCoD92uH1eFl2cjSOfTBrn/Net1lN5Gegj5vYGETGZf97UK8aGsTf06GmaF8z
         H81YIGAkRLBrfr8m/XMZ61GqdRsV3HKtYRNo+iTVJkZmIYMmcGY5wOmMlp413MUCL+f3
         AELw==
X-Gm-Message-State: AO0yUKXjO12B1Wi4ezEXd1hz+GaohQtO10KIVU2kqj8yl0BYqmLGzljM
        QrRYTndBnNHadKp/eBsC55g7Yawvw7g=
X-Google-Smtp-Source: AK7set8oLD+4fq4mW1FnQOPBlZLxDl18Sp0mmct8xi1gXFkLHH5wtS9bgjqz/rgxi6RqZwzd9NUPqg==
X-Received: by 2002:a05:622a:95:b0:3ba:ef:fc0e with SMTP id o21-20020a05622a009500b003ba00effc0emr4207792qtw.57.1677583951960;
        Tue, 28 Feb 2023 03:32:31 -0800 (PST)
Received: from [172.17.0.2] ([172.177.255.84])
        by smtp.gmail.com with ESMTPSA id z29-20020ac8431d000000b003bfc1f49ad1sm6264021qtm.87.2023.02.28.03.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:32:31 -0800 (PST)
Message-ID: <63fde64f.c80a0220.415b7.239e@mx.google.com>
Date:   Tue, 28 Feb 2023 03:32:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4340112370361506628=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel: Iterate only bluetooth device ACPI entries
In-Reply-To: <20230228110154.18936-1-kiran.k@intel.com>
References: <20230228110154.18936-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4340112370361506628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=725466

---Test result---

Test Summary:
CheckPatch                    PASS      1.06 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      32.52 seconds
CheckAllWarning               PASS      35.49 seconds
CheckSparse                   PASS      40.06 seconds
CheckSmatch                   PASS      111.39 seconds
BuildKernel32                 PASS      31.54 seconds
TestRunnerSetup               PASS      450.09 seconds
TestRunner_l2cap-tester       PASS      16.17 seconds
TestRunner_iso-tester         PASS      16.54 seconds
TestRunner_bnep-tester        PASS      5.36 seconds
TestRunner_mgmt-tester        PASS      107.32 seconds
TestRunner_rfcomm-tester      PASS      8.75 seconds
TestRunner_sco-tester         PASS      7.98 seconds
TestRunner_ioctl-tester       PASS      9.40 seconds
TestRunner_mesh-tester        PASS      6.78 seconds
TestRunner_smp-tester         PASS      7.84 seconds
TestRunner_userchan-tester    PASS      5.72 seconds
IncrementalBuild              PASS      28.65 seconds



---
Regards,
Linux Bluetooth


--===============4340112370361506628==--

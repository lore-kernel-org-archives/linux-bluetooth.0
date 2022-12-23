Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E21DC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Dec 2022 09:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbiLWJfH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Dec 2022 04:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiLWJfF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Dec 2022 04:35:05 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E359537231
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Dec 2022 01:35:02 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id c8-20020a17090a4d0800b00225c3614161so1198291pjg.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Dec 2022 01:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/ATqANE8MPzeoKy9Pps8C2fEWlDJCcu+O/SEAi24wfY=;
        b=Ye/XBR7GIclSR5bLZ7LEANZhcEyU/ezjFpjskOSGR7I123YzixHn2qS3LmB3p0Y//m
         AglDnwmR7/aRwGEFx2FbqTxvF4OQ4TcUJdG5sYEFXQ1Nl+9OhW0TbnBfR7TRX/w+A2fG
         7bKjx883E0AYb3DnE0crzRQ5jz5OxbFj0ma2NOxLLxUobrFOD4NjuIwzPjfAPKtexN5y
         XZOWTQ++PZGGRCPHttUnqyAn0NNU7lxZRJnxvnK5sKuURzRN7K/i57ZDUrpViYNkdTiU
         SPJw6JKluFZNN64kvzWpVmEH7/6bUuAF6YAGDsrC/LlSLlboScJZouIpQmoulN8Ti0WU
         fa9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ATqANE8MPzeoKy9Pps8C2fEWlDJCcu+O/SEAi24wfY=;
        b=j+N6wUfWseQfg3WkCrmqxi9ag42pWU0IOOXjRELGPGIuqFEAUna01YviPWidYwum+i
         bvUIo788mZFoZSXCqdXb+vUFGessFOH20gjLTYDajq1DkThFHlTAUD1F/LDi+HTUpPm4
         G3mgJMpdXCTCAnEcz3IpvHSBbrm+OE5PLnruIH9MvSqulzli8UGNvLPbS7q/g21V2UdX
         1Bwbs5s50aBcKBGE5aA6mP7Gm9WcuGRoWRZj6/R70eGbHz+3n1WNuOD2bfLvLxSdrswB
         /UtHOSla5GygkXYSfeU+kTyrPZkrL7aR9gpso7XGpTj5Wn9sMUnHi1oZ10m0+19YtV+K
         PBpw==
X-Gm-Message-State: AFqh2kplTOHeECAzICcVcgFKZpiCGTKxriqxUvGqkY0kzsZ6gY73jjbk
        2zVz+67rht448/01NmzsGIHUO3T/G7Q=
X-Google-Smtp-Source: AMrXdXttAFbFTDV/OWP2Ufdfj6L5TSa5kmtKn+f9sbqYbABTq0fISTZuS9HCLzrxrKY5I129+WJjBA==
X-Received: by 2002:a17:90b:124b:b0:220:7147:c981 with SMTP id gx11-20020a17090b124b00b002207147c981mr24846575pjb.29.1671788101363;
        Fri, 23 Dec 2022 01:35:01 -0800 (PST)
Received: from [172.17.0.2] ([4.154.90.99])
        by smtp.gmail.com with ESMTPSA id v13-20020a17090a4ecd00b001f94d25bfabsm4266634pjl.28.2022.12.23.01.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 01:35:01 -0800 (PST)
Message-ID: <63a57645.170a0220.238bf.874c@mx.google.com>
Date:   Fri, 23 Dec 2022 01:35:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0558746457307241664=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: [v4] Bluetooth: btusb: Work around for spotty SCO quality
In-Reply-To: <20221223085742.2482-1-hildawu@realtek.com>
References: <20221223085742.2482-1-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0558746457307241664==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=706705

---Test result---

Test Summary:
CheckPatch                    PASS      1.21 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      38.85 seconds
CheckAllWarning               PASS      42.62 seconds
CheckSparse                   PASS      47.92 seconds
BuildKernel32                 PASS      39.61 seconds
TestRunnerSetup               PASS      549.90 seconds
TestRunner_l2cap-tester       PASS      19.61 seconds
TestRunner_iso-tester         PASS      21.62 seconds
TestRunner_bnep-tester        PASS      7.01 seconds
TestRunner_mgmt-tester        PASS      133.72 seconds
TestRunner_rfcomm-tester      PASS      11.18 seconds
TestRunner_sco-tester         PASS      10.18 seconds
TestRunner_ioctl-tester       PASS      12.15 seconds
TestRunner_mesh-tester        PASS      9.09 seconds
TestRunner_smp-tester         PASS      10.09 seconds
TestRunner_userchan-tester    PASS      7.42 seconds
IncrementalBuild              PASS      37.98 seconds



---
Regards,
Linux Bluetooth


--===============0558746457307241664==--

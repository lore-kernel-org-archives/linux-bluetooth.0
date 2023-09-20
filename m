Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F82BC04AA7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Sep 2023 16:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbjITQFF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Sep 2023 12:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbjITQFE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Sep 2023 12:05:04 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7482ACF
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Sep 2023 09:04:58 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c5bf7871dcso5843095ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Sep 2023 09:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695225897; x=1695830697; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9+hblDq7PP3kzamzPwX2Snd5Q2AKDnYovRlql8cja/A=;
        b=C8mTA3CJiILjelTY7xBk0YWXiJEwvKnj/NIXnhrghtGbJbGNtVTwttMoh6DT2LQ/YW
         3Mz4cSkY7omxOGTJL5lenVj5pNtQchBe9mI6shua5xCzunWt0gGXqE/WVvKvOLx9O7WM
         70xWj5vUT6FplPs2ZSO/9j501YKQ44ET1cCCq7hfL+KCjFgoJ6DD6BK+eKnUf7qey9hu
         aFZcvBu7vhhXI0NOChzVmX64nfIWdAE05/FoGtATEPV+OTs7SsZ24kSj7r2+T//mU9VL
         2ayXxe2l5PAvHooQQMwrNU3uJmTmJBLYeC5YcPuufF4LrH3rqSwLnBu5fVpd+kvsEaW8
         WBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695225897; x=1695830697;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+hblDq7PP3kzamzPwX2Snd5Q2AKDnYovRlql8cja/A=;
        b=Tcrru3ODzu4SAwQgywSj8xDnlasiGN/Btgwr5Wzv/q9kyWQ3kJUW0V0dD6yejKRJQT
         xolkOJQ9TrnbtvA7D9dg4m/w7fHfkLgI4IeBZOL37ksMvEUNAAacIdELp7A52UjxRYlK
         s4iMBM/U8+IS67yeE7QDvnV/DVjHnqIiQEz0YzEcmkjiNGGtLXOxcufBU0HMt6uG3FEf
         EpUIDEgnDHZFkX0mt79SAtwKvfXVxvk0hiVbHeTt7Tl0PmQW4BF0bjonrG56ZwdfWllq
         RnGeS1Faii3piUJY+DBlx+8IAH9gJ+veFjwJzpm82TUoTWYh7PV65zvkmMozFvWktDrL
         akYQ==
X-Gm-Message-State: AOJu0YzfpUKtzvawHmeM2EVmNyLM58NjWAHmGUOAmvi1nNJgL48kd1cN
        DFmKYnFWW1p7ZSoa7yUZfOoPuthGAsA=
X-Google-Smtp-Source: AGHT+IEk/W4Rr4A0WMxyj/iGk0Fvx0usb5W0sTTQdvjikq029CqRmBT0V95Ui4iBGK5wAFD6yPisxQ==
X-Received: by 2002:a17:903:228b:b0:1c4:1142:6e29 with SMTP id b11-20020a170903228b00b001c411426e29mr3439452plh.14.1695225897400;
        Wed, 20 Sep 2023 09:04:57 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.3.36])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902ec8b00b001befac3b3cbsm10442574plg.290.2023.09.20.09.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 09:04:56 -0700 (PDT)
Message-ID: <650b1828.170a0220.95716.47e1@mx.google.com>
Date:   Wed, 20 Sep 2023 09:04:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7114053324647080898=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: Bluetooth: vhci: Fix race when opening vhci device
In-Reply-To: <20230920153008.967330-1-arkadiusz.bokowy@gmail.com>
References: <20230920153008.967330-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7114053324647080898==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=785987

---Test result---

Test Summary:
CheckPatch                    PASS      0.79 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      35.89 seconds
CheckAllWarning               PASS      44.57 seconds
CheckSparse                   PASS      47.86 seconds
CheckSmatch                   PASS      125.39 seconds
BuildKernel32                 PASS      34.96 seconds
TestRunnerSetup               PASS      560.66 seconds
TestRunner_l2cap-tester       PASS      34.67 seconds
TestRunner_iso-tester         PASS      68.10 seconds
TestRunner_bnep-tester        PASS      11.73 seconds
TestRunner_mgmt-tester        PASS      251.17 seconds
TestRunner_rfcomm-tester      PASS      19.18 seconds
TestRunner_sco-tester         PASS      22.19 seconds
TestRunner_ioctl-tester       PASS      21.92 seconds
TestRunner_mesh-tester        PASS      15.76 seconds
TestRunner_smp-tester         PASS      16.69 seconds
TestRunner_userchan-tester    PASS      13.02 seconds
IncrementalBuild              PASS      35.12 seconds



---
Regards,
Linux Bluetooth


--===============7114053324647080898==--

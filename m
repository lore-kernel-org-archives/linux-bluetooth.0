Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B06CDB47E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Oct 2023 15:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjJRPlY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Oct 2023 11:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjJRPlY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Oct 2023 11:41:24 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97294114
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 08:41:22 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-65b162328edso40820016d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 08:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697643681; x=1698248481; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fnLyAI9V74Ts2hSkn0jIVpXAsAIaPVvXHLpoMnm7bdY=;
        b=Mq+KS22Z965V5VRX12DV7DkJBupjABME+XHgrlhnjtWXEwNXV6+vgSorf1UrKSg3y1
         CAkSAVoN1RXTs36+xT+YajhsSeQMTcWMq4lUYqoJwW4epQkRbfjTVkvVKpH47e/bbV49
         T115TbL2+pk2huLjDNVm6JrmLKM7t3UggtnduFmafV2kIAGxCbaJ60U0Gbg5pBY+Od/F
         nCAz208SQIwhx+JEaZm8uqJaK7Xltw9n2MeAv86iWK0CkN+3OVjcp5E1dFGNPhsSb8tr
         RNDrmkSd6fME/WGJ8qfE5qcrYRgC+I7VTr+bULAi/fYp3Wkzr+DLSsNXjmRudpQMUTH4
         t4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697643681; x=1698248481;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnLyAI9V74Ts2hSkn0jIVpXAsAIaPVvXHLpoMnm7bdY=;
        b=H1b7+tGlGckObe1SC9hokjDUlyOuMs7qjhYV2tHvhdiWCQq/dhEa3JT0WKiG7SyrnY
         t2K0v7ZaZEJwsv3Jg31w29KYx+WfsLoPe6VdUw34hjiPyhzQ6GPTxuaWM6M8XKZPsdOc
         HZ2Pam4c4Ah7daqRUz0rxt6eZAYFPuMzwuZIj0LtNoGPnNkgtr3m6lQXyUDY1y/fia1j
         sG9MjoolFQQAbX+tMN/Y1eWGwDHGClwu6Pb+0+yMi0rUPO/9RiNWLlUQstXkRHpmzgYG
         DMW7Om61tlUZ4mXuxoBi6DcVyQ9NIxxZnywvbYztb+coo3EHt3GJf2zYNp3wCZ7ZxOxX
         XPdg==
X-Gm-Message-State: AOJu0Yz+vNMvC8dgAd8LP50vcSMGfsp5QyvUG6i3x9VcGY9WZwWhQPeZ
        yRhDot4RzQncXfWAeFmLKNbcwmad4E0=
X-Google-Smtp-Source: AGHT+IG/KqhR5si2fWgXUyMLQAXHy+xiPSALfqgAbOFblXj7CEtvYD7VYQ+n2/+9+ydp5+KCOHPO9g==
X-Received: by 2002:ad4:5ae8:0:b0:64f:49d1:3fe7 with SMTP id c8-20020ad45ae8000000b0064f49d13fe7mr6538923qvh.23.1697643681602;
        Wed, 18 Oct 2023 08:41:21 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.202.239])
        by smtp.gmail.com with ESMTPSA id o8-20020a0cc388000000b0065b0d9b4ee7sm43432qvi.20.2023.10.18.08.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 08:41:21 -0700 (PDT)
Message-ID: <652ffca1.0c0a0220.4fe80.06a5@mx.google.com>
Date:   Wed, 18 Oct 2023 08:41:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2003121328664191933=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Allow binding a PA sync socket
In-Reply-To: <20231018143435.3388-2-iulia.tanasescu@nxp.com>
References: <20231018143435.3388-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2003121328664191933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=794361

---Test result---

Test Summary:
CheckPatch                    PASS      0.82 seconds
GitLint                       PASS      0.38 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      40.93 seconds
CheckAllWarning               PASS      43.41 seconds
CheckSparse                   PASS      49.51 seconds
CheckSmatch                   PASS      133.25 seconds
BuildKernel32                 PASS      38.14 seconds
TestRunnerSetup               PASS      598.77 seconds
TestRunner_l2cap-tester       PASS      36.39 seconds
TestRunner_iso-tester         PASS      66.55 seconds
TestRunner_bnep-tester        PASS      12.14 seconds
TestRunner_mgmt-tester        PASS      242.58 seconds
TestRunner_rfcomm-tester      PASS      18.27 seconds
TestRunner_sco-tester         PASS      21.46 seconds
TestRunner_ioctl-tester       PASS      20.88 seconds
TestRunner_mesh-tester        PASS      15.47 seconds
TestRunner_smp-tester         PASS      16.65 seconds
TestRunner_userchan-tester    PASS      12.91 seconds
IncrementalBuild              PASS      36.39 seconds



---
Regards,
Linux Bluetooth


--===============2003121328664191933==--

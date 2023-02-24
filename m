Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B357CC64ED8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Feb 2023 23:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjBXX5g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Feb 2023 18:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBXX5f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Feb 2023 18:57:35 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDE86F436
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Feb 2023 15:57:29 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id ev13so597226qvb.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Feb 2023 15:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677283048;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CqFO7wkAa+4QaLdhVlO8WoTjSgzaw5q7g9xN2PEQy2I=;
        b=SLk06My+0p/ShXQyD3CYDQedTOJnfp+Ajze9LPeekpEldxoA0RZe5IBmktZm4nVZrK
         3yhN0kFa9UcUsVxBFiAkXpDEpFcqcsbeGFQy0GPkyz4dJ6CJw0Eyhkty76POWrtg4M2H
         u3T1nbFgAVFg79qiNQITRAPFtt5Cnog0kJKt0X09dZgLZO7VjiPLZpx7/gyXUh20Wvg/
         iSwIjuf7mmQV3E0F35oAPtCqRuoGVLYp9lBTO9+eVnlixWIkH++A2in5s7nplykILz3i
         U2i3oJweVjPEWeP02Omk8JOOM7PiBAhnGlIo6Qy4iJ1CEDzUgfW8RjEyXsHorTjsxD6e
         hc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677283048;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CqFO7wkAa+4QaLdhVlO8WoTjSgzaw5q7g9xN2PEQy2I=;
        b=DzFAh+JSF4UEvaQpvjSi01zeZ5rsfsMitd6S0p33dIEUv5b6xKEJQyRxWjehPbcDgo
         kazILI8u8KMgSQN7Ihuw41dpSvuuZ/BZONsF2JoQTfg+vP15iThZ84t8lX53neafaLaH
         cKatH3wSmeZRDgjbYCDYtIg1PjJxObKaQIYEe8nN2SbTWmTlo1EhPcXnw/ZjGuNpk87w
         ju6TPWgfHEjpG4atm+CN1VHM75zS/gA2Xy7+/Zok2z2tC+pB/jwHsERmpoceCO8TyGOM
         EwcuTfvXxbuxFvLYYalP2Jg8ny5EqDD1Eq+KkfqGbBVTZomh4bKmUq2bpsHVJSs/i8Bv
         HS/w==
X-Gm-Message-State: AO0yUKVR17b2ltN5D/g2OA8d64WEJdn3jj9wCXzxCTkmG8diS9ObyTg/
        NUDQ0WfW/mG6KbFSKk19qFgsMElZKEw=
X-Google-Smtp-Source: AK7set8n0zT8J1pgU3S+zms1KSoqzG77mpVQkjw4Rck7VvucX1jYH4vlMMMIi6scGNdUkMDkH/fb9A==
X-Received: by 2002:ad4:5aa8:0:b0:557:a5c5:7e01 with SMTP id u8-20020ad45aa8000000b00557a5c57e01mr2623863qvg.25.1677283048364;
        Fri, 24 Feb 2023 15:57:28 -0800 (PST)
Received: from [172.17.0.2] ([172.177.65.64])
        by smtp.gmail.com with ESMTPSA id g128-20020a37b686000000b007419f1561fesm220428qkf.112.2023.02.24.15.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 15:57:28 -0800 (PST)
Message-ID: <63f94ee8.370a0220.3ad3a.0a37@mx.google.com>
Date:   Fri, 24 Feb 2023 15:57:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3920041022407085821=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, macroalpha82@gmail.com
Subject: RE: Bluetooth: Add support for RTL8821CS
In-Reply-To: <20230224232339.124969-2-macroalpha82@gmail.com>
References: <20230224232339.124969-2-macroalpha82@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3920041022407085821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=724799

---Test result---

Test Summary:
CheckPatch                    PASS      1.97 seconds
GitLint                       PASS      1.02 seconds
SubjectPrefix                 FAIL      0.62 seconds
BuildKernel                   PASS      31.79 seconds
CheckAllWarning               PASS      34.69 seconds
CheckSparse                   WARNING   39.58 seconds
CheckSmatch                   WARNING   109.23 seconds
BuildKernel32                 PASS      30.47 seconds
TestRunnerSetup               PASS      438.75 seconds
TestRunner_l2cap-tester       PASS      15.89 seconds
TestRunner_iso-tester         PASS      16.25 seconds
TestRunner_bnep-tester        PASS      5.38 seconds
TestRunner_mgmt-tester        PASS      108.41 seconds
TestRunner_rfcomm-tester      PASS      8.57 seconds
TestRunner_sco-tester         PASS      7.85 seconds
TestRunner_ioctl-tester       PASS      9.13 seconds
TestRunner_mesh-tester        PASS      6.81 seconds
TestRunner_smp-tester         PASS      7.81 seconds
TestRunner_userchan-tester    PASS      5.56 seconds
IncrementalBuild              PASS      36.88 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:47:45: warning: array of flexible structures
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:47:45: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============3920041022407085821==--

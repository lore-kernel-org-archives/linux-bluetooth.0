Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6E5C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 07:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241081AbiKRHe2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 02:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239958AbiKRHe1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 02:34:27 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98A772139
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 23:34:26 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id o140-20020a4a2c92000000b0049effb01130so659796ooo.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 23:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eOM1q/zsCe5+CndBwnZvB3ktofaujmpOyZFONwM9QMw=;
        b=K5/h4csT20XONZFYA4Tn/2DLwX/KSLzWA82J+BN+uUeFn+pFnvhmSHTzAz8N3PcQum
         rEC1UD7oAAkhaVbEhOXEDrcUJ2mhUOaN0k/wW/t17MU4wGDh6FTt66zLWeIdQdsOu4vr
         MxjKem2yrBshUhFThMHwxpLeHWZP/68iE6JMC6W3KIWymb3tuvulHCpYEUjhZIaA14nE
         SS+hVfATjEFFdpJO/zt5VhA1nHNyKoZWcxkOU/BTdBi/pcS+TLMCFn4vVTx+qjKXlW7c
         utsI7ZdTMp7ex6bQ5eazYcNH4u4H68M3ZMCpxn73z3117s0srHp1nzbyedldeMcSOc3k
         LYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eOM1q/zsCe5+CndBwnZvB3ktofaujmpOyZFONwM9QMw=;
        b=NFYqtKlpI3Ul00CR9hNlAM0ZKj5CTBl8KM0TLFq96+m/17KROhGZ1qpcKrpV57USWH
         1urDcdGQJ82rAO8dDQrVRSb2Lb+HHrBEW//LY0a/aQbzpWgyCawDcRgL7AiJ1GOTisVU
         +4rg3Hs9W1O3tJaJN1aX2e6tVyZQ4JaRlUtwhubagDJCOeQ4FsTdxiWZxyCok42cxj77
         zF1lRgdxBzxP9TpU+iz++BR2CfKQsQ2S/sS/lI7MgKcYJ4bygr3lT9ugNpRMQFBJwMCy
         I4yPY2E/a/A1sMwDxYDa7eLB8MAtZcPWJ85H1KpVh90Jzni7tE8eP4bzfMuMaxYWjqJd
         1u2g==
X-Gm-Message-State: ANoB5pm02yhxYjxhDmlWLdSLPG/x4jgWYw0ygRG/nrdmuKpB1MkoDfXG
        WPgpiH3FJBqt6qIOnUKbd62Ggakc5Lk=
X-Google-Smtp-Source: AA0mqf4MXG7GFKcxbb4V4pf5XoAGS7rLL3GGubrpQKvh54H1U2c/q6Y60ghEFChR96F+mQ6kEs0cNw==
X-Received: by 2002:a4a:d086:0:b0:49f:c8f1:a4c8 with SMTP id i6-20020a4ad086000000b0049fc8f1a4c8mr196430oor.39.1668756866085;
        Thu, 17 Nov 2022 23:34:26 -0800 (PST)
Received: from [172.17.0.2] ([20.225.102.65])
        by smtp.gmail.com with ESMTPSA id m25-20020a056870a11900b001324315bb6asm1616768oae.29.2022.11.17.23.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 23:34:25 -0800 (PST)
Message-ID: <63773581.050a0220.2c199.6e5c@mx.google.com>
Date:   Thu, 17 Nov 2022 23:34:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8274120391595372450=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [DNM,v3] Bluetooth: doc: test patch - DO NOT MERGE
In-Reply-To: <20221116052716.57521-1-hj.tedd.an@gmail.com>
References: <20221116052716.57521-1-hj.tedd.an@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8274120391595372450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=695798

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      45.20 seconds
BuildKernel32                 PASS      40.15 seconds
TestRunnerSetup               PASS      560.91 seconds
TestRunner_l2cap-tester       PASS      19.22 seconds
TestRunner_iso-tester         PASS      20.09 seconds
TestRunner_bnep-tester        PASS      7.03 seconds
TestRunner_mgmt-tester        PASS      130.57 seconds
TestRunner_rfcomm-tester      PASS      11.70 seconds
TestRunner_sco-tester         PASS      10.82 seconds
TestRunner_ioctl-tester       PASS      13.07 seconds
TestRunner_mesh-tester        PASS      8.87 seconds
TestRunner_smp-tester         PASS      10.69 seconds
TestRunner_userchan-tester    PASS      7.25 seconds
IncrementalBuild              PASS      42.36 seconds



---
Regards,
Linux Bluetooth


--===============8274120391595372450==--

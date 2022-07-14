Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4611FC43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jul 2022 08:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbiGNIAw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Jul 2022 04:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiGNIAq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Jul 2022 04:00:46 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F24922522
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Jul 2022 01:00:45 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-10c0d96953fso1613623fac.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Jul 2022 01:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=tZOsZ9o/wmMdf21zGnFd0+0ycOAK/adrec2RpHkDbvU=;
        b=kcTcF3QINSdr2ftN3L0IpsmWsj5LzAhAo6FdF5114OKJfliGIEoJQJDbFS7OYz0UTt
         Guk8uZ5ZkvDi+EuGqYlKQvT7AYlUDRd13LtUrD8brDZ7uQiv+FOofrRRSDKAgWWcqFS2
         TVO+BEW7w9lb/SZ+VbC6khM8g/kYv3O0vsj4poajkUPbD4JVbHt6BcNKExgWxbtHq/Ka
         BcUtYAOJG2RJbf5yZD5l3LSY1qvKNnk/yi2UZQ5nvfWnaBHpsWHBQsc6/0e/mHyWHaG+
         w7LExkx39yQOuaA3w6WyL6dGMYKEIrH8ZqKJJdNO7LjArTfy5U/FWlcCANfnJ8YQYzf7
         wRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=tZOsZ9o/wmMdf21zGnFd0+0ycOAK/adrec2RpHkDbvU=;
        b=tlnVFGBdN3e1ICOesWGV9wtQqrH09EXFnqR2oXBxnoOKwSvryX9PYvzvhigTegQClA
         17yZiqGmcYfd5Pwj0KztR63lm0WeOdPeR0sshROWOBalVCwlApE8GoGuRwkUDmTMNTwB
         DIuvdUtu7eJZLaN1K+Q2Q2t1x6cRVexWmchAC+NhIXuF9MXMDGOrN2oqVoYDasQSAybI
         9PYCx6pqggTOVrdmgICMzW/N4ivpW24gaWZ74caW46VOzDEpR7QQCl8wwHTSWErhmdJY
         Bee+2GmnUAaQkd9UWoNnpn9L5DUXznHkeFkWvsrB3+yoiFyNRbWLBYxNhpDfGLU5Npls
         QQCg==
X-Gm-Message-State: AJIora+LwbDEzT6n8Uq4X7Nb1OY4zDYj77jVxOg5YyclOGitFKRtTwHK
        WoeRShJEViFPNaX3ObWy2lgFiZnJenI=
X-Google-Smtp-Source: AGRyM1t8na9YRXATqNL1xnXtMESCP69xtQRYCsxDyNWlyjJzmC3u65VunKXnWxp7jsDY+ZEKBx1yVA==
X-Received: by 2002:a05:6870:e99b:b0:10c:9eb4:faa9 with SMTP id r27-20020a056870e99b00b0010c9eb4faa9mr6554330oao.260.1657785644433;
        Thu, 14 Jul 2022 01:00:44 -0700 (PDT)
Received: from [172.17.0.2] ([20.225.180.188])
        by smtp.gmail.com with ESMTPSA id ek11-20020a056870f60b00b00101afc7b263sm560468oab.9.2022.07.14.01.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 01:00:43 -0700 (PDT)
Message-ID: <62cfcd2b.1c69fb81.13eb3.1c18@mx.google.com>
Date:   Thu, 14 Jul 2022 01:00:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0019298573333289707=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1] Bluetooth: Fix cvsd sco setup failure
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1657782880-28234-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1657782880-28234-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0019298573333289707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=659570

---Test result---

Test Summary:
CheckPatch                    PASS      1.46 seconds
GitLint                       PASS      0.71 seconds
SubjectPrefix                 PASS      0.66 seconds
BuildKernel                   PASS      32.14 seconds
BuildKernel32                 PASS      27.75 seconds
Incremental Build with patchesPASS      38.14 seconds
TestRunner: Setup             PASS      477.78 seconds
TestRunner: l2cap-tester      PASS      17.07 seconds
TestRunner: bnep-tester       PASS      6.08 seconds
TestRunner: mgmt-tester       PASS      103.92 seconds
TestRunner: rfcomm-tester     PASS      9.45 seconds
TestRunner: sco-tester        PASS      9.10 seconds
TestRunner: smp-tester        PASS      9.21 seconds
TestRunner: userchan-tester   PASS      6.10 seconds



---
Regards,
Linux Bluetooth


--===============0019298573333289707==--

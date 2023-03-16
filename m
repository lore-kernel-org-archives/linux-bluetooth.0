Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979E5C6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 10:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjCPKeT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Mar 2023 06:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjCPKeS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Mar 2023 06:34:18 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8555BAA
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 03:34:17 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id p20so1193177plw.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 03:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678962856;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lNd8IcYxVqNald+Mbs+yBMxKxnEHY95vXbVkYoW+O+M=;
        b=etf62E7+HTgYrxptMjbe4z9B27IGt33ff4rp2ZTXTdP+kqS5LviAktkuzjtRpLMl9r
         4DgUi/Ta+sOFyuojIjOegtHg5n/UPsIb3KUgnSn7Oe9Mp5BAG1jcq4WlyoXkJisbfIWO
         BeiQTzOFOvDaG/eDWc/mSpHjKU85fSgYEi1nfrBJ2MZsZmpLsG7f/KrTcPIq9h3WIVNK
         q0EzCgtfoOosDUw2wniqCEBZ9nLRG42k+D2GS9y/OBJEPC3c2tJoZ7Qanc+gFottDrB4
         DGX7Z/z8/4iDr+hMHy+hctWfkSoFSyOo0VUJf3ZRYbZQbpnVWtLQNzHqj+ebUjzfDtkX
         aFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678962856;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNd8IcYxVqNald+Mbs+yBMxKxnEHY95vXbVkYoW+O+M=;
        b=nfmlgTz6amU+N78QahCIEmLDD+HH4WQMsenlRiSoZYAJ3pGnjmNzJIyU25BR2Q+MTu
         MQY4B1+vjxB7xVkgOPiFOE643oT0XfZ6/y6vcCx0Ry/7u30p70xIJzk95eygOzEyjcHQ
         fDkj2pX2ies4bRfxzMwxtyOJRuhZDOA+E2XKg2H55+6w675kEgx7HLn7d8yKgIpwOOWJ
         Tt+wMJ7s5Ga14lp2GTMF6RA89h1UEbO3x4IC/g276a0s/e55wVbEXDr6S0lLTG9ficW3
         7JgtMJI27Awb1wThHrmIMZgvolGnF3zVmDa+G9DtxRlr4Ggvh5zNHJeI9Op7t9v8MtZ/
         gg7Q==
X-Gm-Message-State: AO0yUKV+gChw5JzhABDQwEnRBCHsJGPAwRpFf107P2gOcB/EQkk5VcGz
        aN73Ay8WcWMc9PiPXeED3WzgLvK4icc=
X-Google-Smtp-Source: AK7set9d48JWSCW6iv8E1PrXKkEBdf7A8XzGxlpMIFXoMVDFvLsvNIHch4c5WZzmaoKyvU/u3Zp8Mw==
X-Received: by 2002:a17:902:c94f:b0:19e:675b:a40f with SMTP id i15-20020a170902c94f00b0019e675ba40fmr3423501pla.8.1678962856342;
        Thu, 16 Mar 2023 03:34:16 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.51.36])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902d90400b001a060007fcbsm1463383plz.213.2023.03.16.03.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 03:34:15 -0700 (PDT)
Message-ID: <6412f0a7.170a0220.5ac6a.2fbe@mx.google.com>
Date:   Thu, 16 Mar 2023 03:34:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5237762581480189355=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [v3] Bluetooth: mgmt: Fix MGMT add advmon with RSSI command
In-Reply-To: <20230316181112.v3.1.I9113bb4f444afc2c5cb19d1e96569e01ddbd8939@changeid>
References: <20230316181112.v3.1.I9113bb4f444afc2c5cb19d1e96569e01ddbd8939@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5237762581480189355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=730713

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      30.95 seconds
CheckAllWarning               PASS      34.51 seconds
CheckSparse                   PASS      38.78 seconds
CheckSmatch                   PASS      107.82 seconds
BuildKernel32                 PASS      30.34 seconds
TestRunnerSetup               PASS      438.31 seconds
TestRunner_l2cap-tester       PASS      16.53 seconds
TestRunner_iso-tester         PASS      16.55 seconds
TestRunner_bnep-tester        PASS      5.43 seconds
TestRunner_mgmt-tester        PASS      107.89 seconds
TestRunner_rfcomm-tester      PASS      8.51 seconds
TestRunner_sco-tester         PASS      7.92 seconds
TestRunner_ioctl-tester       PASS      9.13 seconds
TestRunner_mesh-tester        PASS      6.75 seconds
TestRunner_smp-tester         PASS      7.77 seconds
TestRunner_userchan-tester    PASS      5.58 seconds
IncrementalBuild              PASS      28.36 seconds



---
Regards,
Linux Bluetooth


--===============5237762581480189355==--

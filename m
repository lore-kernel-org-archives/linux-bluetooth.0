Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41FAC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Oct 2022 22:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiJMWKR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Oct 2022 18:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiJMWKP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Oct 2022 18:10:15 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F374E62F
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Oct 2022 15:10:09 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id o64so3219288oib.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Oct 2022 15:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7J1HQbPZ+3gnxqn3YUuoXwe7wEcjuXSRdgo9xgrDb9I=;
        b=C59lTUZQ7wKeZTdgdXj9ab3/nOPp0OAF6wfEtGe8Jn3jhF/wkyFdGOUIZyliy0ydQc
         Zp17blIhNIcr4rF2jmCyVTdUgFnb4CJZ5hHL51504ul/7WuDjXeBEl6a7HaenSMfNqHS
         BC7b4jvyBN1Mnfj3aSRL0pFe3iyr+vTdzA4J2kNftIHdDNurYs+YJV+8MgVTQltKrGCw
         zCl9kLJXsE83lRysLIWpvMFC4DCNHVI4A4NtnFEJRcRBfawmEXT9Zoj/cuRNGyxZXrMX
         CZD5NOxWuyuLHXjfh4+U11QpkOXy7RF8xDdevthVF0g7HRibTanXT43cxyRJ8HU+D2ns
         dhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7J1HQbPZ+3gnxqn3YUuoXwe7wEcjuXSRdgo9xgrDb9I=;
        b=Y0Iibjr4zOMe8ns5TfMRS2Cfb4rbyRQaPPY8Q/8JcKJYA+U1s+fOnnBWTIHjuMCLeK
         H3VjWRaM7vUTuaEUheZa0CSa5QysKlkOmr8sCzIVtN48bIX2fmlmQw2ml1nNxTc3eo8z
         qLbugWL+CmvL1JEmwOT4hvLa83P6JvMFopRxY4szjZo8rLvCvonGhuJHtBIfLrGEeSnv
         gNRB/msK2uIGGMJ/SrJ16C0iG3ov/oRPQmN7Petrm4ZO2RKAgkKl5lI8+i+y3b7QblpB
         FWrInyvY+UesNc/4TC9ONopkt03maJP38ttrBGMJ/fuUQRjqvypgllZYAkxi0APcdpIx
         EeiQ==
X-Gm-Message-State: ACrzQf2qm1WZK86BP8vmf6u07RtAK6CnYryLTNVJavzGNwD2bzQXHtdC
        mQqFBsrWmeBEEzoIPOQ4KDuWHJDvzoE=
X-Google-Smtp-Source: AMsMyM4MnivzrKVy1hzz5I6WHpvkPx34xs/YA2e3krs+vRlYqxwv/DEH7qSjbz0Zr80k5iy49WE/zQ==
X-Received: by 2002:aca:d804:0:b0:351:3e0d:ff2a with SMTP id p4-20020acad804000000b003513e0dff2amr955121oig.89.1665699008207;
        Thu, 13 Oct 2022 15:10:08 -0700 (PDT)
Received: from [172.17.0.2] ([20.165.51.62])
        by smtp.gmail.com with ESMTPSA id y8-20020a4ade08000000b00480888cedd3sm241736oot.41.2022.10.13.15.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 15:10:07 -0700 (PDT)
Message-ID: <63488cbf.4a0a0220.2ac5f.1560@mx.google.com>
Date:   Thu, 13 Oct 2022 15:10:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6551714142797788139=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiangzp@google.com
Subject: RE: Bluetooth: hci_qca: only assign wakeup with serial port support
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221013144431.v1.1.I47f1918a2786b34e7649387233377c57a8bdcdac@changeid>
References: <20221013144431.v1.1.I47f1918a2786b34e7649387233377c57a8bdcdac@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6551714142797788139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=685198

---Test result---

Test Summary:
CheckPatch                    PASS      1.25 seconds
GitLint                       PASS      0.74 seconds
SubjectPrefix                 PASS      0.62 seconds
BuildKernel                   PASS      34.78 seconds
BuildKernel32                 PASS      30.82 seconds
Incremental Build with patchesPASS      43.19 seconds
TestRunner: Setup             PASS      516.57 seconds
TestRunner: l2cap-tester      PASS      17.46 seconds
TestRunner: iso-tester        PASS      16.66 seconds
TestRunner: bnep-tester       PASS      6.55 seconds
TestRunner: mgmt-tester       PASS      107.54 seconds
TestRunner: rfcomm-tester     PASS      10.42 seconds
TestRunner: sco-tester        PASS      9.87 seconds
TestRunner: ioctl-tester      PASS      11.18 seconds
TestRunner: mesh-tester       PASS      8.18 seconds
TestRunner: smp-tester        PASS      9.89 seconds
TestRunner: userchan-tester   PASS      6.85 seconds



---
Regards,
Linux Bluetooth


--===============6551714142797788139==--

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF15C636CC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Feb 2023 06:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjBHGkX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Feb 2023 01:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBHGkW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Feb 2023 01:40:22 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45842442F8
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Feb 2023 22:40:21 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gj9-20020a17090b108900b0023114156d36so914358pjb.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Feb 2023 22:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=njkIsg7TqTUODFfIyXO7z1SWd9O8TDSrJT4inCnu9m8=;
        b=FD5SzO9lNOeZyG45IWynsghndrcS23ZhQMW4hDfc2lJsauAaMa5slhnFPN3Z6+u0Bi
         Qyk1Br5vdeuGh+7O7kowrMcuvqaq+HGtimOA9m3wjpMc2LNy6/JumznEMl+PaGQD1scC
         +qnzfpk6qnHc1JvdIvZ7AKf6k2LCt1q1kt1630l4Rhn6JmvCoSpLab4AH/Xl2i4x8qOm
         Fj5aF4F9B8vEoStP/vorXZZXi+TpfSmCPqkv7lb1V9PbZAiCNILs0wTQmzs3mKDkaMiR
         XDXyuqWujFbTsgIVlkUb/B040k8p+xeO1Zp6C+1Yk3xgSHgVca/boE8AuFfgadR97yvn
         U6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njkIsg7TqTUODFfIyXO7z1SWd9O8TDSrJT4inCnu9m8=;
        b=nCKagYjghHc+8Bk4CTJiEjZBArKYHUUuTSuLfZAzCSgYucTVASPAgkj3h4NtGLoscx
         zCf20dQCS+62DTVWEUkuNjroE8mDnjRG1Cc1icOoInfir+/wA1R9AHbzfAdBNOcfTPHt
         y6CyypRc6w9kQy67ykSizaHW8NaoVVHrYJWejuxg+07wvMB6t+BI3qUVmKIorrL+S8Qc
         /dODSkIcJM7ZWZYaTor7ANF/CTde/grj5s+PzE2iBk9Wv2kZ02te9XvHN5Ti2ylxvak7
         SHz+QH7emyXprmnJzq7xldCX8SCB9KxOaXRK0OIbemVkdLypt22rn7I8y+Wq9+I/mM73
         lI6g==
X-Gm-Message-State: AO0yUKXG5WKc2VBpZZAka0GfLudFS+E4gmMqX0QTcs49IhVKrKW6z5+o
        GB3NzaK8NwFJ/E71j4swpAlJT+J0vjg=
X-Google-Smtp-Source: AK7set+NvvxWUbWLrqRcfH2xfvfk7tx0k/DujzQ5wKStaWY5JXeEKm/mSRwR/bU/6S+4/CIWyXLAow==
X-Received: by 2002:a17:902:e888:b0:199:1f1b:3634 with SMTP id w8-20020a170902e88800b001991f1b3634mr6441724plg.26.1675838420411;
        Tue, 07 Feb 2023 22:40:20 -0800 (PST)
Received: from [172.17.0.2] ([13.91.166.0])
        by smtp.gmail.com with ESMTPSA id i64-20020a639d43000000b0044ed37dbca8sm9008495pgd.2.2023.02.07.22.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 22:40:20 -0800 (PST)
Message-ID: <63e343d4.630a0220.b52f4.ff2c@mx.google.com>
Date:   Tue, 07 Feb 2023 22:40:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5052602270860689053=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, max.chou@realtek.com
Subject: RE: [v3] Bluetooth: btrtl: Firmware format v2 support
In-Reply-To: <20230208054908.116502-1-max.chou@realtek.com>
References: <20230208054908.116502-1-max.chou@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5052602270860689053==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=719772

---Test result---

Test Summary:
CheckPatch                    PASS      1.11 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      38.39 seconds
CheckAllWarning               PASS      42.13 seconds
CheckSparse                   PASS      46.26 seconds
CheckSmatch                   PASS      128.69 seconds
BuildKernel32                 PASS      37.25 seconds
TestRunnerSetup               PASS      534.27 seconds
TestRunner_l2cap-tester       PASS      19.08 seconds
TestRunner_iso-tester         PASS      20.90 seconds
TestRunner_bnep-tester        PASS      6.62 seconds
TestRunner_mgmt-tester        PASS      131.05 seconds
TestRunner_rfcomm-tester      PASS      10.95 seconds
TestRunner_sco-tester         PASS      9.62 seconds
TestRunner_ioctl-tester       PASS      11.76 seconds
TestRunner_mesh-tester        PASS      8.51 seconds
TestRunner_smp-tester         PASS      9.58 seconds
TestRunner_userchan-tester    PASS      7.06 seconds
IncrementalBuild              PASS      35.02 seconds



---
Regards,
Linux Bluetooth


--===============5052602270860689053==--

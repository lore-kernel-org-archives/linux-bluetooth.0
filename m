Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65875C05027
	for <linux-bluetooth@archiver.kernel.org>; Sun, 12 Feb 2023 13:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjBLNPP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 12 Feb 2023 08:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjBLNPO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 12 Feb 2023 08:15:14 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8C2CDC6
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Feb 2023 05:15:13 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 24so6537940pgt.7
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Feb 2023 05:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=62rY0E055dwR/d6JPy7qYZp1b48YGlVDB4YtUiJS39U=;
        b=Gfxw8vAmVO1pKZIEdFABlNK4GE7f1JOtBN++TOJ3yGnkUiqAeTMaMW69xMbQF8ioLw
         YeUWMrj72DXX4VnVzXs3n+WRs23YufWW0qyMhVib3kI4grnOBhUbrNbEFOmu2EkoI1gH
         Ivx6K6qWFZgjbS833c1pOPbM6LEeui3EZ4n7SpAQfYDt4sshSWllH2LB1PPMjcLtnxuK
         aRqvCkztoYQh2+kVn7hfCaNz/4ln3i0g/R55/0uWqygCW+7S7hdxm/Z/y0erbGJ27jGp
         aBHgcgiduHhhMV2+GY4dIz+exlHiJjIVfLL2WaE8acpAIgiWWLIlvPdFJEg+dck94hfI
         Cvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62rY0E055dwR/d6JPy7qYZp1b48YGlVDB4YtUiJS39U=;
        b=jJoYIrqR6r30kSg/4QBxxHFfqLrVD5F0icHTa6kmpjciAT+CA9V/xfakb0nSbBfRvV
         k2RagS4koaE9hxkX+M7Mpth55qhuDP0DT13eqvunUbdTHYHRVNqpxN8r5FMyReuapgFE
         i3e3YvQ3PJxU9d47xODEZGE53RvlVZuMfZVAarXFNw5ghvt7UJzJTNwVoQ6QyCOtdg/A
         3XDnqrMpYSef7G3R6eAY4qHG1r2exkPaRMNubrr3hb9ce+KOFTDETjpQnURCmAGIt7pv
         wGe54lL47X7RJEjNkd6q1Xu/rIYG0LUxjwmlPI8INzyXQCoe+3UxZM6Cpb794LFW+C+W
         UqLQ==
X-Gm-Message-State: AO0yUKWyQHds3rtPR132EwHj8FYSIExl9a0CPZS6u8I6cmEcmz6T8ekt
        afHO92BKlNG7P4VgoURLnV6PN8I2Jsg=
X-Google-Smtp-Source: AK7set8ZeIlxh0EDwKqxjOAq/rUF6LDeHmANururqOwFl8Dit2kOgXsQjCSD3D3Kt6HkFKGMz+w9dA==
X-Received: by 2002:a62:1b42:0:b0:5a8:aae7:3032 with SMTP id b63-20020a621b42000000b005a8aae73032mr2079085pfb.14.1676207712719;
        Sun, 12 Feb 2023 05:15:12 -0800 (PST)
Received: from [172.17.0.2] ([20.172.45.224])
        by smtp.gmail.com with ESMTPSA id l22-20020a62be16000000b005943bd7c72bsm6162166pff.190.2023.02.12.05.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 05:15:12 -0800 (PST)
Message-ID: <63e8e660.620a0220.f69b1.b0d9@mx.google.com>
Date:   Sun, 12 Feb 2023 05:15:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7161552340219688282=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bage@debian.org
Subject: RE: Bluetooth: btrtl: add support for the RTL8723CS
In-Reply-To: <20230212124153.2415-2-bage@debian.org>
References: <20230212124153.2415-2-bage@debian.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7161552340219688282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=721066

---Test result---

Test Summary:
CheckPatch                    PASS      1.72 seconds
GitLint                       PASS      0.47 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      31.27 seconds
CheckAllWarning               PASS      34.04 seconds
CheckSparse                   WARNING   38.39 seconds
CheckSmatch                   WARNING   107.31 seconds
BuildKernel32                 PASS      30.17 seconds
TestRunnerSetup               PASS      433.53 seconds
TestRunner_l2cap-tester       PASS      15.83 seconds
TestRunner_iso-tester         PASS      16.39 seconds
TestRunner_bnep-tester        PASS      5.32 seconds
TestRunner_mgmt-tester        PASS      107.44 seconds
TestRunner_rfcomm-tester      PASS      8.59 seconds
TestRunner_sco-tester         PASS      7.87 seconds
TestRunner_ioctl-tester       PASS      9.17 seconds
TestRunner_mesh-tester        PASS      6.73 seconds
TestRunner_smp-tester         PASS      7.77 seconds
TestRunner_userchan-tester    PASS      5.57 seconds
IncrementalBuild              PASS      33.06 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:52:45: warning: array of flexible structures
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:52:45: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============7161552340219688282==--

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664AFC6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 14:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjCWOdJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 10:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjCWOdI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 10:33:08 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05CC55AB
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 07:33:07 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z1so761434iot.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 07:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679581987;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8bjAj75hpSblS1LTQ2B4pbmyZgJvqxmNgy+cAKKltMM=;
        b=J6b13LVxebkmgI3Pf5M6lye1WuBPE7zgrh6LRXSkVGmpkZ517bGmA2pqPlmedrAFqF
         +1WuA3s2ZbeWEgnD/5g5QUeh2ejdiWj3zF7ObaD+4JUAYxiTdAH72wOvcJf4i/5GwwY/
         RGVI+03vKqlBTSDjRPShjAvzTS6QCad2fdBoMNjp/yXhBjlI4PYvuDSY4VKDd/2V06CF
         rj3wXCTlCM5Is5chlOaAWiyUamMWxbcCFwD6dLNOZcuSMxgnYxhc6hsEtiKLz4J5siQP
         u4Vhkzg36Uzghf/+u/shc3m1Xl6oq0+Jza28hi8rTMmAMj006aQZExul17CmPFj97dR6
         0fPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679581987;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8bjAj75hpSblS1LTQ2B4pbmyZgJvqxmNgy+cAKKltMM=;
        b=igFzenryDHhrFfmilw9uXZR426jz1gS6TE/lLrnNG0hobNZDDA0/P+Pxe2F6P3Hppp
         POqyMiwhm6av02rRFJ6ADpcTB7204JO662prYGAYnLxbj+Y2GDI3k610WH+3h3vQf6CR
         kgGWoYr0NwpKAUfEeKTyHmPqV7ZaOAT7cmYw91DVGnlaJmfb/pucMSES2Ny7rDUSP+Z0
         l2TKbzp57MEQKM5vN1DAO9K6VKPwMOrT48vfcyJDJqxvGRn1JeOpXaoWBYM/14qf/tm0
         DqMOrTVHqjq1nx6oak2sulbT4P0IU0yAj47HadiPCN0qEej1aHC5/IBJr2DyiQ3/CujM
         41bg==
X-Gm-Message-State: AO0yUKWtd5KCkdzAebwQzU+pvRpRkiCCTq/7BBbm+iflB+r/ac8xBd4Y
        rJ3pf8KhLnOIbD/nRHYFOyDH3gi4SeM=
X-Google-Smtp-Source: AK7set+AxgatjSDXkCYKVQN2E6FuxlkZdf4gseUqtigAwse6nDMx5yoNVgU6BtrGzco9sMQMyIqPRw==
X-Received: by 2002:a5e:8716:0:b0:755:7b0c:604a with SMTP id y22-20020a5e8716000000b007557b0c604amr6600104ioj.2.1679581987193;
        Thu, 23 Mar 2023 07:33:07 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.93.45])
        by smtp.gmail.com with ESMTPSA id x11-20020a056638248b00b0040637924a30sm5461149jat.31.2023.03.23.07.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 07:33:07 -0700 (PDT)
Message-ID: <641c6323.050a0220.fd30f.b3be@mx.google.com>
Date:   Thu, 23 Mar 2023 07:33:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6477087676651878527=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, raul.cheleguini@gmail.com
Subject: RE: Bluetooth: Add new quirk for broken set random RPA timeout for ATS2851
In-Reply-To: <20230323134539.3957410-1-raul.cheleguini@gmail.com>
References: <20230323134539.3957410-1-raul.cheleguini@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6477087676651878527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=733185

---Test result---

Test Summary:
CheckPatch                    FAIL      1.31 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      32.12 seconds
CheckAllWarning               PASS      34.94 seconds
CheckSparse                   PASS      39.77 seconds
CheckSmatch                   PASS      109.84 seconds
BuildKernel32                 PASS      31.07 seconds
TestRunnerSetup               PASS      443.74 seconds
TestRunner_l2cap-tester       PASS      15.87 seconds
TestRunner_iso-tester         PASS      15.82 seconds
TestRunner_bnep-tester        PASS      5.10 seconds
TestRunner_mgmt-tester        PASS      102.94 seconds
TestRunner_rfcomm-tester      PASS      8.09 seconds
TestRunner_sco-tester         PASS      7.47 seconds
TestRunner_ioctl-tester       PASS      8.78 seconds
TestRunner_mesh-tester        PASS      6.44 seconds
TestRunner_smp-tester         PASS      7.42 seconds
TestRunner_userchan-tester    PASS      5.30 seconds
IncrementalBuild              PASS      29.35 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: Add new quirk for broken set random RPA timeout for ATS2851
WARNING: quoted string split across lines
#152: FILE: net/bluetooth/hci_sync.c:4534:
 			 "HCI Enhanced Setup Synchronous Connection command is "
+			 "advertised, but not supported."),

total: 0 errors, 1 warnings, 0 checks, 39 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13185652.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============6477087676651878527==--

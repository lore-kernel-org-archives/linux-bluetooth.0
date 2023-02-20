Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27C7C6379F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Feb 2023 20:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjBTUdu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Feb 2023 15:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjBTUdt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Feb 2023 15:33:49 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F8ACA16
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Feb 2023 12:33:48 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id f2so2667369qtv.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Feb 2023 12:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6c7C5mCZbEP/ehZ4LwVZbTy/3Z+L/2pav9M2SvXRWrs=;
        b=q1I6vFPwd21ner767dvumsV82PskQfyyXaSblVHk85TCNR/qRK0jWXob6+cpOk0Gpq
         OMgrkq7uuqzt10CApG2TfLPkPyAHZieXZaJS4O6onJY/0pj01tDnUwG8w3dV0bj6BKoE
         6wEHBQ094nC2oX4lcUOrL+YEPcGHKOMKpfuP9u2iCNkZL/mu+c+Fmhk7WAqJRPbX2l/p
         U651KH7UVgHRFvBzdygNAZNWaWxIVuxJ6MDgCX7PUWQSiaUDDgNBnyUxq1ameg8mlpxF
         Qrh02RhnSxwfAgEWz5RxLrsnQ54RNFBGWiOpvcECjs2FHjyiEEhkQ1JiY1kIPV8hKfcL
         Cqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6c7C5mCZbEP/ehZ4LwVZbTy/3Z+L/2pav9M2SvXRWrs=;
        b=nI5xO4nEYm1nbARhQm8OpneVgJlh/etZTE4IaSeM1r7eenmIQNjmWcLT7ZKfAuvDOP
         HqPjXkLl5h5n9M32DEGQBCYhfFoNayHJr4UUCNJIVIMIWQlSPsZQ+PG2SPuEtlZ9+GBj
         WsQTjn3yml9uo5RAox9MZqolAow9uTJYoMSmvDBvzYxVrjhRpl72LjpVlkO6xl96QgcR
         d1GkB4dqJc/mp9035RujjHi7R9uAZpsuTshXPR/EuPkPvUJ93l4EsFeL3RZlPx7alcvO
         A6b3c7MzOHV8mthtocrut4fpSTlaKce6z1woTgWFoyFoqbJY9/deODJWGb5CxsLrm/qj
         wLHw==
X-Gm-Message-State: AO0yUKXrGTpjB1F3K4Ihho3vEA51bLlSrgOMyL2i8AqmwMcuMAUecHC/
        B3K0QfYos/6e6qks3RYALyU9U27DUJs=
X-Google-Smtp-Source: AK7set8uFjCLkTmogWk44s81ifxkoBLeZPdEIrg6RvW14gbt9yYsFPe5Cp13sKvWubAkxMz+eJVk2w==
X-Received: by 2002:ac8:5715:0:b0:3bd:d57:deea with SMTP id 21-20020ac85715000000b003bd0d57deeamr25733183qtw.60.1676925227149;
        Mon, 20 Feb 2023 12:33:47 -0800 (PST)
Received: from [172.17.0.2] ([172.177.106.103])
        by smtp.gmail.com with ESMTPSA id u4-20020a372e04000000b00741680fbcbesm321718qkh.73.2023.02.20.12.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 12:33:47 -0800 (PST)
Message-ID: <63f3d92b.370a0220.520a5.14b2@mx.google.com>
Date:   Mon, 20 Feb 2023 12:33:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4617737908613138248=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: ISO: fix timestamped HCI ISO data packet parsing
In-Reply-To: <1fd2d4523c139deda93aab2c31f1508d79c32472.1676921889.git.pav@iki.fi>
References: <1fd2d4523c139deda93aab2c31f1508d79c32472.1676921889.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4617737908613138248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=723532

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
GitLint                       FAIL      0.56 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      31.92 seconds
CheckAllWarning               PASS      34.65 seconds
CheckSparse                   PASS      39.58 seconds
CheckSmatch                   PASS      107.42 seconds
BuildKernel32                 PASS      30.83 seconds
TestRunnerSetup               PASS      439.94 seconds
TestRunner_l2cap-tester       PASS      16.53 seconds
TestRunner_iso-tester         PASS      17.75 seconds
TestRunner_bnep-tester        PASS      5.75 seconds
TestRunner_mgmt-tester        PASS      112.93 seconds
TestRunner_rfcomm-tester      PASS      9.04 seconds
TestRunner_sco-tester         PASS      8.46 seconds
TestRunner_ioctl-tester       PASS      9.90 seconds
TestRunner_mesh-tester        PASS      7.18 seconds
TestRunner_smp-tester         PASS      8.27 seconds
TestRunner_userchan-tester    PASS      6.00 seconds
IncrementalBuild              PASS      29.22 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: ISO: fix timestamped HCI ISO data packet parsing

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
14: B2 Line has trailing whitespace: "    "


---
Regards,
Linux Bluetooth


--===============4617737908613138248==--

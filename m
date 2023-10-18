Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF0CCDB47E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Oct 2023 15:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjJRPpo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Oct 2023 11:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjJRPpm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Oct 2023 11:45:42 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD376120
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 08:45:39 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a7db1f864bso83137407b3.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 08:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697643939; x=1698248739; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DfZxS4DX4R+oekJ1KT+WypnOB/OrDuzPd4AgyKUNuxA=;
        b=Gihe+yFE9soidBkqyAuejN5WuBTvxXjPWRVuzbxAhLK9h/mXIP52CzAXurpg6lhKbZ
         VP70CNzXvIfifnatZFJfpY89zQxZIJ8ckaorNhZJjWTqcuYxoIgadqCdc4Wt27CX17FU
         fOwhbFZyz8rlofOWPNIB/voMpj2fVM0RuXpqmXLfq6WUk4JmYGFbQhylrwP2T5X3sbcK
         INmq6PqE0Y5UE57+VbhM3Jh9Zdtvh4bGg+7/gnKVe0+yAKdypE/L+5MAZ2jA24j8Z4PW
         BoCimRwuNFlphLhJstkTDfea6mQUGlVK+Sv3iGZJ2RSfOZcVXk4v5Ii4+5r9UiLSB3aZ
         ve/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697643939; x=1698248739;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DfZxS4DX4R+oekJ1KT+WypnOB/OrDuzPd4AgyKUNuxA=;
        b=loRvlmtf/DNninw+/XeT/HKW4nnU096F+Gr/00Zhq2dC1vECdKWCLQxbvnMOuGRuDI
         mCcSwlseGt5JDtfrAdnNWcmyuDlx+EabHGd131AHWY0wkgLmucMnYF9f2FezyirVtd27
         oRhVFljNEe+DQ/sgVlGCYtTe1B9P7nJVfS0uUV9FkTwg3ZCyIcp7Qb93Ju2XSJSSZwHz
         mt6Q2+EVjUYIi+a3JvTROuvlYBsAuM178+RRh/O/P+peBoU1cmVn0yprd8toyoPMNjTx
         KC2kOgTfRaMDK1ehS/IHzBz2AhXbdw/BMLUv+mWDGrqzfDjFNP2D+a31F7Ggpqok0rPV
         Iv9A==
X-Gm-Message-State: AOJu0YynXnD7AY4whDV4g5eV4DnfMfryM1eHEW37FL1yvCA3BTMVd+rQ
        Nl0p25iRAUvapxUwiKFR+Cg3u3J+mNHEeA==
X-Google-Smtp-Source: AGHT+IGbkmCKrnU9YKVNlyoFFUGiDj2NM2N3i3yLkAIwfRFwj9/RIPUoiCj+PJqudlLo3NOcRK1YtQ==
X-Received: by 2002:a81:6e45:0:b0:5a7:bb95:681c with SMTP id j66-20020a816e45000000b005a7bb95681cmr5795793ywc.36.1697643938922;
        Wed, 18 Oct 2023 08:45:38 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.20.101])
        by smtp.gmail.com with ESMTPSA id d29-20020a05620a205d00b0076cda7eab11sm38319qka.133.2023.10.18.08.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 08:45:38 -0700 (PDT)
Message-ID: <652ffda2.050a0220.15cb8.05b9@mx.google.com>
Date:   Wed, 18 Oct 2023 08:45:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5267511784842806717=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, marcel@ziswiler.com
Subject: RE: Bluetooth: hci_sync: Fix Opcode prints in bt_dev_dbg/err
In-Reply-To: <20231018144735.33085-1-marcel@ziswiler.com>
References: <20231018144735.33085-1-marcel@ziswiler.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5267511784842806717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=794369

---Test result---

Test Summary:
CheckPatch                    PASS      0.84 seconds
GitLint                       FAIL      0.66 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      46.41 seconds
CheckAllWarning               PASS      49.87 seconds
CheckSparse                   PASS      57.26 seconds
CheckSmatch                   PASS      151.64 seconds
BuildKernel32                 PASS      44.24 seconds
TestRunnerSetup               PASS      690.70 seconds
TestRunner_l2cap-tester       PASS      39.70 seconds
TestRunner_iso-tester         PASS      91.10 seconds
TestRunner_bnep-tester        PASS      14.13 seconds
TestRunner_mgmt-tester        PASS      282.73 seconds
TestRunner_rfcomm-tester      PASS      21.92 seconds
TestRunner_sco-tester         PASS      24.93 seconds
TestRunner_ioctl-tester       PASS      24.92 seconds
TestRunner_mesh-tester        PASS      18.06 seconds
TestRunner_smp-tester         PASS      19.46 seconds
TestRunner_userchan-tester    PASS      15.73 seconds
IncrementalBuild              PASS      42.57 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_sync: Fix Opcode prints in bt_dev_dbg/err

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
7: B3 Line contains hard tab characters (\t): "	Bluetooth: hci0: Opcode 0x c03 failed: -110"
11: B3 Line contains hard tab characters (\t): "	Bluetooth: hci0: Opcode 0x0c03 failed: -110"


---
Regards,
Linux Bluetooth


--===============5267511784842806717==--

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A8CC47089
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Dec 2022 02:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbiLFCek (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Dec 2022 21:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbiLFCeg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Dec 2022 21:34:36 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263AF1EAE5
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Dec 2022 18:34:33 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id g20so1759330iob.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Dec 2022 18:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vl96vL6m5AEqJNfzJ9JymqtNHrcyexFyxG6iLFazTaA=;
        b=SYaTWExIO1xx1XmNc4CCukt8i+5xXwcPAelCfWgKQlfZAhGTj1xXUn+5RofwkaoJlA
         +w5amk7iuAnnihvVABmIy66yGcWJp7n4iSmVbxWnyNLaafrfEq8GRmJZfde+hEk3lGGb
         gfZ1TVmhBRJ9zAgCh5MsNuNhjxdGJzLfx6z7xWpljFi4JOmgYTeA8SYj4dScawoNGwzG
         7kb0bNdQ4rGeQF3O6xYdUpltzQ45PxijVI4Xy0kqdMTquukpi+tGF0bRg1KkdQZ8zAAq
         +vjYcIaDUO9DS7LM9dccLJv64lIp67WV2sNqiIjPze7KU170iNT+DpddWzlAlzO8AkyU
         VzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vl96vL6m5AEqJNfzJ9JymqtNHrcyexFyxG6iLFazTaA=;
        b=3dMKq/GJAM+lVZdSs++tNDMF9oU5b+TIQbXMcU3RNZhlHQa9l/P8HwEwdz8/B2fNwT
         PpHKjkGtw/WEAM/N4ZRdsskYnKoU8mq+fOt1vAJ/VqoZEaHkOfFHBQtXjtTQ7xp5WfEz
         ypvv2ICw64BSzLABMfZkgBYFf5/uJbyhR6jdEGREkjV463ETUWuhgQpkBMWqDX9AHRRP
         DJ+qV4V1VXcvhaPrGXjy5yZcZ+U8RcGjT3EhdV7HQmCrAEx17xuGq59oPok1oM2VdI5O
         1dffaIkob3bsuVy/lHDTseHWFfHqUFOIv2BJcDwCsmONKUq5rTmY7wIqT/bgCYzp+Pq4
         T8PA==
X-Gm-Message-State: ANoB5pn/sD08C5c06PP9Leswfoj2a5dI5jLrQv2l7nfoA5c8SJvu+KA3
        W+QQAAs7m7MzG4/0P5IGH4Le+yTbM4Q=
X-Google-Smtp-Source: AA0mqf6ZjMOD1NuNAXjFmqAsts9rFhru58NIaptqpa22FppfhiL3s9kg/BoBfn6CVYS0vZZAVlBxpg==
X-Received: by 2002:a5d:9911:0:b0:6db:1f90:7e62 with SMTP id x17-20020a5d9911000000b006db1f907e62mr30064359iol.107.1670294072353;
        Mon, 05 Dec 2022 18:34:32 -0800 (PST)
Received: from [172.17.0.2] ([168.61.171.55])
        by smtp.gmail.com with ESMTPSA id m12-20020a924a0c000000b00300efcac7b7sm5699296ilf.7.2022.12.05.18.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 18:34:32 -0800 (PST)
Message-ID: <638eaa38.920a0220.e3b93.b357@mx.google.com>
Date:   Mon, 05 Dec 2022 18:34:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2919928006925603072=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_conn: Fix crash on hci_create_cis_sync
In-Reply-To: <20221206012323.3684462-1-luiz.dentz@gmail.com>
References: <20221206012323.3684462-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2919928006925603072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=702026

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      34.15 seconds
BuildKernel32                 PASS      30.43 seconds
TestRunnerSetup               PASS      426.68 seconds
TestRunner_l2cap-tester       PASS      16.16 seconds
TestRunner_iso-tester         PASS      16.19 seconds
TestRunner_bnep-tester        PASS      5.58 seconds
TestRunner_mgmt-tester        PASS      108.27 seconds
TestRunner_rfcomm-tester      PASS      9.54 seconds
TestRunner_sco-tester         PASS      8.95 seconds
TestRunner_ioctl-tester       PASS      10.44 seconds
TestRunner_mesh-tester        PASS      7.01 seconds
TestRunner_smp-tester         PASS      8.73 seconds
TestRunner_userchan-tester    PASS      5.93 seconds
IncrementalBuild              PASS      31.51 seconds



---
Regards,
Linux Bluetooth


--===============2919928006925603072==--

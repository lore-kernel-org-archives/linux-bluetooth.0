Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A502C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 May 2022 23:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359345AbiELXEe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 May 2022 19:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359344AbiELXEd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 May 2022 19:04:33 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B5EAFAD5
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 May 2022 16:04:32 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id y3so5625815qtn.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 May 2022 16:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=sBZfVvDpvhXwc09ij3AjgQSPzLvrRO5dHoiiu9cJ0KM=;
        b=qSsVxFCWfwk7B7F+y+207/7L58m9zZwuPtLdz+dmIqaWOuzlP0Mz8o5GNGsIXSL7x6
         TIZJIqABeONz9jSZQ2C3zoxSlfJqvQinwdOKyE6MDT3RJLYlkCdsJP5cPgMNlU6o3Jvv
         T1RLINUTCKw7xs6Yl+tRKRahLSlnLbgq5xBQYW6hb8HHV4gw0CLNKrVntrpWIcpemZk2
         Jmh3fnx1Jt//O9twxZU4lk5mUd4IvPUdPyTcvo7+Nny/lQvxTt1DKxQ1NK13HUeeWv5r
         boY0jtxgLGmCmXIBO52mEk1bTlxrWv0N9LIAjvXzPqvdV8+egONx5XKWa6NhCDp+tdxo
         fVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=sBZfVvDpvhXwc09ij3AjgQSPzLvrRO5dHoiiu9cJ0KM=;
        b=s/ORbYvpuPnCYDzDYZgTrZzqC52+xsAfwt4Hkp+Z+dPZ2w2WvMMxfisQWL4qnaRn8+
         uvSFZ68Wl4dev/2XaXlMIAu4wUuo6s6gwjBHo5Y5PNrnCbnHrc8MkDT9kQuKfAlVDA5s
         aHIPCtQdMzOts9Fc++o1Zy0z6L5CkruruxxF91zReEjspFgFU8bVfHi5bOB8hKBJy9bx
         Ej9so86BHJy2xCzXwzLDm/D8H7mwc/zZFYrzC4UqHOH3zYBNiZvcmRFO1GZwavmyDajn
         bBswGM0GUvfFjTNAkmkoLe5VJwlM/LgB5MYxtkRTypMEdEcL+5OcpHn9Hebx73kdV9Wc
         4pOw==
X-Gm-Message-State: AOAM530L8/dmPP2/PTeoIebqDq8lgJEzZck3XguyfPaKZhq5+Iqj0Dab
        tnr7Rbz3G6s5QWrn1OUz7UGmVl0KGWpPVQ==
X-Google-Smtp-Source: ABdhPJz3IWYYR0mT/jzoEIPblfNDjW8iPj2g2+akGhV7CJdgMtwp6+YTrXUy4sABd27nyVVeqYnEUA==
X-Received: by 2002:a05:622a:608c:b0:2f1:e3fa:b603 with SMTP id hf12-20020a05622a608c00b002f1e3fab603mr2180696qtb.48.1652396671514;
        Thu, 12 May 2022 16:04:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.250.98])
        by smtp.gmail.com with ESMTPSA id f6-20020a05622a114600b002f39b99f69esm488734qty.56.2022.05.12.16.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 16:04:31 -0700 (PDT)
Message-ID: <627d927f.1c69fb81.e896e.3477@mx.google.com>
Date:   Thu, 12 May 2022 16:04:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3243755493222761670=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/2] Bluetooth: MGMT: Add conditions for setting HCI_CONN_FLAG_REMOTE_WAKEUP
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220512223134.1021074-1-luiz.dentz@gmail.com>
References: <20220512223134.1021074-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3243755493222761670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=641172

---Test result---

Test Summary:
CheckPatch                    PASS      3.22 seconds
GitLint                       FAIL      1.88 seconds
SubjectPrefix                 PASS      1.70 seconds
BuildKernel                   PASS      30.90 seconds
BuildKernel32                 PASS      27.89 seconds
Incremental Build with patchesPASS      44.22 seconds
TestRunner: Setup             PASS      469.25 seconds
TestRunner: l2cap-tester      PASS      17.40 seconds
TestRunner: bnep-tester       PASS      6.07 seconds
TestRunner: mgmt-tester       PASS      101.55 seconds
TestRunner: rfcomm-tester     PASS      9.66 seconds
TestRunner: sco-tester        PASS      9.48 seconds
TestRunner: smp-tester        PASS      9.49 seconds
TestRunner: userchan-tester   PASS      6.37 seconds

Details
##############################
Test: GitLint - FAIL - 1.88 seconds
Run gitlint with rule in .gitlint
[v2,2/2] Bluetooth: hci_sync: Fix attempting to suspend with unfiltered passive scan
1: T1 Title exceeds max length (84>80): "[v2,2/2] Bluetooth: hci_sync: Fix attempting to suspend with unfiltered passive scan"




---
Regards,
Linux Bluetooth


--===============3243755493222761670==--

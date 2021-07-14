Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C019C12002
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jul 2021 19:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D970613AB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jul 2021 19:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhGNTEl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Jul 2021 15:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhGNTEk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Jul 2021 15:04:40 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57E1C06175F
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 12:01:48 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id g19so4864174ybe.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 12:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0kwiaIvEcwwC8RQlBLoKf1XRrOC1LEP4AgmjcSBFpr8=;
        b=B6csQKHxsKmlTE1P71iUI+Ime2RhmLM11rEhov/ZadXG0r8UhTHWsCLipKrA4z/Yz2
         hb0VzDYnkbMmi82TWQ2IghDjg+r+1dFszOC0qbRc3fiFEzSeiZb6duHGp+GSEhuyX3Et
         ib/qklEWALIWcfu3b/Na4qKRrx3gu4e9bk9WgMqWPFKQYix3wrdc2nrhfRMgFCEkasy3
         e7xefTn8uRKDzTfnGaix+pputXCSfJx+KMkpa70Lu++2S7dWLwrFr9Gk2bHr+T5+u4QE
         LCrxlpJUw0+VGk1xycj+5ePHP4b3s0wVyNWzbiZcoG2NE7HxfgiXB6lPNYOGCJa4YtHv
         OieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0kwiaIvEcwwC8RQlBLoKf1XRrOC1LEP4AgmjcSBFpr8=;
        b=SO9r/zUoRIaf42moHHNr3IagPa++2Z/jppqw1LG6X2s5m+aitagAODq8+IWbwxQs0W
         8sYoLDEdPBEUjm1qZPVt5O2n4O7+fjciHfeGZCoBLR58ktp5Dkc3ZZE/mK3T5VJtbQ/5
         60Am2TWRn7V41z+rJmaeCkusDtIs4bLlMtKVPEqrtHMoWbF8/ur74b9U16r9z4ov/xCw
         J1olPy/GWdur0GUU4nEPiokO17n2Av1BLwsNBaMr5hydrVNgRpflIR2FNvwY96hHwxey
         7ZlnDDHzmmLGJf5YlHX0aU5Po1csnRShagX2/Ew5PMRmxutJNDdAZ+Fei0j2KtXlbMVD
         rCwQ==
X-Gm-Message-State: AOAM532gE8N8D7HYjFMVw5xPoWNcK+VVpF0EoiLlfkNtc2R23pr4OvaP
        95Cdigq8K3/00hqoO/E1mtDVZbDqKH0rnHj995zKKzehOqM=
X-Google-Smtp-Source: ABdhPJweG98SGKbGwLF2llVqYztJkKiNfmQVjUZrEvl0uv5i6WosyWGGukE/S/WvyTKu/8kM6/EbxmQnvt0GXVbTjSE=
X-Received: by 2002:a25:fc1c:: with SMTP id v28mr15861799ybd.408.1626289307707;
 Wed, 14 Jul 2021 12:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210629004952.569862-1-luiz.dentz@gmail.com> <60da7ef1.1c69fb81.2485b.2da7@mx.google.com>
In-Reply-To: <60da7ef1.1c69fb81.2485b.2da7@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 14 Jul 2021 12:01:37 -0700
Message-ID: <CABBYNZKiw6QLO-gk66+1BsjSaAK_pgvFL+jXWZq1+0THfAFXpg@mail.gmail.com>
Subject: Re: Bluetooth: HCI: Add proper tracking for enable status of adv instances
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Mon, Jun 28, 2021 at 7:01 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=508287
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.98 seconds
> GitLint                       PASS      0.13 seconds
> BuildKernel                   PASS      514.51 seconds
> TestRunner: Setup             PASS      338.20 seconds
> TestRunner: l2cap-tester      PASS      2.61 seconds
> TestRunner: bnep-tester       PASS      1.94 seconds
> TestRunner: mgmt-tester       FAIL      29.42 seconds
> TestRunner: rfcomm-tester     PASS      2.13 seconds
> TestRunner: sco-tester        PASS      2.05 seconds
> TestRunner: smp-tester        PASS      2.16 seconds
> TestRunner: userchan-tester   PASS      1.99 seconds
>
> Details
> ##############################
> Test: CheckPatch - PASS - 0.98 seconds
> Run checkpatch.pl script with rule in .checkpatch.conf
>
>
> ##############################
> Test: GitLint - PASS - 0.13 seconds
> Run gitlint with rule in .gitlint
>
>
> ##############################
> Test: BuildKernel - PASS - 514.51 seconds
> Build Kernel with minimal configuration supports Bluetooth
>
>
> ##############################
> Test: TestRunner: Setup - PASS - 338.20 seconds
> Setup environment for running Test Runner
>
>
> ##############################
> Test: TestRunner: l2cap-tester - PASS - 2.61 seconds
> Run test-runner with l2cap-tester
> Total: 40, Passed: 40 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: bnep-tester - PASS - 1.94 seconds
> Run test-runner with bnep-tester
> Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: mgmt-tester - FAIL - 29.42 seconds
> Run test-runner with mgmt-tester
> Total: 446, Passed: 436 (97.8%), Failed: 5, Not Run: 5
>
> Failed Test Cases
> Read Ext Controller Info 1                           Failed       0.016 seconds
> Read Ext Controller Info 2                           Failed       0.015 seconds
> Read Ext Controller Info 3                           Failed       0.013 seconds
> Read Ext Controller Info 4                           Failed       0.013 seconds
> Read Ext Controller Info 5                           Failed       0.015 seconds
>
> ##############################
> Test: TestRunner: rfcomm-tester - PASS - 2.13 seconds
> Run test-runner with rfcomm-tester
> Total: 9, Passed: 9 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: sco-tester - PASS - 2.05 seconds
> Run test-runner with sco-tester
> Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: smp-tester - PASS - 2.16 seconds
> Run test-runner with smp-tester
> Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: userchan-tester - PASS - 1.99 seconds
> Run test-runner with userchan-tester
> Total: 3, Passed: 3 (100.0%), Failed: 0, Not Run: 0
>
>
>
> ---
> Regards,
> Linux Bluetooth


The cmd_sync set depends on this one, so if you can prioritize this
one, or I can include it with the cmd-sync set but I rather have it
separately since as it fixes tracking of advertising instance
programmed in the controller.


-- 
Luiz Augusto von Dentz

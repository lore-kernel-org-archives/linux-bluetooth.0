Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE594C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 00:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 937AF60F58
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 00:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbhG1AaX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jul 2021 20:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbhG1AaW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jul 2021 20:30:22 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAB4C061757
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 17:30:21 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id s19so1013029ybc.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jul 2021 17:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=klHoIcJTECsLMy7FJlqbf9OUIA/vIKSqTpKR0DoOYGU=;
        b=aUlzGQPHyOz1c1YeMrAz0eiEBehqcPyar0InNp+eCw+bTIoeQWUidTlJDml3jly9EC
         dlOlkiDPATDAjk8V35p8C5PhijVZqGjWNbENqJ7TXLVYMlI3A0kwvCsq0uigM0QxOxTp
         TZUU/O3Z80vo8CqsiGnuy1LVQqDV7MetM2TNh/Ocz1uzDwWYJK3qvHiVGjfrjCzDos4+
         zjh2eD/1tdlunw4BAFVVRB2Ev9rwtfA0DFgzjsJ3sQSFgZOKYXujcZ+5ZpBjbSvCWjx8
         VBLoUwfwwa77M5ntmK5MQTJmsAcWFlOrI4K/ZBWMLRVhagy6t/zv53pa3m2m1TK8aGOs
         O4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=klHoIcJTECsLMy7FJlqbf9OUIA/vIKSqTpKR0DoOYGU=;
        b=lvxn1VT+q11NaYJ51CnPuzuGmW7o0A2MTzl87USpNkWqVu4HnRbmU2Lwcydv279by8
         Fo2d3JQ4GgxKcr9N3BmBuxTEU474nw/PYluFO+fg3NY6VKpUCymBwtF6bfmskVZHqD5M
         LIGjRkkuS9/IoWXepk+gQv1nWuBApUaYgf8ucmxDoOgGP4LU7FbFQ6UWl55iVTunVshu
         4V8T39TkUmcwsO6kZxcoT9VtGmGE8fiMWeavkpM9V5qBoeYCl8JlsmBvGlBdC8G2iPZX
         Wv8FPyZGFfuQ8PHjyLmdrk2cbGmNDLaWJay5LvhwLijkffVIbGAvy7vhBSjE8EubBAnm
         YOMA==
X-Gm-Message-State: AOAM530kcASNBOTlzpLSyneWuhxMiGH8ssC0xdugBgzvaWAbVOoVbBz8
        +HGm01ayFdFmrVRpCXTPZAdmdQQ6FuM170fxuItoB7mk
X-Google-Smtp-Source: ABdhPJwDmHT1ttqDrYRaA7Dngf99SPze0GW0agzcUM2NHaRl311VaCQfgqwwu88cWw1Kh/HLyypFB6z2Svna1MKx3x4=
X-Received: by 2002:a25:9b03:: with SMTP id y3mr31993387ybn.264.1627432219923;
 Tue, 27 Jul 2021 17:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210726233654.1988081-1-luiz.dentz@gmail.com> <60ff7cc9.1c69fb81.c0e8c.7681@mx.google.com>
In-Reply-To: <60ff7cc9.1c69fb81.c0e8c.7681@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 27 Jul 2021 17:30:09 -0700
Message-ID: <CABBYNZKe-Mp8iw6kjBWhiXZfyzdsUGbaitdVz=WfFaqwzxczpw@mail.gmail.com>
Subject: Re: [v2] Bluetooth: defer cleanup of resources in hci_unregister_dev()
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tetsuo,

On Mon, Jul 26, 2021 at 8:26 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=521583
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      1.14 seconds
> GitLint                       FAIL      0.12 seconds
> BuildKernel                   PASS      615.44 seconds
> TestRunner: Setup             PASS      399.97 seconds
> TestRunner: l2cap-tester      PASS      3.01 seconds
> TestRunner: bnep-tester       PASS      2.18 seconds
> TestRunner: mgmt-tester       PASS      32.18 seconds
> TestRunner: rfcomm-tester     PASS      2.42 seconds
> TestRunner: sco-tester        PASS      2.32 seconds
> TestRunner: smp-tester        FAIL      2.32 seconds
> TestRunner: userchan-tester   PASS      2.25 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL - 1.14 seconds
> Run checkpatch.pl script with rule in .checkpatch.conf
> Bluetooth: defer cleanup of resources in hci_unregister_dev()
> WARNING: Unknown commit id 'b40df5743ee8aed8', maybe rebased or not pulled?
> #11:
> Commit b40df5743ee8aed8 ("[PATCH] bluetooth: fix socket locking in
>
> WARNING: Unknown commit id '4ce61d1c7a8ef4c1', maybe rebased or not pulled?
> #15:
> Then, commit 4ce61d1c7a8ef4c1 ("[BLUETOOTH]: Fix locking in
>
> WARNING: Unknown commit id '4b5dd696f81b210c', maybe rebased or not pulled?
> #20:
> Then, commit 4b5dd696f81b210c ("Bluetooth: Remove local_bh_disable() from
>
> WARNING: Unknown commit id 'e305509e678b3a4a', maybe rebased or not pulled?
> #23:
> Then, commit e305509e678b3a4a ("Bluetooth: use correct lock to prevent UAF
>
> total: 0 errors, 4 warnings, 0 checks, 94 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> "[PATCH] Bluetooth: defer cleanup of resources in hci_unregister_dev()" has style problems, please review.
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
> ##############################
> Test: GitLint - FAIL - 0.12 seconds
> Run gitlint with rule in .gitlint
> Bluetooth: defer cleanup of resources in hci_unregister_dev()
> 41: B1 Line exceeds max length (85>80): "Fixes: e305509e678b3a4a ("Bluetooth: use correct lock to prevent UAF of hdev object")"
>
>
> ##############################
> Test: BuildKernel - PASS - 615.44 seconds
> Build Kernel with minimal configuration supports Bluetooth
>
>
> ##############################
> Test: TestRunner: Setup - PASS - 399.97 seconds
> Setup environment for running Test Runner
>
>
> ##############################
> Test: TestRunner: l2cap-tester - PASS - 3.01 seconds
> Run test-runner with l2cap-tester
> Total: 40, Passed: 40 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: bnep-tester - PASS - 2.18 seconds
> Run test-runner with bnep-tester
> Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: mgmt-tester - PASS - 32.18 seconds
> Run test-runner with mgmt-tester
> Total: 448, Passed: 445 (99.3%), Failed: 0, Not Run: 3
>
> ##############################
> Test: TestRunner: rfcomm-tester - PASS - 2.42 seconds
> Run test-runner with rfcomm-tester
> Total: 9, Passed: 9 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: sco-tester - PASS - 2.32 seconds
> Run test-runner with sco-tester
> Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: smp-tester - FAIL - 2.32 seconds
> Run test-runner with smp-tester
> Total: 8, Passed: 7 (87.5%), Failed: 1, Not Run: 0
>
> Failed Test Cases
> SMP Client - SC Request 2                            Failed       0.022 seconds
>
> ##############################
> Test: TestRunner: userchan-tester - PASS - 2.25 seconds
> Run test-runner with userchan-tester
> Total: 3, Passed: 3 (100.0%), Failed: 0, Not Run: 0
>
>
>
> ---
> Regards,
> Linux Bluetooth

Pushed, thanks.


-- 
Luiz Augusto von Dentz

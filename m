Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11B2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 01:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFEE561184
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 01:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhIOBCi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Sep 2021 21:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhIOBCh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Sep 2021 21:02:37 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948EDC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Sep 2021 18:01:19 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id j31so597068uad.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Sep 2021 18:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=cPi8e7LvtkQklhB9sjyO1jTceWSNlY7GoGT965tIY/Q=;
        b=Nf54MOL/fnC3CuOMPHOEhjKPN4fFDIdj1iwS1/atlWNV5a6HxBBOZyGsKVvEahaXSI
         wN2kmujOn/tvSBRl15sNUEs76ISqabA/AUCoE+nErwjsTABACqM4yyQS4F97GBPAyCrb
         Qn3cEMEBkD5L6ofVwW9rwuTcpNQ0R5Cx/BlB1Oi5nRaPg3Gdg8ova2zzgIUkBkYPm7GF
         TFSkOmlpDg2pcslqQD40v1xDBCRY7Ly/iNpCglwAQS7l+1WLal5i46eDTvmf9gq6t2T2
         GUT9cW9xRvStxuyFp0kpvW9IuhDgR/1/xOUqY5bUXg6gdWhGJhQortCFW90vqLCWQb/x
         nHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=cPi8e7LvtkQklhB9sjyO1jTceWSNlY7GoGT965tIY/Q=;
        b=gvhNLyFS0Kw0p8DzCAnVkrSXqmQV9BTq+i8CEeLUksXTHu5898VZK/wRsI+EUm3qMI
         UnIrhlYw2rO17ZTspIS0ItJ7CfGXi9FhM23LFi90WMKz8HvfksAlYPRM0KBijAFJ2/68
         PB0wXH/CphPT9+ESCvbixoXxN0f5dQ9me/0Iwj2scBvVWa4suII3Pf/WYs39wizAzyLO
         dQWHikukUQWFVmSN+A3LNbFP+NQt4d/f9Y0ZgzUa+aVg4KJQYuebpzbAY03R1pYeeGlo
         RXGQJgXaSE7+vA7d5MWZ/DyZyyJAa4k8jGkvRoMofw5xjFgIWvPxrL1mj253DslXQYOQ
         A7gg==
X-Gm-Message-State: AOAM5314iC2k7qWB6j6iQj4PwkWL5P642atMBHGFlZ7jEPK57+R4Hf0s
        mrJr2UpTi0wXC+VKc21Qr5+dAxEhOPMguhFLPtHykoh1
X-Google-Smtp-Source: ABdhPJyRpWJMQoJuqpG8NdiKF1rS/leQlzLmV0dBcYnipDJj3EHguwhDbNIEeZJl/TjOodUbJC4gQPAOhlBz0Izk088=
X-Received: by 2002:ab0:6616:: with SMTP id r22mr6690636uam.129.1631667678539;
 Tue, 14 Sep 2021 18:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210914220403.3848971-1-luiz.dentz@gmail.com> <614129dd.1c69fb81.22f2b.5c81@mx.google.com>
In-Reply-To: <614129dd.1c69fb81.22f2b.5c81@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 14 Sep 2021 18:01:07 -0700
Message-ID: <CABBYNZL-Og4aOQYH5px-KU_uf=4=tTFV4AiPL9aXGNggzQ2LTg@mail.gmail.com>
Subject: Re: Bluetooth: hci_sock: Replace use of memcpy_from_msg with bt_skb_sendmsg
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Tue, Sep 14, 2021 at 4:01 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=546957
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.51 seconds
> GitLint                       PASS      0.11 seconds
> BuildKernel                   PASS      524.96 seconds
> TestRunner: Setup             PASS      348.84 seconds
> TestRunner: l2cap-tester      PASS      2.57 seconds
> TestRunner: bnep-tester       PASS      1.88 seconds
> TestRunner: mgmt-tester       FAIL      32.39 seconds
> TestRunner: rfcomm-tester     PASS      2.56 seconds
> TestRunner: sco-tester        PASS      2.01 seconds
> TestRunner: smp-tester        PASS      2.13 seconds
> TestRunner: userchan-tester   PASS      1.93 seconds
>
> Details
> ##############################
> Test: CheckPatch - PASS - 0.51 seconds
> Run checkpatch.pl script with rule in .checkpatch.conf
>
>
> ##############################
> Test: GitLint - PASS - 0.11 seconds
> Run gitlint with rule in .gitlint
>
>
> ##############################
> Test: BuildKernel - PASS - 524.96 seconds
> Build Kernel with minimal configuration supports Bluetooth
>
>
> ##############################
> Test: TestRunner: Setup - PASS - 348.84 seconds
> Setup environment for running Test Runner
>
>
> ##############################
> Test: TestRunner: l2cap-tester - PASS - 2.57 seconds
> Run test-runner with l2cap-tester
> Total: 40, Passed: 40 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: bnep-tester - PASS - 1.88 seconds
> Run test-runner with bnep-tester
> Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: mgmt-tester - FAIL - 32.39 seconds
> Run test-runner with mgmt-tester
> Total: 452, Passed: 451 (99.8%), Failed: 1, Not Run: 0
>
> Failed Test Cases
> Read Exp Feature - Success                           Failed       0.014 seconds
>
> ##############################
> Test: TestRunner: rfcomm-tester - PASS - 2.56 seconds
> Run test-runner with rfcomm-tester
> Total: 9, Passed: 9 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: sco-tester - PASS - 2.01 seconds
> Run test-runner with sco-tester
> Total: 11, Passed: 11 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: smp-tester - PASS - 2.13 seconds
> Run test-runner with smp-tester
> Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: userchan-tester - PASS - 1.93 seconds
> Run test-runner with userchan-tester
> Total: 3, Passed: 3 (100.0%), Failed: 0, Not Run: 0
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz

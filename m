Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE23C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Apr 2022 18:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352297AbiDLS3M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Apr 2022 14:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238453AbiDLS3L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Apr 2022 14:29:11 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E5A50E18
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Apr 2022 11:26:52 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-e2fa360f6dso2078362fac.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Apr 2022 11:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KFmh9BeuJWA1g4KwGEKkJbdKg3eQVCs91A2lksvjbUs=;
        b=czNpF6whzdWMbfOzzNJtnrpzFvRBiCFD6qX3kf4JuBGOzwjzlYKeE3aJXsprJVBHcr
         ZJprxA85ZVr+eCyWZ+7unNMCcTxKxPP68tveubu3pBBmbvzFVhC4pFpBDfetC+bWivPl
         aIdPL6u6wIOvKtscGdqXWwwKi9NJW+BTVIT5e8pLHYYEZnbL7UNACN5D+Bh9aps/njym
         Q8g+hq3Bmetyq/PZyh5/S89BTjg+jEfx9s5I8Nj0eNRJsNWtYt7wA309GDR8QCPvDdMN
         LlmdqGK8hieI70mZAfvgHzX67dkDMVWTMHUCvcstGJCXDqqVWKST3V8yvhXzm7w+HozW
         Iq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KFmh9BeuJWA1g4KwGEKkJbdKg3eQVCs91A2lksvjbUs=;
        b=thCzO5yNy3HVRLZTZkcSmyll4WXcuKfqKK9lUYEXGpMdbfso7CTFkau8neKorlQlJ+
         3kUgGhBdKL64hE1Xtyz7+cHaKbT1d1/+q8qQnSGf9R+VNCQG887KxTGOk8Fm8NYfV7eu
         vUJLgM7GS1nUCNO5fh/qgkUdwAImWejWYnyMHlu6rMBh1fuILMXxZ4w6bFk6uJuZw4QI
         Xn+h01sgup2XfuNWwm7MCYqJPPxJ9X8AuE5Cyh23CDXyUdoNpk9TvTSylntj7QvmdYRY
         zg+a+WiCbUBsclC5NHipVLekFicbD5yHErlPjAtfqWtN8NrlKIU1+WSXhiHmNP1Ob6+f
         ueCA==
X-Gm-Message-State: AOAM530Y8Bvp6zEtCp8lCfh+CKjwYiUWMtK9c3ZfcKM2n6isAZ6Ss/pB
        9+Pu7Exm/6mnNuuz417mTY+424mP/Ho7XsU2CfeC27dDh9Xlpw==
X-Google-Smtp-Source: ABdhPJzYXe7wrFCECK5Utsvga8nlg+RpPUhUk5m48a87tBrt1sDUE114Sz6Qt50uNAFyS957v566HvsgKuj9vg3gf4w=
X-Received: by 2002:a05:6870:f21a:b0:dd:9bec:caf8 with SMTP id
 t26-20020a056870f21a00b000dd9beccaf8mr2726538oao.78.1649788011640; Tue, 12
 Apr 2022 11:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220412120945.28862-1-vasyl.vavrychuk@opensynergy.com> <6255804f.1c69fb81.50dda.e99b@mx.google.com>
In-Reply-To: <6255804f.1c69fb81.50dda.e99b@mx.google.com>
From:   Vasyl Vavrychuk <vvavrychuk@gmail.com>
Date:   Tue, 12 Apr 2022 21:26:40 +0300
Message-ID: <CAGj4m+413TdHZFTpFZS3yV60+uakMw-Y9BkCg4khTWgQpA+sCg@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: core: Allow bind HCI socket user channel when
 HCI is UP.
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

CI reported userchan-tester failure since it is expected old
behaviour: that bind to user channel should fail when device is
powered up.

I can update https://github.com/bluez/bluez/blob/master/tools/userchan-test=
er.c
by removing test cases:
* User channel open - Failed
* User channel open - Power Toggle Success

On Tue, Apr 12, 2022 at 4:36 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D631=
489
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      1.67 seconds
> GitLint                       FAIL      1.02 seconds
> SubjectPrefix                 PASS      0.82 seconds
> BuildKernel                   PASS      30.11 seconds
> BuildKernel32                 PASS      27.80 seconds
> Incremental Build with patchesPASS      39.08 seconds
> TestRunner: Setup             PASS      471.62 seconds
> TestRunner: l2cap-tester      PASS      16.22 seconds
> TestRunner: bnep-tester       PASS      6.26 seconds
> TestRunner: mgmt-tester       PASS      106.06 seconds
> TestRunner: rfcomm-tester     PASS      8.22 seconds
> TestRunner: sco-tester        PASS      7.99 seconds
> TestRunner: smp-tester        PASS      7.98 seconds
> TestRunner: userchan-tester   FAIL      6.66 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL - 1.67 seconds
> Run checkpatch.pl script with rule in .checkpatch.conf
> [RFC] Bluetooth: core: Allow bind HCI socket user channel when HCI is UP.=
\WARNING:FROM_SIGN_OFF_MISMATCH: From:/Signed-off-by: email address mismatc=
h: 'From: Vasyl Vavrychuk <vvavrychuk@gmail.com>' !=3D 'Signed-off-by: Vasy=
l Vavrychuk <vasyl.vavrychuk@opensynergy.com>'
>
> total: 0 errors, 1 warnings, 0 checks, 10 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inpl=
ace.
>
> /github/workspace/src/12810739.patch has style problems, please review.
>
> NOTE: Ignored message types: UNKNOWN_COMMIT_ID
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
> ##############################
> Test: GitLint - FAIL - 1.02 seconds
> Run gitlint with rule in .gitlint
> [RFC] Bluetooth: core: Allow bind HCI socket user channel when HCI is UP.
> 1: T3 Title has trailing punctuation (.): "[RFC] Bluetooth: core: Allow b=
ind HCI socket user channel when HCI is UP."
>
>
> ##############################
> Test: TestRunner: userchan-tester - FAIL - 6.66 seconds
> Run test-runner with userchan-tester
> Total: 4, Passed: 3 (75.0%), Failed: 1, Not Run: 0
>
> Failed Test Cases
> User channel open - Failed                           Failed       0.082 s=
econds
>
>
>
> ---
> Regards,
> Linux Bluetooth
>

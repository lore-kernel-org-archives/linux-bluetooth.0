Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEFDC54E94
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Jan 2023 07:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjAZHQz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Jan 2023 02:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjAZHQy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Jan 2023 02:16:54 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642E546702
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jan 2023 23:16:53 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id p185so729558oif.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jan 2023 23:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaEwd0zqHtceHod9qmaDARLMgXAIQ/cXzhxixc0SCyc=;
        b=d1v+WMQnlFNJa78zDA1jjz1XDnJMND/MXn1EOQOSRtNWmqrwRvR2Nz37A8l9EiKbXF
         Ll+nRs92YkhsM/OBJ1nn6q3gyeAowTHZsSrbJU2oBgf7jPZvYCGnfr4Hh8++cecianzt
         OBQ3pecZTy9E5Ib3Ru7r5NM9t06g9Nk8MJIv0dyzbUeuXUuxQzeZcbmaRIlI6WM5XB23
         MYQ+TZKOP4L3Ex0wn2FHbG/WgGKbeEUpaB87ClHGx1T4+bGmxRuUeiGiBHE6v0SEi3v+
         OqRxxSLcUi31KZlCU51tumQ9t4uT97qOw/oHJRDuC85jxaDpEiv+AZASmJdy7TgXggLy
         v4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AaEwd0zqHtceHod9qmaDARLMgXAIQ/cXzhxixc0SCyc=;
        b=EGENrVkJWC06pk0idAxOlRSi8bRpLL6tnSOVHltUgqrxM2CCr3fCkmhssKWv/FKDAh
         HBA1plnJ7rsgFyC9A7nOJO7txzrHQwNtJG0xsIH0N+y7cw1UYTg+LYf4ZDONhfpcnbrt
         u7MmQdPc8qsHgoa72fgukvCDqA6RaLeYVENurNoSN5Rxe9QA+fNVWZWXdfsy91/lFxXy
         1Nc/a+mWEC42CLTKxeS7ccH6OF9Y/Pc0vOTgZCsEYGmGvcJWeaBiVc5y6uBxvnG1WRRm
         cUPWLILdOVfAs7b/FgMwG4c3eMRMURxKWfzfwVEdEvVmmnTJdUM9/XxGaRpOLO3eOs8p
         Rdaw==
X-Gm-Message-State: AFqh2koPFG69xb0MHiiQ8OraRlcpMoiV61eVY+GP+0iOKaex4w7G3XqI
        hDqpvxmrU7YWAC5wKwX42c480f4mM+zhBiwdwov2Tg==
X-Google-Smtp-Source: AMrXdXtBPxiLWFhD3ajtqGzmxzDgoayE/Oi9twggmXT15PCC6rxapXh7fIwAltKBrRR0bGpWNThpXP1jdqKX1m2Gr8o=
X-Received: by 2002:a54:450c:0:b0:35b:d002:675a with SMTP id
 l12-20020a54450c000000b0035bd002675amr2266833oil.44.1674717412494; Wed, 25
 Jan 2023 23:16:52 -0800 (PST)
MIME-Version: 1.0
References: <20230125131159.kernel.v1.1.Id80089feef7af8846cc6f8182eddc5d7a0ac4ea7@changeid>
 <63d1a5b4.4a0a0220.9d8f1.ae69@mx.google.com> <CABBYNZKzTCN3wNOk=qiJjg0A5dSzZC-=q_kt4YbRK73WB020Gw@mail.gmail.com>
 <CAB4PzUphAqGHatozWALKMP=b69jt1otdWJeCWGQaprdwc-qemg@mail.gmail.com> <CABBYNZJSCHhq=6k2S7_HWeqKJ=rDdnowHie57-kcgUVTzCgTfg@mail.gmail.com>
In-Reply-To: <CABBYNZJSCHhq=6k2S7_HWeqKJ=rDdnowHie57-kcgUVTzCgTfg@mail.gmail.com>
From:   Zhengping Jiang <jiangzp@google.com>
Date:   Wed, 25 Jan 2023 23:16:39 -0800
Message-ID: <CAB4PzUoCtADmAHVZ6zUNVMqCTp2Jhn=9LvyXz828oLQQNm=Y8g@mail.gmail.com>
Subject: Re: Reason to disable adv during power off without clearing
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> What test are you talking about? The one in mgmt-tester which the CI
runs or your own tests?

Sorry for the confusion, I mean our own tests. Are the advertisement
instances fully cleared before the hci_sync rework? I looked at the
old hci_power_off before commit cf75ad8b41d2aa0 and did not find the
code to do that.

Thanks
Zhengping

On Wed, Jan 25, 2023 at 11:02 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Tedd,
>
> On Wed, Jan 25, 2023 at 8:34 PM Zhengping Jiang <jiangzp@google.com> wrot=
e:
> >
> > Hi Luiz,
> >
> > Thanks for the comment. Is there a way to get more information about
> > the failed test? After we cherry picked the hci_sync rework to our
> > branch, some existing tests failed. The failed test will register a
> > few advertisements, then run a power cycle. After the power cycle, the
> > advertisements should be re-enabled automatically. I believe this used
> > to be the behavior before the hci_sync rework? Now calling
> > "hci_clear_adv_sync" during hci_power_off_sync will remove all
> > advertisement instances, so the client code needs to "manually"
> > re-register the advertisement after powering on the adapter. Please
> > let me know if I understood correctly.
>
> What test are you talking about? The one in mgmt-tester which the CI
> runs or your own tests?
>
> @Tedd Ho-Jeong An Perhaps we could add the github PR link to pw that
> way people can inspect the errors.
>
> > Thanks,
> > Zhengping
> >
> > On Wed, Jan 25, 2023 at 3:47 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > On Wed, Jan 25, 2023 at 2:06 PM <bluez.test.bot@gmail.com> wrote:
> > > >
> > > > This is automated email and please do not reply to this email!
> > > >
> > > > Dear submitter,
> > > >
> > > > Thank you for submitting the patches to the linux bluetooth mailing=
 list.
> > > > This is a CI test results with your patch series:
> > > > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=
=3D715641
> > > >
> > > > ---Test result---
> > > >
> > > > Test Summary:
> > > > CheckPatch                    PASS      0.65 seconds
> > > > GitLint                       FAIL      0.85 seconds
> > > > SubjectPrefix                 PASS      0.09 seconds
> > > > BuildKernel                   PASS      31.31 seconds
> > > > CheckAllWarning               PASS      33.97 seconds
> > > > CheckSparse                   PASS      38.25 seconds
> > > > CheckSmatch                   PASS      107.12 seconds
> > > > BuildKernel32                 PASS      29.96 seconds
> > > > TestRunnerSetup               PASS      430.17 seconds
> > > > TestRunner_l2cap-tester       PASS      16.16 seconds
> > > > TestRunner_iso-tester         PASS      16.36 seconds
> > > > TestRunner_bnep-tester        PASS      5.43 seconds
> > > > TestRunner_mgmt-tester        FAIL      110.68 seconds
> > > > TestRunner_rfcomm-tester      PASS      8.62 seconds
> > > > TestRunner_sco-tester         PASS      7.99 seconds
> > > > TestRunner_ioctl-tester       PASS      9.42 seconds
> > > > TestRunner_mesh-tester        PASS      6.79 seconds
> > > > TestRunner_smp-tester         PASS      7.81 seconds
> > > > TestRunner_userchan-tester    PASS      5.73 seconds
> > > > IncrementalBuild              PASS      27.75 seconds
> > > >
> > > > Details
> > > > ##############################
> > > > Test: GitLint - FAIL
> > > > Desc: Run gitlint
> > > > Output:
> > > > [kernel,v1,1/1] Bluetooth: Don't send HCI commands to remove adv if=
 adapter is off
> > > >
> > > > WARNING: I3 - ignore-body-lines: gitlint will be switching from usi=
ng Python regex 'match' (match beginning) to 'search' (match anywhere) sema=
ntics. Please review your ignore-body-lines.regex option accordingly. To re=
move this warning, set general.regex-style-search=3DTrue. More details: htt=
ps://jorisroovers.github.io/gitlint/configuration/#regex-style-search
> > > > 1: T1 Title exceeds max length (82>80): "[kernel,v1,1/1] Bluetooth:=
 Don't send HCI commands to remove adv if adapter is off"
> > > > ##############################
> > > > Test: TestRunner_mgmt-tester - FAIL
> > > > Desc: Run mgmt-tester with test-runner
> > > > Output:
> > > > Total: 494, Passed: 493 (99.8%), Failed: 1, Not Run: 0
> > > >
> > > > Failed Test Cases
> > > > Add Advertising - Success 18 (Power -> off, Remove)  Timed out    2=
.314 seconds
> > >
> > > Looks like there is something not quite right wrt assumption that
> > > power off don't remove clear the adv, at least this test says
> > > otherwise and this test is actually quite old so I don't know if it
> > > has always been like that or we did change this behavior and forgot t=
o
> > > change the test, anyway this explains why we have done the clearing
> > > with cmd_sync work since that is what this test expects.
> > >
> > > >
> > > > ---
> > > > Regards,
> > > > Linux Bluetooth
> > > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz

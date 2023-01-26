Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CE1C05027
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Jan 2023 07:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbjAZHCg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Jan 2023 02:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjAZHCf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Jan 2023 02:02:35 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E2D5C0EF
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jan 2023 23:02:34 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bp15so1635243lfb.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jan 2023 23:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1UXxwwrSF3eX3SP+0GsdgMLK9i3zsvunE9Y8qruhxU=;
        b=DGbH77yKBKzp1EWRQukxj5xaQCqmkXxN/Rvl3Ch6iBtPBHJk3HUOYBeCU97NSjnUQg
         E7Y62emQWBF+K+Y9/yUetM7WQZuJD9INaaWel1ahYarVzpmVJJ7Tz6tJS/IWXRl9goiA
         RsvzsibAANO8fwviwfjsXvIBCXz1ybkMrSVDvCzGXXHcQ5dXkASKHJqZFaR4Ik1Tz6+c
         xfClO1BsOIPHDuEf/8f124lbJq9AJNjG8f3C9giw5+YZZcF3FjozSH8LpAb0H2nwZM82
         Q4JNa1Sb0N783CTwEKeV+P6oKRckfCE4AcBSzKoeB23EyqYzjtsgwegYfsy4WrypHfka
         ecAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1UXxwwrSF3eX3SP+0GsdgMLK9i3zsvunE9Y8qruhxU=;
        b=v/hjDA6l7FwcC4A2RT6YlD+nMm3gn5A3CSAx9aeodWLUNlDhpw973PGcfWCy7z1p6d
         Ayktr/q1eFByD2kFzyztTOuKreFwSb34KB/XnNpxvU3vGU7Djn5RCbv/dbb+3Z74sK76
         +iVbGtzKXqunpZAGaOfzCIQRY4QcWAf155koVbg5UMI+uoUK9yoLJBh7AiJku2ldmVoW
         i+adVQXenGsIEnoMCNYCHSfb+lYqHyhg9EO0DqUcO9Y2GoGtH7+OclelfXjU6wbxjlX7
         lxt/ggiDjSx7FWwMvClqLNLMW9pM6Jr6TkSWmhri8gDrU/AeXskeda31JwBaMfA01lG9
         4o3Q==
X-Gm-Message-State: AFqh2kqQWL585n3IUE/7FXc6xZXmfql3/72wheA7JP0xLl8SJv0G+kbU
        4bNLLQFoQiPYzF3L9O7UqRbx1QzN7nFJk7WvDFA=
X-Google-Smtp-Source: AMrXdXvJHsserN8SybtgsrIuQHwvhwqmymUPjyYdAbzacKjYu+NgPXLHNTTn+vBshHvPJ3b4oL07+vHw+ZQ8GX44Yds=
X-Received: by 2002:ac2:4acd:0:b0:4ce:e95c:f302 with SMTP id
 m13-20020ac24acd000000b004cee95cf302mr1672718lfp.108.1674716552233; Wed, 25
 Jan 2023 23:02:32 -0800 (PST)
MIME-Version: 1.0
References: <20230125131159.kernel.v1.1.Id80089feef7af8846cc6f8182eddc5d7a0ac4ea7@changeid>
 <63d1a5b4.4a0a0220.9d8f1.ae69@mx.google.com> <CABBYNZKzTCN3wNOk=qiJjg0A5dSzZC-=q_kt4YbRK73WB020Gw@mail.gmail.com>
 <CAB4PzUphAqGHatozWALKMP=b69jt1otdWJeCWGQaprdwc-qemg@mail.gmail.com>
In-Reply-To: <CAB4PzUphAqGHatozWALKMP=b69jt1otdWJeCWGQaprdwc-qemg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 25 Jan 2023 23:02:18 -0800
Message-ID: <CABBYNZJSCHhq=6k2S7_HWeqKJ=rDdnowHie57-kcgUVTzCgTfg@mail.gmail.com>
Subject: Re: Reason to disable adv during power off without clearing
To:     Zhengping Jiang <jiangzp@google.com>,
        Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Wed, Jan 25, 2023 at 8:34 PM Zhengping Jiang <jiangzp@google.com> wrote:
>
> Hi Luiz,
>
> Thanks for the comment. Is there a way to get more information about
> the failed test? After we cherry picked the hci_sync rework to our
> branch, some existing tests failed. The failed test will register a
> few advertisements, then run a power cycle. After the power cycle, the
> advertisements should be re-enabled automatically. I believe this used
> to be the behavior before the hci_sync rework? Now calling
> "hci_clear_adv_sync" during hci_power_off_sync will remove all
> advertisement instances, so the client code needs to "manually"
> re-register the advertisement after powering on the adapter. Please
> let me know if I understood correctly.

What test are you talking about? The one in mgmt-tester which the CI
runs or your own tests?

@Tedd Ho-Jeong An Perhaps we could add the github PR link to pw that
way people can inspect the errors.

> Thanks,
> Zhengping
>
> On Wed, Jan 25, 2023 at 3:47 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi,
> >
> > On Wed, Jan 25, 2023 at 2:06 PM <bluez.test.bot@gmail.com> wrote:
> > >
> > > This is automated email and please do not reply to this email!
> > >
> > > Dear submitter,
> > >
> > > Thank you for submitting the patches to the linux bluetooth mailing l=
ist.
> > > This is a CI test results with your patch series:
> > > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=
=3D715641
> > >
> > > ---Test result---
> > >
> > > Test Summary:
> > > CheckPatch                    PASS      0.65 seconds
> > > GitLint                       FAIL      0.85 seconds
> > > SubjectPrefix                 PASS      0.09 seconds
> > > BuildKernel                   PASS      31.31 seconds
> > > CheckAllWarning               PASS      33.97 seconds
> > > CheckSparse                   PASS      38.25 seconds
> > > CheckSmatch                   PASS      107.12 seconds
> > > BuildKernel32                 PASS      29.96 seconds
> > > TestRunnerSetup               PASS      430.17 seconds
> > > TestRunner_l2cap-tester       PASS      16.16 seconds
> > > TestRunner_iso-tester         PASS      16.36 seconds
> > > TestRunner_bnep-tester        PASS      5.43 seconds
> > > TestRunner_mgmt-tester        FAIL      110.68 seconds
> > > TestRunner_rfcomm-tester      PASS      8.62 seconds
> > > TestRunner_sco-tester         PASS      7.99 seconds
> > > TestRunner_ioctl-tester       PASS      9.42 seconds
> > > TestRunner_mesh-tester        PASS      6.79 seconds
> > > TestRunner_smp-tester         PASS      7.81 seconds
> > > TestRunner_userchan-tester    PASS      5.73 seconds
> > > IncrementalBuild              PASS      27.75 seconds
> > >
> > > Details
> > > ##############################
> > > Test: GitLint - FAIL
> > > Desc: Run gitlint
> > > Output:
> > > [kernel,v1,1/1] Bluetooth: Don't send HCI commands to remove adv if a=
dapter is off
> > >
> > > WARNING: I3 - ignore-body-lines: gitlint will be switching from using=
 Python regex 'match' (match beginning) to 'search' (match anywhere) semant=
ics. Please review your ignore-body-lines.regex option accordingly. To remo=
ve this warning, set general.regex-style-search=3DTrue. More details: https=
://jorisroovers.github.io/gitlint/configuration/#regex-style-search
> > > 1: T1 Title exceeds max length (82>80): "[kernel,v1,1/1] Bluetooth: D=
on't send HCI commands to remove adv if adapter is off"
> > > ##############################
> > > Test: TestRunner_mgmt-tester - FAIL
> > > Desc: Run mgmt-tester with test-runner
> > > Output:
> > > Total: 494, Passed: 493 (99.8%), Failed: 1, Not Run: 0
> > >
> > > Failed Test Cases
> > > Add Advertising - Success 18 (Power -> off, Remove)  Timed out    2.3=
14 seconds
> >
> > Looks like there is something not quite right wrt assumption that
> > power off don't remove clear the adv, at least this test says
> > otherwise and this test is actually quite old so I don't know if it
> > has always been like that or we did change this behavior and forgot to
> > change the test, anyway this explains why we have done the clearing
> > with cmd_sync work since that is what this test expects.
> >
> > >
> > > ---
> > > Regards,
> > > Linux Bluetooth
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

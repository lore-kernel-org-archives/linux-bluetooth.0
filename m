Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62793C05027
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Jan 2023 22:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjAZWU1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Jan 2023 17:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjAZWU1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Jan 2023 17:20:27 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A50EDBEA
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 14:20:25 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id n5so3559410ljc.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 14:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPHiJpbSKi8qV9iyr8+6ZX2i7GqeSd5zaEt/m/FDJNg=;
        b=XFP+taLjeBGo30VbEmUQJtH+Gb8KBIM6wF4cEKOrA8+/M3Q9gnL5dMt/GwPecm19RZ
         1WeyJ8pCgUTtdwKAtAVYvsnBZW2tYdjBNU4RnYAQ5x80j2SUS3TuYOOZO7pjDqKNmc/h
         W5CLUmhY+qiYb2s1xFObGJ34s05cMtjp811TOT/yy9M/zFvy/bnbLgd25VaXbgCYYqWV
         W+GEAgbm02qEYnD+4JsYy2eHiDqATTFVdpjgOsrA5msqpvtnrY/AuGduA2lw7dFUCEU+
         t8mGN0NrWPjZEebmQ/Ft54EUR2u7sJfG8FWvd8XZREvqOdfQ67rwqpXpJpizc6+AXrYI
         KGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPHiJpbSKi8qV9iyr8+6ZX2i7GqeSd5zaEt/m/FDJNg=;
        b=0pVG98EO+jrnGpKrTkbtqDElkbmQq9YudeCT/bU9FGxv3TAVF6C+Lj3+t5u0CzpWZ0
         alNCX/yC4hNpbaRFW1tkTxayyz1WY4R16KeTaYnLkFPYZp/K9F59I+pUyLnWbYW6vJKI
         PE4233VAx61+gGw+5K72EboXxDLmyU9cZNId3zYRnGPkRdLpO+AEY3jw9D89C8yZHWJ5
         Fem3kvo72c6rpwszIKQSM0kSrMRlefjkiIZzImOHglVj9e8mUyyCsj/hdGIUuzxKpSGH
         OV44oxYgWr8IhrpFj2jT4KCfaTBsqq0jjEl3OkFRTZ6VY3oWStrKnHTZKgkbb+qpyGw0
         0nSQ==
X-Gm-Message-State: AO0yUKXdXpcXiKf04wlYFIXa/aDBXnvG79qoFtdFp4Ca3mcPEKvwHfuA
        kCgaVotBSCqAv8K6PsZpEAzcxD/T509xwrd//hc=
X-Google-Smtp-Source: AK7set9WckMllII2pkkpVMn0qdT+Z8RgzDhzJr9vvyACVWWNUXpvAUTCLEharG3p7kLjkHTGlusSQkHsQwPvZuZg4H8=
X-Received: by 2002:a2e:9045:0:b0:28f:d85f:2e22 with SMTP id
 n5-20020a2e9045000000b0028fd85f2e22mr168472ljg.161.1674771623310; Thu, 26 Jan
 2023 14:20:23 -0800 (PST)
MIME-Version: 1.0
References: <20230125131159.kernel.v1.1.Id80089feef7af8846cc6f8182eddc5d7a0ac4ea7@changeid>
 <63d1a5b4.4a0a0220.9d8f1.ae69@mx.google.com> <CABBYNZKzTCN3wNOk=qiJjg0A5dSzZC-=q_kt4YbRK73WB020Gw@mail.gmail.com>
 <CAB4PzUphAqGHatozWALKMP=b69jt1otdWJeCWGQaprdwc-qemg@mail.gmail.com>
 <CABBYNZJSCHhq=6k2S7_HWeqKJ=rDdnowHie57-kcgUVTzCgTfg@mail.gmail.com> <CAB4PzUoCtADmAHVZ6zUNVMqCTp2Jhn=9LvyXz828oLQQNm=Y8g@mail.gmail.com>
In-Reply-To: <CAB4PzUoCtADmAHVZ6zUNVMqCTp2Jhn=9LvyXz828oLQQNm=Y8g@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 26 Jan 2023 14:20:11 -0800
Message-ID: <CABBYNZJaLJ2qpeQ=GYQb7Gc6QnjdVnVJkkfnQufhS2sujwozqg@mail.gmail.com>
Subject: Re: Reason to disable adv during power off without clearing
To:     Zhengping Jiang <jiangzp@google.com>
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Zhengping,

On Wed, Jan 25, 2023 at 11:16 PM Zhengping Jiang <jiangzp@google.com> wrote=
:
>
> Hi Luiz,
>
> > What test are you talking about? The one in mgmt-tester which the CI
> runs or your own tests?
>
> Sorry for the confusion, I mean our own tests. Are the advertisement
> instances fully cleared before the hci_sync rework? I looked at the
> old hci_power_off before commit cf75ad8b41d2aa0 and did not find the
> code to do that.

The test expects Advertising Removed (0x0024) to pass:

https://gist.github.com/Vudentz/82938a4b7d501d5fea43a3b71e265e12

Like I said I suspect that test was broken, perhaps we change the
behavior but did not change the tests which then caused us to revert
to the old behavior in order to pass the test, anyway Add Advertising
does allow instances to be programmed while powered off but Add
Extended Advertising Data doesn't:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/mgmt-api.txt#n3=
745

So I think it is better to maintain the current behavior and handle
this in the daemon, meaning we shall handle if the Advertising got
removed we just re-add it on power on, so at D-Bus level we allow
application to register advertising instance regardless of the power
state but while at the kernel level the instances are cleared on power
off. We can actually introduce a property to tell if the instance is
active or not at the kernel level so the daemon is able to notify the
application when they are currently programmed in the controller or
not.

>
> Thanks
> Zhengping
>
> On Wed, Jan 25, 2023 at 11:02 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Tedd,
> >
> > On Wed, Jan 25, 2023 at 8:34 PM Zhengping Jiang <jiangzp@google.com> wr=
ote:
> > >
> > > Hi Luiz,
> > >
> > > Thanks for the comment. Is there a way to get more information about
> > > the failed test? After we cherry picked the hci_sync rework to our
> > > branch, some existing tests failed. The failed test will register a
> > > few advertisements, then run a power cycle. After the power cycle, th=
e
> > > advertisements should be re-enabled automatically. I believe this use=
d
> > > to be the behavior before the hci_sync rework? Now calling
> > > "hci_clear_adv_sync" during hci_power_off_sync will remove all
> > > advertisement instances, so the client code needs to "manually"
> > > re-register the advertisement after powering on the adapter. Please
> > > let me know if I understood correctly.
> >
> > What test are you talking about? The one in mgmt-tester which the CI
> > runs or your own tests?
> >
> > @Tedd Ho-Jeong An Perhaps we could add the github PR link to pw that
> > way people can inspect the errors.
> >
> > > Thanks,
> > > Zhengping
> > >
> > > On Wed, Jan 25, 2023 at 3:47 PM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Wed, Jan 25, 2023 at 2:06 PM <bluez.test.bot@gmail.com> wrote:
> > > > >
> > > > > This is automated email and please do not reply to this email!
> > > > >
> > > > > Dear submitter,
> > > > >
> > > > > Thank you for submitting the patches to the linux bluetooth maili=
ng list.
> > > > > This is a CI test results with your patch series:
> > > > > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?seri=
es=3D715641
> > > > >
> > > > > ---Test result---
> > > > >
> > > > > Test Summary:
> > > > > CheckPatch                    PASS      0.65 seconds
> > > > > GitLint                       FAIL      0.85 seconds
> > > > > SubjectPrefix                 PASS      0.09 seconds
> > > > > BuildKernel                   PASS      31.31 seconds
> > > > > CheckAllWarning               PASS      33.97 seconds
> > > > > CheckSparse                   PASS      38.25 seconds
> > > > > CheckSmatch                   PASS      107.12 seconds
> > > > > BuildKernel32                 PASS      29.96 seconds
> > > > > TestRunnerSetup               PASS      430.17 seconds
> > > > > TestRunner_l2cap-tester       PASS      16.16 seconds
> > > > > TestRunner_iso-tester         PASS      16.36 seconds
> > > > > TestRunner_bnep-tester        PASS      5.43 seconds
> > > > > TestRunner_mgmt-tester        FAIL      110.68 seconds
> > > > > TestRunner_rfcomm-tester      PASS      8.62 seconds
> > > > > TestRunner_sco-tester         PASS      7.99 seconds
> > > > > TestRunner_ioctl-tester       PASS      9.42 seconds
> > > > > TestRunner_mesh-tester        PASS      6.79 seconds
> > > > > TestRunner_smp-tester         PASS      7.81 seconds
> > > > > TestRunner_userchan-tester    PASS      5.73 seconds
> > > > > IncrementalBuild              PASS      27.75 seconds
> > > > >
> > > > > Details
> > > > > ##############################
> > > > > Test: GitLint - FAIL
> > > > > Desc: Run gitlint
> > > > > Output:
> > > > > [kernel,v1,1/1] Bluetooth: Don't send HCI commands to remove adv =
if adapter is off
> > > > >
> > > > > WARNING: I3 - ignore-body-lines: gitlint will be switching from u=
sing Python regex 'match' (match beginning) to 'search' (match anywhere) se=
mantics. Please review your ignore-body-lines.regex option accordingly. To =
remove this warning, set general.regex-style-search=3DTrue. More details: h=
ttps://jorisroovers.github.io/gitlint/configuration/#regex-style-search
> > > > > 1: T1 Title exceeds max length (82>80): "[kernel,v1,1/1] Bluetoot=
h: Don't send HCI commands to remove adv if adapter is off"
> > > > > ##############################
> > > > > Test: TestRunner_mgmt-tester - FAIL
> > > > > Desc: Run mgmt-tester with test-runner
> > > > > Output:
> > > > > Total: 494, Passed: 493 (99.8%), Failed: 1, Not Run: 0
> > > > >
> > > > > Failed Test Cases
> > > > > Add Advertising - Success 18 (Power -> off, Remove)  Timed out   =
 2.314 seconds
> > > >
> > > > Looks like there is something not quite right wrt assumption that
> > > > power off don't remove clear the adv, at least this test says
> > > > otherwise and this test is actually quite old so I don't know if it
> > > > has always been like that or we did change this behavior and forgot=
 to
> > > > change the test, anyway this explains why we have done the clearing
> > > > with cmd_sync work since that is what this test expects.
> > > >
> > > > >
> > > > > ---
> > > > > Regards,
> > > > > Linux Bluetooth
> > > > >
> > > >
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

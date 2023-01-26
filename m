Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0357C05027
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Jan 2023 04:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjAZEeK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Jan 2023 23:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjAZEeJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Jan 2023 23:34:09 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78764C2B
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jan 2023 20:34:06 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id f88-20020a9d03e1000000b00684c4041ff1so392851otf.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jan 2023 20:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKctV4JnqR2g6t3f6jFPJLCdZsFyGS9kfEIdA+vX0F8=;
        b=cWKU0TkqIosmBJygkmfAH31B8mVydosTTUoLg/z+rPP56yWN/ivr2NGgT77904nu0B
         m8qFmvEvk+GbQAv17ayqiusXMYUl6XpQGx1GDGfJdvd4Cf5F+l7YHG8KB2C0GOgItQud
         PlQuaNVpCAf+LLnoj2iYpD0PhHdup5VE/Lsc6DF0vwEa0o1xanPX/WuZP4auOQlZVukN
         61WA+6OqKcuLNO+BNdF/vgNiRT37Uvnbkoll8ANRsl35K4WNqg2JXwS/MScKVGMFPzAc
         xxFWOI1+YEd2e5l6GAncL5IWE3wj4STnXTiC3jkmc6whshppenHDIjJdV7tJsHpcU9mv
         zvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKctV4JnqR2g6t3f6jFPJLCdZsFyGS9kfEIdA+vX0F8=;
        b=LBWCFgQgLGp6SxDJbLop+u2QrVpO8zOYssb6vZs52uJ6pRQffGDP1OqI517iUvGaMv
         YmvNkDxyap74XPsNCrABMkd6S+UnKfNwyWQQZY49Eak1sQuvl9R7WpnlekckXNjIBzh7
         6Zs0iDZJJ82DS1u9fCUN7WY3PhQtX7GmE+gV5TInkpEBqW5XkK9sr4IVlQlb8k1kh4Sf
         fed016OjP746QRbLK89K+HZQlPPimFq3ox4dHlpCt7CN/5H8/lPUYef6OKWDEnFIAjmL
         s3JoeDIhkmxdj/DADMSEgXQ11PMjk4CX5gHpcPpb1sqR5CLapXtFjkhgkNYeBUbl1n/X
         +0EA==
X-Gm-Message-State: AFqh2kqu8pF1auWxt+0hz0j8aOSEWvZmIvxJS9DLKGfr5QMYgfIst4nO
        o7ZfwoywNLgmDWHziZk3h3WUzd4f1vEx+OTOG5LWpQ==
X-Google-Smtp-Source: AMrXdXs050JWQBvqveMmnCNhrrZV66ehGKqGOQYt9O1bRzh5SI1A9cNLC192nDzhLnC24aCIFiQsPrYVKYM+9QOtQo4=
X-Received: by 2002:a05:6830:1350:b0:670:5e9e:3260 with SMTP id
 r16-20020a056830135000b006705e9e3260mr1894933otq.37.1674707645844; Wed, 25
 Jan 2023 20:34:05 -0800 (PST)
MIME-Version: 1.0
References: <20230125131159.kernel.v1.1.Id80089feef7af8846cc6f8182eddc5d7a0ac4ea7@changeid>
 <63d1a5b4.4a0a0220.9d8f1.ae69@mx.google.com> <CABBYNZKzTCN3wNOk=qiJjg0A5dSzZC-=q_kt4YbRK73WB020Gw@mail.gmail.com>
In-Reply-To: <CABBYNZKzTCN3wNOk=qiJjg0A5dSzZC-=q_kt4YbRK73WB020Gw@mail.gmail.com>
From:   Zhengping Jiang <jiangzp@google.com>
Date:   Wed, 25 Jan 2023 20:33:53 -0800
Message-ID: <CAB4PzUphAqGHatozWALKMP=b69jt1otdWJeCWGQaprdwc-qemg@mail.gmail.com>
Subject: Re: Reason to disable adv during power off without clearing
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Thanks for the comment. Is there a way to get more information about
the failed test? After we cherry picked the hci_sync rework to our
branch, some existing tests failed. The failed test will register a
few advertisements, then run a power cycle. After the power cycle, the
advertisements should be re-enabled automatically. I believe this used
to be the behavior before the hci_sync rework? Now calling
"hci_clear_adv_sync" during hci_power_off_sync will remove all
advertisement instances, so the client code needs to "manually"
re-register the advertisement after powering on the adapter. Please
let me know if I understood correctly.

Thanks,
Zhengping

On Wed, Jan 25, 2023 at 3:47 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi,
>
> On Wed, Jan 25, 2023 at 2:06 PM <bluez.test.bot@gmail.com> wrote:
> >
> > This is automated email and please do not reply to this email!
> >
> > Dear submitter,
> >
> > Thank you for submitting the patches to the linux bluetooth mailing lis=
t.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D7=
15641
> >
> > ---Test result---
> >
> > Test Summary:
> > CheckPatch                    PASS      0.65 seconds
> > GitLint                       FAIL      0.85 seconds
> > SubjectPrefix                 PASS      0.09 seconds
> > BuildKernel                   PASS      31.31 seconds
> > CheckAllWarning               PASS      33.97 seconds
> > CheckSparse                   PASS      38.25 seconds
> > CheckSmatch                   PASS      107.12 seconds
> > BuildKernel32                 PASS      29.96 seconds
> > TestRunnerSetup               PASS      430.17 seconds
> > TestRunner_l2cap-tester       PASS      16.16 seconds
> > TestRunner_iso-tester         PASS      16.36 seconds
> > TestRunner_bnep-tester        PASS      5.43 seconds
> > TestRunner_mgmt-tester        FAIL      110.68 seconds
> > TestRunner_rfcomm-tester      PASS      8.62 seconds
> > TestRunner_sco-tester         PASS      7.99 seconds
> > TestRunner_ioctl-tester       PASS      9.42 seconds
> > TestRunner_mesh-tester        PASS      6.79 seconds
> > TestRunner_smp-tester         PASS      7.81 seconds
> > TestRunner_userchan-tester    PASS      5.73 seconds
> > IncrementalBuild              PASS      27.75 seconds
> >
> > Details
> > ##############################
> > Test: GitLint - FAIL
> > Desc: Run gitlint
> > Output:
> > [kernel,v1,1/1] Bluetooth: Don't send HCI commands to remove adv if ada=
pter is off
> >
> > WARNING: I3 - ignore-body-lines: gitlint will be switching from using P=
ython regex 'match' (match beginning) to 'search' (match anywhere) semantic=
s. Please review your ignore-body-lines.regex option accordingly. To remove=
 this warning, set general.regex-style-search=3DTrue. More details: https:/=
/jorisroovers.github.io/gitlint/configuration/#regex-style-search
> > 1: T1 Title exceeds max length (82>80): "[kernel,v1,1/1] Bluetooth: Don=
't send HCI commands to remove adv if adapter is off"
> > ##############################
> > Test: TestRunner_mgmt-tester - FAIL
> > Desc: Run mgmt-tester with test-runner
> > Output:
> > Total: 494, Passed: 493 (99.8%), Failed: 1, Not Run: 0
> >
> > Failed Test Cases
> > Add Advertising - Success 18 (Power -> off, Remove)  Timed out    2.314=
 seconds
>
> Looks like there is something not quite right wrt assumption that
> power off don't remove clear the adv, at least this test says
> otherwise and this test is actually quite old so I don't know if it
> has always been like that or we did change this behavior and forgot to
> change the test, anyway this explains why we have done the clearing
> with cmd_sync work since that is what this test expects.
>
> >
> > ---
> > Regards,
> > Linux Bluetooth
> >
>
>
> --
> Luiz Augusto von Dentz

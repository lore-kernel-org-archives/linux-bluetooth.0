Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25A8C61D97
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Jan 2023 23:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbjAYXrS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Jan 2023 18:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236206AbjAYXrQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Jan 2023 18:47:16 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F8E6A52
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jan 2023 15:47:11 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id br9so540634lfb.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jan 2023 15:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btWSNtUJKbuAqUiTaNK4MzHiOXM1PO7iY2j+cIaRCZg=;
        b=kqj3PFCX2HE6fqRgN/QyhMllK5NmRCyoGVv2657Ht7Qt8MS3+oH5r0pvpMfoz6AzHZ
         vdzbCUB52tCaoNaX7brQpHGB6FzsqyXTfSQqLsxIvRL3/AYXr0lQSXlF8fjZEtMSY473
         PRrLmvi2RBoZXJvqrMYRaIPgzeZ21ByKydMJeDnQB31lv+f/TJ1B6+eQlTmXlh4tQT3q
         sJ6rEuydp0lx5rhF/4+Mt2piiacSRtJxACi+pugW9g68pRXhfKDXnj6Cw5HrxlCjyCUX
         kRQiXyjB0nx5yBqXlDzv3B84jeGwLIHOWflGfS7LHMMFal7HmNrgPMMnUjSShCDKp0n6
         MVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btWSNtUJKbuAqUiTaNK4MzHiOXM1PO7iY2j+cIaRCZg=;
        b=7Fu/L8LKLKGIvU6l+fBUiPyrRjjPPs1/dKdiHAucmoetu0chzQmk7sjdF1YeuCDzOs
         IrGuhsKK1sIouNACPJv4yNwLw9h26ShBBEzH8YlVSaWEmNTGLHuTpS8wroyNvLX4AgQ1
         o69ID0eUog13lf5hWASnLuwZsFXjyuwYvZeIy4aPzCwBhgjl5mxuAObwdJKNFBG6HIJ5
         FEPRPOK+XmiRuJEIBYAncPKI+Wh+krYmGCtxVv0MvKdw7PbckQ2rLqiHVZnn1GjGI0qH
         NZt2LHF6aaHLSa8wW4NsXdOaUclpC1HmDxqsr0G6uJgMAoPXlVEDhZpBWX83+piMgOrt
         25Qg==
X-Gm-Message-State: AFqh2kqHQy5Uo+ob9eSwDKz+kJBdNKzuo+26iY+D6utmRz3Hjj9jCdL/
        rxPqnNDzg1WsVoSniaO2eYjX6xdG0lYxkxkHvLcCehs8zfI=
X-Google-Smtp-Source: AMrXdXsp+9Nv+dwzJ5ULNsmdFylxMML62b9FnGOkqBmMaOh63EYGtYdR4mNAsYltKdmNgGHJw6WXoCVdo0tzEiIGJbs=
X-Received: by 2002:a05:6512:3c9b:b0:4cc:9bfb:69cf with SMTP id
 h27-20020a0565123c9b00b004cc9bfb69cfmr1848569lfv.229.1674690428789; Wed, 25
 Jan 2023 15:47:08 -0800 (PST)
MIME-Version: 1.0
References: <20230125131159.kernel.v1.1.Id80089feef7af8846cc6f8182eddc5d7a0ac4ea7@changeid>
 <63d1a5b4.4a0a0220.9d8f1.ae69@mx.google.com>
In-Reply-To: <63d1a5b4.4a0a0220.9d8f1.ae69@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 25 Jan 2023 15:46:57 -0800
Message-ID: <CABBYNZKzTCN3wNOk=qiJjg0A5dSzZC-=q_kt4YbRK73WB020Gw@mail.gmail.com>
Subject: Re: Reason to disable adv during power off without clearing
To:     linux-bluetooth@vger.kernel.org
Cc:     jiangzp@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Jan 25, 2023 at 2:06 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D715=
641
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.65 seconds
> GitLint                       FAIL      0.85 seconds
> SubjectPrefix                 PASS      0.09 seconds
> BuildKernel                   PASS      31.31 seconds
> CheckAllWarning               PASS      33.97 seconds
> CheckSparse                   PASS      38.25 seconds
> CheckSmatch                   PASS      107.12 seconds
> BuildKernel32                 PASS      29.96 seconds
> TestRunnerSetup               PASS      430.17 seconds
> TestRunner_l2cap-tester       PASS      16.16 seconds
> TestRunner_iso-tester         PASS      16.36 seconds
> TestRunner_bnep-tester        PASS      5.43 seconds
> TestRunner_mgmt-tester        FAIL      110.68 seconds
> TestRunner_rfcomm-tester      PASS      8.62 seconds
> TestRunner_sco-tester         PASS      7.99 seconds
> TestRunner_ioctl-tester       PASS      9.42 seconds
> TestRunner_mesh-tester        PASS      6.79 seconds
> TestRunner_smp-tester         PASS      7.81 seconds
> TestRunner_userchan-tester    PASS      5.73 seconds
> IncrementalBuild              PASS      27.75 seconds
>
> Details
> ##############################
> Test: GitLint - FAIL
> Desc: Run gitlint
> Output:
> [kernel,v1,1/1] Bluetooth: Don't send HCI commands to remove adv if adapt=
er is off
>
> WARNING: I3 - ignore-body-lines: gitlint will be switching from using Pyt=
hon regex 'match' (match beginning) to 'search' (match anywhere) semantics.=
 Please review your ignore-body-lines.regex option accordingly. To remove t=
his warning, set general.regex-style-search=3DTrue. More details: https://j=
orisroovers.github.io/gitlint/configuration/#regex-style-search
> 1: T1 Title exceeds max length (82>80): "[kernel,v1,1/1] Bluetooth: Don't=
 send HCI commands to remove adv if adapter is off"
> ##############################
> Test: TestRunner_mgmt-tester - FAIL
> Desc: Run mgmt-tester with test-runner
> Output:
> Total: 494, Passed: 493 (99.8%), Failed: 1, Not Run: 0
>
> Failed Test Cases
> Add Advertising - Success 18 (Power -> off, Remove)  Timed out    2.314 s=
econds

Looks like there is something not quite right wrt assumption that
power off don't remove clear the adv, at least this test says
otherwise and this test is actually quite old so I don't know if it
has always been like that or we did change this behavior and forgot to
change the test, anyway this explains why we have done the clearing
with cmd_sync work since that is what this test expects.

>
> ---
> Regards,
> Linux Bluetooth
>


--=20
Luiz Augusto von Dentz

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F46C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Dec 2021 21:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237314AbhLUVyU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Dec 2021 16:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhLUVyU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Dec 2021 16:54:20 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EDCC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Dec 2021 13:54:19 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id d10so487886ybe.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Dec 2021 13:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=roR3BWMMZuH6DgZzdrEh4PwMcHUdVw7EnwuXO+o2e1Y=;
        b=o1od94VcSieuiSmA9mJArTyV3FbuHK/NjgdFEp2kvhT4HgBOysphuIuGRyJaSszugS
         6aTmmXlhO+BZUTuOMWvyvbdw6Gebd99D6rMKWFoMbOYhxNbA9BuksnSnxz83O8uGMR1f
         cXQkNKmxysQ/uwXPG5Rs7ZZtUwFdpotfX8jSW8qQbmO8dfH2UTt96GYV5O0pBkiQoAit
         alE1aj3/HAb2pyWgVQe+0LCD1MO1jwiS6x10QI55izzr1PEOx0bMTnkEZBgfvf68Vz/A
         mQLGHjdlEHhNgAfv7JWsQdwhuZWFV8OL8C8Av8uN5tcx+PsN4KlydEr9upVlHdadGlAG
         Hx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=roR3BWMMZuH6DgZzdrEh4PwMcHUdVw7EnwuXO+o2e1Y=;
        b=U8DD3eskbKjIB4LODVMhU3XN8zpXo66CTbDx1uu5ldW+APSnCg92U8QR9L4HnBGPa+
         M+XPHC1HEO0fJS37ytpMZymwvN9/6MuP/8GaqVzLvldjPWKTT/gJp8tF8djPB7/9HeTc
         wUEEvZwD7OOQBfxZe2yP73hpMsxFnkq+YfWdMaVopZ3cOvP/rY+j6cSZl7K2elMJ3xlJ
         q6P5Wa5Vm7dB+nSgKBNsG+6PioqAEut94CZ1P8J5oC12jkTayVxiAHdpLo/Yyg1dFszZ
         1I2RoKBsmvUfbjRoJV1cVLV5WimZtm3/oto8vS3eJ1jfXqE8dOGZ5hya+lPaKKunCu5p
         KXqg==
X-Gm-Message-State: AOAM530cj4XeYAftdG/iC4UHZJsIzeeRU7Fkxguo5zyUyXZ5Hf2Y6WXT
        XmoMD65oaQxHyeqBwg0Ec6ixzXeq1LLEqVF1sDRNlJPF
X-Google-Smtp-Source: ABdhPJyIltk9DzHNlIGs02JNHRwMlDhWOXAR5e/dZ8YfRS2kwSrctLEFtsomiwY27DdD+frgclOn0OTjCkIWydXNBwY=
X-Received: by 2002:a25:7287:: with SMTP id n129mr371685ybc.351.1640123659056;
 Tue, 21 Dec 2021 13:54:19 -0800 (PST)
MIME-Version: 1.0
References: <20211213212650.2067066-1-luiz.dentz@gmail.com>
 <61b7c408.1c69fb81.22a92.79f9@mx.google.com> <CABBYNZ+4CAg=4V7DHHws3J8T1LfVGJ8S91gCEgg-bQuSebkEAw@mail.gmail.com>
 <CAGPPCLAe0MbE3++O7Rdczc_M8C8jT038igiyr-Z40Z5MvcjqWQ@mail.gmail.com> <CABBYNZJmv5-sLhz7sK_5ytZEfjz7oyq-MM1yB_iFu8c0r_3Z4A@mail.gmail.com>
In-Reply-To: <CABBYNZJmv5-sLhz7sK_5ytZEfjz7oyq-MM1yB_iFu8c0r_3Z4A@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 21 Dec 2021 13:54:08 -0800
Message-ID: <CABBYNZJmx8o0Jk7KqRtqHTuMO+WCAAAmWezjQo=m8+GJuoHnsw@mail.gmail.com>
Subject: Re: Bluetooth: mgmt: Fix mgmt_device_found panic
To:     Manish Mandlik <mmandlik@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Mon, Dec 20, 2021 at 1:07 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Marcel,
>
> On Fri, Dec 17, 2021 at 4:44 PM Manish Mandlik <mmandlik@google.com> wrote:
> >
> >
> >
> > On Fri, Dec 17, 2021 at 5:43 PM Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> >>
> >> Hi Marcel,
> >>
> >> On Mon, Dec 13, 2021 at 2:07 PM <bluez.test.bot@gmail.com> wrote:
> >> >
> >> > This is automated email and please do not reply to this email!
> >> >
> >> > Dear submitter,
> >> >
> >> > Thank you for submitting the patches to the linux bluetooth mailing list.
> >> > This is a CI test results with your patch series:
> >> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=595033
> >> >
> >> > ---Test result---
> >> >
> >> > Test Summary:
> >> > CheckPatch                    FAIL      1.63 seconds
> >> > GitLint                       FAIL      0.92 seconds
> >> > BuildKernel                   PASS      317.18 seconds
> >> > Incremental Build with patchesPASS      321.54 seconds
> >> > TestRunner: Setup             PASS      454.37 seconds
> >> > TestRunner: l2cap-tester      PASS      11.79 seconds
> >> > TestRunner: bnep-tester       PASS      5.89 seconds
> >> > TestRunner: mgmt-tester       PASS      112.27 seconds
> >> > TestRunner: rfcomm-tester     PASS      7.41 seconds
> >> > TestRunner: sco-tester        PASS      7.54 seconds
> >> > TestRunner: smp-tester        PASS      7.34 seconds
> >> > TestRunner: userchan-tester   PASS      6.14 seconds
> >> >
> >> > Details
> >> > ##############################
> >> > Test: CheckPatch - FAIL - 1.63 seconds
> >> > Run checkpatch.pl script with rule in .checkpatch.conf
> >> > Bluetooth: mgmt: Fix mgmt_device_found panic\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
> >> > #103:
> >> > FS:  0000000000000000(0000) GS:ffffffff8c097000(0000) knlGS:0000000000000000
> >> >
> >> > total: 0 errors, 1 warnings, 0 checks, 16 lines checked
> >> >
> >> > NOTE: For some of the reported defects, checkpatch may be able to
> >> >       mechanically convert to the typical style using --fix or --fix-inplace.
> >> >
> >> > /github/workspace/src/12674615.patch has style problems, please review.
> >> >
> >> > NOTE: Ignored message types: UNKNOWN_COMMIT_ID
> >> >
> >> > NOTE: If any of the errors are false positives, please report
> >> >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> >> >
> >> >
> >> > ##############################
> >> > Test: GitLint - FAIL - 0.92 seconds
> >> > Run gitlint with rule in .gitlint
> >> > Bluetooth: mgmt: Fix mgmt_device_found panic
> >> > 77: B1 Line exceeds max length (97>80): "Fixes: 2023db7e3a343 ("Bluetooth: mgmt: Make use of mgmt_send_event_skb in MGMT_EV_DEVICE_FOUND")"
> >>
> >> Can you please fixup/squash this one, this is breaking inquiry
> >> response processing.
> >>
> >> --
> >> Luiz Augusto von Dentz
> >
> >
> > Tested-by: Manish Mandlik <mmandlik@google.com>
>
> Ping, we really need to fix this up.
>
> --
> Luiz Augusto von Dentz

Ive fixed the original patch and pushed to bluetooth-next.

-- 
Luiz Augusto von Dentz

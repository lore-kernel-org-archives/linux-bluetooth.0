Return-Path: <SRS0=DUSx=ST=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062B1C282DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Apr 2019 18:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B912320663
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Apr 2019 18:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIE8lH+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfDQSms (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:42:48 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37917 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbfDQSms (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Apr 2019 14:42:48 -0400
Received: by mail-oi1-f196.google.com with SMTP id a6so20858256oie.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2019 11:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yN7AFswgTcE+Un2CcZhERcBuwBWVGfeNJ8aSaTMcGxU=;
        b=RIE8lH+MB6Urc2Ju+hXtBk4OtKHKp4Y4AJT3rZMM/Q4l7f/sQb/10JjfVPiDOWwQ/l
         1q3XO2TW1P4wueTEqRsWUDGYD/YmdXPB+HNCEIKDs3extpRRXWMdmxYLn6qFcjDXc23h
         U8cGurLDwM6rti05wTIbQVKK3jlTSMFXcsmHRXZPQxu9tdmrtLcb3r+aa3JPnR9/YKPV
         H2FnzyAJyEUKxjlLC9J0IH929l0SUNKNHqyC4gQqeuH0NbxkdEoW331pFI8bqOz/x7yG
         EXyNSUIs+RIOVL5fGoWaae5oK62EJPV+dU1qFY1xPCgpoqNOZjOtE/qkmgBA9qefTQbw
         g40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yN7AFswgTcE+Un2CcZhERcBuwBWVGfeNJ8aSaTMcGxU=;
        b=nsbqUXb6E2U459r2R5fFmjTAjb/ASkDiUiBaFm2eRzx29GoKvluLxqU2CC5M0o7wxj
         jOY6Q1AAIqvkkiwIORxeTWwrCZEaMUNrytUuyswhjiLAixBGBWiIuUj88z27ZJniwzE6
         HXfjyvkOjGCT9N2Y6AO2iT7jSSw+obdQCNgblw7fpZFiwC+52S01Yuo+23F8XI0QaZRH
         wBSrGIBEV5sDY2+qlq5Ccd29oG2WoyHhsYJ862fK9sFnttnIB8GFmQxMLzuBmogHYWyf
         CvAgnSq19dvfvVg7swpvPSHvi2gridBN1oooBEIc6It+/W2YyjZOCVYZE827lL0bUvEj
         7F1w==
X-Gm-Message-State: APjAAAUW5aLJyLgGZWmbbD+I+bCsNBebvDM7Ht3EkD9ZBiBOz39Y/LMD
        a6ljP5jRCb157DNGFwNv5Gb5KNiPpm5D/gF5dKw=
X-Google-Smtp-Source: APXvYqwu167XSGs+qilRg0myBU9veTTRko+f1Oz44kCee7Tx7h3UcanI8yqRYqtRsW/cDVAMeDrD9gcvKU/R1FCa0xM=
X-Received: by 2002:aca:adc8:: with SMTP id w191mr44736oie.110.1555526567264;
 Wed, 17 Apr 2019 11:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190416193241.GA10277@amd>
In-Reply-To: <20190416193241.GA10277@amd>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 17 Apr 2019 21:42:37 +0300
Message-ID: <CABBYNZK92AH7fnQJ7ikz=nvroVN9AKQDNZ07es2V52kRP0RL=g@mail.gmail.com>
Subject: Re: Gatt server with random address does not work (everything is ok
 with public address)
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pavel,

On Tue, Apr 16, 2019 at 10:35 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> I adapted example-gatt-server for a project... and it works ok
> (thanks), as long as public address is used. I could not configure
> random address in main.conf, so I'm doing it with btmgmt:

Have you tried setting Privacy = device?
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/main.conf#n71

> #!/bin/bash
> (
>     echo power off
>     sleep .1
>     echo le on
>     sleep .1
>     echo bredr off
>     sleep .1
>     echo static-addr c2:34:56:78:90:ab
>     #echo public-addr 00:1A:7D:DA:71:11
>     #echo static-addr c2:34:56:78:90:ab
>     sleep .1
>     echo connectable on
>     sleep .1
>     echo pairable on
>     sleep .1
> #    echo discov on
>     sleep .1
> #    echo advertising on
>     sleep .1
>     sleep .1
>     echo power on
> ) | sudo ../bluez/tools/btmgmt
> sleep 2
>
> With random address, it does not work: lescan from other machine
> detects right address, and I can connect, but that's it, services
> can't be listed.

bluetoothd don't really know that you have set a static address like
that, anyway I don't know what exactly is not working so it very hard
to give any instruction with such vague description of the problem.

> I'm using 4.19 kernel on one side and current -next on the other side,
> with bluez e4cf43fc62b4e4dbabc72d4e44e095d7a9087992, Fri Sep 7
> 16:25:44 2018.
>
> And it seems I'm not the only one having this problem:
> https://stackoverflow.com/questions/50707914/setup-bluez-gatt-server-with-random-address
>
> Any ideas how to debug that? Does configuration with random address
> work for you? Is there chance update to latest versions helps?

Look at privacy, if that doesn't work then collect the journal logs
and btmon traces, etc.


-- 
Luiz Augusto von Dentz

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A25C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Jul 2022 15:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiGUP14 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jul 2022 11:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiGUP1z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jul 2022 11:27:55 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831587F51B
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 08:27:54 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id z13so1843453ljj.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 08:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jw8IAE7nCZttBT4SGG/rDAgE/7RI+HSSW6knUqS2lfc=;
        b=XfI4x3gnssJYbuq7HEOxXEChRl3QoYPH6utQAHmu64hPl9cxdvLQ4KS7z8unfmF1D0
         37KwQjPtW1twSrMmWOuCErNbmtlvB1O2qzqErLkgCXEt5MwpR0m98rIxLtoPO21TlJqk
         2rWu+vLZCfjsu36JU8f/IliJKiVacAkrcl5R4JTY+MfqMDKUVZ8+KWHqXE1Z6mVex0Ed
         8wIknuYNbJwDBuE1+bp/pG3p5WH9YQuzhZi5g2bFWf45G7OjeFN7lQJYoYGm76LmSzZd
         9UDqQ/6mvrkCkt9t94ytfb/lImX5FD/fcuTzQVm4ogG/4uSmXVUxN0ClBePr3RPe2hl7
         MejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jw8IAE7nCZttBT4SGG/rDAgE/7RI+HSSW6knUqS2lfc=;
        b=6VAU8CKfsnlX+FLNf/TQpSpF/Wor0J7Fck4dS2PJVdgUy/Pt5yi/beQEa6lS3BHVS1
         DG+xJpcNKtGVHHH7hj2LKNYdzPuvWufrHKntsXC2feFEfK9RpeG776Y7JYBjdihTZewF
         STB3KwK8MuhkKSOGkE1UvVr7U91hklJcphZ+8EY5UhItWX5RMqSLDTjaG/jl3gGD92a7
         hJ34F43qg1UpEpvpW5WZByJoH1UAcQU529pN2HQwT3WYdkVC+DuQxTeokSfeL6AvopAN
         oDNF8K8yqbraKR9O7hrwrQgkB+XcqbKciuYjYKMYri2Zl3AwA1Q+TDnugVkzkRr9DhWl
         AA6Q==
X-Gm-Message-State: AJIora/5n7EcWqfFdjpaHilFTDG4oyBfN2ZJhJZ3mbBBBzs+spip+Qzh
        sxSs/fJfgdC+926q0TzlLxTPruJcIRxILEibYl/1HY6QTR0=
X-Google-Smtp-Source: AGRyM1tmGlovxgCGxkbM/IuWtcuswFYC54RuBwHzC/Yjs6bLba1CocrONPAfwxP3xdyIbn11yVBGu+/6LHyUfnCrFnI=
X-Received: by 2002:a2e:a884:0:b0:25d:d8a2:d18c with SMTP id
 m4-20020a2ea884000000b0025dd8a2d18cmr2789820ljq.305.1658417272470; Thu, 21
 Jul 2022 08:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <SJ0PR13MB5755315F09CF8B49984DE12FFE869@SJ0PR13MB5755.namprd13.prod.outlook.com>
 <CABBYNZ+ei7=TXw_gP8keZaCyz5igABLxYxUnmBhAe35wAXoR0g@mail.gmail.com>
 <SJ0PR13MB57558B7A49D3A9C106C3C210FE869@SJ0PR13MB5755.namprd13.prod.outlook.com>
 <CABBYNZ+LytLtRwZBvZMgaiVnoR6AXeT7G4_n7DrZ_QgqZ8cTWw@mail.gmail.com> <SJ0PR13MB57550A4487E740DF7BDC9AE1FE919@SJ0PR13MB5755.namprd13.prod.outlook.com>
In-Reply-To: <SJ0PR13MB57550A4487E740DF7BDC9AE1FE919@SJ0PR13MB5755.namprd13.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 21 Jul 2022 08:27:40 -0700
Message-ID: <CABBYNZKEgUeqj_wUthpNGGkhosZewk+1jOcevAND=FtApSqwsw@mail.gmail.com>
Subject: Re: How does bluetoothctl work from the command line with gatt?
To:     John Klug <John.Klug@multitech.com>
Cc:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi John,

On Thu, Jul 21, 2022 at 8:00 AM John Klug <John.Klug@multitech.com> wrote:
>
> Luiz Augusto von Dentz
> >I think the problem is that you are issuing the select-attribute and
> >then exiting, instead you will need to enter all the commands at the
> >same time otherwise the next time you call bluetoothctl it doesn't
> >have any attribute selected
>
> With gatttool you could issue all the commands non-interactively from the command line.
>
> What you are saying is bluetoothctl has limited command line capability, and cannot replace gatttool as currently written.

Not quite what I said, the difference is that bluetoothctl does
require another command to access so when you are scripting things you
would have to pass the input as a multi line instead of invoking the
binary multiple times with a single line, we could perhaps add support
for a input file where one could enter multiple commands.

>
>
> John Klug
>


-- 
Luiz Augusto von Dentz

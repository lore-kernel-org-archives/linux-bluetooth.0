Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBD5EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jul 2023 18:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjGTSd5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Jul 2023 14:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjGTSd4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Jul 2023 14:33:56 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C36FB7
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jul 2023 11:33:55 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso17345851fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jul 2023 11:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689878033; x=1690482833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gh2SpC2TfxCdtwRgRi/HnQ5srnGHVaVf506sjFM96CE=;
        b=rCWalSQUfAnOL3InLTWJSAj37z3fLtHAEqaPs25yHPlfL7e1tQcNlaTbzHOvS9liqz
         VGr302xX/WEbyAGfuKXlG8DsGRov64Rc+NrWRobqkCkfH8zxvZsLmhwD3hxTXiEUnJkr
         teNR9ht6i4f8p/eEvsjzpkqz1Z40s/WsTomRPwxvyzah+kbWelS6zP3Cvmtvuv+Rqa6/
         /gjN5jx0cxi4o1gijoQyXcLOT1nD9y+7NmKmpTsQhtq6VyW3t1XDGn2q8rEISnAMLtGg
         9gQ0zke7AjU1VDPzBUtV/LB6BNOzYswhQ+eYenh0vR+RfxDo97JjcExMpTVmne1dzCjB
         2ftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689878033; x=1690482833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gh2SpC2TfxCdtwRgRi/HnQ5srnGHVaVf506sjFM96CE=;
        b=QoFPxoEH5jeDt4xTeSoLKeRcjoftLlbgZtMh6l59hBi6Vzo7/GBVyav2+z6bdsiJT3
         V2JkY+WBykb3wiboUfZV2qx61mL6T2akC+9ylcfW88i+6glmUvvBzhOVgOotGp+NrtXB
         Vvs3Mq2iuzBwqBd/OAvDyYKM2+lcnxeP6fBnGJ/52ryYGJvieFAoveE9Rekly2G1keui
         qSBGawppZLZAEEQxBvKBmJs4X/lQ7clUGB2ImC8MufugPt8wmstezJTkm+gtTILViW7L
         +LuMRrqsoQ3VnL4UUbVUSF1RbKYqsPK1GZXfWYRhjueqKCdC4uETurzqhHBeMHH6cYwU
         jyPw==
X-Gm-Message-State: ABy/qLZ1wSkJucp6ErlIURZLzNR18Ohz42+cDmUrk/MnuErfN11YSbM8
        s4WcscXDR0WUP8v0BG59X5g/grCKkdLnFPDdzOnoXAZl
X-Google-Smtp-Source: APBJJlGZ78zYOM93oqaD32HuOFAyLMABwMrlxQ2X6tBA4ch5MMjsbEJN1kWR3276vPt1KQmpL5MENTeJmOyPIYdtQQM=
X-Received: by 2002:a2e:3a09:0:b0:2b6:f009:d1b with SMTP id
 h9-20020a2e3a09000000b002b6f0090d1bmr2790295lja.49.1689878033090; Thu, 20 Jul
 2023 11:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAEU5HDZD-U7vrQrusZxYW7L4wPiZL5m2kZw0nDz401oJjiVs=w@mail.gmail.com>
 <CABBYNZ+c1CfDDQ7GbO5wdQvF-ef=jaVKDcGGnVxHhJN84Edm5Q@mail.gmail.com> <CAEU5HDZVY7hYAK=1FhzSabg9n5Oogq81GqvsuHHJYU7Mr2TXUA@mail.gmail.com>
In-Reply-To: <CAEU5HDZVY7hYAK=1FhzSabg9n5Oogq81GqvsuHHJYU7Mr2TXUA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 20 Jul 2023 11:33:40 -0700
Message-ID: <CABBYNZLLTfu33iU2Z+hE7R3sDyb+nnGSsmf1tiRva5A2TS1+8A@mail.gmail.com>
Subject: Re: Daemonizing bluetoothd
To:     Dynastic Space <dynasticspace@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

Can't recall when we made the change to stop forking, but it has been
a while bluetoothd has this behavior, doesn't procd handle processes
that don't fork by themselves? How old is bluetoothd in OpenWRT that
this is only showing up now?

On Thu, Jul 20, 2023 at 11:15=E2=80=AFAM Dynastic Space <dynasticspace@gmai=
l.com> wrote:
>
> Thank you for your reply.
> So you are saying that you are relying on whatever service manager to
> daemonize the process? I am compiling for OpenWRT which uses procd,
> not systemd.
>
> On Thu, Jul 20, 2023 at 9:04=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi,
> >
> > On Thu, Jul 20, 2023 at 10:42=E2=80=AFAM Dynastic Space <dynasticspace@=
gmail.com> wrote:
> > >
> > > I am reading through the bluetoothd code for version 5.56, but I
> > > cannot find the call that makes it into a daemon. I don't see a fork
> > > or a daemon call. How is it turned to one?
> > > I am compiling the code on an OpenWRT system.
> >
> > We don't call fork anymore, since most likely bluetoothd would be run
> > as a systemd service I don't think it matters though.
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

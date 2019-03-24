Return-Path: <SRS0=QAi9=R3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F09EC43381
	for <linux-bluetooth@archiver.kernel.org>; Sun, 24 Mar 2019 09:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197782171F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 24 Mar 2019 09:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHGPte7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfCXJBC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 24 Mar 2019 05:01:02 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41513 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfCXJBC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 24 Mar 2019 05:01:02 -0400
Received: by mail-oi1-f195.google.com with SMTP id v7so4767900oie.8
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Mar 2019 02:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HrhBkbdZIYb0Nlxveks3wb5Eslwv4HiHxjd3d5gQqwo=;
        b=PHGPte7VIoD9QU8S42vUT8v2Mf83IDtdgvqm9no10mlcFlKLYtd+ZXtjMjWCJ2fIT9
         wQxMPh8JtTNH+SnRVfIl0E2DXew9GZoxPrQXmMOInW4zxQX9wY6mBaZq9qTzrzH0VhSY
         VE1xxOQseaJN4tuiw7F3sGYXCb1nXoXZfMA2RZsZY7F7kkoZsp0nD97/g0iOcAGuczen
         5QIRRNkFdeBEdxkE4dN+t1i5C+UYiO4hNW4TP2+VvZCizZrI/IEplHiLnjCm/QJmDEQU
         Eu/vq9y2rVXcng6bPeRarwhKc86/C5q+3cCG2NaIhvJP0yE+5TkRD0d5FkLaU0LcFawo
         /UnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HrhBkbdZIYb0Nlxveks3wb5Eslwv4HiHxjd3d5gQqwo=;
        b=XXQS87hXyJrIFnNkbIKcLmju7aea0PHSCC8AOWv5j2ktPgezmSQBJMOj0cHpulg5s/
         vpQE2/ypH6LJBy5rNBqGVUZWR9lgpXdXbMeFMbbMi7gLcA18+kAsL9Q6XpAAhOg3XHbR
         SNm903u6CjdF4VHc6UnJDiVNIJFJjna2e/qYM7XCK/1m1/3DbmxDD/6HkxksxIewgaYd
         35xj4NhDvOmKYehGT8KLfFeoIbG0ZbE0CLJMIIw0+HMFfs9oLvq8tlQiswgMYqaCRoB7
         7ccby7dgwuIiXLGo48te7f79qXc+Cn7BPsd3jA01a3IQHLBJAGNjOEGnBzYebCGPdrCH
         NGOw==
X-Gm-Message-State: APjAAAX4FIxz5ke0W+vw4KUpBGNgdbW6ysQ95ut2rFe+KAFKv03fXVuD
        iePoliMQz1w6bKFxJt4a7WkLAMfFyTSHBK9CQKX7nUvQx8BI5w==
X-Google-Smtp-Source: APXvYqxiZljQ8ewIATdSFpDgve5uktgBoDojsggJAvxDCVbQMNeqOqezS5crXqRDJsSwr6qLDFHMj+H7SU0iQ/Cqsjc=
X-Received: by 2002:aca:4a0a:: with SMTP id x10mr7700973oia.82.1553418061303;
 Sun, 24 Mar 2019 02:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190322034927.6247-1-inga.stotland@intel.com>
 <82D05BF3-3E54-4BB1-B22B-72F1C94051A5@gmail.com> <2815DD46-4BB1-46DC-881D-1C30200DAED9@intel.com>
 <E232C390-8571-40A5-9E72-2499E9973959@gmail.com>
In-Reply-To: <E232C390-8571-40A5-9E72-2499E9973959@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sun, 24 Mar 2019 11:00:50 +0200
Message-ID: <CABBYNZLAau4paWF9yoLXzUzmJnVawDiZWaVZUnwZfGqhRsQnMw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] test: Enable test-mesh to send raw vendor commands
To:     Johan Hedberg <johan.hedberg@gmail.com>
Cc:     "Gix, Brian" <brian.gix@intel.com>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Johan, Brian,

On Sat, Mar 23, 2019 at 12:08 PM Johan Hedberg <johan.hedberg@gmail.com> wr=
ote:
>
> Hi Brian
>
> On 22 Mar 2019, at 16.00, Gix, Brian <brian.gix@intel.com> wrote:
> >>> On 22 Mar 2019, at 5.49, Inga Stotland <inga.stotland@intel.com> wrot=
e:
> >>> +#       5 - on/off model client menu
> >>> +#       6 - send raw message
> >>> +#       7 - exit
> >>
> >> Please don=E2=80=99t use numeric identifiers for commands in interacti=
ve tools. Use intuitive, human readable strings like we do in the other int=
eractive tools in the tree. Numbers might be convenient for computers, but =
they=E2=80=99re not particularly human friendly :)
> >
> > We do plan on making better tools, but this is mostly intended as a tes=
ter script to quickly allow us to test stuff, particularly the d-bus APIs, =
and demonstrate the way the methods are called from python.
>
> Understood, however what I proposed
>
>  - Doesn=E2=80=99t take really any extra effort
>  - Is friendlier to the user
>  - Is friendlier to the reader of the code (no need to do number lookups =
to understand the purpose of a branch)
>  - Is consistent with the rest of the code base
>
> =E2=80=A6 so I don=E2=80=99t understand why you wouldn=E2=80=99t want tha=
t, even if it=E2=80=99s a quick test tool :)

+1

> I suppose the long-term idea is to provide the same kind of interactive c=
ommand-line interface as meshctl has provided for provisioner and configura=
tion client role? In fact, would it make sense to keep using meshctl for th=
at and hide the detail whether stuff is going via meshd or not?

There is actually a lot in common to meshctl so I wonder why not
extend it to work with meshd instead, or we do intend to abandon it? I
thought its code would be assimilated by meshd and then reworked...
Anyway our python scripts are just small samples currently and Id say
we should keep it like that and not have full blow clients since there
are better tools for it, for instance there exists python bindings for
BlueZ which might be extended to work with meshd:

https://pypi.org/project/bluezero/



> Johan



--=20
Luiz Augusto von Dentz

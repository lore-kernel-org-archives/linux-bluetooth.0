Return-Path: <SRS0=4ALD=QH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDFCC169C4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Jan 2019 18:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D70218F0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Jan 2019 18:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="obNVM2gq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfAaSJm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:09:42 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:42525 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbfAaSJl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Jan 2019 13:09:41 -0500
Received: by mail-pl1-f176.google.com with SMTP id y1so1819484plp.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jan 2019 10:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QMQAs2BrPBakFvbTOghvEIxQFVe5ahqNhhW/TQsLidw=;
        b=obNVM2gqupXtF3bBQraYooSPcwTVRDjIQuM/SE5g78MsSSVBwKiz1hpqktk/QOjdUt
         OBBbg4Y5QHzBIjZAMIWWy/nmohsLh8cwSiRcf9d7/9AZdT/ucv+TdF9THQcJPP2rv/gb
         lJQfWpEZUFv8HCYDTuOxl/u7oLJdj7mc0EeziCcNyKVH/FwGBFbm0JJkKPbtDOGQZ57f
         YC+J2I0e+EwUuOFV1XIsWYhtxWd1I3ZmijrYgeiCTL9FP01bu9zzPsi+cC/0SQJnYibU
         p53fAkyLjGIXGa5ttdMPnXk5eqOvXs8h72uPKE5hTJkdsOdgGw1K5Db887QtHfXEYZtz
         Bd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QMQAs2BrPBakFvbTOghvEIxQFVe5ahqNhhW/TQsLidw=;
        b=lwu+opJ1H7chx50NW4XCNlhfHuYOraWk6JShEWjMuqjDdQ7nePX5kExk+dQa4NUPEI
         O9ngAn3RHkgdnX2Y5KjIXSgvVvr9Gc3OawzNDfPKNiYkdXuQGi8fP0+LMLnb/NA9qWPb
         sT4np/r1dzuReWRJf/F46I2tPGGPQbDLdhTvNq8yDVApBAlCJLV1bOhKCo588gxc0VpN
         TyIe3Wx5B/awayC7aN/VF/CtKWaBHZ3LXRGY3tmsfSP9/vq1fM0ZzjY7q1LEIXQNbDJU
         GCcjzZ6usFu251ceyYvg/hKeB4I5i2hBiwvVB9PD3MtVwj5Tzhoqx+gJRUITpijP1nCJ
         qHjg==
X-Gm-Message-State: AJcUukdV/6ZY8t/mgiIEqKY7GGCA3/FzENoMU0yjStyORwFxE4ihmGdV
        tPofZadl14Vdfpf/2ZHhDXVtvILBEziDQCn7C/c=
X-Google-Smtp-Source: ALg8bN4ZpevbdF6c5s2fblRrzhOAu/0ElfNhEO4zwlnCYC/qtJQfREQAuksMGE6/7Q67aL4vmHVAL9bA6uOJ13RTA3Y=
X-Received: by 2002:a17:902:9897:: with SMTP id s23mr34335157plp.69.1548958180817;
 Thu, 31 Jan 2019 10:09:40 -0800 (PST)
MIME-Version: 1.0
References: <CAO1O6scUuK1K+zLjyQA12HtY9nNdR=Q8MeuruC2GKvaJPH0knA@mail.gmail.com>
 <CABBYNZJ8hqJph3DgFBdTPBpD5eqSvMHCsrwvNZx3z5v9Fbu3Vg@mail.gmail.com>
 <CAO1O6sdp8j+DkawuMcR_X27Dt1VDyO_zc=cmQcYraea7oN=pLg@mail.gmail.com> <CABBYNZ+hc8OVTPOiVEh30qQ=L4Bjv4k_S4eUFJiRT-71fL+LCg@mail.gmail.com>
In-Reply-To: <CABBYNZ+hc8OVTPOiVEh30qQ=L4Bjv4k_S4eUFJiRT-71fL+LCg@mail.gmail.com>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Thu, 31 Jan 2019 19:09:31 +0100
Message-ID: <CAO1O6sdTqHFuDOp9DDasK_aHQ7Ld8YHJtsgcZQLDq+1PebZRwQ@mail.gmail.com>
Subject: Re: Flag for specifying write type to WriteValue in gatt-api.
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Den tors 31 jan. 2019 kl 18:55 skrev Luiz Augusto von Dentz
<luiz.dentz@gmail.com>:
>
> Hi Emil,
>
> On Thu, Jan 31, 2019 at 7:46 PM Emil Lenngren <emil.lenngren@gmail.com> wrote:
> >
> > Hi Luiz,
> >
> > Den tors 31 jan. 2019 kl 18:03 skrev Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com>:
> > >
> > > Hi Emil,
> > >
> > > On Thu, Jan 31, 2019 at 6:19 PM Emil Lenngren <emil.lenngren@gmail.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > I was looking through the quite lengthy discussion at
> > > > https://github.com/WebBluetoothCG/web-bluetooth/issues/238 on the
> > > > issue that in Web-Bluetooth, only a single "write value" API is
> > > > available, causing Web-Bluetooth to decide on its own if Write With
> > > > Response or Write Without Response should be used, in case both are
> > > > supported by the characteristic.
> > > >
> > > > But in the Bluetooth spec about Write Without Response:
> > > >
> > > > "This sub-procedure is used to write a Characteristic Value to a
> > > > server when the client knows the Characteristic Value Handle and the
> > > > client does not need an acknowledgement that the write was
> > > > successfully performed."
> > > >
> > > > Basically, it says it's up to the client/application to decide if an
> > > > acknowledgement is needed or not, and hence it's the app that should
> > > > decide if Write With or Without Response should be used. The "client"
> > > > can't mean a bluetooth stack here since it can of course not know if
> > > > an acknowledgement is needed or not.
> > >
> > > There is a property indicating if write without response is supported
> > > though, but you are right regarding that not excluding regular write
> > > so at that point the client would have a choice whether to use it or
> > > not.
> > >
> > > > I noticed that according to gatt-api.txt, BlueZ has the same
> > > > limitation in the WriteValue method, in that the stack chooses the
> > > > write type "arbitrarily" if both write types are supported (or really
> > > > the Write With Response is chosen, which might cause unwanted
> > > > latency). Therefore I suggest that an option should be added to the
> > > > WriteValue method, for example "write-without-response" (bool) to
> > > > force Write Without Response.
> > >
> > > It gets a bit trickier if the attribute is in fact a control point in
> > > which case perhaps only write-without-response really works, anyway
> > > control points are better off using AcquireWrite.
> > >
> > > > Note how iOS has a write type parameter to the write method, and
> > > > Android has a write type property you set before you execute the
> > > > write.
> > > >
> > > > I see that it might be possible to achieve the same result with
> > > > AcquireWrite -> write to socket -> release but that wouldn't be a good
> > > > solution for bluetooth stacks built on top of BlueZ that would like to
> > > > differentiate between the two write types (such as Web-Bluetooth)
> > > > since AcquireWrite can fail, for example if two apps write the value
> > > > at the same time (I guess the lock is exclusive?). It also seems like
> > > > unnecessary overhead to open and close sockets.
> > >
> > > AcquireWrite is to be used when the app needs exclusive access, like
> > > control points such as those commonly used for things like DFU, I
> > > don't think that is your intent here (or is it?) so I guess adding an
> > > option for WriteValue is probably better. Note though that obviously
> > > one cannot use such a flag with things like e.g. offset as that is not
> > > supported which makes the API a little trickier to use but I guess
> > > that ok given that setting flags is optional.
> >
> > No DFU etc. wasn't really the intention here.
> >
> > I guess most (all?) people don't use the offset parameter. The reason
> > the offset parameter exists in the Prepare Write Request is so that
> > it's possible to write a long value in several chunks I guess. Anyway,
> > the solution is to simply disallow offset != 0 and
> > write-without-response=true at the same time.
> >
> > By the way, I see "Reliable Write" is also forced/first choice if the
> > characteristic supports that (even though I think nobody uses it?).
> > The downside of using Reliable Write over a simple Write Request is
> > that it requires more packets/overhead so I was thinking that maybe,
> > to cover all cases, instead of having a bool "write-without-response",
> > it should be a "write-type" option which can take the values
> > "reliable-write", "write-with-response" or "write-without-response"
> > (or use automatic logic like today if the option is not specified).
> > What do you think?
>
> I would have named it just type since it is for WriteValue we should
> not need to repeat the write term on the flags, so Id would go for
> type="reliable" (reliable-write), "command" (write-without-response),
> "request" (write-with-response). Also, I assume this would force the
> operation no matter what the flags indicate so people can work around
> if the regular WriteValue don't work for some reason, perhaps the
> service is not really adhering to the spec or it is a vendor service
> just not setting the properties properly.
>
Yes, that sounds great!

/Emil

Return-Path: <SRS0=4ALD=QH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53536C169C4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Jan 2019 17:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EEED20B1F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Jan 2019 17:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFH2RYw5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfAaRqd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:46:33 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:38531 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfAaRqd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Jan 2019 12:46:33 -0500
Received: by mail-pf1-f181.google.com with SMTP id q1so1803754pfi.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jan 2019 09:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eeo2ZSA8IqB9JbaE8kW79o82x7hat5RASUxbOf+iKlk=;
        b=tFH2RYw5Zn5ENzkRVKedVZkFgywD3WLocKn8v/LSMQAmqvNXjRBw3sNlQNb9/GkRi+
         vucvkTx5KRkEM3IiWdTfv/ILcgYj3h5MF4/RHZOYYt2lKsKzC2VmuWiAGuSmsNSH5OGi
         wMd6d6T/VeXVc20Yn0UZCRyRr07clKJTh0NsJoGwAmw0d8l2GRiaEof2jH8lRa5iHN1I
         lqda8ghigQi9Ig48Mi2mRTIfcGrS1TFGwXoFIEew7YBUL0aiGbL6KxOp7BgFvSx+BN/h
         VWubDCZKm5s77x125CmzNLbauZs/BhCB0TpRhxEmvIed2iepgEKofqYUDvuu5nOsI7T9
         YcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eeo2ZSA8IqB9JbaE8kW79o82x7hat5RASUxbOf+iKlk=;
        b=FxnbcLxiUCMLp1zAQXvR5ci7vBKoFBc+723sz4ZYLQiFw3fqEq2stCnCecJtZnjeQG
         FE0IKiLWKPVd8k17L7fFH/Jzray/k+L2PJgXQN/UUmx5sEbObEHBN/jL/8tVBkyuUYhW
         bYQXsq22GSFB8wcmUMF/GoCyHMpZiIf7po5XSfNVbfRkQTPQvxBbUeFFTXj9ZQWaulyo
         8zb70xoMWYuC9majrsppbZ+wzoAvjwPS3FNBMrj0jwnDT4lQeWOdOjIodZ7pc6+9k6WV
         3QHBs/JqAEHUIwjLH21rcGsR5BE5ceU8fDgu3j2oWCzzJNRegJ0dRG3FEs9oMRZOLpnW
         WXHQ==
X-Gm-Message-State: AJcUukftG63hdq5iVs7nQuQb8RORFQmsMShRtVpW8YDjKglB+zxI3N/h
        S82bI5c4Ui11nrSnTKJlN3ac5Qi6QMB2tDEOan8=
X-Google-Smtp-Source: ALg8bN4D1iv/WP4ib1Xyv8aDfdVvDXzDWsPm6QnDBG/lxBAuGteecP0dVmDi4xdleGGzCX/UhWQZYNd6hIhwYCYQ2fg=
X-Received: by 2002:a62:1992:: with SMTP id 140mr35750906pfz.33.1548956792120;
 Thu, 31 Jan 2019 09:46:32 -0800 (PST)
MIME-Version: 1.0
References: <CAO1O6scUuK1K+zLjyQA12HtY9nNdR=Q8MeuruC2GKvaJPH0knA@mail.gmail.com>
 <CABBYNZJ8hqJph3DgFBdTPBpD5eqSvMHCsrwvNZx3z5v9Fbu3Vg@mail.gmail.com>
In-Reply-To: <CABBYNZJ8hqJph3DgFBdTPBpD5eqSvMHCsrwvNZx3z5v9Fbu3Vg@mail.gmail.com>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Thu, 31 Jan 2019 18:46:23 +0100
Message-ID: <CAO1O6sdp8j+DkawuMcR_X27Dt1VDyO_zc=cmQcYraea7oN=pLg@mail.gmail.com>
Subject: Re: Flag for specifying write type to WriteValue in gatt-api.
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Den tors 31 jan. 2019 kl 18:03 skrev Luiz Augusto von Dentz
<luiz.dentz@gmail.com>:
>
> Hi Emil,
>
> On Thu, Jan 31, 2019 at 6:19 PM Emil Lenngren <emil.lenngren@gmail.com> wrote:
> >
> > Hi,
> >
> > I was looking through the quite lengthy discussion at
> > https://github.com/WebBluetoothCG/web-bluetooth/issues/238 on the
> > issue that in Web-Bluetooth, only a single "write value" API is
> > available, causing Web-Bluetooth to decide on its own if Write With
> > Response or Write Without Response should be used, in case both are
> > supported by the characteristic.
> >
> > But in the Bluetooth spec about Write Without Response:
> >
> > "This sub-procedure is used to write a Characteristic Value to a
> > server when the client knows the Characteristic Value Handle and the
> > client does not need an acknowledgement that the write was
> > successfully performed."
> >
> > Basically, it says it's up to the client/application to decide if an
> > acknowledgement is needed or not, and hence it's the app that should
> > decide if Write With or Without Response should be used. The "client"
> > can't mean a bluetooth stack here since it can of course not know if
> > an acknowledgement is needed or not.
>
> There is a property indicating if write without response is supported
> though, but you are right regarding that not excluding regular write
> so at that point the client would have a choice whether to use it or
> not.
>
> > I noticed that according to gatt-api.txt, BlueZ has the same
> > limitation in the WriteValue method, in that the stack chooses the
> > write type "arbitrarily" if both write types are supported (or really
> > the Write With Response is chosen, which might cause unwanted
> > latency). Therefore I suggest that an option should be added to the
> > WriteValue method, for example "write-without-response" (bool) to
> > force Write Without Response.
>
> It gets a bit trickier if the attribute is in fact a control point in
> which case perhaps only write-without-response really works, anyway
> control points are better off using AcquireWrite.
>
> > Note how iOS has a write type parameter to the write method, and
> > Android has a write type property you set before you execute the
> > write.
> >
> > I see that it might be possible to achieve the same result with
> > AcquireWrite -> write to socket -> release but that wouldn't be a good
> > solution for bluetooth stacks built on top of BlueZ that would like to
> > differentiate between the two write types (such as Web-Bluetooth)
> > since AcquireWrite can fail, for example if two apps write the value
> > at the same time (I guess the lock is exclusive?). It also seems like
> > unnecessary overhead to open and close sockets.
>
> AcquireWrite is to be used when the app needs exclusive access, like
> control points such as those commonly used for things like DFU, I
> don't think that is your intent here (or is it?) so I guess adding an
> option for WriteValue is probably better. Note though that obviously
> one cannot use such a flag with things like e.g. offset as that is not
> supported which makes the API a little trickier to use but I guess
> that ok given that setting flags is optional.

No DFU etc. wasn't really the intention here.

I guess most (all?) people don't use the offset parameter. The reason
the offset parameter exists in the Prepare Write Request is so that
it's possible to write a long value in several chunks I guess. Anyway,
the solution is to simply disallow offset != 0 and
write-without-response=true at the same time.

By the way, I see "Reliable Write" is also forced/first choice if the
characteristic supports that (even though I think nobody uses it?).
The downside of using Reliable Write over a simple Write Request is
that it requires more packets/overhead so I was thinking that maybe,
to cover all cases, instead of having a bool "write-without-response",
it should be a "write-type" option which can take the values
"reliable-write", "write-with-response" or "write-without-response"
(or use automatic logic like today if the option is not specified).
What do you think?

/Emil

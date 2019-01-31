Return-Path: <SRS0=4ALD=QH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD99C282D9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Jan 2019 17:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67068218EA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Jan 2019 17:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NieD4LWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfAaRzY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:55:24 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:39860 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbfAaRzX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Jan 2019 12:55:23 -0500
Received: by mail-ot1-f46.google.com with SMTP id n8so3588604otl.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jan 2019 09:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0GOKmhWbx+xjg0mJOFK6ity3ev2QpaAcanXlPjFjrsU=;
        b=NieD4LWva5xT/CGY21yRe493WNsIeNK4//AUoBVxx199iUCg85PyCeW5o//ss3eiIH
         1JwrCYOHENheDACIbO/SP811cuG4YG0iAu+1L7iBxyLzFpmsvJCbLq0Zr9Enmsis9JMM
         OCyXLRkSNipvfY/o8iiZsWFt1wTG20/FA0sv7/fQ0mIuafWfrKuHJXkqi7SLOyZFtd4Z
         zPJmniEAByHu4jRH3I/VwSAKFjmAK8LD2AMXjBpFDJHTzQzS6jjT5szIIrXmLTbJYh6m
         4uTL82QyA1QBXRHbxw/X+507rRrS/lr83NpLr1nQYp5Pq1rtyPNEeqHx45jamGCER/J3
         E0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0GOKmhWbx+xjg0mJOFK6ity3ev2QpaAcanXlPjFjrsU=;
        b=it0XXJTkqO9BNu8ht1O7S5tGlQjtYNkRA8WxV4JrQQerTQvznAHfCLdK9f06RVm5fG
         sXO44qbxZKHQwC5yKQcEmtX5kjGqyq71s1gY2pPuU044T7hPA8Us2euDCVR3oUt74Qm2
         ftV+HksWp+IforNCT/sNprMro75focBazSwp4HubYpDXdjxMoJEU7TpNtUUUwflGnoTP
         Gb1zlDwDwV8QD/IeL7t/deCjafGW6//K5GhQe8d86xwQXa9PwifyPSl2uVIl27KPUd+R
         sWxcGm/+HJyWFLRN8mttgkohDsxQt/LJ9ed5rW4FZMGv5W558j7JvkMY6LBnfHYymT2B
         /rbw==
X-Gm-Message-State: AJcUukcRevJr/8VampB/xnw7t4V93m58MNF9LQrE9XomzCKcRHv3jFV/
        Ygh9ld4IdcXfbir10x8YwlQKBvpfhR6/SKsgBhVh2Q==
X-Google-Smtp-Source: ALg8bN4fgctFvS2vjlDAdn2kAe3QRFOlxvs1EiW8EaJNpszLhIjSaPAtGITeI7M3GhOpyOi4AxyqOxYTTWY2ycC1Inc=
X-Received: by 2002:a9d:d73:: with SMTP id 106mr25598601oti.291.1548957322693;
 Thu, 31 Jan 2019 09:55:22 -0800 (PST)
MIME-Version: 1.0
References: <CAO1O6scUuK1K+zLjyQA12HtY9nNdR=Q8MeuruC2GKvaJPH0knA@mail.gmail.com>
 <CABBYNZJ8hqJph3DgFBdTPBpD5eqSvMHCsrwvNZx3z5v9Fbu3Vg@mail.gmail.com> <CAO1O6sdp8j+DkawuMcR_X27Dt1VDyO_zc=cmQcYraea7oN=pLg@mail.gmail.com>
In-Reply-To: <CAO1O6sdp8j+DkawuMcR_X27Dt1VDyO_zc=cmQcYraea7oN=pLg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 31 Jan 2019 19:55:12 +0200
Message-ID: <CABBYNZ+hc8OVTPOiVEh30qQ=L4Bjv4k_S4eUFJiRT-71fL+LCg@mail.gmail.com>
Subject: Re: Flag for specifying write type to WriteValue in gatt-api.
To:     Emil Lenngren <emil.lenngren@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Emil,

On Thu, Jan 31, 2019 at 7:46 PM Emil Lenngren <emil.lenngren@gmail.com> wrote:
>
> Hi Luiz,
>
> Den tors 31 jan. 2019 kl 18:03 skrev Luiz Augusto von Dentz
> <luiz.dentz@gmail.com>:
> >
> > Hi Emil,
> >
> > On Thu, Jan 31, 2019 at 6:19 PM Emil Lenngren <emil.lenngren@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > I was looking through the quite lengthy discussion at
> > > https://github.com/WebBluetoothCG/web-bluetooth/issues/238 on the
> > > issue that in Web-Bluetooth, only a single "write value" API is
> > > available, causing Web-Bluetooth to decide on its own if Write With
> > > Response or Write Without Response should be used, in case both are
> > > supported by the characteristic.
> > >
> > > But in the Bluetooth spec about Write Without Response:
> > >
> > > "This sub-procedure is used to write a Characteristic Value to a
> > > server when the client knows the Characteristic Value Handle and the
> > > client does not need an acknowledgement that the write was
> > > successfully performed."
> > >
> > > Basically, it says it's up to the client/application to decide if an
> > > acknowledgement is needed or not, and hence it's the app that should
> > > decide if Write With or Without Response should be used. The "client"
> > > can't mean a bluetooth stack here since it can of course not know if
> > > an acknowledgement is needed or not.
> >
> > There is a property indicating if write without response is supported
> > though, but you are right regarding that not excluding regular write
> > so at that point the client would have a choice whether to use it or
> > not.
> >
> > > I noticed that according to gatt-api.txt, BlueZ has the same
> > > limitation in the WriteValue method, in that the stack chooses the
> > > write type "arbitrarily" if both write types are supported (or really
> > > the Write With Response is chosen, which might cause unwanted
> > > latency). Therefore I suggest that an option should be added to the
> > > WriteValue method, for example "write-without-response" (bool) to
> > > force Write Without Response.
> >
> > It gets a bit trickier if the attribute is in fact a control point in
> > which case perhaps only write-without-response really works, anyway
> > control points are better off using AcquireWrite.
> >
> > > Note how iOS has a write type parameter to the write method, and
> > > Android has a write type property you set before you execute the
> > > write.
> > >
> > > I see that it might be possible to achieve the same result with
> > > AcquireWrite -> write to socket -> release but that wouldn't be a good
> > > solution for bluetooth stacks built on top of BlueZ that would like to
> > > differentiate between the two write types (such as Web-Bluetooth)
> > > since AcquireWrite can fail, for example if two apps write the value
> > > at the same time (I guess the lock is exclusive?). It also seems like
> > > unnecessary overhead to open and close sockets.
> >
> > AcquireWrite is to be used when the app needs exclusive access, like
> > control points such as those commonly used for things like DFU, I
> > don't think that is your intent here (or is it?) so I guess adding an
> > option for WriteValue is probably better. Note though that obviously
> > one cannot use such a flag with things like e.g. offset as that is not
> > supported which makes the API a little trickier to use but I guess
> > that ok given that setting flags is optional.
>
> No DFU etc. wasn't really the intention here.
>
> I guess most (all?) people don't use the offset parameter. The reason
> the offset parameter exists in the Prepare Write Request is so that
> it's possible to write a long value in several chunks I guess. Anyway,
> the solution is to simply disallow offset != 0 and
> write-without-response=true at the same time.
>
> By the way, I see "Reliable Write" is also forced/first choice if the
> characteristic supports that (even though I think nobody uses it?).
> The downside of using Reliable Write over a simple Write Request is
> that it requires more packets/overhead so I was thinking that maybe,
> to cover all cases, instead of having a bool "write-without-response",
> it should be a "write-type" option which can take the values
> "reliable-write", "write-with-response" or "write-without-response"
> (or use automatic logic like today if the option is not specified).
> What do you think?

I would have named it just type since it is for WriteValue we should
not need to repeat the write term on the flags, so Id would go for
type="reliable" (reliable-write), "command" (write-without-response),
"request" (write-with-response). Also, I assume this would force the
operation no matter what the flags indicate so people can work around
if the regular WriteValue don't work for some reason, perhaps the
service is not really adhering to the spec or it is a vendor service
just not setting the properties properly.

> /Emil



-- 
Luiz Augusto von Dentz

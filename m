Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BDEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Nov 2021 23:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhKVXuE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Nov 2021 18:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhKVXuD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Nov 2021 18:50:03 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55C5C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Nov 2021 15:46:56 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id l24so40149749uak.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Nov 2021 15:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ISqQIm0LEGpc6qn3B8UrEYI7xQgZbRpmpXISgnY5OaI=;
        b=UexYV3iMSyn3/b6H/uwk17XxJqNU+tcsjy/YcxxeGS7XV9hwV/gBH5whYfiD8JOn39
         32b7PpHmQvSU/o65GdKbR8CcL96mdqF7hSStxVW2+XzA1LvEUecLfJjPWgCMxG+QKjmd
         S31cVR47b8CqkIuzGwLvlIXDxfRu7Fc6nzP1BGeZRobj7tas7ynQB01+h+POCdJmAKr5
         gQ55FstWEL0vog5GibWsQFrIyVbuWcB9re+ZuEjSdEyQcimF5WPjTAMnyQOpoQihz0oo
         L2s8T1yh7HGQFOv/H12cj9DU52qVG+oc56Blut17PsXTpGKDO7zPvg/G0YsM1AB7UE6C
         RwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ISqQIm0LEGpc6qn3B8UrEYI7xQgZbRpmpXISgnY5OaI=;
        b=hXUnBUKOA6PrbhthesJIy4PK/n9nqWWa0VvWxmQpmp7SIpraig7K7VQe/EtaL5PtE9
         W6EtETZX61qfYJ3Dnb2OONn9jYHC2eFBvJvJG+iybBfkpSWPxs5IHUGGWXAs50lLQD7/
         F5wsBUTTt8t73RO+JEnI363nN0t8byzrO87iTwXy371dbqqCY2KZB14jOU8CFdSSvDyL
         v4RHAFHLo8ciYvJCy2+a2fi25AKNz7C5qLQ1waue1JD9irOe6uoxHrarwxAY+6gdFXgj
         rw3ucs9f/MrRzSQYZfCxa+HmlOTMwf8z1e+nMi4KbVryXbZHDAFI7ZPkGjOIGrA/EazX
         J/wg==
X-Gm-Message-State: AOAM531rDXAaouwBvwzBMMdp/9UGyJrAqBKnaXA6e9I1fMeqySHVzMBS
        pjUnwNk4kotsbLt38YrJMKKu6gMJsmBuX+XG5EsC6liz
X-Google-Smtp-Source: ABdhPJwg1dk4VShfVhqhB1esFZN9HDs6bIIIyn5R4d/Qk3tpJjFyunthtJaKWJgkR6AWn7diIRYpLeJ7CIdZwCpVICY=
X-Received: by 2002:a05:6102:c06:: with SMTP id x6mr2018306vss.23.1637624815681;
 Mon, 22 Nov 2021 15:46:55 -0800 (PST)
MIME-Version: 1.0
References: <20211122211707.2219208-1-luiz.dentz@gmail.com> <45caaa82b56528fed03e534103f55f2ebbdc3885.camel@hadess.net>
In-Reply-To: <45caaa82b56528fed03e534103f55f2ebbdc3885.camel@hadess.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 22 Nov 2021 15:46:44 -0800
Message-ID: <CABBYNZJgpB8Y9gc92BupiBBkjyPf5SNkOBpp6B1qtYktxmAb_g@mail.gmail.com>
Subject: Re: [PATCH v2] uhid: Remove local copy of uhid header
To:     Bastien Nocera <hadess@hadess.net>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

On Mon, Nov 22, 2021 at 3:06 PM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Mon, 2021-11-22 at 13:17 -0800, Luiz Augusto von Dentz wrote:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > uhid.h is part of kernel uapi nowadays so it can be included
> > directly from linux/uhid.h so this removes the local copy to use it
> > instead.
>
> This will cause the same problems that importing those headers into the
> repository was supposed to solve. If you remove those headers, then
> older distributions will be stuck on old kernel headers, and bluez
> compilations will regularly fail when it uses new structs, struct
> members, functions, or constants that are in the upstream uapi headers
> but not yet propagated to the user's distribution.

I'm not following you on this, the distros don't have uapi headers
that match their kernel release? Afaik being a kernel uapi means these
APIs are considered stable and I suspect they haven't been changed in
a while, you are right that this introduces a kernel dependency if we
were to use new members but I still think this is better than having
copies that at some point goes out of sync, specially when nothing
indicates that things like input_event was not accepted by the kernel.

> Strong NAK on this one and the uinput header change too.

I didn't introduce the usage of any new symbols, so the only new
requirement is that linux/uinput.h and linux/uhid.h headers exist, I
could however rollback if we have another way to check if those
headers exists use then otherwise we can keep using copies, perhaps
move then under linux/ directory, anyway it is not like we don't have
kernel dependencies already and we actually have been debating on
having the bluetooth socket definitions as part of the uapi instead of
libbluetooth, so we will need to sort out how we can update the
userspace parts with new kernel interface without breaking the build
on systems that don't actually ship with e.g. linux/bluetooth.h.

-- 
Luiz Augusto von Dentz

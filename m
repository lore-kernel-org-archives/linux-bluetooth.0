Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5375C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Feb 2022 18:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbiBVSg1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Feb 2022 13:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiBVSg0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Feb 2022 13:36:26 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AD48F63A
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Feb 2022 10:36:00 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2d6d0cb5da4so129879127b3.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Feb 2022 10:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r9CKGbEAk88zvxC0Ml+jtVeOdq/JkI8Z9poWa1khDHA=;
        b=DMMapXSWkq3f6OFNJmh6bYHyYQiUZG5JHOFx0SSmDf3FgEWOhDZOdmhQ6vcbm1m14/
         VrJpSK578ITVF8nsa1uWghJbSo8bZRQsYHe3ygfAs23bTVevkcB6nZREDWuWCaSziYrI
         1qylAZwUtk9oQP5+Zp60fNWXlcuqdI6noPHlW9GAcXAG03wF8K9pkFqLTpyWK0Ol1mF/
         hrwakvcKErZnGUMEL9YRzkqGPK1ulMogYFjDEWm/nj28Kwkm/jlgBhXKP3micSDq8CEK
         fPeQ4srikwEQAOgE5RmTj6G3nwp7goZt9bqh2zuKrDLGgmCxKBRp8U2SDPc/uOwMs79A
         IoFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r9CKGbEAk88zvxC0Ml+jtVeOdq/JkI8Z9poWa1khDHA=;
        b=d9psnjprdsrfe3XcreQ7EblEFoQ0ocYilc1DvLriTO4SbJfgFXzSpgMcRk1htMMiU7
         vRzvJihQtYWbUCsJEc3pgk09IRvFu0+l9lYn6edgD9tDpv7NKmQqPRCRCBSIy2i4kIaD
         CVzjuPnIM+7NRqi2L3cDz/53ww3Bq351EvSxcguLrrXDrD1Ju7tMDG+hIfMvHCfJiYAv
         Ju+iz/iuwlZKWkPzYI0kwnJ49A5hy1MxZZ2L/carAFQmngYQiXtQn4InQpiY0qjmPijS
         PyjLk/2acqprzeoc0nA4Dsk4q7AlcrvKbozBzJOH0s43FuzsNxEn3HGuZZzfZ3QavLb2
         HDHw==
X-Gm-Message-State: AOAM530uDSnetecSyzFkJZlUfdisDWqJU7C90TSwy+klLmQ/iKzJbsIN
        vxPSTW5Gkl34pyF+GReBuv7NGDQf3bz3G3vSv5c=
X-Google-Smtp-Source: ABdhPJzUBYNdTyZfvEbE+r9Eki1zLrV/fVpQoiw+BkFnmEgUd7tceCKQ+x9q0rM7+/dp9AIIwDZYd/pqGqw6Ser35l8=
X-Received: by 2002:a0d:c781:0:b0:2d2:d059:19c1 with SMTP id
 j123-20020a0dc781000000b002d2d05919c1mr25484190ywd.376.1645554959561; Tue, 22
 Feb 2022 10:35:59 -0800 (PST)
MIME-Version: 1.0
References: <f648f2e11bb3c2974c32e605a85ac3a9fac944f1.camel@redhat.com>
In-Reply-To: <f648f2e11bb3c2974c32e605a85ac3a9fac944f1.camel@redhat.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 22 Feb 2022 10:35:48 -0800
Message-ID: <CABBYNZKWpPvJvKefgjw5YXCk9BL7900X+XnobLS6gw+50wKNfA@mail.gmail.com>
Subject: Re: Since commit e8907f76544ffe225ab95d70f7313267b1d0c76d bluetooth
 scanning stopped working on my system
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Maxim,

On Mon, Feb 21, 2022 at 7:14 PM Maxim Levitsky <mlevitsk@redhat.com> wrote:
>
> Today I updated to a new kernel and I am bisecting few regressions:
>
> I noticed that if I open GNOME's bluetooth setting, it hangs for like minute or so,
> and then shows only the paired devices and no scan results.
>
> I bisected this to this commit.
>
> For reference I am running fairly old fedora 32 on this machine, and thus I have
> bluez 5.55 and stock GNOME from fedora 32.
>
> I can provide any more info on anything if required and/or test patches.
>
> I wasn't able tor revert this commit as it is part of a bigger rewrite of scanning
> which makes sense.
>
> I tried merging bluetooth-next master as of today,
> into my kernel but no noticeable improvement.

Is there any error being reported in bluetoothd, does bluetoothctl
have the same problem? It would be great if you could provide an HCI
trace of the problem.

-- 
Luiz Augusto von Dentz

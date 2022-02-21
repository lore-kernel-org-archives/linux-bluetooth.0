Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFCEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Feb 2022 17:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381505AbiBURNZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Feb 2022 12:13:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348967AbiBURNY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Feb 2022 12:13:24 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E8B6411
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Feb 2022 09:13:00 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id j12so35720188ybh.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Feb 2022 09:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4EExWLmR4eMXDmUVgaOH7DePPuISp3X4jtEynHj6ffs=;
        b=dtoEoWi9MSz0mZUA5M6Rzpja98+WS3YV9RMVX844gyTh610dmgOesDFtgrt56YyCrh
         vW8vJ8ilJnxa+WVskTbKKM2nCmF0JXsEDJmdyLkjqPie3/qxkv5c91ZKJazvZZ/4n9Vd
         sRSXPLY04t0ysfLa5FaitX2seAtPnWmIFfO2XR62gvuyFyg2HQyvuNKWoNlvh/u7KlVD
         APunvFkvK/gkqizFn6rnsaSPyKc/MPmt+egWa05EWu6wyvB9TffZBGPoJ+/5zwCfpkY8
         a9EppRsELrYfvNVB4yQudF+TVGVQqfWAL9EuCjntuCulOS2xMDwp4zaMNeXbBSw97C65
         3w9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4EExWLmR4eMXDmUVgaOH7DePPuISp3X4jtEynHj6ffs=;
        b=zuvdl5OUhZJrhGTqDc980o7fskZjhhXAChxjtiB2FgYV8MPRoDjtJ+WVJecqpIzFze
         KJUybW3gw9pQxvQdzH9cdyRSe+ww1UV3UbXrkBAjzD72xMSVTAPrCCsxYjbFjE5uZJKk
         DHuD47N/SAWOn31oPKvmTRCZ25ha+3M5qO5jt3L/zBa8N4QdiDYuTWgtJJWDQRsrHodM
         FwQ54XhMWZNzslNwr9Z07SAJcADdsDSt41K5nkRxmKq/lBkeMjUL8pQdVmIstKEJlMfO
         Ds28NI3yeVcTtBLfyo3KRpLdVzblKvjLM+7A0DEl6G/4oP4r32kihGFbU3aB2m6bKinc
         83cA==
X-Gm-Message-State: AOAM530qlYlOz1tFcDIuBKxFAdu74yYZLrNRv2Zm8Sts2Em/uvDyjIlH
        HNMDXGSQwIfIgP57MyEGGhNI158Jrkpf/HGWWe0Q+iO/
X-Google-Smtp-Source: ABdhPJwFJ/IxbsbO+o+7W4XuwuXKY/AbXhhwpCqjIvacwZT+vkA68WK3kWiw/DTM2K6do30IjOYdRWC5DsFf0If1+vk=
X-Received: by 2002:a25:8546:0:b0:61e:1d34:ec71 with SMTP id
 f6-20020a258546000000b0061e1d34ec71mr18830684ybn.259.1645463579391; Mon, 21
 Feb 2022 09:12:59 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i+RE+L2FTXSA@mail.gmail.com>
 <CAJCQCtTdiPNkV1_b478_LkG11TMOPEdDGHTjf5LfZJpwWrK+bg@mail.gmail.com>
 <CAJCQCtTNk25u6sm_Xqt8qzf7mM5kmOrnXyD6pT1GKJ5z5-Kqbw@mail.gmail.com>
 <CAJCQCtRYKbTQ16eUq2qODZ=dE=HB6pZpLNswdqMbiWw+DBE9KQ@mail.gmail.com>
 <CABBYNZKfy-ntFhbx0TStNwFiwxCF4sPVaHS4wDbef0shb=pawg@mail.gmail.com>
 <CAJCQCtRiTQ1BTEHugxhS-zmXFG4qi4WLxsRyZsG9-_Q0isM+7Q@mail.gmail.com>
 <CAJCQCtS35JeABLDBaNpfgxjq+ZJ9rZgwtRnSYLNm8tMwtdYGMw@mail.gmail.com>
 <CABBYNZKTSe83iP4tm36we4cpAbeGUbEw9frZD1wCM9yo1zry5w@mail.gmail.com> <CAJCQCtTpHQe2co3fLNs5csKQchmwH=3YwQOvFnuc2nhjRseVnw@mail.gmail.com>
In-Reply-To: <CAJCQCtTpHQe2co3fLNs5csKQchmwH=3YwQOvFnuc2nhjRseVnw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 21 Feb 2022 09:12:48 -0800
Message-ID: <CABBYNZL3ARfn7DkQ7n_P-NqHvThdB+EbeKoHkEEk1i0g3iZVeg@mail.gmail.com>
Subject: Re: bug kernel 5.17, qualcom and intel adapters, unable to reliably
 connect to bluetooth devices
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Chris,

On Thu, Feb 17, 2022 at 7:49 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Thu, Feb 17, 2022 at 5:15 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Chris,
> >
> > On Thu, Feb 17, 2022 at 3:36 PM Chris Murphy <lists@colorremedies.com> wrote:
> > >
> > > OK I started over, and for now keeping the reporting constrained to
> > > the hardware I personally have on hand.
> > >
> > > Hardware:
> > > Lenovo Thinkpad X1 Carbon Gen 7
> > > Bus 001 Device 004: ID 8087:0aaa Intel Corp. Bluetooth 9460/9560
> > > Jefferson Peak (JfP)
> > > Sony 1000XM3 headset
> > > bluez-5.63-3.fc36.x86_64
> > >
> > > kernel 5.17.0-rc4
> > > * remove the paired headset with bluetoothctl
> > > * reset the headset so it's not longer paired either
> > > * put the headset in pairing mode
> > > * GNOME Settings Bluetooth panel sees -> LE_WH-1000XM3, Not Setup
> > > * click on Not Setup and nothing happens
> >
> > Well from the logs it doesn't seem the GNOME Setting is trying to do
> > anything, have you tried bluetoothctl> connect <address>
>
> `bluetoothctl scan on`  does see the device
> $ bluetoothctl pair 38:18:4C:24:2D:1D
> Device 38:18:4C:24:2D:1D not available
> $ bluetoothctl connect 38:18:4C:24:2D:1D
> Device 38:18:4C:24:2D:1D not available

Well you are unable to scan the device you won't be able to connect to
it, are you sure the device is discoverable?

> $ journalctl -b -o short-monotonic --no-hostname | grep -i blue
> https://drive.google.com/file/d/1x9EDvDx6XUowyRy2056n6uW-4PLx5KRb/view?usp=sharing
>
>
>
> --
> Chris Murphy



-- 
Luiz Augusto von Dentz

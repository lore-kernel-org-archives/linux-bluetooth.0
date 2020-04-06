Return-Path: <SRS0=77es=5W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E250C2BA19
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 09:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E9E2072A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 09:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzkzqr+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgDFJfY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Apr 2020 05:35:24 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38146 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgDFJfY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Apr 2020 05:35:24 -0400
Received: by mail-io1-f65.google.com with SMTP id e79so5195920iof.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Apr 2020 02:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sZzC/TcAbQMO3HRRA+7o+Hnn5xiNU4E7Hlm1+Ahj63E=;
        b=hzkzqr+4BmQ8ryaXUVMf2G5xfGYXFeSb7pdk8B0CjUI+Cm9kEENTsnok3l4pIIguaH
         J32Pj7t+nZ1p9sNg/Fn27VOQExvKBPqJ29IUTv0mmgkxY/43BcvSTXfsOXqP6xW3XTJL
         selHqaDUNsqeViEJveGym8IVU45JnORyBv7vKzb3ar5vgo2gKKyjZVHelwl2SpQWECkC
         LoZaJCia6IH3gx92JQUZ4rXxbpLfiWh6IsLrAku2/4Bh0laPE4jjXyzYe6lONK7ncl7o
         q2Z9GZCbnKHwAMkp1fRCFU/IG8jficNmqpTSPSxolJBuWZB2pw12EVXC7w04erU76KtS
         JSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sZzC/TcAbQMO3HRRA+7o+Hnn5xiNU4E7Hlm1+Ahj63E=;
        b=S5tpV2HAKhAzfFtadeDNpJVOc5gLx79sUhqiZG9nfcbcizF5xH8sp1Evzz9fVOtpe5
         vrWr/j9GLXbY62s5ZdqbUru2s11moYvp2RskwVfeNm9wCsRU6sU37KjNyF959tV0MPmZ
         MVScbYpdsskliQHBZnkjgbFzcUmAN25amqpANcXv5Yv7TbA94x7gizdCAZFxAcVfEca5
         52LPBk5D0qkMRBA5pfvQj5zu5hZD7xl6inDj2rLRB1xVi+lY0WBPXd2O7kIkzqqx1gei
         Pb0g0vPQP6Jl5s46HRlJPnGKWMsAhlqqo7TK0IlLmlD53OOhse/kq7M6reG50Q1/Jid/
         Ggow==
X-Gm-Message-State: AGi0PuYaIasazXuZkdMAObya2WMaza8NE/XRkLSfnI8K41xcTaMdBYt0
        beFlsO2lFElc9pOUdOPfrm9zNU3zwawVVwEYrvs=
X-Google-Smtp-Source: APiQypJqnXkODYoZ6OjdxDhbIXMkRvlDbMyyp4R5uw0JA8Z6gJbi+4LLV8QDL2K49ikdLJAHEmmJ0Q8dx4aZ+zLoAmA=
X-Received: by 2002:a6b:3111:: with SMTP id j17mr9602504ioa.17.1586165723110;
 Mon, 06 Apr 2020 02:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200402152758.10363-1-sathish.narasimman@intel.com>
 <20200402152758.10363-2-sathish.narasimman@intel.com> <59EE263D-87B2-42E0-A5EA-9F261BAC29BC@holtmann.org>
In-Reply-To: <59EE263D-87B2-42E0-A5EA-9F261BAC29BC@holtmann.org>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Mon, 6 Apr 2020 15:05:12 +0530
Message-ID: <CAOVXEJJRvzsWjTL4Z7eLyqfjFPb7rMXmHnqp_Ux7ZvnyXMMEGg@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] bluetooth:btusb: handle msbc audio over USB Endpoints
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Sathish Narasimman <sathish.narasimman@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Hsin-Yu Chao <hychao@chromium.org>,
        Amit K Bag <amit.k.bag@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel


On Fri, Apr 3, 2020 at 11:24 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Sathish,
>
> > For msbc encoded audio stream over usb transport, btusb driver
> > to be set to alternate settings 6 as per BT core spec 5.0. The
> > type of air mode is used to differenting which alt setting to be
> > used.
> > The changes are made considering some discussion over the similar
> > patch submitted earlier from Kuba Pawlak(link below)
> > https://www.spinics.net/lists/linux-bluetooth/msg64577.html
> >
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
> > Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> > Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
> > Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> > ---
> > drivers/bluetooth/btusb.c | 155 +++++++++++++++++++++++++++++---------
> > 1 file changed, 118 insertions(+), 37 deletions(-)
>
> I decided to look at these to patches and fix up a few things.
>
> 1) Use conn->setting & SCO_AIRMODE_MASK to select the option and with tha=
t also ensure that we don=E2=80=99t send this for ulaw and alaw air modes i=
f they ever get established (even if unlikely).
>
> 2) Fix a bunch of coding style violation
>
> Please test these two patches if they still work according and then I can=
 apply them.
>
> Regards
>
> Marcel
>
Tested these 2 patches and they are working fine

Thanks
Sathish N

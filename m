Return-Path: <SRS0=e/tT=4Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E05C3F2D2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 18:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D13246B0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 18:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EI6EXXt1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgB1SFJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Feb 2020 13:05:09 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38478 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgB1SFG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Feb 2020 13:05:06 -0500
Received: by mail-oi1-f196.google.com with SMTP id 2so3709641oiz.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2020 10:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qUjyDjjlfB46s58Rpq2BTAdX7moW8SLzvVpcgZmlcao=;
        b=EI6EXXt1gWHCVJhK5n2+YRmtqI6Cj/nRYYXOqIKVLnNf0zlnY/PX/Av7VoTBIdbRjh
         Jl5iEeVnNeHC65/vusUP15OqZHFZfxQ41N6s/NwAbkCvvQoTaeCOtpn5/Qq3UGeIJhNg
         z12zb6gHc3W/TLgnqc+rZFEc1fJCgEkUSZE+J+GL66a8EaL9PV9Ol4OdXsubGiKq2Xmf
         xxObF0tWHXeznLIAcduam3TvlEsWTgqiJbA323kugWwT4jj1c66F4RQxFC7Cn6ZTrV6f
         wkmisGB1B932t6T7XSMfiLY+OsQI08Opmo+RiDq4FhdI6affwMruLezRp/BdquAQe6IF
         NePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qUjyDjjlfB46s58Rpq2BTAdX7moW8SLzvVpcgZmlcao=;
        b=acsfDpUFMYmEQ03q9L8qriijT+M9haPF+5na8SZ6ylR68q2Ijm9i8UiqJYP7HyZRzv
         MINmrA1xbpZp8MP/nDc7t3QmgZzbiD4w7It70S4Mn3kjc4MLFnYdA2ztk6MIstCrYkiW
         ZUHvRbTQHkumBXDrwEX5nMtp3i0SOvPuFcFzD21O4PSmMopZ5zKLC0J4fQjFAr0ItNcG
         ND6rlhwolWVg0/0Hf41HR9hLtn23KmzwvV6PPI+uM1xfgYjpnZcx/fKkWjqTocbAiIiH
         NxITgbdQVYigLZ/PrWFflNdk+roV/mfiivc+nQ3keB16aBe/jj5Buz4ef2vsWOpFwkPs
         bazw==
X-Gm-Message-State: APjAAAWka6TDLN5JtP8m9CtxYPopYloZaGdVso4nEq89VHSnH9cGupDU
        hh/O3DJusKs0T2+uo6RmdMGFpcUkyJw0oN1UOdFa1NGl
X-Google-Smtp-Source: APXvYqyJHRecHna6AeYit3LgDs2+XMrpikRrwc3FBGvWaFZAAbrj0z9ACrQcQAOpRJsuDB0sTSskAqAHVGiOvqGo8sM=
X-Received: by 2002:a05:6808:98e:: with SMTP id a14mr3870150oic.8.1582913105740;
 Fri, 28 Feb 2020 10:05:05 -0800 (PST)
MIME-Version: 1.0
References: <20200225073437.11212-1-luiz.dentz@gmail.com> <6F27945C-88B1-4F11-BE40-57125E0A8DAC@holtmann.org>
In-Reply-To: <6F27945C-88B1-4F11-BE40-57125E0A8DAC@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 28 Feb 2020 10:04:53 -0800
Message-ID: <CABBYNZKKkVqg9h_dXDeYC50YDfKNjd+R0fg0-ojCZy_+Fcfznw@mail.gmail.com>
Subject: Re: [RFC 1/5] Bluetooth: Add BT_MODE socket option
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Fri, Feb 28, 2020 at 12:20 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > This adds BT_MODE socket option which can be used to set L2CAP modes,
> > including modes only supported over LE which were not supported using
> > the L2CAP_OPTIONS.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > include/net/bluetooth/bluetooth.h |  2 +
> > net/bluetooth/l2cap_sock.c        | 64 ++++++++++++++++++++++++-------
> > 2 files changed, 53 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> > index 1576353a2773..c361ec7b06aa 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -139,6 +139,8 @@ struct bt_voice {
> > #define BT_PHY_LE_CODED_TX    0x00002000
> > #define BT_PHY_LE_CODED_RX    0x00004000
> >
> > +#define BT_MODE                      15
> > +
>
> can we postpone this change. I like to get your patches 2, 3 and 4 merged first. That way we can do some initial testing here.

Sure, but without this there is no way to use the new mode from
userspace, I could perhaps make it condition to enabled_ecred, how
about that?

-- 
Luiz Augusto von Dentz

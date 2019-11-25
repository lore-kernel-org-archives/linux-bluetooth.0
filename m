Return-Path: <SRS0=LhHL=ZR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1668C432C0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Nov 2019 12:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932B720863
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Nov 2019 12:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qTQ08Az4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfKYMlG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Nov 2019 07:41:06 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39573 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfKYMlF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Nov 2019 07:41:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so14724706wrt.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2019 04:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YC6GgXhvDqK3KuJ1zNfssrAFRF4tIpatp2t0FHXg91E=;
        b=qTQ08Az4xt87bEfe0uAzQYoE0QE9JGN0wbbUE7N/GN/Q7MuQ0BzJHGZ+LyNEDgVSt3
         fymS1MMSQxnXmD9G3P8KMuTY7jw6X2kTsrn/tzBvmDgBfRLXhSlQvnD8imhXIHHT5byU
         +SSr+rFBhBF579//D0GKJY91FRm8J4aEXOjiHKmU8GEFq0edNBiHtTQmMa0NXG2jw1/p
         kUbsoVt++EaaYhw1/dinAQnQJHEIS3WiZCu+6ksCmwzMFcwn+0btDr8PLv0CJBKX8ntD
         6m8Y52jHvzCiPdeTs2NYzkYqYuXu4fOxTMwu7kY7EYD7bhvh/GyEe5jZ+7YIrKlixZEQ
         30cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YC6GgXhvDqK3KuJ1zNfssrAFRF4tIpatp2t0FHXg91E=;
        b=uCnr/WNZ7Kxo3W0dn5zZi+99XBrAL0ptIO+oMrv2cThGEVfVCAIfVclNjK7V5cG/E7
         LJCqwk2NNfuoj2Amc4PaoODJQNulUHALStJt7Z2lX0cR0w/4+f+wUHP4880/NweSb+Ze
         OPEWLnX7VL+IYYGeqqHghMu6+UJhExPznGNJkFZpc1WcWLWy0dLXwX7BcCWD9CaD0Nbu
         yZbobthSSNRS1tQgHXXqw/2/K6HQkCxmF/O5qHzmhZE/NoOjJkZhflppmJouc06zMC1r
         2RkwwI6+becKrPBwnTEnRzb/TEcNStvz6t0ax2EG11yZETSu3e/cOTKBhFKL3m2SBQYC
         PKDw==
X-Gm-Message-State: APjAAAVRbzXK/ObQan7uv66FflsEp7nnylkOPASfRjomCFOa2ViMhbdP
        Fun2gw+QU370zThDUfSEFaw6r3eQSHQqeA2R9Ot9Dg==
X-Google-Smtp-Source: APXvYqwgFlSbbBiUka5IOkhKkxxAHxWWuNrJVPVTA3z3YupbWi46oO56Hy5M+ONUcru244JxQlS5xIq1mp+JOxKh0dg=
X-Received: by 2002:adf:e911:: with SMTP id f17mr32946834wrm.300.1574685663091;
 Mon, 25 Nov 2019 04:41:03 -0800 (PST)
MIME-Version: 1.0
References: <000000000000109f9605964acf6c@google.com> <20191101204244.14509-1-tomasbortoli@gmail.com>
 <E16896E5-B946-450F-BF42-04665D219EEA@holtmann.org>
In-Reply-To: <E16896E5-B946-450F-BF42-04665D219EEA@holtmann.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 25 Nov 2019 13:40:51 +0100
Message-ID: <CAG_fn=Xqb1KoAvV==F5sODUYHDsxCxaz72n6qucdkR70XGCkig@mail.gmail.com>
Subject: Re: [PATCH] Fix invalid-free in bcsp_close()
To:     Marcel Holtmann <marcel@holtmann.org>,
        Tomas Bortoli <tomasbortoli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        syzbot+a0d209a4676664613e76@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tomas, Marcel, Greg,

On Mon, Nov 4, 2019 at 3:20 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Tomas,
>
> > Syzbot reported an invalid-free that I introduced fixing a memleak.
> >
> > bcsp_recv() also frees bcsp->rx_skb but never nullifies its value.
> > Nullify bcsp->rx_skb every time it is freed.
> >
> > Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> > Reported-by: syzbot+a0d209a4676664613e76@syzkaller.appspotmail.com
> > ---
> > drivers/bluetooth/hci_bcsp.c | 3 +++
> > 1 file changed, 3 insertions(+)
>
> patch has been applied to bluetooth-next tree.
I believe this bug requires stable tags, as it can potentially provide
an arbitrary write (via __skb_unlink) and is triggerable locally with
user privileges.
> Regards
>
> Marcel
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller/E16896E5-B946-450F-BF42-04665D219EEA%40holtmann.org.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

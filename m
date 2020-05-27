Return-Path: <SRS0=nKc5=7J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D354C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 May 2020 15:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D97A620776
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 May 2020 15:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGVkSHr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387467AbgE0PtI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 May 2020 11:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgE0PtI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 May 2020 11:49:08 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5527DC05BD1E
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2020 08:49:07 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id r12so5085279ool.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2020 08:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RA0ORo2hEWbjZ+p2Reh5Jbg3LvAZ9GQ82ur7MO/qXp8=;
        b=kGVkSHr9dMCPHIvqrL9h0TeyEKf79ZcC5xCa+kFgpaPOrtHyaF5KU6Ms+oxT1rnG0p
         cm3rHf1NVZ20sVyZl3aVrBxMEAfAduA7DiqiVx661JyAn6mmok6gUiyWmSXnWP/BRkK5
         su2CZwW+UG8PUrt+bF5AiirPkvPPS9qkCV/Qs5VfTaa+CLUExrcGsc8q9v7mDFzicdTh
         9MyGhSJqN0RTF8DdEtaynNG89qEj8pwPl4lBjR6+cM0HkKtmyIOqcdexCAeAAAtWQQBi
         wzQDGwD1XRAmXw8E3r4Pj8dFI46ze/mCqnQcqCHu0WB6CZc3wmoLDzGMsXNdkajJ/lZr
         g78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RA0ORo2hEWbjZ+p2Reh5Jbg3LvAZ9GQ82ur7MO/qXp8=;
        b=JkW+emh1bCWoPDrpfSjh3W7fgAVdSrgOTRYN51RR5iuqSPiTJLO4nHcnMjgUdw2vzv
         vyyJUWeHGYN9zS1TGFC9plW16ZtNPrbfg+Mb1I245GOluWnqOD/F2MEMex8wMWZ8Lg3q
         OiGhyr4NxqROhtgJ/2aK1/3iqQzXTqpNJdlCEhJYRxEspqf3w/CJArQxKFST5WwXVXAz
         /OEmqIRi1J27KkTeexlz8bmzGbGTsoC5OpeJE61pebveyWtzzmJOhjxlbRStwB8Can7v
         GI+0yVM4Ch+dZAkJ3SdORoaG50ZjKGXjJcu1TT8iFsJGSnlARH8nk/oxr3RyI37w6O4E
         cfXw==
X-Gm-Message-State: AOAM530ypGvqcG2nJ9Hc2RnFUe+ThndYRKO5vcdYYy+wzVE71YpWpWIE
        hTq7As4PvZreCowWjm7QaeFmA3Q1o1mbb9tZQYE=
X-Google-Smtp-Source: ABdhPJxyjjUu+FWhicVqGW4qXOxkwZ/3TLX+6NVC4M3xyRdenAQnjxFV7j9juv42I9AhILiCSkGbvgxSpCOcRp3gvkI=
X-Received: by 2002:a4a:3b04:: with SMTP id s4mr3588851oos.35.1590594546608;
 Wed, 27 May 2020 08:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <B6A143FD-717D-44F9-B62F-17CF357961A1@holtmann.org>
 <20200219120940.1509224-1-david@ixit.cz> <20200419234937.4zozkqgpt557m3o6@pali>
 <177c5794-1cd7-8f76-b66f-e9473ed37a31@redhat.com> <CAB5wbS97WQTduY9sKgiLjAnpsmka+9hGQOBDdbAEHgkcwnze1w@mail.gmail.com>
 <CABBYNZ+TQ+oSYgL1wGsC0rs9faecd0RtQkFE9fbnV89D1r=LOg@mail.gmail.com>
 <20200516075340.3z37ejs3fuhctunl@pali> <CABBYNZLWsYHeOo3_+hcq4r+gY_0sLBQhftW7My7Y4D1n9o5jxg@mail.gmail.com>
 <20200518165011.jfarrp5mtqoy3mqz@pali> <6da08b42-34d5-9d20-bfc1-161cc8d0f2ea@igalia.com>
In-Reply-To: <6da08b42-34d5-9d20-bfc1-161cc8d0f2ea@igalia.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 27 May 2020 08:48:51 -0700
Message-ID: <CABBYNZ+myxfFmobLuzGeYfP_G5tM_ptKgCQCmpQCiUkPZYemuQ@mail.gmail.com>
Subject: Re: Bluetooth: Allow to use configure SCO socket codec parameters
To:     Ujjwal Sharma <ryzokuken@igalia.com>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Andrew Fuller <mactalla.obair@gmail.com>,
        Aleksandar Kostadinov <akostadi@redhat.com>,
        David Heidelberg <david@ixit.cz>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ujjwal,

On Wed, May 27, 2020 at 5:19 AM Ujjwal Sharma <ryzokuken@igalia.com> wrote:
>
> On 5/18/20 10:20 PM, Pali Roh=C3=A1r wrote> ...
> > AuriStream works also in HSP profile and I already implemented
> > negotiation for AuriStream codec for both HSP and HFP profiles.
> >
> > The only missing part is to unblock kernel to allow usage of AuriStream=
.
> > ...
> > AuriStream does not need HFP, it is available also in HSP. So missing
> > HFP should not be a blocker.
> >
> > Anyway, my HFP implementation is there:
> >
> > https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/merge_requests/2=
88
> > https://github.com/pali/hsphfpd-prototype
> >
> > And people are already testing my HFP implementation with pulseaudio
> > integration.
> >
> > So, we can continue at kernel level, as this is the missing part right
> > now.
>
> Reading through this thread, it seems like Pali has alleviated all
> concerns regarding the patch. I would like to ask what still remains to
> be done in order to make this patch more acceptable?

Testing is one thing but for production we would need a qualifyable
solution, that said I wouldn't oppose to have the socket option behind
a module options (runtime) or Kconfig (build-time) so people willing
to run this code can do on their own.

--=20
Luiz Augusto von Dentz

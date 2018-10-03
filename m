Return-Path: <SRS0=yBkr=MP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2FCC00449
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Oct 2018 07:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F62C20835
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Oct 2018 07:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sm3s+z0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F62C20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbeJCObx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:31:53 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35060 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbeJCObx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Oct 2018 10:31:53 -0400
Received: by mail-ot1-f65.google.com with SMTP id j9-v6so4625698otl.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Oct 2018 00:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UK7Yq0/gtcbgMUxR+X8U9SjDDZYEDGwrFWSOG5I3cvc=;
        b=Sm3s+z0+tAmox12/otgtsQtVPNujX2i55dD0gyVKv1tzFxWaM0qAYWhV9NRK+mVU2m
         qORDnP1eHEonNZ67vIHahS1jkg5hm90EvBsoHBeYy6QJz/+PQyK0853SmFr9dXCgNGjN
         eTQi/LZzjZk4CE587GMciw40S2fNVA+RJ9gdeXNfo46ELhjMF835bs8uo5vvuIgPZS9o
         d5ozkZnD8AZlJzeGVtbCS8opIL0eljTQ7EE2RqcDrgfZffYAuHyGJ5p9zeaOxbyqkeTB
         oMtdsye027mQorepMsqUOJl5vXnMbIWmnNkoiPzeoL5jvNlDOxbuPYwV8DOkBdD6H00/
         Jydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UK7Yq0/gtcbgMUxR+X8U9SjDDZYEDGwrFWSOG5I3cvc=;
        b=EeJmwYe2DJA+H0qdnJ1riurYlLyIZ5rQhVybJrO4ICOFpCwZ526Gyan3jxapDdwxDX
         JQzJSktvLlxv75bai9cWQ5UpPal/DMO+psmnp38yV2iMFvXAwyNz7e1ZELIK8A5Q8Gky
         ov+zj8z0LoOFnvGabAl+KY50U3Zi2YBY2a6pkNdRXB6yxleh+HBwNuajhfoRDcDrTCCd
         NQp28rqX/YGm5/VzU3tAzm7QRMJCElWS68ITx3q8NeabXSEYQgzGyF14BGfOJoan5Jv3
         kyIcwpMpF6qAOoigCZF+LjyyaJLJ1EtqrWBN3juyzmMaLeUWCxTw59S/kc9pKX/3iCtJ
         vXmA==
X-Gm-Message-State: ABuFfohRtHiX1YP9PeBbxey7TRgQQ5Z8Y0uBtZqROyozmwGAavcsuYEl
        hL6eg7euorWHYEY1AyASdQyrbGut1UITZa9c1PCH5A==
X-Google-Smtp-Source: ACcGV60cHbREieYQSAJ+EViRGYr+9grtSImJZ68vTVadf23Vm1SRsIafexOgjvlDFwiqzqlQ+f5RMHd0hwbYv+Muj2s=
X-Received: by 2002:a9d:fa4:: with SMTP id d33-v6mr158395otd.84.1538552679665;
 Wed, 03 Oct 2018 00:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20181002082442.20802-1-luiz.dentz@gmail.com> <CABBYNZJPcxQ+1FBU4Gc1qj_Gf7yDcEx84ft6BRksJrgbEE85+g@mail.gmail.com>
In-Reply-To: <CABBYNZJPcxQ+1FBU4Gc1qj_Gf7yDcEx84ft6BRksJrgbEE85+g@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 3 Oct 2018 10:44:26 +0300
Message-ID: <CABBYNZL=a=LFRDcdjwbvOc6zus3OrfuW-Yx=SK99y98vhByiXg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] shared/att: Reset fd when disconnected
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Yunhan Wang <yunhanw@google.com>,
        Sukesh Srikakula <sukeshs@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
On Tue, Oct 2, 2018 at 2:29 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> On Tue, Oct 2, 2018 at 11:24 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > Set att->fd to -1 when considered disconnected.
> > ---
> > v3: Pass btd_device instead of bt_att since the later may have been
> > disconnected already.
> >
> >  src/shared/att.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/src/shared/att.c b/src/shared/att.c
> > index 8bf3f4611..04577eddd 100644
> > --- a/src/shared/att.c
> > +++ b/src/shared/att.c
> > @@ -570,6 +570,7 @@ static bool disconnect_cb(struct io *io, void *user_data)
> >
> >         io_destroy(att->io);
> >         att->io = NULL;
> > +       att->fd = -1;
> >
> >         /* Notify request callbacks */
> >         queue_remove_all(att->req_queue, NULL, NULL, disc_att_send_op);
> > --
> > 2.17.1
> >

Applied.

-- 
Luiz Augusto von Dentz

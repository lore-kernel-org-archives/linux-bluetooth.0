Return-Path: <SRS0=tQl/=SH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C8CC282CE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Apr 2019 16:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106B421738
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Apr 2019 16:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7b+LBed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbfDEQ3K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:29:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42428 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730554AbfDEQ3K (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Apr 2019 12:29:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id w25so2099836pfi.9;
        Fri, 05 Apr 2019 09:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fspO/TVEVGTpRmAtOyB9yj5kFZPJCio5d8wD7/B9/oU=;
        b=S7b+LBed0zPmKOXX0WE1GNguEoiGI9ka/UArvKmVTSS0I/Kf9gsExfgissLpmJGtDd
         cdX89VdhdGw9DjIZSwCcOO+5RA4yvtlv6/fYo9/hkWsjGJhRynAAI7Io1g2GBp78tEUz
         jHXzAZYaGZ+nIunS0QA4smK6oNFGemLID52qhieXTEwGMxXIIjVxNrt/tw8zVz2du+zx
         7VKp/uDiTBa+dcV7kBiWVuX8Rjlx6yuL4xgcBxqfLyV8PYydSchmccBZ89fQkhGoY8Xt
         6lMiHszWeGpCMLlbv+y5Q7cZsnVxApQPLn7RQongZfLXN6mgFD5utyyUPM2Tu24pnopE
         aZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fspO/TVEVGTpRmAtOyB9yj5kFZPJCio5d8wD7/B9/oU=;
        b=Bt+xybMgvDONWfFIr4JExH3qxCxMXbclgtXzUUYlyNTx9te1KlP8lRi/rJxF/aSOEY
         WPLijrDTuqnWHO+A0Sg3/QIpDIEX6P3wP0qHAOho2wET5pZPN2q5L1jBq2YV1oUsqAuA
         /02UJUJQjfTwB3YfkoUgAMDzVoARAy1lCfHiYlnBqcEwB4Fw3CXkvOKoWox0TIpHYJI0
         eJM+zMKcRZQSaSzQRkGxctxiIhU/Rb2LE8VmLKETjRAbqNorA6kS5BYl5orFRO8p9tHi
         asFRt7IrJwnN/6bW5/vM7HueOQ804eVDQMNE+mkNbOZE+72jysd5L8M/LfP2t/RPlM17
         XlFg==
X-Gm-Message-State: APjAAAVeTbm5Uim6CYnJw58uN7C7Ut2d8+UnZsyT2BphDtoySpU9OIHG
        PCEC46bCTfGyvQf/cFUbnEMwlxNmgUTNw+VExOk=
X-Google-Smtp-Source: APXvYqyRf+bgSTDMeZWGzx+9hoWLt2+YN2HzfsK4D+ZxKYgXypZilAKSF5/c+9KfTTKPlHOgixibs3Bi401QdkWvSck=
X-Received: by 2002:a63:c40c:: with SMTP id h12mr1935228pgd.39.1554481749667;
 Fri, 05 Apr 2019 09:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190330072511.GA5502@kadam> <f1baaa05-bd1d-f2cf-410a-7073e85412d3@gmail.com>
 <CAM_iQpVNqyoBirtKg-rbOHsOZCZ0Oz5PTE2sFQnHQnv6s7g2gg@mail.gmail.com>
 <20190402063313.GA32613@kadam> <CAM_iQpW=X2X5A873nSPM7yLBiWZM+rsJk+uMpiOioYPFsFP9vg@mail.gmail.com>
 <20190402201322.GG32613@kadam> <CAM_iQpWjwOwawBN3yiZ0F-B-HDSOW8KGfpLGhAsf5yE0A=wtDA@mail.gmail.com>
 <20190404063521.GF32590@kadam>
In-Reply-To: <20190404063521.GF32590@kadam>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Fri, 5 Apr 2019 09:28:57 -0700
Message-ID: <CAM_iQpUgv5HhiPV2P+swHbSfnnhWNTNCLnNAK=WCTcp3HZVTmQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_event: potential out of bounds parsing ADV events
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Tomas Bortoli <tomasbortoli@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Jaganath Kanakkassery <jaganath.k.os@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Apr 3, 2019 at 11:35 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Wed, Apr 03, 2019 at 03:51:18PM -0700, Cong Wang wrote:
> > On Tue, Apr 2, 2019 at 1:15 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > >
> > > On Tue, Apr 02, 2019 at 10:42:38AM -0700, Cong Wang wrote:
> > > > > Btw, get rid of all the likely/unlikely() macros.  Then the other style
> > > > > comment would be don't move the "ev = (void *)skb->data;" assignments
> > > > > around.  It's ok to say:
> > > >
> > > >
> > > > Similarly, pskb_may_pull() may reallocate skb's, although very unlikely
> > > > for bluetooth case (skb's are linear). At least it doesn't harm anything
> > > > we move the skb->data dereference after pskb_may_pull().
> > > >
> > >
> > > It harms readability.
> >
> > Why? I can't see how it harms readability if you have pskb_may_pull()
> > in mind that it potentially reallocates skb->data.
>
> You're making the code more complicated because you're pretending that
> we didn't linearize the skb data already...  :/

I am not pretending it, I just want to use a standard networking API
which covers all cases.

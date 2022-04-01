Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D50C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Apr 2022 21:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349573AbiDAVHD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Apr 2022 17:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239280AbiDAVHC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Apr 2022 17:07:02 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14B6657B7
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Apr 2022 14:05:11 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2e6650cde1bso45603357b3.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Apr 2022 14:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Mey963D3n6K3ldafDHr1m5NNNQGXT/Jh47vgPmLNmk=;
        b=j/O3RCLbZTWkIycE/n4ff2dytbtdwNxzq0u7Oe74bI7C2T0vTHeaoxZJM4S+j5EKYj
         wA2SxIwg8LxG+0b/Mfw3pr2aeJaPLi6vyV0lidWmxt53VsKuvLnupJM6r4d2gGn/QJPK
         ZcH7yrNs7zY7o4Sc5SFOz39gL49JYN5IyUJ1LS0CaUB64+KSFGVXbVsfXJL18p3Fr9Sl
         mRLiczEZ9gITt3xwZwnQ3NklIGZKuTaVdGoGmMI7jjnkHURb3ExgY4C8//k84AMzzKUD
         bJIKkOx6yTJODjJpTVi81/WfAoAL5QpYuhcZ07e90VLeEESXJOsCuPf57NTiXI45JU3n
         QB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Mey963D3n6K3ldafDHr1m5NNNQGXT/Jh47vgPmLNmk=;
        b=UnVnmwN847xuFjC3sDFIo9MfPBbCQD/ccNEHOnf2eS+BrWTbI6GyaBTgGOvF118arj
         d3wlKdyrFbEU9ATD3xsgyjX4HUSVZqShSialVcFlgtARnhHJQvotgH4NrPdqQAocIqsD
         /QNza4EDIdHGn5y3O2xAWxjiHyXnjVHBB7Sz2Yowpc0tMsSQoftJCFtC+Me1dj9Ecf2J
         49FL0TUpt/NqT8DPMraBKUjq/eqFQj7vuQTVbp76WSw75+BEqoMu43QeBkusHhUhoIvD
         +FDn0N+vr0jnBbmYICAr2bkZIyRRWpZCqo4gLiGCgTL5Fwa7Jcpkqe8eD9rhymz2Vk/x
         LVmw==
X-Gm-Message-State: AOAM532yR4CjgEvs21JuQH39rQ/DPndZIW2E+4mA7qD9hK+0TxPeH5Vb
        g1f4CXlgKP5z+w7lcpX5nUd5cTBx7+RM8RqlrAY=
X-Google-Smtp-Source: ABdhPJzuYKEi+AvgiTe47jhkOVLsDO5R5rDoj2DLW1L2Rz2iOqWGF93L9BmdX2f6vY/8AHy0WlHpVaoBmJWsqllCMTA=
X-Received: by 2002:a81:1185:0:b0:2ea:9fcf:5ca1 with SMTP id
 127-20020a811185000000b002ea9fcf5ca1mr12138796ywr.37.1648847111161; Fri, 01
 Apr 2022 14:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220330182552.2613523-1-luiz.dentz@gmail.com>
 <20220330182552.2613523-3-luiz.dentz@gmail.com> <00F602DF-EA8C-47C5-8F13-31F8D2DD0D42@holtmann.org>
In-Reply-To: <00F602DF-EA8C-47C5-8F13-31F8D2DD0D42@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 1 Apr 2022 14:05:00 -0700
Message-ID: <CABBYNZJ1LJmO0VLNKyeVrC27-ugoZfD0va2Gq2b-hNFsd8JJ+Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] Bluetooth: btusb: Set HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN
 for QCA
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Fri, Apr 1, 2022 at 10:30 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > This sets HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN for QCA controllers
> > since SCO appear to not work when using HCI_OP_ENHANCED_SETUP_SYNC_CONN.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=215576
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > drivers/bluetooth/btusb.c | 3 +++
> > 1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 50df417207af..2470c3d4ef0f 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -3335,6 +3335,9 @@ static int btusb_setup_qca(struct hci_dev *hdev)
> >                       msleep(QCA_BT_RESET_WAIT_MS);
> >       }
> >
> > +     /* https://bugzilla.kernel.org/show_bug.cgi?id=215576 */
>
> I dislike having a link here. Just describe what is going on.

Fair enough I will include the description of the problem instead of
just having the link.

> > +     set_bit(HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN, &hdev->quirks);
> > +
> >       return 0;
> > }
>
> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz

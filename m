Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8549C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Dec 2020 18:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7543A22C9C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Dec 2020 18:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgLUSGi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgLUSGc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Dec 2020 13:06:32 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030AFC0611C5
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Dec 2020 10:05:52 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id 11so6887372pfu.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Dec 2020 10:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/uAxBrvdDC73TZp+IQZEOJGWsfHQdihTLi9dAWQtrSE=;
        b=mkLMg3gaqGSEPm5adLDLrlCFvaVoR/w6A23AMV3Z5AX6e/ysILXx6OHMWwUga/vLU8
         HnbVnuqeyEsBfK9rFIzMUzDw1fCgWczOJ2P3bEk9L3Kdqb7DZiOt/hJYY+pRTH5P3DnT
         OgatzO7l7YH+PIotdA1nfWUoStjda9g7Qiyic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/uAxBrvdDC73TZp+IQZEOJGWsfHQdihTLi9dAWQtrSE=;
        b=CXwHzn1CHfh7jQCgIQL4h18lZFH3pDFZ8THhCqEcx3+AMQw4ofEjwmDOcv2KD8VZXq
         pWB1SUsLGtmJnkI9jVCeb7rk8GQG/kh7NJ5sNW4TQNRPU3t/R/e5DIty3pGb9LJMShj4
         fPNDPwrxlu4NlzB7FdZQMsFng4B8pIwvFOeYccRg7H88XOEXQbNQV13C86+fBhQ7SeMG
         8TFXU513JCivkRxqNFlhWYxomZe7+RAcUDeGdG0jobGW0KqjxwmzR/8pVDl49E1vU5Nv
         hrRRk4OL8ynhTWtUjEduZx5fDpgTHvInShTd9xd9f30KdSbYae0U2pLp2+m/uwSBeKoY
         8WWA==
X-Gm-Message-State: AOAM531q8x886v2Q9erGAdc/HyVaWVKM/9b0YIPe/8eky2JPiP95ME7h
        B7YcmXlO1xqiUyfBucNDRjo9Z3SxEy4VYbp4KAMKH3L0aEGrGg==
X-Google-Smtp-Source: ABdhPJyV0goa8SGmlmymnQKepQstMMHuhDMRNmJgzQdCMoAr+K8sd66iCURLhWXfRpoINdcwNfpYX6V8wLVS0SVk9rc=
X-Received: by 2002:a67:c983:: with SMTP id y3mr13124134vsk.59.1608573510353;
 Mon, 21 Dec 2020 09:58:30 -0800 (PST)
MIME-Version: 1.0
References: <20201204111038.v1.1.I4557a89427f61427e65d85bc51cca9e65607488e@changeid>
 <ec27a562-d53b-a947-1a93-bd55a2dfcc91@gmail.com>
In-Reply-To: <ec27a562-d53b-a947-1a93-bd55a2dfcc91@gmail.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Mon, 21 Dec 2020 09:58:18 -0800
Message-ID: <CANFp7mXdz8jYB0=tkj-mzWETo+M-Tx9ecTwEquh-JoDXRT54qw@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: Set missing suspend task bits
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Howard Chung <howardchung@google.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>, apusaka@chromium.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dmitry,

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3D295fa2a5647b13681594bb1bcc76c74619035218
should fix this issue.

Your issue seems the same as the one I encountered -- the
SUSPEND_DISABLE bit (0x4) wasn't being cleared by the request
completion handler.

Thanks,
Abhishek

On Mon, Dec 21, 2020 at 6:35 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 04.12.2020 06:14, Howard Chung =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> >
> > When suspending, mark SUSPEND_SCAN_ENABLE and SUSPEND_SCAN_DISABLE task=
s
> > correctly when either classic or le scanning is modified.
> >
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > Signed-off-by: Howard Chung <howardchung@google.com>
> > Reviewed-by: Alain Michaud <alainm@chromium.org>
> > ---
> >
> >  net/bluetooth/hci_request.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> > index 80dc451d6e124..71bffd7454720 100644
> > --- a/net/bluetooth/hci_request.c
> > +++ b/net/bluetooth/hci_request.c
> > @@ -707,6 +707,9 @@ void hci_req_add_le_scan_disable(struct hci_request=
 *req, bool rpa_le_conn)
> >               return;
> >       }
> >
> > +     if (hdev->suspended)
> > +             set_bit(SUSPEND_SCAN_DISABLE, hdev->suspend_tasks);
> > +
> >       if (use_ext_scan(hdev)) {
> >               struct hci_cp_le_set_ext_scan_enable cp;
> >
> > @@ -1159,6 +1162,11 @@ static void hci_req_set_event_filter(struct hci_=
request *req)
> >               scan =3D SCAN_PAGE;
> >       }
> >
> > +     if (scan)
> > +             set_bit(SUSPEND_SCAN_ENABLE, hdev->suspend_tasks);
> > +     else
> > +             set_bit(SUSPEND_SCAN_DISABLE, hdev->suspend_tasks);
> > +
> >       hci_req_add(req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
> >  }
> >
> >
>
> Hi,
>
> This commit caused a regression on entering into suspend for Broadcom
> Bluetooth 4330 on Nexus 7:
>
>  Bluetooth: hci0: Timed out waiting for suspend events
>  Bluetooth: hci0: Suspend timeout bit: 4
>  Bluetooth: hci0: Suspend notifier action (3) failed: -110
>
> I don't see this problem using BCM4329 chip on another device.
>
> Please fix, thanks in advance.

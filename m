Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3569C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Mar 2021 20:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A134964DDF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Mar 2021 20:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbhCOUCB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Mar 2021 16:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbhCOUBa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Mar 2021 16:01:30 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCBDC06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 13:01:29 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id x78so35761422oix.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 13:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VE9vYK16lIhebNeFtRwi4e5KFBe2scXiyRQNMULQxJE=;
        b=DIbBLE6AF0oznOeOBHSKHrnHDwan0qENsg3kCW7gyh6T7FENtbqWwcCXL/JHhLQNrl
         ZD7+68pPtUhouMu5ma4Xo5kN8zfMBVk6INL8I2CiH1T1fF98YTqJuD+D5vlcEagJmk/4
         nqmQkdl+rWVRBlKFy4V6XBDdx828DsvXj7KxUGSsfTQ54F8OvupmP8hLCEtjz3x+rr1X
         3X4ZIEjf2o8vWMpfb/dj41HJeLuLtX78mmMjSk6K9/uGWcbjXH9wfVBD/nJdQIS4neKK
         BlDcHlARWDUKFUo4/ZNMSn/bJ+XkRo3pevoFuGJBIDI70FbXeDXfV/xuH64A7mi1FYW4
         nxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VE9vYK16lIhebNeFtRwi4e5KFBe2scXiyRQNMULQxJE=;
        b=ge6tUj01b7m587fT+BLJl8cDO5bGUV79Wvz35RthVYdmXwvifHf5YzQmp4v490/c0/
         cY841v8IsOT0oLKPe6ln2K0jek659gJCfduy/bXVbOsxLyr0GeEBSlf8VMk3ydED6F1C
         0Jjf1LJUWxvNuMzEYgnAoxOUmYBQkj1sLnAyQylrSY8SzOhdbghobhcW7DwhnJJdobVh
         2/8i5DdaN5InZDmW6r9Y5er7dyl6bd5VqEQyFcbi0KcUWxBLhANnKU5UhLRKcxPyLjTH
         Mo4LLo7QCU6aEeYR+dvXCJoksBL7pMsqmPXsMSntPofsC1jTIbwIWz7JdMEaJhoJLYq0
         n5xA==
X-Gm-Message-State: AOAM531oFoXzaqBhJZ4lS++qUgqF1SvQkiwIx2bD0rLNUY21KMV8C3BG
        fkoAfMoTb+WZl2WWPCiFYCfPAdyNAKdMquD8kJa5+m13DddqTg==
X-Google-Smtp-Source: ABdhPJwkLqX0+T+gAV8FyGyYYCBE50Qsmbfv3MMjQELA1TX7Yq/c35N2maYoQoID/BTCwmab1zcrzZzgpDmJKXueYt8=
X-Received: by 2002:a05:6808:1290:: with SMTP id a16mr559373oiw.161.1615838489039;
 Mon, 15 Mar 2021 13:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210312181948.1225833-1-luiz.dentz@gmail.com> <D4446968-D944-4FE8-A6B7-290706FF7923@holtmann.org>
In-Reply-To: <D4446968-D944-4FE8-A6B7-290706FF7923@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 15 Mar 2021 13:01:18 -0700
Message-ID: <CABBYNZLHhqEADbBDhavOTDX=+ycwGGpDhYJuZ=f5rYj9D44Ubg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix not checking for maximum number of DCID
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Sat, Mar 13, 2021 at 3:02 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > When receiving L2CAP_CREDIT_BASED_CONNECTION_REQ the remote may request
> > more channels than allowed by the spec (10 octecs = 5 CIDs) so this
> > truncates the response allowing it to create only the maximum allowed.
>
> so what does the spec say the behavior should be? Truncate or actually respond with an error?

The spec is not very clear about this, well except by saying:

'The Source CID is an array of up to 5 two-octet values and represents the
channel endpoints on the device sending the request.'

So I guess responding with an error would still conform to the above
statement so we would just strictly follow the maximum number of
channels allowed.

> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > include/net/bluetooth/l2cap.h | 1 +
> > net/bluetooth/l2cap_core.c    | 4 ++--
> > 2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> > index 61800a7b6192..3c4f550e5a8b 100644
> > --- a/include/net/bluetooth/l2cap.h
> > +++ b/include/net/bluetooth/l2cap.h
> > @@ -494,6 +494,7 @@ struct l2cap_le_credits {
> >
> > #define L2CAP_ECRED_MIN_MTU           64
> > #define L2CAP_ECRED_MIN_MPS           64
> > +#define L2CAP_ECRED_MAX_CID          5
> >
> > struct l2cap_ecred_conn_req {
> >       __le16 psm;
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 72c2f5226d67..6325d4a89b31 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -5921,7 +5921,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
> >       struct l2cap_ecred_conn_req *req = (void *) data;
> >       struct {
> >               struct l2cap_ecred_conn_rsp rsp;
> > -             __le16 dcid[5];
> > +             __le16 dcid[L2CAP_ECRED_MAX_CID];
> >       } __packed pdu;
> >       struct l2cap_chan *chan, *pchan;
> >       u16 mtu, mps;
> > @@ -5973,7 +5973,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
> >       cmd_len -= sizeof(*req);
> >       num_scid = cmd_len / sizeof(u16);
> >
> > -     for (i = 0; i < num_scid; i++) {
> > +     for (i = 0; i < num_scid && i < ARRAY_SIZE(pdu.dcid); i++) {
> >               u16 scid = __le16_to_cpu(req->scid[i]);
> >
> >               BT_DBG("scid[%d] 0x%4.4x", i, scid);
>
> Is this really a good idea? I would prefer if we check the size first and then just respond with an error.

Right, I will change it to just fail with L2CAP_CR_LE_INVALID_PARAMS instead.

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz

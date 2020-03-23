Return-Path: <SRS0=apyX=5I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B4EC3F2CD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Mar 2020 18:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7AE20719
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Mar 2020 18:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qfe9tv2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgCWSj3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:39:29 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40324 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgCWSj2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Mar 2020 14:39:28 -0400
Received: by mail-ot1-f67.google.com with SMTP id e19so14481389otj.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Mar 2020 11:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RplqySvfx/op7XHzUTAJIXuYUIYRwdVxIUXlcpSseb0=;
        b=qfe9tv2il1zZ8ci9osbYgLAFKAxMPVwt+iwS6NoD/q4gqfl3NxNuhwk8c7SdrwuOHg
         zDiyRUgbCCERYPJtSGew6I5T6RnaDCekpD3eBMjTt4A+LAn5P5DEX28Cl8Q3D9a3K7rM
         VKXMmvvwGgKG/xa94OXT8HbAcBVwIHuAh4eJRls67bsKrdBawNSt+nsr/+R9YIHtcVFW
         Ud+EuoKKec/hgWpm+EIil1iYVmBDS+eQs9tMRfzzNJMHLLkCKIXbEzAAGV0GBclNwNNV
         FsTZ45HH5x/ORe6U4fmLwf3gaqrM9mpc801T31zPvgKt5ejeWvdLXOBx/aa5jA3c3QPB
         801w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RplqySvfx/op7XHzUTAJIXuYUIYRwdVxIUXlcpSseb0=;
        b=ibWucQcdaoVhelu+e1f9qpv3VI/dcPRnKDSXIwUpRUYfbY+6Mlsd6GFjNxp8ztSOj5
         3OszjHjrPCf62qZhKq9kHu73Kbz/MepqVL5/urOEzIIAvX95QAvFLgpFgaLnpB3sWuaM
         NRq97AlSCXsQDxh5ybtnWn89Z2XiPPQ1ju304BSpM2D4UcXA/4ltDb4M1cdc9eX4vlQ8
         zBfugIgrwtM/rE4WwPNjWx6TUm4ceUsDTydeJuvk5jVk8DR8iGaPrG2GYewXuJcf5oV8
         3eawV6G8x6PMWPiESZNOkTJ/zq4LYuQJEu1x9LKI2nr+CD7S4ebHjmdqG/Xyq9CDy3Mb
         qnrA==
X-Gm-Message-State: ANhLgQ1Vq6UderTjipY3GRMOmuW85jAcvGoB2+y3AcnduGjlpAiSRaLl
        vHgEyt2YMBVU9pF2Py83rSSdk0zrEo+5FYL5K4APvQ==
X-Google-Smtp-Source: ADFU+vu43Esn1qKs7psUigTqaPnS3nB4FDS3gSA56y0y8oqewxdIDaQFntEx+lmQsEng+rN5f1WgssoaiAGUqh91ByM=
X-Received: by 2002:a05:6830:19c7:: with SMTP id p7mr19823163otp.79.1584988765998;
 Mon, 23 Mar 2020 11:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200318215019.21494-1-luiz.dentz@gmail.com> <20200318215019.21494-4-luiz.dentz@gmail.com>
 <DDA058C0-9DF5-43F4-9A41-001595A95573@holtmann.org> <CABBYNZ++Kr+y7QX-2ah0CtaC5W+3A66a=Ppu71i0DeyvZW-CjA@mail.gmail.com>
 <70260AFD-45C1-4A28-B7B1-021F65E38A5C@holtmann.org>
In-Reply-To: <70260AFD-45C1-4A28-B7B1-021F65E38A5C@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 23 Mar 2020 11:39:14 -0700
Message-ID: <CABBYNZLndyg9DzTUohx-DZ0y09OscbdFLNm+LMWfv+6L9XwdZw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] Bluetooth: Add BT_MODE socket option
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel.

On Mon, Mar 23, 2020 at 10:42 AM Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Luiz,
>
> >>> This adds BT_MODE socket option which can be used to set L2CAP modes,
> >>> including modes only supported over LE which were not supported using
> >>> the L2CAP_OPTIONS.
> >>>
> >>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >>> ---
> >>> include/net/bluetooth/bluetooth.h | 11 ++++
> >>> net/bluetooth/l2cap_sock.c        | 96 ++++++++++++++++++++++++++++++=
+
> >>> 2 files changed, 107 insertions(+)
> >>>
> >>> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetoot=
h/bluetooth.h
> >>> index 1576353a2773..34191e34bfdc 100644
> >>> --- a/include/net/bluetooth/bluetooth.h
> >>> +++ b/include/net/bluetooth/bluetooth.h
> >>> @@ -139,6 +139,17 @@ struct bt_voice {
> >>> #define BT_PHY_LE_CODED_TX    0x00002000
> >>> #define BT_PHY_LE_CODED_RX    0x00004000
> >>>
> >>> +#define BT_MODE                      15
> >>> +
> >>> +#define BT_MODE_BASIC                0x00
> >>> +#define BT_MODE_RETRANS              0x01
> >>> +#define BT_MODE_FLOWCTL              0x02
> >>> +#define BT_MODE_ERTM         0x03
> >>> +#define BT_MODE_STREAMING    0x04
> >>> +#define BT_MODE_EXT_FLOWCTL  0x05
> >>> +
> >>> +#define BT_MODE_LE_FLOWCTL   0x80
> >>> +
> >>
> >> what I would do is just this:
> >>
> >>        BASIC           0x00
> >>        ERTM            0x01
> >>        STREAMING       0x02
> >>        LE_FLOWCTL      0x03
> >>        EXT_FLOWCTL     0x04
> >>
> >> Trying to cling onto some old L2CAP definition from the 2.1 days is no=
t helpful. I would really make a clean cut here.
> >
> > Just to confirm, that means we will not going to support the old
> > flowctl and retransmit modes from BR/EDR with BT_MODE?
>
> we currently don=E2=80=99t support these two modes, nor are there any spe=
cs that require it.

Right, it seems we didn't validate these modes in L2CAP_OPTION though,
I left that unchanged in the last set.

> >> This way we can also cleanly check the available modes per selected so=
cket and have either setsockopt or connect fail appropriately.
> >>
> >>> __printf(1, 2)
> >>> void bt_info(const char *fmt, ...);
> >>> __printf(1, 2)
> >>> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> >>> index 117ba20ea194..f2bb376c699f 100644
> >>> --- a/net/bluetooth/l2cap_sock.c
> >>> +++ b/net/bluetooth/l2cap_sock.c
> >>> @@ -500,6 +500,25 @@ static int l2cap_sock_getsockopt_old(struct sock=
et *sock, int optname,
> >>>      return err;
> >>> }
> >>>
> >>> +static u8 l2cap_get_mode(struct l2cap_chan *chan)
> >>> +{
> >>> +     switch (chan->mode) {
> >>> +     case L2CAP_MODE_BASIC:
> >>> +     case L2CAP_MODE_RETRANS:
> >>> +     case L2CAP_MODE_FLOWCTL:
> >>> +     case L2CAP_MODE_ERTM:
> >>> +     case L2CAP_MODE_STREAMING:
> >>> +             /* Mode above are the same on both old and new sockopt =
*/
> >>> +             return chan->mode;
> >>> +     case L2CAP_MODE_LE_FLOWCTL:
> >>> +             return BT_MODE_FLOWCTL;
> >>> +     case L2CAP_MODE_EXT_FLOWCTL:
> >>> +             return BT_MODE_EXT_FLOWCTL;
> >>> +     }
> >>> +
> >>> +     return chan->mode;
> >>> +}
> >>> +
> >>
> >> Don=E2=80=99t bother with this. Keep the old socket and new socket ind=
ependent code. I also want to add Kconfig option later that will allow us t=
o disable the old socket options once we have SOL_L2CAP requirement eradica=
ted.
> >
> > The reason I had the defines intermixed was that application would be
> > able to use the old sockopt to set it and then use BT_MODE to read it,
> > in which case I may need to store the actual socket mode separately
> > from the chan->mode and then perhaps fail if application attempt to
> > read it with BT_MODE if was not set using it.
>
> If someone used L2CAP_OTIONS, then just lets fail BT_MODE read and write.

Right, Ive made it fail with lastest change, I can probably have a
flag to make it exclusively thogh with one or another, I will send an
update shortly.

> Regards
>
> Marcel
>


--=20
Luiz Augusto von Dentz

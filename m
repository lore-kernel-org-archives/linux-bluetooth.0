Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174A1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Jul 2022 16:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiGUQLh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jul 2022 12:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGUQLg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jul 2022 12:11:36 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FFB237E4
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 09:11:34 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id k19so2373544lji.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 09:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UMECKP7NC51ktYlhkjwfZowoi23kUrgAbEgGtHHb1jY=;
        b=Su3RJ0p9LVL5Zfr0+Ocpww4aag4ZB0KyIWc35NbhWxsEu+GtxGmd3xovMJYKvIWTUI
         +bEpAACF7f2sL898cLgOf32f3SANHevNBiaNIYVCuFtHn8/rt0tVtb4hLFErnPBqo4rX
         bBSZPcqx9wwnIfjfYF60hBVvkk+2mfc3Nauhd0NZ/UZmVT7QbxnUFsLtvZIFjyAS4Hbr
         whSmd8SJDO64vyRH0JZNfp15zCiqwdbxKx0sJJIgl1N+UAA05BBF+94kn7agtJV6LMMg
         ZONdSrulFjBByV/aR9wUURX6Acgj08yAbDo5Gcf78M095m1wvyjfuitFInArxWo2jezk
         jOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UMECKP7NC51ktYlhkjwfZowoi23kUrgAbEgGtHHb1jY=;
        b=v6XwrzWYuE5r/zlC4L5y+T6PIwldF1sk4I4jm/u/lWnfBgbAkMXQkjsvI8xptbVnR0
         V0jRHMR8moLQZYP54sdnjttVshhjMeIKCRLbNVu2BO0JfoemSWD6rPvtBs5iQhL0nBtm
         41P4vScSOPzeSyaHcUp/CK9lY+6Yvn01gzSnrpNVydIwVPvDoC8DEeORbxREdxkWc3u/
         +fHT1N2RSIHqlZfv6ui1ZiXuGzCeoz+vIP+cTbsgIUtbveooeSpp9CqTzVhLIldWdnU7
         T+f/nVcsojD3zyOOhEF0jOYN78crx3Su2HgSeY06z9xrRx+14HBYMzCUtIq2EBfXMzG6
         Xfsg==
X-Gm-Message-State: AJIora8lWPByX0mX0ki5neugYe+cNvkeBJ/QpCsboHT1RW02U8+TgzGD
        Or2k1BpDCgrWKWsNpzXQPiYZopMzFTiM4vj/XaU=
X-Google-Smtp-Source: AGRyM1vLiAing5GXSJZv9Gyb22ctQmSbR1o71uEsw8JaoDsgXshKBj0INKHvlxJR54PjAn1Vrp6+9kFhnoa6fMqKAfM=
X-Received: by 2002:a2e:b538:0:b0:25d:881d:a10f with SMTP id
 z24-20020a2eb538000000b0025d881da10fmr17907551ljm.65.1658419892080; Thu, 21
 Jul 2022 09:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220720170648.148219-1-luiz.dentz@gmail.com> <YtkDklSo4kYRCR2a@google.com>
In-Reply-To: <YtkDklSo4kYRCR2a@google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 21 Jul 2022 09:11:20 -0700
Message-ID: <CABBYNZ+5Hv+D6kqAyH3X6w4xDr7nFBh65GzMWo+9L=J2gA6=wQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix use-after-free caused by l2cap_chan_put
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Lee,

On Thu, Jul 21, 2022 at 12:43 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Wed, 20 Jul 2022, Luiz Augusto von Dentz wrote:
>
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This fixes the following trace which is caused by hci_rx_work starting =
up
> > *after* the final channel reference has been put() during sock_close() =
but
> > *before* the references to the channel have been destroyed, so instead
> > the code now rely on kref_get_unless_zero/l2cap_chan_hold_unless_zero t=
o
> > prevent referencing a channel that is about to be destroyed.
> >
> >   refcount_t: increment on 0; use-after-free.
> >   BUG: KASAN: use-after-free in refcount_dec_and_test+0x20/0xd0
> >   Read of size 4 at addr ffffffc114f5bf18 by task kworker/u17:14/705
> >
> >   CPU: 4 PID: 705 Comm: kworker/u17:14 Tainted: G S      W
> >   4.14.234-00003-g1fb6d0bd49a4-dirty #28
> >   Hardware name: Qualcomm Technologies, Inc. SM8150 V2 PM8150
> >   Google Inc. MSM sm8150 Flame DVT (DT)
> >   Workqueue: hci0 hci_rx_work
> >   Call trace:
> >    dump_backtrace+0x0/0x378
> >    show_stack+0x20/0x2c
> >    dump_stack+0x124/0x148
> >    print_address_description+0x80/0x2e8
> >    __kasan_report+0x168/0x188
> >    kasan_report+0x10/0x18
> >    __asan_load4+0x84/0x8c
> >    refcount_dec_and_test+0x20/0xd0
> >    l2cap_chan_put+0x48/0x12c
> >    l2cap_recv_frame+0x4770/0x6550
> >    l2cap_recv_acldata+0x44c/0x7a4
> >    hci_acldata_packet+0x100/0x188
> >    hci_rx_work+0x178/0x23c
> >    process_one_work+0x35c/0x95c
> >    worker_thread+0x4cc/0x960
> >    kthread+0x1a8/0x1c4
> >    ret_from_fork+0x10/0x18
> >
> > Cc: stable@kernel.org
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>
> Signed-off-by isn't the correct tag for this since I wasn't
> responsible for any of the coding, nor am I in the merge path.
>
> Either as a v2 or when the patch is applied, please swap out for:
>
> Reported-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Tested-by: Lee Jones <lee.jones@linaro.org>

v2 sent.

> > ---
> >  include/net/bluetooth/l2cap.h |  1 +
> >  net/bluetooth/l2cap_core.c    | 61 +++++++++++++++++++++++++++--------
> >  2 files changed, 49 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2ca=
p.h
> > index 3c4f550e5a8b..2f766e3437ce 100644
> > --- a/include/net/bluetooth/l2cap.h
> > +++ b/include/net/bluetooth/l2cap.h
> > @@ -847,6 +847,7 @@ enum {
> >  };
> >
> >  void l2cap_chan_hold(struct l2cap_chan *c);
> > +struct l2cap_chan *l2cap_chan_hold_unless_zero(struct l2cap_chan *c);
> >  void l2cap_chan_put(struct l2cap_chan *c);
> >
> >  static inline void l2cap_chan_lock(struct l2cap_chan *chan)
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 09ecaf556de5..77c0aac14539 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -111,7 +111,8 @@ static struct l2cap_chan *__l2cap_get_chan_by_scid(=
struct l2cap_conn *conn,
> >  }
> >
> >  /* Find channel with given SCID.
> > - * Returns locked channel. */
> > + * Returns a reference locked channel.
> > + */
> >  static struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_conn *co=
nn,
> >                                                u16 cid)
> >  {
> > @@ -119,15 +120,19 @@ static struct l2cap_chan *l2cap_get_chan_by_scid(=
struct l2cap_conn *conn,
> >
> >       mutex_lock(&conn->chan_lock);
> >       c =3D __l2cap_get_chan_by_scid(conn, cid);
> > -     if (c)
> > -             l2cap_chan_lock(c);
> > +     if (c) {
> > +             /* Only lock if chan reference is not 0 */
> > +             c =3D l2cap_chan_hold_unless_zero(c);
> > +             if (c)
> > +                     l2cap_chan_lock(c);
> > +     }
> >       mutex_unlock(&conn->chan_lock);
> >
> >       return c;
> >  }
> >
> >  /* Find channel with given DCID.
> > - * Returns locked channel.
> > + * Returns a reference locked channel.
> >   */
> >  static struct l2cap_chan *l2cap_get_chan_by_dcid(struct l2cap_conn *co=
nn,
> >                                                u16 cid)
> > @@ -136,8 +141,12 @@ static struct l2cap_chan *l2cap_get_chan_by_dcid(s=
truct l2cap_conn *conn,
> >
> >       mutex_lock(&conn->chan_lock);
> >       c =3D __l2cap_get_chan_by_dcid(conn, cid);
> > -     if (c)
> > -             l2cap_chan_lock(c);
> > +     if (c) {
> > +             /* Only lock if chan reference is not 0 */
> > +             c =3D l2cap_chan_hold_unless_zero(c);
> > +             if (c)
> > +                     l2cap_chan_lock(c);
> > +     }
> >       mutex_unlock(&conn->chan_lock);
> >
> >       return c;
> > @@ -162,8 +171,12 @@ static struct l2cap_chan *l2cap_get_chan_by_ident(=
struct l2cap_conn *conn,
> >
> >       mutex_lock(&conn->chan_lock);
> >       c =3D __l2cap_get_chan_by_ident(conn, ident);
> > -     if (c)
> > -             l2cap_chan_lock(c);
> > +     if (c) {
> > +             /* Only lock if chan reference is not 0 */
> > +             c =3D l2cap_chan_hold_unless_zero(c);
> > +             if (c)
> > +                     l2cap_chan_lock(c);
> > +     }
> >       mutex_unlock(&conn->chan_lock);
> >
> >       return c;
> > @@ -497,6 +510,16 @@ void l2cap_chan_hold(struct l2cap_chan *c)
> >       kref_get(&c->kref);
> >  }
> >
> > +struct l2cap_chan *l2cap_chan_hold_unless_zero(struct l2cap_chan *c)
> > +{
> > +     BT_DBG("chan %p orig refcnt %u", c, kref_read(&c->kref));
> > +
> > +     if (!kref_get_unless_zero(&c->kref))
> > +             return NULL;
> > +
> > +     return c;
> > +}
> > +
> >  void l2cap_chan_put(struct l2cap_chan *c)
> >  {
> >       BT_DBG("chan %p orig refcnt %u", c, kref_read(&c->kref));
> > @@ -1969,7 +1992,10 @@ static struct l2cap_chan *l2cap_global_chan_by_p=
sm(int state, __le16 psm,
> >                       src_match =3D !bacmp(&c->src, src);
> >                       dst_match =3D !bacmp(&c->dst, dst);
> >                       if (src_match && dst_match) {
> > -                             l2cap_chan_hold(c);
> > +                             c =3D l2cap_chan_hold_unless_zero(c);
> > +                             if (!c)
> > +                                     continue;
> > +
> >                               read_unlock(&chan_list_lock);
> >                               return c;
> >                       }
> > @@ -1984,7 +2010,7 @@ static struct l2cap_chan *l2cap_global_chan_by_ps=
m(int state, __le16 psm,
> >       }
> >
> >       if (c1)
> > -             l2cap_chan_hold(c1);
> > +             c1 =3D l2cap_chan_hold_unless_zero(c1);
> >
> >       read_unlock(&chan_list_lock);
> >
> > @@ -4464,6 +4490,7 @@ static inline int l2cap_config_req(struct l2cap_c=
onn *conn,
> >
> >  unlock:
> >       l2cap_chan_unlock(chan);
> > +     l2cap_chan_put(chan);
> >       return err;
> >  }
> >
> > @@ -4578,6 +4605,7 @@ static inline int l2cap_config_rsp(struct l2cap_c=
onn *conn,
> >
> >  done:
> >       l2cap_chan_unlock(chan);
> > +     l2cap_chan_put(chan);
> >       return err;
> >  }
> >
> > @@ -5305,6 +5333,7 @@ static inline int l2cap_move_channel_req(struct l=
2cap_conn *conn,
> >       l2cap_send_move_chan_rsp(chan, result);
> >
> >       l2cap_chan_unlock(chan);
> > +     l2cap_chan_put(chan);
> >
> >       return 0;
> >  }
> > @@ -5397,6 +5426,7 @@ static void l2cap_move_continue(struct l2cap_conn=
 *conn, u16 icid, u16 result)
> >       }
> >
> >       l2cap_chan_unlock(chan);
> > +     l2cap_chan_put(chan);
> >  }
> >
> >  static void l2cap_move_fail(struct l2cap_conn *conn, u8 ident, u16 ici=
d,
> > @@ -5426,6 +5456,7 @@ static void l2cap_move_fail(struct l2cap_conn *co=
nn, u8 ident, u16 icid,
> >       l2cap_send_move_chan_cfm(chan, L2CAP_MC_UNCONFIRMED);
> >
> >       l2cap_chan_unlock(chan);
> > +     l2cap_chan_put(chan);
> >  }
> >
> >  static int l2cap_move_channel_rsp(struct l2cap_conn *conn,
> > @@ -5489,6 +5520,7 @@ static int l2cap_move_channel_confirm(struct l2ca=
p_conn *conn,
> >       l2cap_send_move_chan_cfm_rsp(conn, cmd->ident, icid);
> >
> >       l2cap_chan_unlock(chan);
> > +     l2cap_chan_put(chan);
> >
> >       return 0;
> >  }
> > @@ -5524,6 +5556,7 @@ static inline int l2cap_move_channel_confirm_rsp(=
struct l2cap_conn *conn,
> >       }
> >
> >       l2cap_chan_unlock(chan);
> > +     l2cap_chan_put(chan);
> >
> >       return 0;
> >  }
> > @@ -5896,12 +5929,11 @@ static inline int l2cap_le_credits(struct l2cap=
_conn *conn,
> >       if (credits > max_credits) {
> >               BT_ERR("LE credits overflow");
> >               l2cap_send_disconn_req(chan, ECONNRESET);
> > -             l2cap_chan_unlock(chan);
> >
> >               /* Return 0 so that we don't trigger an unnecessary
> >                * command reject packet.
> >                */
> > -             return 0;
> > +             goto unlock;
> >       }
> >
> >       chan->tx_credits +=3D credits;
> > @@ -5912,7 +5944,9 @@ static inline int l2cap_le_credits(struct l2cap_c=
onn *conn,
> >       if (chan->tx_credits)
> >               chan->ops->resume(chan);
> >
> > +unlock:
> >       l2cap_chan_unlock(chan);
> > +     l2cap_chan_put(chan);
> >
> >       return 0;
> >  }
> > @@ -7598,6 +7632,7 @@ static void l2cap_data_channel(struct l2cap_conn =
*conn, u16 cid,
> >
> >  done:
> >       l2cap_chan_unlock(chan);
> > +     l2cap_chan_put(chan);
> >  }
> >
> >  static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
> > @@ -8086,7 +8121,7 @@ static struct l2cap_chan *l2cap_global_fixed_chan=
(struct l2cap_chan *c,
> >               if (src_type !=3D c->src_type)
> >                       continue;
> >
> > -             l2cap_chan_hold(c);
> > +             c =3D l2cap_chan_hold_unless_zero(c);
> >               read_unlock(&chan_list_lock);
> >               return c;
> >       }
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Principal Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog



--=20
Luiz Augusto von Dentz

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4C0C4167D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Feb 2022 01:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344017AbiBHBGd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Feb 2022 20:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237625AbiBHAQu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Feb 2022 19:16:50 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2285AC061355
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Feb 2022 16:16:49 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id v47so20067455ybi.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Feb 2022 16:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lUMV1GTkJhuvp55RcAluTwsKlcq95o6eHqpjTOUBOSQ=;
        b=auXHH2MctkOPc4fnT/IXZtEv7jTkkv38pcdv6kFFG0kgJHboAjowQIbEJ9p8FL8/GV
         6SJ6WTu+06aZ7eEF2FXbWy9NOQoby1DiWuNbn0zAxxdxsM9Zr6wzohlM2z7FU1y9rho5
         S5HpaNYCthylxdwDIJzEnNeF/I39YI6F9OY9c7PlChBVWh+j9DIaWNSc0pEEi76eesdv
         Nl3SGjkncoJXQmjEdSb58zA2M+OSsfjIm/p2lT0e2VBzg/PTzYf8VGQa1wtGK4Kll0ez
         eLIxCryfoxh+xaN1lSAKAWHSI548NyQaGKJaUK7ekExoV9pQVf/umnEWy1mMZLkTlqPF
         mRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lUMV1GTkJhuvp55RcAluTwsKlcq95o6eHqpjTOUBOSQ=;
        b=aFNrzLv3br3DeiZkQ6gbOVIkGU3Rb2XBKBYNoD50WMX+yJGNiFZkgQVl/0AB05Cp9/
         5yNpH84Vh0c9mvKEr4IfhvpeyIuMNPl0yU5VcLzIMlkyjYrKCx2GW50gfHSsCzFt+/Ru
         D6/P84a5ze8LocDarIltTGFu+jhqmqZbg0veHczpv4qimhSp1NNK1lo0Z2HR1V7yZlFI
         Z1selkg6Vs+mjdlHbEnsuq3DGcqYXczYsFDQBCJQfjPZEBhOs9tIskgiLfCWVaewuwcR
         Rn9xlPqZcQvSEyQfMw7ddG70j3MaQ4/hpsqxC9Qv6ESN5cBzuvAa4fnqGkwERbrzruZm
         g7NQ==
X-Gm-Message-State: AOAM530ej4vLlwi2JFxHWG67e2/55dAOwQcsB/ETrWdVrfBK5rgJcWV5
        +mo2AEFcmMAwnwleo/X79WH1Yhy6+dK99Sm/oaqrfCRKEMZ8WA==
X-Google-Smtp-Source: ABdhPJy2W/bqYdZRNJX9kGLzsgbOJgUMzXsWUlWzpu+yL+llkvJMeBHsJb2lQk92Cv2JplNsIBwSvEXi1oQLvxryoTo=
X-Received: by 2002:a25:684a:: with SMTP id d71mr2382903ybc.284.1644279408180;
 Mon, 07 Feb 2022 16:16:48 -0800 (PST)
MIME-Version: 1.0
References: <20220204211236.2690926-1-luiz.dentz@gmail.com>
 <20220204211236.2690926-2-luiz.dentz@gmail.com> <97AF1D34-8429-42C7-AC13-A7247234EC3F@holtmann.org>
In-Reply-To: <97AF1D34-8429-42C7-AC13-A7247234EC3F@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 7 Feb 2022 16:16:37 -0800
Message-ID: <CABBYNZL77NjJPMVni45M3Pn189Dodp9DYF5s0pafy+Xh=iFTQA@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: hci_core: Introduce hci_recv_event_data
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Mon, Feb 7, 2022 at 7:53 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > This introduces hci_recv_event_data to make it simpler to access the
> > contents of last received event rather than having to pass its contents
> > to the likes of *_ind/*_cfm callbacks.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > include/net/bluetooth/hci_core.h |  2 ++
> > net/bluetooth/hci_core.c         | 32 ++++++++++++++++++++++++++++++++
> > net/bluetooth/hci_event.c        |  3 +++
> > 3 files changed, 37 insertions(+)
> >
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > index f5caff1ddb29..c454913794bf 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -516,6 +516,7 @@ struct hci_dev {
> >       struct sk_buff_head     cmd_q;
> >
> >       struct sk_buff          *sent_cmd;
> > +     struct sk_buff          *recv_event;
> >
> >       struct mutex            req_lock;
> >       wait_queue_head_t       req_wait_q;
> > @@ -1727,6 +1728,7 @@ void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
> > void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
> >
> > void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
> > +void *hci_recv_event_data(struct hci_dev *hdev, __u8 event);
> >
> > u32 hci_conn_get_phy(struct hci_conn *conn);
> >
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index b4782a6c1025..5d1167b67a47 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -2740,6 +2740,7 @@ void hci_release_dev(struct hci_dev *hdev)
> >
> >       ida_simple_remove(&hci_index_ida, hdev->id);
> >       kfree_skb(hdev->sent_cmd);
> > +     kfree_skb(hdev->recv_event);
> >       kfree(hdev);
> > }
> > EXPORT_SYMBOL(hci_release_dev);
> > @@ -3024,6 +3025,37 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
> >       return hdev->sent_cmd->data + HCI_COMMAND_HDR_SIZE;
> > }
> >
> > +/* Get data from last received event */
> > +void *hci_recv_event_data(struct hci_dev *hdev, __u8 event)
> > +{
> > +     struct hci_event_hdr *hdr;
> > +     int offset;
> > +
> > +     if (!hdev->recv_event)
> > +             return NULL;
> > +
> > +     hdr = (void *) hdev->recv_event->data;
> > +     offset = sizeof(hdr);
> > +
> > +     if (hdr->evt != event) {
> > +             /* In case of LE metaevent check the subevent match */
> > +             if (hdr->evt == HCI_EV_LE_META) {
> > +                     struct hci_ev_le_meta *ev;
> > +
> > +                     ev = (void *) hdev->recv_event->data + offset;
> > +                     offset += sizeof(*ev);
> > +                     if (ev->subevent == event)
> > +                             goto found;
> > +             }
> > +             return NULL;
> > +     }
> > +
> > +found:
> > +     bt_dev_dbg(hdev, "event 0x%2.2x", event);
> > +
> > +     return hdev->recv_event->data + offset;
> > +}
> > +
> > /* Send ACL data */
> > static void hci_add_acl_hdr(struct sk_buff *skb, __u16 handle, __u16 flags)
> > {
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 63b925921c87..613050bd80cc 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -6898,6 +6898,9 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
> >               goto done;
> >       }
> >
> > +     kfree_skb(hdev->recv_event);
> > +     hdev->recv_event = skb_clone(skb, GFP_KERNEL);
> > +
>
> fill me into why this a good idea. We end up creating clones of an SKB. Is this a good idea?

It is limited to just the last event, Id like to introduce since in
most cases _ind/_cfm callbacks are done with use of an hci_conn but in
case of BIS we don't really have a connection until we have created a
BIG Sync so I end up doing the following:

https://gist.github.com/Vudentz/2dd08291a0ae0df7fff1034653b01e97#file-diff-L279
https://gist.github.com/Vudentz/2dd08291a0ae0df7fff1034653b01e97#file-diff-L337

So that saves us the trouble of having to add or change the existing
callbacks to sockets, so the socket themselves can check the last
event data instead if it really needs to.

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz

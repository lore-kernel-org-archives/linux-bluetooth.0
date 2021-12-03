Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D4BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Dec 2021 21:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353901AbhLCV4w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Dec 2021 16:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236017AbhLCV4w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Dec 2021 16:56:52 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE6FC061751
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Dec 2021 13:53:27 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id q21so2765206vkn.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Dec 2021 13:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bWpADWEYGacbYCPx5YESAAMDvzLfNoDgtZLI0Wtohtc=;
        b=azOmPJfqXHMLiuHg78EbGFHDloQ+3dF96oz1lBioVzjbTMsNlyEZ+QE5croU43+zUU
         QIv+wqfe6+GknI3AFwLEF1vKi4wvM75URVN4LYzcw4Jv1rJ6rKJU+43a/l9SDfd+4MOv
         Q33jKPMKGY/Oof0gw8xr6LeQGKZyTuJz9C0mlo0Takzoi4vLWqkYBUmhgj8h8ls82qAq
         R3QyUqbOXqA740wCncYYoBrnFI04FGsy/vXH2fsON7kb8su47qDzstthVEZIW0MEftQ1
         iQhGmQMlbtSGWWeQBZDk06laESlusCVR3Dl6YLua9Q6NWGi/DTvm/FdGfkFIguXc8Vqy
         1nzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bWpADWEYGacbYCPx5YESAAMDvzLfNoDgtZLI0Wtohtc=;
        b=5r79tG8ONe3JwYHIVEqA9rEl74D4pFSNBp4oFWYdILOH+JRiBOpuME7JpWNItmksQR
         nMffavIyUTQ12wAbiGvcBxsmNk56yof4P+6xqLAAXFd2M97rrPLjQ+pr9KYrT2r2AxvM
         zR11zmJ3wV+3LFH0Hq1d5mPQzAQmp+AF1ZMraA1sXFJsQW24ALaOw/2vG1ApFEbz4fBk
         jviy8VecLAX9ybazNCjRBlmHUFe7CIuRmdUivwogjhHUxHVQ7WM1tAzrUjhbbVEYAHBY
         oat1k4wwHxl803gxcv11EYSS5v8U9Lqq00lvfH9MHEKpuFtbGitANJ6oGLiMEDjt2+lw
         0d4g==
X-Gm-Message-State: AOAM533QjhKDCqiO2WJINij2WfAuqNE/H6pkwZv5sHnu+4fikNOZWhX7
        dLzrlruyr6dGxo9Dfaz8A+/WI/21f4yba67/rSRf8tv5
X-Google-Smtp-Source: ABdhPJzAru5vXEoUeNBOHRX0mqAz8NCJPGSj59wZArHjRn0eJ1tqNuWp9MiQ8soRgowSbSANUmZqG3tTuDFxKfjsYKk=
X-Received: by 2002:a05:6122:1813:: with SMTP id ay19mr27389459vkb.10.1638568406635;
 Fri, 03 Dec 2021 13:53:26 -0800 (PST)
MIME-Version: 1.0
References: <20211203192529.2199867-1-luiz.dentz@gmail.com> <360C8200-95D7-4596-A39B-40703E99E92B@holtmann.org>
In-Reply-To: <360C8200-95D7-4596-A39B-40703E99E92B@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 3 Dec 2021 13:53:15 -0800
Message-ID: <CABBYNZ+ABuq9MwBF+Gh0V84X61-UrXgEdKdSZb76HD0p1poRaA@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: mgmt: Introduce mgmt_alloc_skb and mgmt_send_event_skb
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Fri, Dec 3, 2021 at 1:40 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > This introduces mgmt_alloc_skb and mgmt_send_event_skb which are
> > convenient when building MGMT events that have variable length as the
> > likes of skb_put_data can be used to insert portion directly on the skb
> > instead of having to first build an intermediate buffer just to be
> > copied over the skb.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > net/bluetooth/mgmt_util.c | 54 +++++++++++++++++++++++++++------------
> > net/bluetooth/mgmt_util.h |  3 +++
> > 2 files changed, 40 insertions(+), 17 deletions(-)
> >
> > diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
> > index 83875f2a0604..4774e993d774 100644
> > --- a/net/bluetooth/mgmt_util.c
> > +++ b/net/bluetooth/mgmt_util.c
> > @@ -56,40 +56,60 @@ static struct sk_buff *create_monitor_ctrl_event(__=
le16 index, u32 cookie,
> >       return skb;
> > }
> >
> > -int mgmt_send_event(u16 event, struct hci_dev *hdev, unsigned short ch=
annel,
> > -                 void *data, u16 data_len, int flag, struct sock *skip=
_sk)
> > +struct sk_buff *mgmt_alloc_skb(unsigned int size)
> > {
> >       struct sk_buff *skb;
> > +
> > +     skb =3D alloc_skb(sizeof(struct mgmt_hdr) + size, GFP_KERNEL);
> > +     if (skb)
> > +             skb_reserve(skb, sizeof(struct mgmt_hdr));
> > +
> > +     return skb;
> > +}
> > +
> > +int mgmt_send_event_skb(u16 event, struct hci_dev *hdev, unsigned shor=
t channel,
> > +                     struct sk_buff *skb, int flag, struct sock *skip_=
sk)
> > +{
> >       struct mgmt_hdr *hdr;
> > +     int len =3D skb->len;
> >
> > -     skb =3D alloc_skb(sizeof(*hdr) + data_len, GFP_KERNEL);
> > -     if (!skb)
> > -             return -ENOMEM;
> > +     /* Time stamp */
> > +     __net_timestamp(skb);
> >
> > -     hdr =3D skb_put(skb, sizeof(*hdr));
> > +     /* Send just the data, without headers, to the monitor */
> > +     if (channel =3D=3D HCI_CHANNEL_CONTROL)
> > +             hci_send_monitor_ctrl_event(hdev, event, skb->data, skb->=
len,
> > +                                         skb_get_ktime(skb), flag, ski=
p_sk);
> > +
> > +     hdr =3D skb_push(skb, sizeof(*hdr));
> >       hdr->opcode =3D cpu_to_le16(event);
> >       if (hdev)
> >               hdr->index =3D cpu_to_le16(hdev->id);
> >       else
> >               hdr->index =3D cpu_to_le16(MGMT_INDEX_NONE);
> > -     hdr->len =3D cpu_to_le16(data_len);
> > -
> > -     if (data)
> > -             skb_put_data(skb, data, data_len);
> > -
> > -     /* Time stamp */
> > -     __net_timestamp(skb);
> > +     hdr->len =3D cpu_to_le16(len);
> >
> >       hci_send_to_channel(channel, skb, flag, skip_sk);
> >
> > -     if (channel =3D=3D HCI_CHANNEL_CONTROL)
> > -             hci_send_monitor_ctrl_event(hdev, event, data, data_len,
> > -                                         skb_get_ktime(skb), flag, ski=
p_sk);
> > -
> >       kfree_skb(skb);
> >       return 0;
> > }
> >
> > +int mgmt_send_event(u16 event, struct hci_dev *hdev, unsigned short ch=
annel,
> > +                 void *data, u16 data_len, int flag, struct sock *skip=
_sk)
> > +{
> > +     struct sk_buff *skb;
> > +
> > +     skb =3D mgmt_alloc_skb(data_len);
> > +     if (!skb)
> > +             return -ENOMEM;
> > +
> > +     if (data)
> > +             skb_put_data(skb, data, data_len);
> > +
> > +     return mgmt_send_event_skb(event, hdev, channel, skb, flag, skip_=
sk);
> > +}
> > +
> > int mgmt_cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status)
> > {
> >       struct sk_buff *skb, *mskb;
> > diff --git a/net/bluetooth/mgmt_util.h b/net/bluetooth/mgmt_util.h
> > index 63b965eaaaac..9f8692d4ce90 100644
> > --- a/net/bluetooth/mgmt_util.h
> > +++ b/net/bluetooth/mgmt_util.h
> > @@ -32,6 +32,9 @@ struct mgmt_pending_cmd {
> >       int (*cmd_complete)(struct mgmt_pending_cmd *cmd, u8 status);
> > };
> >
> > +struct sk_buff *mgmt_alloc_skb(unsigned int size);
> > +int mgmt_send_event_skb(u16 event, struct hci_dev *hdev, unsigned shor=
t channel,
> > +                     struct sk_buff *skb, int flag, struct sock *skip_=
sk);
> > int mgmt_send_event(u16 event, struct hci_dev *hdev, unsigned short cha=
nnel,
> >                   void *data, u16 data_len, int flag, struct sock *skip=
_sk);
> > int mgmt_cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status);
>
> this altogether doesn=E2=80=99t create nicer to read code. What about doi=
ng this:
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bl=
uetooth.h
> index 2f31e571f34c..fd0a114a69c6 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -399,6 +399,7 @@ struct bt_skb_cb {
>                 struct l2cap_ctrl l2cap;
>                 struct sco_ctrl sco;
>                 struct hci_ctrl hci;
> +               struct mgmt_ctrl mgmt;
>         };
>  };
>
> And then adding hci_dev and event to mgmt_ctrl. So you can do something l=
ike:
>
> struct sk_buff *mgmt_alloc_skb(struct hci_dev *hdev, u16 event, unsigned =
int size);

So you want bt_cb to be used when sending? We could as well push the
mgmt_header as well and then update the length at send since the
header is already at the start in skb->data.

> Then the send_event becomes easier to read. Right now it is total mess wi=
th the allocated skb parameter in the middle. It should be first and center=
 to make sure that is the one that matter.
>
> Regards
>
> Marcel
>


--=20
Luiz Augusto von Dentz

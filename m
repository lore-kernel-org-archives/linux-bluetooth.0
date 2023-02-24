Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8815FC64ED8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Feb 2023 20:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjBXUli (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Feb 2023 15:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjBXUlh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Feb 2023 15:41:37 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9536C1BC
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Feb 2023 12:41:35 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id n2so663584lfb.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Feb 2023 12:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AKx+Bkf+6D6BpbPMFrxdghIWAWzEQu8Q/cH2teNBmeY=;
        b=Vk26T+Fh6bN0fHTXGI8Ft9IquAUjCIica4+/gG6XSql4DSU0a12gcf5F5G2AcI0YWJ
         982PqOxpBbFBt2hDyxHQFJfMzCqzOJIbigDwasZpsVXBm8jfjG09s90VnAjf+8WeICAM
         yz0QYeyN8QCXaGQVcqmSjh6jMC2/oVYPKwR5eUuyM4rKoukuUW0Mx32Py8SwfzOw9kdH
         1ZvLbiYTraExyKsoNajVnCaFDtvisB+sdKfricmMuUNR55l1ZSUqveSZrWQjURXjbQUG
         OUMTs4EQJsHniuoFvy3QFTrISSxc7Xr69Y/3eoT0ZrRuLtWAism7o6PNVa8QaPXF83ux
         KRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKx+Bkf+6D6BpbPMFrxdghIWAWzEQu8Q/cH2teNBmeY=;
        b=qOr2BsKXDNXByovx22cDXDOyaJrJH6Q1LdwcHDZd6C8yDE0MB1pzUtwhPOe4e3o/pT
         rhaMRj4Wjvn4cMlka1nK3vBcdjwbFJ8XP1f88hIrt+FaoT+3OO7CN0rPalZ9F6Q7alYK
         pirMGOJR/vNydBO4oh2502yuOnrvlhL3YNygRz7xC7EWjQevtV7CwQVEnmqoJrTwC6DH
         ZFaFhNU+c352yP+9FiBd7WAs79gXn1Ga+/ljT/Q3cC3jbETUM5qe9sQlf5lu5z5oV9XQ
         b8E4z28pHP512GLNeTW0I6IJFtE6jAIdEOhlGPkdPvzzqh3tXTl1Dje0ptx1AxmjAYT2
         oDIg==
X-Gm-Message-State: AO0yUKVara/WASTlqAP74OO7ZKr5jtz0+z/KTUrQoT/YfSfC/4QrBD7P
        8RnmtGB/kQf+lxMEFVRZqVY43ZPS03kHarqov2L9C0ZANdY=
X-Google-Smtp-Source: AK7set/lbgu6iY20MkIwfEXlIG00+BOvfS/4xtaMPCMdM4FLv7ggnGm97gCb8nJ1FA3FWg94/xNUi9BZG/xkh5aKYws=
X-Received: by 2002:ac2:4311:0:b0:4dd:a058:f088 with SMTP id
 l17-20020ac24311000000b004dda058f088mr2424535lfh.8.1677271293806; Fri, 24 Feb
 2023 12:41:33 -0800 (PST)
MIME-Version: 1.0
References: <1fd2d4523c139deda93aab2c31f1508d79c32472.1676921889.git.pav@iki.fi>
 <CABBYNZ+kGVtCXN1X7ZOG64mLfWfXBah_Qo5+cy2dGWQMbNidoA@mail.gmail.com> <cb4b657b13f21bd9f164a0c205e31e3a2184c6c8.camel@iki.fi>
In-Reply-To: <cb4b657b13f21bd9f164a0c205e31e3a2184c6c8.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 24 Feb 2023 12:41:21 -0800
Message-ID: <CABBYNZ+CTfOTh8KVo6r8o6wzAny+wB9=VnzWb=8+_39F-CMRRg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: ISO: fix timestamped HCI ISO data packet parsing
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Fri, Feb 24, 2023 at 11:52 AM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> ti, 2023-02-21 kello 14:08 -0800, Luiz Augusto von Dentz kirjoitti:
> > > Hi Pauli,
> > >
> > > On Mon, Feb 20, 2023 at 11:42 AM Pauli Virtanen <pav@iki.fi> wrote:
> > > > >
> > > > > Use correct HCI ISO data packet header struct when the packet has
> > > > > timestamp. The timestamp, when present, goes before the other fields
> > > > > (Core v5.3 4E 5.4.5), so the structs are not compatible.
> > > > >
> > > > > Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
> > > > > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > > > > ---
> > > > >
> > > > > Notes:
> > > > >     My hardware doesn't seem to produce timestamped packets, so this is not
> > > > >     properly tested, except to the extent that it doesn't break the
> > > > >     non-timestamped code path.
> > > > >
> > > > >     Regardless, the current state of things looks wrong, so sending this to
> > > > >     the list in any case.
> > >
> > > Perhaps we should first attempt to enable this in the emulator, Id use
> > > BT_HCI_CMD_LE_READ_ISO_TX_SYNC as hint that the host is interested in
> > > knowing the timestamp:
> > >
> > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/emulator/btdev.c#n5752
>
> Yes, it probably would be best, and probably not too complicated to do
> at least if we are happy with not per spec timestamps.
>
> > > > >  net/bluetooth/iso.c | 9 +++++++--
> > > > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> > > > > index 2dabef488eaa..cb959e8eac18 100644
> > > > > --- a/net/bluetooth/iso.c
> > > > > +++ b/net/bluetooth/iso.c
> > > > > @@ -1621,7 +1621,6 @@ static void iso_disconn_cfm(struct
> > > > > hci_conn *hcon, __u8 reason)
> > > > >  void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16
> > > > > flags)
> > > > >  {
> > > > >         struct iso_conn *conn = hcon->iso_data;
> > > > > -       struct hci_iso_data_hdr *hdr;
> > > > >         __u16 pb, ts, len;
> > > > >
> > > > >         if (!conn)
> > > > > @@ -1643,6 +1642,8 @@ void iso_recv(struct hci_conn *hcon,
> > > > > struct sk_buff *skb, u16 flags)
> > > > >                 }
> > > > >
> > > > >                 if (ts) {
> > > > > +                       struct hci_iso_ts_data_hdr *hdr;
> > > > > +
> > > > >                         /* TODO: add timestamp to the packet?
> > > > > */
> > >
> > > Perhaps we should use skb_set_delivery_time to set the timestamp as
> > > received by the controller? That said I don't know if the unit
> > > would
> > > be compatible.
>
> The userspace I think is interested also in the sequence number and
> packet status flags (if controller knows data is corrupted, that should
> be indicated to userspace, similarly for missed packets). Would e.g.
> putting all these into some custom cmsg struct be better here?
>
> This timestamp is also based on controller clock. Not sure if
> delivery_time is supposed to be in system clock not some unrelated
> hardware clock.
>
> Userspace may also want to set the packet sequence numbers and
> timestamps itself when sending, to indicate in which interval it wanted
> things to come out.
>
> On systems where synchronization to Controller ISO clock is not
> available (it IIUC cannot really be done via HCI and so this is likely
> the situation on desktop/laptop machines), userspace needs some other
> tool to keep its SDU timing in sync with the controller, and for e.g.
> keeping a fixed number of packets queued to have some buffer for missed
> deadlines, and making sure there is no timing offset between eg. left
> and right earpieces of TWS headset.

Yeah, btw I will be posting the patches for CSIP soon and I wonder if
you could check with this headset of yours, in fact we probably need
some changes to the likes of pipewire to detect the presence of
DeviceSet object and split the left and right streams.

> This probably means things like information on the timing of the latest
> Number of Completed Packets event for the handle, the number of
> currently queued ISO packets on the controller, and the sequence number
> of the latest packet queued on controller (to know how much is still in
> socket buffer). Probably also LE Read TX Sync information to know
> controller timestamp on a sent packet...
>
> Does this go via some new ioctls? Or send empty packets with some cmsg
> (so userspace can just poll until it needs to do something)?
>
> It should also be decided how much the kernel is going to be involved
> in getting the SDU timing, sequence numbers, etc. right, or whether
> it's just left to the userspace.
>
> Before trying to propose something here, I think I'd need to first make
> some prototypes so that it becomes clearer how it would best work.

I think we might want to use BT_PKT_STATUS, like is done for SCO, to
carry information such as controller timestamp, etc, have a look at
it:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/sco.c#n450

>
> > > > >                         hdr = skb_pull_data(skb,
> > > > > HCI_ISO_TS_DATA_HDR_SIZE);
> > > > >                         if (!hdr) {
> > > > > @@ -1650,15 +1651,19 @@ void iso_recv(struct hci_conn *hcon,
> > > > > struct sk_buff *skb, u16 flags)
> > > > >                                 goto drop;
> > > > >                         }
> > > > >
> > > > > +                       len = __le16_to_cpu(hdr->slen);
> > > > >                 } else {
> > > > > +                       struct hci_iso_data_hdr *hdr;
> > > > > +
> > > > >                         hdr = skb_pull_data(skb,
> > > > > HCI_ISO_DATA_HDR_SIZE);
> > > > >                         if (!hdr) {
> > > > >                                 BT_ERR("Frame is too short (len
> > > > > %d)", skb->len);
> > > > >                                 goto drop;
> > > > >                         }
> > > > > +
> > > > > +                       len = __le16_to_cpu(hdr->slen);
> > > > >                 }
> > > > >
> > > > > -               len    = __le16_to_cpu(hdr->slen);
> > > > >                 flags  = hci_iso_data_flags(len);
> > > > >                 len    = hci_iso_data_len(len);
> > > > >
> > > > > --
> > > > > 2.39.2
> > > > >
> > >
> > >
>
>


-- 
Luiz Augusto von Dentz

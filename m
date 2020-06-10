Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378DCC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 14:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DCB2207C3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 14:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgFJOCC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 10:02:02 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:39195 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729701AbgFJOCB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 10:02:01 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 550F0CECE5;
        Wed, 10 Jun 2020 16:11:49 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] sco:Add support for BT_PKT_STATUS CMSG data
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CALWDO_VHTT4V5GvPFtSZcW5Xce8oTSaLNdNQ1gNd=hyCaBX-yg@mail.gmail.com>
Date:   Wed, 10 Jun 2020 16:01:59 +0200
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <E431DB43-4BEC-4B4C-AC11-AD002E315099@holtmann.org>
References: <20200603145121.124842-1-alainm@chromium.org>
 <DCF83E8F-62CC-49F8-B660-0AFEDBED5F02@holtmann.org>
 <CALWDO_VHTT4V5GvPFtSZcW5Xce8oTSaLNdNQ1gNd=hyCaBX-yg@mail.gmail.com>
To:     Alain Michaud <alainmichaud@google.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> > This change adds support for reporting the BT_PKT_STATUS to the socket
> > CMSG data to allow the implementation of a packet loss correction on
> > erronous data received on the SCO socket.
> > 
> > The patch was partially developed by Marcel Holtmann and validated by
> > Hsin-yu Chao
> > 
> > Signed-off-by: Alain Michaud <alainm@chromium.org>
> > 
> > ---
> > 
> > include/net/bluetooth/bluetooth.h |  8 +++++++
> > include/net/bluetooth/sco.h       |  3 +++
> > net/bluetooth/af_bluetooth.c      |  3 +++
> > net/bluetooth/hci_core.c          |  1 +
> > net/bluetooth/sco.c               | 35 +++++++++++++++++++++++++++++++
> > 5 files changed, 50 insertions(+)
> 
> I already had this patch in my tree for testing, but then realized that I gave you a bad example on how to handle this.
> 
> So we should not use the same constants for CMSG and socket options. Fundamentally the socket semantics use SO_foo for enabling an aux data transmission and they use SCM_bar for the CMSG portion.
> 
> > 
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> > index 3fa7b1e3c5d9..85e6c5754448 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -147,6 +147,8 @@ struct bt_voice {
> > #define BT_MODE_LE_FLOWCTL    0x03
> > #define BT_MODE_EXT_FLOWCTL   0x04
> > 
> > +#define BT_PKT_STATUS          16
> > +
> > __printf(1, 2)
> > void bt_info(const char *fmt, ...);
> > __printf(1, 2)
> > @@ -275,6 +277,7 @@ struct bt_sock {
> >       struct sock *parent;
> >       unsigned long flags;
> >       void (*skb_msg_name)(struct sk_buff *, void *, int *);
> > +     void (*skb_put_cmsg)(struct sk_buff *, struct msghdr *, struct sock *);
> > };
> > 
> > enum {
> > @@ -324,6 +327,10 @@ struct l2cap_ctrl {
> >       struct l2cap_chan *chan;
> > };
> > 
> > +struct sco_ctrl {
> > +     u8      pkt_status;
> > +};
> > +
> > struct hci_dev;
> > 
> > typedef void (*hci_req_complete_t)(struct hci_dev *hdev, u8 status, u16 opcode);
> > @@ -350,6 +357,7 @@ struct bt_skb_cb {
> >       u8 incoming:1;
> >       union {
> >               struct l2cap_ctrl l2cap;
> > +             struct sco_ctrl sco;
> >               struct hci_ctrl hci;
> >       };
> > };
> > diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
> > index f40ddb4264fc..7f0d7bdc53f6 100644
> > --- a/include/net/bluetooth/sco.h
> > +++ b/include/net/bluetooth/sco.h
> > @@ -46,4 +46,7 @@ struct sco_conninfo {
> >       __u8  dev_class[3];
> > };
> > 
> > +/* CMSG flags */
> > +#define SCO_CMSG_PKT_STATUS  0x0001
> > +
> > #endif /* __SCO_H */
> > diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> > index 3fd124927d4d..d0abea8d08cc 100644
> > --- a/net/bluetooth/af_bluetooth.c
> > +++ b/net/bluetooth/af_bluetooth.c
> > @@ -286,6 +286,9 @@ int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> >               if (msg->msg_name && bt_sk(sk)->skb_msg_name)
> >                       bt_sk(sk)->skb_msg_name(skb, msg->msg_name,
> >                                               &msg->msg_namelen);
> > +
> > +             if (bt_sk(sk)->skb_put_cmsg)
> > +                     bt_sk(sk)->skb_put_cmsg(skb, msg, sk);
> >       }
> > 
> >       skb_free_datagram(sk, skb);
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 51d399273276..7b5e46198d99 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -4549,6 +4549,7 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
> > 
> >       if (conn) {
> >               /* Send to upper protocol */
> > +             bt_cb(skb)->sco.pkt_status = flags & 0x03;
> >               sco_recv_scodata(conn, skb);
> >               return;
> >       } else {
> > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > index c8c3d38cdc7b..f6b54853e547 100644
> > --- a/net/bluetooth/sco.c
> > +++ b/net/bluetooth/sco.c
> > @@ -66,6 +66,7 @@ struct sco_pinfo {
> >       bdaddr_t        dst;
> >       __u32           flags;
> >       __u16           setting;
> > +     __u32           cmsg_mask;
> >       struct sco_conn *conn;
> > };
> > 
> > @@ -449,6 +450,15 @@ static void sco_sock_close(struct sock *sk)
> >       sco_sock_kill(sk);
> > }
> > 
> > +static void sco_skb_put_cmsg(struct sk_buff *skb, struct msghdr *msg,
> > +                          struct sock *sk)
> > +{
> > +     if (sco_pi(sk)->cmsg_mask & SCO_CMSG_PKT_STATUS)
> > +             put_cmsg(msg, SOL_BLUETOOTH, BT_PKT_STATUS,
> 
> This needs an extra BT_SCM_PKT_STATUS constant.
> Since we don't have this name space defined yet, I'm assuming I just start with 01 for this. 

hmmm. Since we used to have a few HCI ones, just for the sake of never ever conflicting, I would say start after them.

/* CMSG flags */                                                                 
#define HCI_CMSG_DIR    0x0001                                                   
#define HCI_CMSG_TSTAMP 0x0002

So lets start with 3.

I think even for the socket numbering options we started with 4 to just make sure we never ever come into some weird conflict. Some of this code is 18+ years old ;)

Regards

Marcel


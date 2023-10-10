Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8045CD8CAF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Oct 2023 18:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbjJJSv6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Oct 2023 14:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjJJSv5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Oct 2023 14:51:57 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC4793
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 11:51:55 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c124adf469so69368061fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 11:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696963914; x=1697568714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKW46toLPO9ytSVySbAaKEOe7HoBW2vmuB9Ml9pg/ac=;
        b=VRm8GhX7w5c0XDxgNikTQp4uke244X1a37f9thuKWIhQHkKIIuPIyq2vHt3jPowSsg
         dfQZ0B7JT+EgDjKE4r5rJujIxI7FwejE/T2EB0bFFygLkZyj9yEpx3VVQ+/DvMW/LaT6
         wHxf8XTNXMV99H19lXa53wi6nvJvRVjdnyzjbQrBUPDhboAPPYNzhh0LpdtWpC0oinPy
         Z142Ly54M/0pdKG5Q9Yw9WR1PkJrBOiMNBOI0Bvwnbb9XyT3VxAjJgLWdOGQCjWbrUz9
         RIEtaVG3VIDaw9fPxe4ySbeOrCQWLiv0RU3a0oSCOjVozOuVPmveK2uLy/0uFyP9aEc6
         nErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696963914; x=1697568714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JKW46toLPO9ytSVySbAaKEOe7HoBW2vmuB9Ml9pg/ac=;
        b=NHlmr/ej0GKK+m97BtNMmuyDWWAWIDES0Qfa8VvLCt2Lkf2EM3aAVV3F8h2dmX9x3o
         FGXTWaJ67vcWZzr5CITUkPClj8QS0wbC/RSg4f/Jd0d2q0BEqLqB9vtOxcuACI4TvoiU
         COVUyKNseWm3tJVIy6IQpgnfdeTBi2edtISoswviomOdukfEpg5D242s7zeCBwmRdgJS
         32NyHK7sy52XUMIdOYjHlnAsl6NYlDsizw+Ey51dZJ7syslXt4rE5ieK0GOco69BuGsM
         m8IapdgtKa4tBou87ZCcWdEe7tpPMiq+cKncs7yPN2Gun/jG+PdckTHPD4ExDSvkhEk8
         PWNQ==
X-Gm-Message-State: AOJu0Yymi9VExZjhcA1+lY37P8r1/CheFp02MVLbpWWRPlaA4JFTkBwU
        bAWnxNsFkc316jq5fWSLaIR89WZTJVZIkIhH9kM=
X-Google-Smtp-Source: AGHT+IEmvBDVhZSOX0exUV4yrnssYoLD2n4z4zQJ9aWngIX/iKJeXCSLq5wukQfBa6RY/8IMQdzcI0MjWCiiKSsqfDY=
X-Received: by 2002:a2e:2e15:0:b0:2bc:f439:b5a5 with SMTP id
 u21-20020a2e2e15000000b002bcf439b5a5mr19082210lju.14.1696963913285; Tue, 10
 Oct 2023 11:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231009123045.587882-1-william.xuanziyang@huawei.com>
 <117a47da5324a02cece6d601ff8b51b331d072fa.camel@iki.fi> <8f61ef8e-f959-3feb-fb9b-b9b60bf26758@huawei.com>
 <a72b89cd520f502d6d384f97fcaf83f92ead147f.camel@iki.fi>
In-Reply-To: <a72b89cd520f502d6d384f97fcaf83f92ead147f.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 10 Oct 2023 11:51:41 -0700
Message-ID: <CABBYNZKiXwGWR296TU7_4wVMsemzY=mV2CUo-DDMYvSAWX5RwQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Fix UAF for hci_chan
To:     Pauli Virtanen <pav@iki.fi>
Cc:     "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Tue, Oct 10, 2023 at 11:32=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> ti, 2023-10-10 kello 20:49 +0800, Ziyang Xuan (William)
> kirjoitti:[clip]
> > > >
> > > > - if (atomic_dec_and_test(&conn->refcnt)) {
> > > > + if (atomic_dec_and_test(&conn->refcnt) &&
> > > > +     !test_bit(HCI_CONN_DISC, &conn->flags)) {
> > > >           unsigned long timeo;
> > >
> > > hci_abort_conn already checks if conn->abort_reason was already set, =
to
> > > avoid queuing abort for the same conn again. Does this flag not try t=
o
> > > do the same thing?
> >
> > That is not enough. hci_conn occur UAF in hci_proto_disconn_ind() befor=
e enter
> > hci_abort_conn().
>
> Thanks, this was not clear to me from the patch.
>
> So the problem is that the cancel_delayed_work_sync(&conn->disc_work)
> in hci_conn_del doesn't help in a few cases:
>
> 1. [task A] hci_conn_del(conn) entered
> 2. [A] cancel_delayed_work_sync(conn->disc_work)
> 3. [B] concurrent hci_conn_drop(conn) queues disc_work again
> 4. [A] hci_conn_del finishes
> 5. UAF when disc_work runs
>
> or without needing concurrency
>
> 1. hci_conn_del(conn) entered and finishes
> 2. hci_conn_drop(conn); hci_conn_put(conn); as done in several places
>
> ?

Either way Im not sure what the IDA logic has to with it, that said I
think using ida function is actually a much better solution then the
lookup one so I would be happy to apply it if someone split the
changes related to it and send a patch.

> The hci_conn_del here is not necessarily from hci_abort_conn. Should
> the atomic flag be set in hci_conn_del before
> cancel_delayed_work_sync(&conn->disc_work) to catch possible other
> cases?
>
> > > There are potential races in hci_sync vs. handle reuse since the queu=
ed
> > > abort is not canceled if the conn is deleted by something else. But n=
ow
> > > I'm not sure syzbot hits this race.
> >
> > Sorry, can you give a specific scenario. I can't understand exactly wha=
t you mean.
>
> As noted in the other patch:
>
> 1. hci_conn_abort(conn)
>
> 2. hci_cmd_sync_queue(hdev,abort_conn_sync,UINT_PTR(conn->handle))
>
> 3. something else (e.g. HCI event) deletes conn
>
> 4. something else (e.g. HCI event) creates conn2, with same handle
>    value
>
> 5. Queued abort_conn_sync executes. It needs to be delayed enough,
>    but doesn't need to be concurrent.
>
> 6. abort_conn_sync uses queued handle value, finds conn2 (not conn)
>
> 7. hci_abort_conn_sync(conn2, conn2->abort_reason)
>
> 8. Calling hci_abort_conn_sync with reason =3D=3D 0 causes UAF
>
> The UAF is because reason=3D=3D0 is passed to l2cap_disconn_ind which doe=
s
> not signal disconnection to the L2CAP layer, hci_abort_conn_sync
> deletes conn immediately after that, and later on L2CAP tries to access
> stale conn pointer.

Are you looking into implementing the cancel logic for abort? Long ago
Ive send a patch to introduce the queue_one logic which does include a
function to lookup into the cmd_sync queue, perhaps we can reuse that
to implement the cancel logic.

> > > >
> > > >           switch (conn->type) {
> > > > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > > > index 974631e652c1..f87281b4386f 100644
> > > > --- a/net/bluetooth/hci_conn.c
> > > > +++ b/net/bluetooth/hci_conn.c
> > > > @@ -153,6 +153,9 @@ static void hci_conn_cleanup(struct hci_conn *c=
onn)
> > > >
> > > >
> > > >
> > > >
> > > >   hci_conn_hash_del(hdev, conn);
> > > >
> > > >
> > > >
> > > >
> > > > + if (HCI_CONN_HANDLE_UNSET(conn->handle))
> > > > +         ida_free(&hdev->unset_handle_ida, conn->handle);
> > > > +
> > > >   if (conn->cleanup)
> > > >           conn->cleanup(conn);
> > > >
> > > >
> > > >
> > > >
> > > > @@ -929,29 +932,17 @@ static void cis_cleanup(struct hci_conn *conn=
)
> > > >   hci_le_remove_cig(hdev, conn->iso_qos.ucast.cig);
> > > >  }
> > > >
> > > >
> > > >
> > > >
> > > > -static u16 hci_conn_hash_alloc_unset(struct hci_dev *hdev)
> > > > +static int hci_conn_hash_alloc_unset(struct hci_dev *hdev)
> > > >  {
> > > > - struct hci_conn_hash *h =3D &hdev->conn_hash;
> > > > - struct hci_conn  *c;
> > > > - u16 handle =3D HCI_CONN_HANDLE_MAX + 1;
> > > > -
> > > > - rcu_read_lock();
> > > > -
> > > > - list_for_each_entry_rcu(c, &h->list, list) {
> > > > -         /* Find the first unused handle */
> > > > -         if (handle =3D=3D 0xffff || c->handle !=3D handle)
> > > > -                 break;
> > > > -         handle++;
> > > > - }
> > > > - rcu_read_unlock();
> > >
> > > The original hci_conn_hash_alloc_unset seems to have wrong logic. It'=
ll
> > > e.g. always return HCI_CONN_HANDLE_MAX+1 except if the first conn in
> > > conn_hash (which is not in particular order) has that handle...
> > >
> > > The code paths adding/deleting conns or entering here / setting handl=
es
> > > should be holding hdev->lock, so probably no concurrency issue in it.
> > >
> > > Is syzbot happy with just this handle allocation fixed?
> >
> > Just fix handle, hci_conn occur UAF in hci_proto_disconn_ind() within h=
ci_conn_timeout() process.
> >
> > >
> > > > -
> > > > - return handle;
> > > > + return ida_alloc_range(&hdev->unset_handle_ida, HCI_CONN_HANDLE_M=
AX + 1,
> > > > +                        U16_MAX, GFP_ATOMIC);
> > > >  }
> > > >
> > > >
> > > >
> > > >
> > >
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz

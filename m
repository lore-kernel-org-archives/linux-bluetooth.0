Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49558C77B7F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 May 2023 13:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjECNPt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 May 2023 09:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjECNPs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 May 2023 09:15:48 -0400
Received: from pku.edu.cn (mx19.pku.edu.cn [162.105.129.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7263559D1
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 May 2023 06:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:References:MIME-Version:Content-Type:
        Content-Disposition:Content-Transfer-Encoding:In-Reply-To; bh=SP
        LT0FPYcL3nPhjYRtiYM/9sciuTKxUsbM8Z1rQ6hQc=; b=PJzxmkhEMPt4c3TXuM
        vXXMsU3MJLt5QW44hckQEeu6kGeMYlNmvbBzylXMFPd0TSzsxQCOyHlJfwEaku0C
        zj+ExxW3qkpJ7FD2eN4a8AjF8lIkM0du7vgzM7BfUsjnv08PRcTaPN3rngNPoFGQ
        uPq/4qXPKA4XFAbv7Gf6Awh+Y=
Received: from localhost (unknown [10.7.101.92])
        by front02 (Coremail) with SMTP id 54FpogDX3k51XlJksfpmEg--.9463S2;
        Wed, 03 May 2023 21:15:40 +0800 (CST)
Date:   Wed, 3 May 2023 21:15:33 +0800
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Ruihan Li <lrh2000@pku.edu.cn>
Subject: Re: [PATCH v3 6/6] Bluetooth: Avoid recursion in hci_conn_unlink
Message-ID: <55zqfg4flsequzz3ho2xqy775b5y7yj6r7qlwd2qizlhrc37r6@36pnpkoa5b4y>
References: <20230502145737.140856-1-lrh2000@pku.edu.cn>
 <20230502145737.140856-7-lrh2000@pku.edu.cn>
 <CABBYNZJS3QLbCPizwaTaKmy13+34vNLFo2YMy2cMS3zwvVeZsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZJS3QLbCPizwaTaKmy13+34vNLFo2YMy2cMS3zwvVeZsw@mail.gmail.com>
X-CM-TRANSID: 54FpogDX3k51XlJksfpmEg--.9463S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4kGr47JF4fuFyUCFW3Jrb_yoWrAw1rpa
        45Way3JF48J3Z3uF42vw1kJrn0qr1kAF9xKrWrtFyxAws0vr1vyr4Fk3WUKry5ArWkWFyx
        ZF4Ut3Z7KFs8G3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvG1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24V
        AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF
        04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26w4UJr1UMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
        73UjIFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEPBVPy77wh+AAlsH
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Tue, May 02, 2023 at 09:18:02AM -0700, Luiz Augusto von Dentz wrote:
> Hi Ruihan,
> 
> On Tue, May 2, 2023 at 7:57 AM Ruihan Li <lrh2000@pku.edu.cn> wrote:
> >
> > Previously, hci_conn_unlink was implemented as a recursion function. To
> > unlink physical connections (e.g. ACL/LE), it calls itself to unlink all
> > its logical channels (e.g. SCO/eSCO/ISO).
> >
> > Recursion is not required. This patch refactors hci_conn_unlink into two
> > functions, where hci_conn_unlink_parent takes a physical connection,
> > checks out all its logical channels, and calls hci_conn_unlink_child for
> > each logical channel to unlink it.
> >
> > Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
> > ---
> >  net/bluetooth/hci_conn.c | 55 +++++++++++++++++++++++-----------------
> >  1 file changed, 32 insertions(+), 23 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index de553e062..243d68a64 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -1074,34 +1074,13 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
> >         return conn;
> >  }
> >
> > -static void hci_conn_unlink(struct hci_conn *conn)
> > +static void hci_conn_unlink_parent(struct hci_conn *conn)
> >  {
> >         struct hci_dev *hdev = conn->hdev;
> >
> >         bt_dev_dbg(hdev, "hcon %p", conn);
> >
> > -       if (!conn->parent) {
> > -               struct hci_link *link, *t;
> > -
> > -               list_for_each_entry_safe(link, t, &conn->link_list, list) {
> > -                       struct hci_conn *child = link->conn;
> > -
> > -                       hci_conn_unlink(child);
> > -
> > -                       /* Due to race, SCO connection might be not established
> > -                        * yet at this point. Delete it now, otherwise it is
> > -                        * possible for it to be stuck and can't be deleted.
> > -                        */
> > -                       if ((child->type == SCO_LINK ||
> > -                            child->type == ESCO_LINK) &&
> > -                           child->handle == HCI_CONN_HANDLE_UNSET)
> > -                               hci_conn_del(child);
> > -               }
> > -
> > -               return;
> > -       }
> > -
> > -       if (!conn->link)
> > +       if (WARN_ON(!conn->link))
> >                 return;
> >
> >         list_del_rcu(&conn->link->list);
> > @@ -1115,6 +1094,36 @@ static void hci_conn_unlink(struct hci_conn *conn)
> >         conn->link = NULL;
> >  }
> >
> > +static void hci_conn_unlink_children(struct hci_conn *conn)
> > +{
> > +       struct hci_dev *hdev = conn->hdev;
> > +       struct hci_link *link, *t;
> > +
> > +       bt_dev_dbg(hdev, "hcon %p", conn);
> > +
> > +       list_for_each_entry_safe(link, t, &conn->link_list, list) {
> > +               struct hci_conn *child = link->conn;
> > +
> > +               hci_conn_unlink_parent(child);
> > +
> > +               /* Due to race, SCO connection might be not established
> > +                * yet at this point. Delete it now, otherwise it is
> > +                * possible for it to be stuck and can't be deleted.
> > +                */
> > +               if (child->type == SCO_LINK || child->type == ESCO_LINK)
> > +                       if (child->handle == HCI_CONN_HANDLE_UNSET)
> > +                               hci_conn_del(child);
> > +       }
> 
> This is not quite right, when we are unlinking the children's hci_conn
> it shall only unlink itself from the parent not everything.

My assumption is that each hci_conn is either
 * a logical channel, which implies that it has a parent and no
   children, or
 * a physical link, which means that it has no parent and possibly some
   children.
So here, as children of physical links, they must be logical channels
and thus cannot have more children, so just unlinking them from the
parent should be ok. We can add some assertions like
	WARN_ON(!conn->parent || !conn->link)   // conn has a parent
	WARN_ON(!list_empty(&conn->link_list))  // conn has no children
in hci_conn_unlink_parent.

Do you think this assumption is wrong, or could become wrong in the
future? Otherwise, I don't think there are correctness problems.

In my opinion, separating the functions for logical channels and
physical links makes the code a bit cleaner. But it's my opinion, if you
think it actually makes the code harder to understand, I won't insist.

> 
> > +}
> > +
> > +static void hci_conn_unlink(struct hci_conn *conn)
> > +{
> > +       if (conn->parent)
> > +               hci_conn_unlink_parent(conn);
> > +       else
> > +               hci_conn_unlink_children(conn);
> > +}
> > +
> >  void hci_conn_del(struct hci_conn *conn)
> >  {
> >         struct hci_dev *hdev = conn->hdev;
> > --
> > 2.40.0
> >
> 
> 
> -- 
> Luiz Augusto von Dentz

Thanks,
Ruihan Li


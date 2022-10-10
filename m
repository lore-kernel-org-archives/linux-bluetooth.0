Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326ABC433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Oct 2022 19:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJJTKC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Oct 2022 15:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJJTKB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Oct 2022 15:10:01 -0400
X-Greylist: delayed 90 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Oct 2022 12:09:57 PDT
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF56527154
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Oct 2022 12:09:56 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 63B85240105
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Oct 2022 21:08:25 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4MmT2w4VTbz6tpW;
        Mon, 10 Oct 2022 21:08:24 +0200 (CEST)
Message-ID: <71ac3f7a801192980142beb34d618770802d9a4c.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: hci_conn: Fix CIS connection dst_type
 handling
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Date:   Mon, 10 Oct 2022 19:08:23 +0000
In-Reply-To: <CABBYNZ+KzN_4w2x4en+fXP+SqwA5-WF_SNL_Q7dRmiCN1JQLNw@mail.gmail.com>
References: <20221009174216.17533-1-pav@iki.fi>
         <CABBYNZ+KzN_4w2x4en+fXP+SqwA5-WF_SNL_Q7dRmiCN1JQLNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

su, 2022-10-09 kello 14:45 -0700, Luiz Augusto von Dentz kirjoitti:
[clip]
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 9777e7b109ee..78d8b8b7fd72 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -1691,12 +1691,19 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
> >  {
> >         struct hci_conn *cis;
> > 
> > +       /* Convert from ISO socket address type to HCI address type  */
> > +       if (dst_type == BDADDR_LE_PUBLIC)
> > +               dst_type = ADDR_LE_DEV_PUBLIC;
> > +       else
> > +               dst_type = ADDR_LE_DEV_RANDOM;
> > +
> >         cis = hci_conn_hash_lookup_cis(hdev, dst, dst_type);
> >         if (!cis) {
> >                 cis = hci_conn_add(hdev, ISO_LINK, dst, HCI_ROLE_MASTER);
> >                 if (!cis)
> >                         return ERR_PTR(-ENOMEM);
> >                 cis->cleanup = cis_cleanup;
> > +               cis->dst_type = dst_type;
> >         }
> > 
> >         if (cis->state == BT_CONNECTED)
> > @@ -2075,20 +2082,21 @@ struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
> >  {
> >         struct hci_conn *le;
> >         struct hci_conn *cis;
> > +       u8 hci_dst_type;
> > 
> >         /* Convert from ISO socket address type to HCI address type  */
> >         if (dst_type == BDADDR_LE_PUBLIC)
> > -               dst_type = ADDR_LE_DEV_PUBLIC;
> > +               hci_dst_type = ADDR_LE_DEV_PUBLIC;
> >         else
> > -               dst_type = ADDR_LE_DEV_RANDOM;
> > +               hci_dst_type = ADDR_LE_DEV_RANDOM;
> 
> Nice catch, though I think we should make sure these types are not
> from hci_conn.c as the name suggest these should be dealing HCI
> procedures so it doesn't make much sense to propagate types other than
> HCI.

Not sure I parse right: You want to move the conversions to the
callsite in iso.c? Or change the variable name here? If the former,
there are a few other instances of these in hci_conn.c.

> >         if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
> > -               le = hci_connect_le(hdev, dst, dst_type, false,
> > +               le = hci_connect_le(hdev, dst, hci_dst_type, false,
> >                                     BT_SECURITY_LOW,
> >                                     HCI_LE_CONN_TIMEOUT,
> >                                     HCI_ROLE_SLAVE);
> >         else
> > -               le = hci_connect_le_scan(hdev, dst, dst_type,
> > +               le = hci_connect_le_scan(hdev, dst, hci_dst_type,
> >                                          BT_SECURITY_LOW,
> >                                          HCI_LE_CONN_TIMEOUT,
> >                                          CONN_REASON_ISO_CONNECT);
> > --
> > 2.37.3
> > 
> 
> While at it probably makes sense to introduce a test to iso-tester
> that uses random address rather than always using public, that way we
> can make sure we exercise this code with CI.

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D8AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 19:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58DDE61AF0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 19:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbhKSTsx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 14:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbhKSTsx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 14:48:53 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2998C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Nov 2021 11:45:50 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id y5so23418821ual.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Nov 2021 11:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+4tc0ntOhCclSD+BFMB8/sgCoHWpgh7F5X75yTVa9SA=;
        b=JV1RoyTSD42VQiif5/qy3BwtJMuqMVchVkMV9WT4po9H2/iJ2DQi8CcWtp2LmKHP1+
         60aEYDgzFZHaRScpWDlvtUtH4IgtgubMuPQ3VrVmeAa2g71lY4Uwf3OLeVzOH50ylU5x
         2/H6rrZdqzHvEbcGcSDG1dObjR6bzADGvxAdXly4n+AuhCDrQvJl92DKj/Y7lJlAZLrG
         pU4IW9R/gGp167d5pPqhfk5q3YPqPHnSwV55ROAfZkLg5i0mNl6v0Ff/CVH6vfwR7bge
         rjuwH4+0V/qDWB8ndIvRQFON3tTdS97RDzG3Vk+xoT7w8UsQciDV5S8AuNkA+urPV6Bf
         9fAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+4tc0ntOhCclSD+BFMB8/sgCoHWpgh7F5X75yTVa9SA=;
        b=3NaYSldWZ1dIeKbl35xJrFBS3WKuOHoqnFpzsD0IGk1hw8ViaxzrVrjgyEsuNDTZmP
         n7JDCAJ4aKBx+s0Gy5Sy3ulTeLTIc/DD8ylxyQp+i19TMDhvErEMJucuhEZg7XC6MIMC
         mI0Acz+jYs+quQeWvltTauZsudr7x+1WMTDQdBkqd6z44lh7D5QHDMGn5JaLxJG6/HHk
         la/k9TMyti7Qp3EDKwOT80jnhweq+mu9886R4vDzZE1fRy8X3VqrTPxCfXBYRCkpEdsE
         6PcIMirUX2POetd9hX1i2HasspejoM1oJBDBf4P6q9g7GdVBFJRKjVFWumg8dX4fIT9V
         fpHA==
X-Gm-Message-State: AOAM5327hxtlN9UBB6S7n4kDfRLpKExoeqAaw8EZumERfYxKlwaizfOx
        53JXO05nVKPllGxoz9UWeSqZmoCULmAOqU75ETV0MGtoSQo=
X-Google-Smtp-Source: ABdhPJwvA5uK8utzJ++foN3aowBlc4vTNnhyYeH3ocn1g2JoMV+RcaSPW/17aiJFUaITt8AKK0sD5wIzAEKv4SnCucY=
X-Received: by 2002:a67:fd90:: with SMTP id k16mr96509150vsq.39.1637351149877;
 Fri, 19 Nov 2021 11:45:49 -0800 (PST)
MIME-Version: 1.0
References: <20211118231302.1000168-1-luiz.dentz@gmail.com>
 <20211118231302.1000168-2-luiz.dentz@gmail.com> <7E27934B-018E-462D-8593-A873C0206A7D@holtmann.org>
In-Reply-To: <7E27934B-018E-462D-8593-A873C0206A7D@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 19 Nov 2021 11:45:39 -0800
Message-ID: <CABBYNZLBafQFgKSLmw+NQW1fy-5TZceiiCq1-9uxGMf878pF2Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Bluetooth: hci_sync: Set Privacy Mode when
 updating the resolving list
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Fri, Nov 19, 2021 at 2:02 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > This adds support for Set Privacy Mode when updating the resolving list
> > when HCI_CONN_FLAG_DEVICE_PRIVACY so the controller shall use Device
> > Mode for devices programmed in the resolving list, Device Mode is
> > actually required when the remote device are not able to use RPA as
> > otherwise the default mode is Network Privacy Mode in which only
> > allows RPAs thus the controller would filter out advertisement using
> > identity addresses for which there is an IRK.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > include/net/bluetooth/hci.h      | 10 ++++++
> > include/net/bluetooth/hci_core.h |  1 +
> > net/bluetooth/hci_event.c        | 29 +++++++++++++++++
> > net/bluetooth/hci_sync.c         | 53 ++++++++++++++++++++++++++++----
> > 4 files changed, 87 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 84db6b275231..7444d286e6be 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -1931,6 +1931,16 @@ struct hci_rp_le_read_transmit_power {
> >       __s8  max_le_tx_power;
> > } __packed;
> >
> > +#define HCI_NETWORK_PRIVACY          0x00
> > +#define HCI_DEVICE_PRIVACY           0x01
> > +
> > +#define HCI_OP_LE_SET_PRIVACY_MODE   0x204e
> > +struct hci_cp_le_set_privacy_mode {
> > +     __u8  bdaddr_type;
> > +     bdaddr_t  bdaddr;
> > +     __u8  mode;
> > +} __packed;
> > +
> > #define HCI_OP_LE_READ_BUFFER_SIZE_V2 0x2060
> > struct hci_rp_le_read_buffer_size_v2 {
> >       __u8    status;
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > index 42ba40df6e20..0b3de5411948 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -755,6 +755,7 @@ struct hci_conn_params {
> >
> >       struct hci_conn *conn;
> >       bool explicit_connect;
> > +     u8  privacy_mode;
> >       u32 current_flags;
> > };
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index efc5458b1345..51c88f4f1274 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -1300,6 +1300,31 @@ static void hci_cc_le_read_transmit_power(struct hci_dev *hdev,
> >       hdev->max_le_tx_power = rp->max_le_tx_power;
> > }
> >
> > +static void hci_cc_le_set_privacy_mode(struct hci_dev *hdev,
> > +                                    struct sk_buff *skb)
> > +{
> > +     __u8 status = *((__u8 *)skb->data);
> > +     struct hci_cp_le_set_privacy_mode *cp;
> > +     struct hci_conn_params *params;
> > +
> > +     bt_dev_dbg(hdev, "status 0x%2.2x", status);
> > +
> > +     if (status)
> > +             return;
> > +
> > +     cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_PRIVACY_MODE);
> > +     if (!cp)
> > +             return;
> > +
> > +     hci_dev_lock(hdev);
> > +
> > +     params = hci_conn_params_lookup(hdev, &cp->bdaddr, cp->bdaddr_type);
> > +     if (params)
> > +             params->privacy_mode = cp->mode;
> > +
> > +     hci_dev_unlock(hdev);
> > +}
> > +
> > static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
> > {
> >       __u8 *sent, status = *((__u8 *) skb->data);
> > @@ -3812,6 +3837,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
> >               hci_cc_le_read_transmit_power(hdev, skb);
> >               break;
> >
> > +     case HCI_OP_LE_SET_PRIVACY_MODE:
> > +             hci_cc_le_set_privacy_mode(hdev, skb);
> > +             break;
> > +
> >       default:
> >               BT_DBG("%s opcode 0x%4.4x", hdev->name, *opcode);
> >               break;
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index ad86caf41f91..08acd664590b 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -1580,8 +1580,42 @@ static int hci_le_add_resolve_list_sync(struct hci_dev *hdev,
> >                                    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> > }
> >
> > +/* Set Device Privacy Mode. */
> > +static int hci_le_set_privacy_mode_sync(struct hci_dev *hdev,
> > +                                     struct hci_conn_params *params)
> > +{
> > +     struct hci_cp_le_set_privacy_mode cp;
> > +     struct smp_irk *irk;
> > +
> > +     /* If device privacy mode has already been set there is nothing to do */
> > +     if (params->privacy_mode == HCI_DEVICE_PRIVACY)
> > +             return 0;
> > +
> > +     /* Set Privacy Mode requires the use of resolving list (aka. LL Privacy)
> > +      * by default Network Mode is used so only really send the command if
> > +      * Device Mode is required (HCI_CONN_FLAG_DEVICE_PRIVACY).
> > +      */
> > +     if (!privacy_mode_capable(hdev) ||
> > +         !hci_conn_test_flag(HCI_CONN_FLAG_DEVICE_PRIVACY,
> > +                             params->current_flags))
> > +             return 0;
>
> does this also account for the fact that LL Privacy is behind an experimental option. I think in the previous patch it is more important to check if LL Privacy is actually enabled via experimental setting.

Yep, it does check it:

#define privacy_mode_capable(dev) (use_ll_privacy(dev) && \
   (hdev->commands[39] & 0x04))

That said, maybe we should check it again since one wouldn't be able
to set HCI_CONN_FLAG_DEVICE_PRIVACY as it wouldn't be supported.

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz

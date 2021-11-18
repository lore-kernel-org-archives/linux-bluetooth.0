Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D72DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Nov 2021 16:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54F8661A38
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Nov 2021 16:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbhKRQP0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbhKRQP0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Nov 2021 11:15:26 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41663C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Nov 2021 08:12:26 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id t13so14762375uad.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Nov 2021 08:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ey3c0OFaOvK3srY8jOIhTfsqGX6LvMoaX33DDv/RJU=;
        b=OmaN/EmruivFPmSR3qFmmmJkpGhJc6DSdbD2EN9LVAnML/DOTjhS65h+8RWDjLYVRX
         VsJ41y3mqVGmz85QWrHRWgU9vU7UKOlIfgfYWDWw2Sn8cULorBpC0vcIv9TBJprjSU9m
         dC20Ves+h0P9xVNv83KJIKFQI1xfntjUg51ZOGY0YwcQ8hh2V/q3GXHOfxvPrf9eIOAy
         YhfW+vPs4B70sdv2KBQ2T5ml4GlyDakrOflTRlKIfllbkRJe06/2g5/keqJSZeFhUXd6
         nQMVZfFD2s4ezt095EruimD1DYnQddI4BT7a+JQDvavHk2Wl8UUGNugcP4nKF6tgMroD
         LTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ey3c0OFaOvK3srY8jOIhTfsqGX6LvMoaX33DDv/RJU=;
        b=Y1dIyaM9oiDMemS6gqOfWZZ/rMbhy3iR7gIxM1I8fA57BJfgSHBW6y3ZxgyWtbhR3B
         Vrq5coIDb9StbHLQbE1BKeklOLMNwH55DHS7hE2I1c6uLBPnBjkiyEGqDkdcWnCQ0GqE
         IAljYoLDA1dxU2YRiGutekTcXODEJ5T8IblyZn8SysylPmDkZddLO8JwFInbz2d6M7Fz
         4JXSH3UWlHHdUaMycQkLMu8LRV5Y5kNdO6Hs+srQTryWcehUv61OSniVoxS9Lz31uCmG
         7qpov3d/OiE8yVkkjSSubSpC0q4dPGXYKqy3yl/kp80pSrxkV+p4pCNiV7lCcrgpfP3f
         Zzcw==
X-Gm-Message-State: AOAM531vxh5sZM5lJ7eeXK2Huml/klUBW3CMnRr4M6aUIhPcvH2goJRP
        Z5NF1ODyEsFBdgF2GA3Ji3pTkPWEzhB+vJWkTOHScBE/
X-Google-Smtp-Source: ABdhPJz0rOwylGE4CEb570eWYxR/rCmNDeigRH+fCXQSQFozQqUwL8NzpJ7YhM33m0LBXBZdwoxTMPKMEl6C3fLILnk=
X-Received: by 2002:ab0:4465:: with SMTP id m92mr37938807uam.47.1637251945296;
 Thu, 18 Nov 2021 08:12:25 -0800 (PST)
MIME-Version: 1.0
References: <20211105222739.461398-1-luiz.dentz@gmail.com> <20211105222739.461398-2-luiz.dentz@gmail.com>
 <2837B8C6-392C-4CA5-9DF3-6EC81DE207F9@holtmann.org>
In-Reply-To: <2837B8C6-392C-4CA5-9DF3-6EC81DE207F9@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 18 Nov 2021 08:12:14 -0800
Message-ID: <CABBYNZ+XRvWOeYw8f8mQYOrJuzaLtA9YavY_P0=kDknU2e2-uw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Bluetooth: hci_sync: Set Privacy Mode when
 updating the resolving list
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Nov 17, 2021 at 8:46 PM Marcel Holtmann <marcel@holtmann.org> wrote:
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
> > index 63065bc01b76..979da5179ff4 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -1930,6 +1930,16 @@ struct hci_rp_le_read_transmit_power {
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
> > index 07d2d099dc2a..cb5684da3ed4 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -758,6 +758,7 @@ struct hci_conn_params {
> >
> >       struct hci_conn *conn;
> >       bool explicit_connect;
> > +     uint8_t privacy_mode;
>
> actually u8 please.

Ah nice catch, I really wish that was a way to catch this sort of
mistake with CI but checkpatch doesn't seem to have a rule for it.

> >       u32 current_flags;
> > };
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index d4b75a6cfeee..9cadc543abcb 100644
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
> > index b794605dc882..32ed7da3b6dd 100644
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
> > +
> > +     irk = hci_find_irk_by_addr(hdev, &params->addr, params->addr_type);
> > +     if (!irk)
> > +             return 0;
> > +
> > +     memset(&cp, 0, sizeof(cp));
> > +     cp.bdaddr_type = irk->addr_type;
> > +     bacpy(&cp.bdaddr, &irk->bdaddr);
> > +     cp.mode = HCI_DEVICE_PRIVACY;
> > +
> > +     return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_PRIVACY_MODE,
> > +                                  sizeof(cp), &cp, HCI_CMD_TIMEOUT);
> > +}
> > +
> > /* Adds connection to allow list if needed, if the device uses RPA (has IRK)
> > - * this attempts to program the device in the resolving list as well.
> > + * this attempts to program the device in the resolving list as well and
> > + * properly set the privacy mode.
> >  */
> > static int hci_le_add_accept_list_sync(struct hci_dev *hdev,
> >                                      struct hci_conn_params *params,
> > @@ -1590,11 +1624,6 @@ static int hci_le_add_accept_list_sync(struct hci_dev *hdev,
> >       struct hci_cp_le_add_to_accept_list cp;
> >       int err;
> >
> > -     /* Already in accept list */
> > -     if (hci_bdaddr_list_lookup(&hdev->le_accept_list, &params->addr,
> > -                                params->addr_type))
> > -             return 0;
> > -
> >       /* Select filter policy to accept all advertising */
> >       if (*num_entries >= hdev->le_accept_list_size)
> >               return -ENOSPC;
> > @@ -1620,6 +1649,18 @@ static int hci_le_add_accept_list_sync(struct hci_dev *hdev,
> >               return err;
> >       }
> >
> > +     /* Set Privacy Mode */
> > +     err = hci_le_set_privacy_mode_sync(hdev, params);
> > +     if (err) {
> > +             bt_dev_err(hdev, "Unable to set privacy mode: %d", err);
> > +             return err;
> > +     }
> > +
> > +     /* Check if already in accept list */
> > +     if (hci_bdaddr_list_lookup(&hdev->le_accept_list, &params->addr,
> > +                                params->addr_type))
> > +             return 0;
> > +
> >       *num_entries += 1;
> >       cp.bdaddr_type = params->addr_type;
> >       bacpy(&cp.bdaddr, &params->addr);
>
> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz

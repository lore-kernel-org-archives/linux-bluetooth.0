Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C83C00140
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Aug 2022 22:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiHJW0n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Aug 2022 18:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiHJW0m (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Aug 2022 18:26:42 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BB68D3E5
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 15:26:41 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b16so20872837edd.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 15:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=Igs1I7eqEMN5M26+HiNC3VGFg46jmCOcNqc8dAjQ9wQ=;
        b=erJV2Pn4lUxZeCKjye4tdiaEU7zdvbVXpZ/l/Yoc7vTZ/TXFOboNBm28d5w0JIu6Y6
         71oNe4DjMaH4gTE0VMtSg8CF3FaGjqdDTxCQADNl2Al5PvrSIMJIEWMfXq80yld/jz4r
         naJlAHUNqy3ky82hpDnromplpti8+B5cVYkZRCUOYbkv0j4u3EJtOOglPbtbJaEpMtpL
         RYztMCHIu21iz3eNYRqkNiP6D8H5vUrs0ZqKMCN663wN0reYykZcQeI0jc7YslotyTyf
         Uv8oGRa3B94RW5fJgR9+BxCTIGZ1FTuepnxj5eveObS3Kg95T+3u8DkOZOrSemqP6Oft
         G7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=Igs1I7eqEMN5M26+HiNC3VGFg46jmCOcNqc8dAjQ9wQ=;
        b=bR88ZVpHID3QfXf0Uq026cuofHrpGl2//NsOWfe3pQbREQVQj6YA3dqvhdam6ZDYqH
         JROXmX5pSbILA/n8svsD4Lqwdu+4+anmQKN7DSq/MzLL5d0x2s7zGKl1GXEVdOsB1M6+
         5hOTSb7yixewZ8vEEBCIpvqjEeseacwlkaBwI6mqqY72KCOTqceyMHXdbIC5rI7ISLWv
         cHAjhmfoJS7AA5xODRJ+gW6td9ixcsMZb5+zsumW0QUGC9gKEXbydZyakfzuHqBolT3Y
         EJi40tk81L1bhP6qhEgSlnsyknKyhKH4d/+OF8U0RN39MvqiviWi1C6niYgmjeThn66M
         MdFQ==
X-Gm-Message-State: ACgBeo3SuNNJLNNJcB60oddzUpcpLb7O/lStK6tr5rgX7rsT88vQX3eJ
        syDOjKpJUJBQlSowsL1Jund6TdQLSjYSeB1cVD0=
X-Google-Smtp-Source: AA6agR4YAYOQVZUXVyh2ov1xFhxJkM8S4Tw5Eet3DKyJ/0O8WVKJMHnN4PlSKHD/SDadnqzovnhQesl34OpqRaJWkZ8=
X-Received: by 2002:a05:6402:438d:b0:43d:b383:660f with SMTP id
 o13-20020a056402438d00b0043db383660fmr28517020edc.283.1660170400249; Wed, 10
 Aug 2022 15:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220807205740.777363-1-hdegoede@redhat.com> <CABBYNZLwKJcEoaHzihV92LhvPAAOB7p8vfX9rc=8Z_U61Zjt2A@mail.gmail.com>
In-Reply-To: <CABBYNZLwKJcEoaHzihV92LhvPAAOB7p8vfX9rc=8Z_U61Zjt2A@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 10 Aug 2022 15:26:28 -0700
Message-ID: <CABBYNZ+kUVT5K_+jiGn6eU=yOde+3Fmq6KHPmyawgbZMCseh1A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_event: Fix vendor (unknown) opcode status handling
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hans,

On Mon, Aug 8, 2022 at 12:58 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Hans,
>
> On Sun, Aug 7, 2022 at 1:57 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > Commit c8992cffbe74 ("Bluetooth: hci_event: Use of a function table to
> > handle Command Complete") was (presumably) meant to only refactor thing=
s
> > without any functional changes.
> >
> > But it does have one undesirable side-effect, before *status would alwa=
ys
> > be set to skb->data[0] and it might be overridden by some of the opcode
> > specific handling. While now it always set by the opcode specific handl=
ers.
> > This means that if the opcode is not known *status does not get set any
> > more at all!
> >
> > This behavior change has broken bluetooth support for BCM4343A0 HCIs,
> > the hci_bcm.c code tries to configure UART attached HCIs at a higher
> > baudraute using vendor specific opcodes. The BCM4343A0 does not
> > support this and this used to simply fail:
> >
> > [   25.646442] Bluetooth: hci0: BCM: failed to write clock (-56)
> > [   25.646481] Bluetooth: hci0: Failed to set baudrate
> >
> > After which things would continue with the initial baudraute. But now
> > that hci_cmd_complete_evt() no longer sets status for unknown opcodes
> > *status is left at 0. This causes the hci_bcm.c code to think the baudr=
aute
> > has been changed on the HCI side and to also adjust the UART baudrate,
> > after which communication with the HCI is broken, leading to:
> >
> > [   28.579042] Bluetooth: hci0: command 0x0c03 tx timeout
> > [   36.961601] Bluetooth: hci0: BCM: Reset failed (-110)
> >
> > And non working bluetooth. Fix this by restoring the previous
> > default "*status =3D skb->data[0]" handling for unknown opcodes.
> >
> > Fixes: c8992cffbe74 ("Bluetooth: hci_event: Use of a function table to =
handle Command Complete")
> > Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> >  net/bluetooth/hci_event.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index af17dfb20e01..fda31d558ded 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -3996,6 +3996,13 @@ static void hci_cmd_complete_evt(struct hci_dev =
*hdev, void *data,
> >                         break;
> >                 }
> >         }
> > +       if (i =3D=3D ARRAY_SIZE(hci_cc_table)) {
> > +               /* Unknown opcode, assume byte 0 contains the status, s=
o
> > +                * that e.g. __hci_cmd_sync() properly returns errors
> > +                * for vendor specific commands send by HCI drivers.
> > +                */
> > +               *status =3D skb->data[0];
> > +       }
>
> The format of return parameters in command is not defined by the spec:
>
> BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
> page 2189:
>
> Return_Parameters:
> Size: Depends on command
>
> This is the return parameter(s) for the command specified in the
> Command_Opcode event parameter. See each command=E2=80=99s definition for
> the list of return parameters associated with that command.
>
> So assuming the status is the first by is not quite right, although
> for the standard ones that seems to be valid, I think the best way to
> resolve this would have been to check if it a vendor command and then
> have the driver handle it or perhaps have some means for the driver to
> register it vendor_cc_table, we can perhaps have this as a workaround
> for now and only really change how we parse the cc for vendor commands
> if a vendor decide not to have a status as first parameter but Id
> probably leave a comment that quoting the spec that reminds us this
> code may need changing.

Are you still planning to send updates for this, I consider this quite
urgent given that it can break support with some vendors.

> >         handle_cmd_cnt_and_timer(hdev, ev->ncmd);
> >
> > --
> > 2.37.1
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

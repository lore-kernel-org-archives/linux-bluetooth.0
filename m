Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF27C00140
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Aug 2022 19:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243914AbiHHT6e (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Aug 2022 15:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236856AbiHHT6c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Aug 2022 15:58:32 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A97A196
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Aug 2022 12:58:31 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id j8so18485686ejx.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Aug 2022 12:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jYFh67Z/iJIySYzxW+dvqCfobkF6ZVpVJKcKqS5//xE=;
        b=f2n8v0zE9INU4TAz02rEJuWKBTOe47H6t/YRS+hKpCYt7/9CYtpPT/z9TmVREcQn7q
         bfGlYanlc2O4ZzrWMkSZeio4tr+RiWiNXeEgv56GRjjQtiEq7oLZ2zO1puKgPwsE95aM
         9y7iAtlxKTCYkD3fpl4LNcmm76HdCfPCesQfaUgP4DADdPc1WPhK2Jis7rmvtO08o93h
         m5woG27hRmtfTOKJBGwc1TFPNwNE1BAV4r5nR5/CstT5E4dLxulcSaAPc+AUHToC4F6B
         hQ9b1CwTpXYQ60mG+f5Oyl2XQoabwjvD7o5uWdj+/AS8cici678oTmz6Cugq1hCwW5Wu
         DIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jYFh67Z/iJIySYzxW+dvqCfobkF6ZVpVJKcKqS5//xE=;
        b=0ZtA5Qa9xOO84ThghDGX2AFitpv6e5HBhbB4zhTJKLrTIBcpCuIlZScjOn6ZJTfOlh
         RJgPS3Zeo5ND3ft8GVvuL27Fh2zTTh8JqqY/7tq2L+FkRwi8RSGpQR+dX8JfsxpUgHqx
         rGTqrMSCXgNKleCBnhkL4njVZGV0Re+xInhcJFPor1JjlB+PCkq0cEC04cirabOLBDMf
         rj4XacuQyoukbA1v/FN+b/iKmallDkDfvECXQ2e96aVFWjf1qMjlJN2U+f47oEXFidwm
         2JZTKtH48ttNyQ1mERkHio7QagOthqg0oZYd07p9+8rL6wAA2GtvX2X1gw7h0nTw2KJn
         BIng==
X-Gm-Message-State: ACgBeo0sx+eCn7nKsYXxpdz3TC45/60c6D1rr+c86L9rDRK8M4G8wkBY
        UnJKDPjY5oQGUdoZt3+cwuGNN85fcKEG3KGZLFUVv30q/200IA==
X-Google-Smtp-Source: AA6agR550bE4JpwYa9uQyHJzfiiUj930FHQPRfQ+PYOmalwcF5QCZjouIAvdQHRxPaekfTn54joXVU/cjhk8dXtj39w=
X-Received: by 2002:a17:907:2707:b0:730:af0b:3572 with SMTP id
 w7-20020a170907270700b00730af0b3572mr14478722ejk.411.1659988709585; Mon, 08
 Aug 2022 12:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220807205740.777363-1-hdegoede@redhat.com>
In-Reply-To: <20220807205740.777363-1-hdegoede@redhat.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 8 Aug 2022 12:58:18 -0700
Message-ID: <CABBYNZLwKJcEoaHzihV92LhvPAAOB7p8vfX9rc=8Z_U61Zjt2A@mail.gmail.com>
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

On Sun, Aug 7, 2022 at 1:57 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Commit c8992cffbe74 ("Bluetooth: hci_event: Use of a function table to
> handle Command Complete") was (presumably) meant to only refactor things
> without any functional changes.
>
> But it does have one undesirable side-effect, before *status would always
> be set to skb->data[0] and it might be overridden by some of the opcode
> specific handling. While now it always set by the opcode specific handler=
s.
> This means that if the opcode is not known *status does not get set any
> more at all!
>
> This behavior change has broken bluetooth support for BCM4343A0 HCIs,
> the hci_bcm.c code tries to configure UART attached HCIs at a higher
> baudraute using vendor specific opcodes. The BCM4343A0 does not
> support this and this used to simply fail:
>
> [   25.646442] Bluetooth: hci0: BCM: failed to write clock (-56)
> [   25.646481] Bluetooth: hci0: Failed to set baudrate
>
> After which things would continue with the initial baudraute. But now
> that hci_cmd_complete_evt() no longer sets status for unknown opcodes
> *status is left at 0. This causes the hci_bcm.c code to think the baudrau=
te
> has been changed on the HCI side and to also adjust the UART baudrate,
> after which communication with the HCI is broken, leading to:
>
> [   28.579042] Bluetooth: hci0: command 0x0c03 tx timeout
> [   36.961601] Bluetooth: hci0: BCM: Reset failed (-110)
>
> And non working bluetooth. Fix this by restoring the previous
> default "*status =3D skb->data[0]" handling for unknown opcodes.
>
> Fixes: c8992cffbe74 ("Bluetooth: hci_event: Use of a function table to ha=
ndle Command Complete")
> Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  net/bluetooth/hci_event.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index af17dfb20e01..fda31d558ded 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3996,6 +3996,13 @@ static void hci_cmd_complete_evt(struct hci_dev *h=
dev, void *data,
>                         break;
>                 }
>         }
> +       if (i =3D=3D ARRAY_SIZE(hci_cc_table)) {
> +               /* Unknown opcode, assume byte 0 contains the status, so
> +                * that e.g. __hci_cmd_sync() properly returns errors
> +                * for vendor specific commands send by HCI drivers.
> +                */
> +               *status =3D skb->data[0];
> +       }

The format of return parameters in command is not defined by the spec:

BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
page 2189:

Return_Parameters:
Size: Depends on command

This is the return parameter(s) for the command specified in the
Command_Opcode event parameter. See each command=E2=80=99s definition for
the list of return parameters associated with that command.

So assuming the status is the first by is not quite right, although
for the standard ones that seems to be valid, I think the best way to
resolve this would have been to check if it a vendor command and then
have the driver handle it or perhaps have some means for the driver to
register it vendor_cc_table, we can perhaps have this as a workaround
for now and only really change how we parse the cc for vendor commands
if a vendor decide not to have a status as first parameter but Id
probably leave a comment that quoting the spec that reminds us this
code may need changing.

>         handle_cmd_cnt_and_timer(hdev, ev->ncmd);
>
> --
> 2.37.1
>


--=20
Luiz Augusto von Dentz

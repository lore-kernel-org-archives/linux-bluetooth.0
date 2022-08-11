Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9D8C19F2A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Aug 2022 20:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbiHKU1z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Aug 2022 16:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbiHKU1y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Aug 2022 16:27:54 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18839F0E2
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 13:27:53 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id k26so35461415ejx.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 13:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=6AQDq13iTCs/KWbrOxjEbcnhniL48spdre0QquZITFg=;
        b=q6CKcxLAyZqOr30DxG4YsMqKS320gVv2u3ARXUQpxd92hG18vrDhukoSfKWZmWPCZN
         /TyXITwqysXRKkclyyUrrmKFrKNEjdzZc7bwG7Ci14eVs3oriDEFN2nQ9fpqy9GvUJCR
         IghkP4KtwQ7+Zt/PFW/aKyibKc43rYVcWtCWtz7rg7vunnnz5vB0laOM9RPJj9G+o4vl
         Ds3g6JXtCDU2Ye5cwOO4q+XrXx6zyNfri0HWVfW+niFLZL/0whuxncGLcEjIfZpXBlVT
         ny0r/wpP8n5R72gQY5znifDA3asSh777GjsVjYS6otKwAhQ0sjXgLk9QPqvbEL9RFbra
         c3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=6AQDq13iTCs/KWbrOxjEbcnhniL48spdre0QquZITFg=;
        b=ByB3Dm1rNY9MM5bb4ICPmLUqvBvb243zT1rhIEciOpGEB7bROwhxdVqr88j5fOpfOq
         34M/fFmnENPuAtAEsx5WzaXeBTq/0U8Ro3n/umeKpE6UuuBIPJDOe1aDTzo1MepEYTkK
         xbJTVAz32xjScFRXkoRkPt+bCkIyte0PfG5DHt1+EYE8nu2eGQnMz3ds0z9QDnxidLJU
         yX/pKuXVubxdLt2okOcLd+lAm1NrsrvImH6muYPWkeXDSrLz/6gbHUwwC90jmqe5Uk4f
         T1immtjitEEjdFdw+sp78Ng1bdPaZFiiLZEdaMy6aUGU6WXkAFJDRDXEE6/GMYyINhMy
         M3FA==
X-Gm-Message-State: ACgBeo2dNoK18uPtyHAnWhLqF94XXltQsfGc1gN/T+uQWOLV3s6CXsRH
        pt3IRovB1HD5v53R8c7hwKoCrWs/FYNmjK2smbMFX3RxNxQamgpc
X-Google-Smtp-Source: AA6agR6EYCznZM91tIV41hvVXC1h5eDCh/L6o16c9aoycqmFYZ5S+B0W6b9niL+wcEkEiEG9tLsezPgMiDGeWML+tr8=
X-Received: by 2002:a17:906:4bd3:b0:731:3bdf:b95c with SMTP id
 x19-20020a1709064bd300b007313bdfb95cmr491077ejv.677.1660249672326; Thu, 11
 Aug 2022 13:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220811120103.47669-1-hdegoede@redhat.com>
In-Reply-To: <20220811120103.47669-1-hdegoede@redhat.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 11 Aug 2022 13:27:40 -0700
Message-ID: <CABBYNZL2TjDFCx3EFnYRhe2JCSh3YAgBPiNAHpk1Ya+e3sDtxQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_event: Fix vendor (unknown) opcode
 status handling
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hans,

On Thu, Aug 11, 2022 at 5:01 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Commit c8992cffbe74 ("Bluetooth: hci_event: Use of a function table to
> handle Command Complete") was (presumably) meant to only refactor things
> without any functional changes.
>
> But it does have one undesirable side-effect, before *status would always
> be set to skb->data[0] and it might be overridden by some of the opcode
> specific handling. While now it always set by the opcode specific handlers.
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
> *status is left at 0. This causes the hci_bcm.c code to think the baudraute
> has been changed on the HCI side and to also adjust the UART baudrate,
> after which communication with the HCI is broken, leading to:
>
> [   28.579042] Bluetooth: hci0: command 0x0c03 tx timeout
> [   36.961601] Bluetooth: hci0: BCM: Reset failed (-110)
>
> And non working bluetooth. Fix this by restoring the previous
> default "*status = skb->data[0]" handling for unknown opcodes.
>
> Fixes: c8992cffbe74 ("Bluetooth: hci_event: Use of a function table to handle Command Complete")
> Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - Add a comment that byte 0 containing the status is not guaranteed
>   by the Bluetooth specification
> ---
>  net/bluetooth/hci_event.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index af17dfb20e01..eb43afd5549a 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3996,6 +3996,26 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, void *data,
>                         break;
>                 }
>         }
> +       if (i == ARRAY_SIZE(hci_cc_table)) {
> +               /* Unknown opcode, assume byte 0 contains the status, so
> +                * that e.g. __hci_cmd_sync() properly returns errors
> +                * for vendor specific commands send by HCI drivers.
> +                *
> +                * Note that the specification does not specify that
> +                * byte 0 is the status:
> +                *
> +                * BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
> +                * page 2189:
> +                *
> +                * Return_Parameters:
> +                * Size: Depends on command
> +                *
> +                * For now using byte 0 seems to work fine, but in the future
> +                * this may need to be updated so that drivers using vendor
> +                * commands can specify their own completion handler.
> +                */
> +               *status = skb->data[0];
> +       }
>
>         handle_cmd_cnt_and_timer(hdev, ev->ncmd);
>
> --
> 2.37.1

Not sure why CI bot didn't respond to the list but this patch was
already applied yesterday:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=84a0a27ea39a9caed74d80a78666a91a9ea5e12b

-- 
Luiz Augusto von Dentz

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA08C77B73
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Apr 2023 18:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243835AbjD0SuK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Apr 2023 14:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbjD0SuI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Apr 2023 14:50:08 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6711E359D
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Apr 2023 11:50:07 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-549f0b45ac6so1177947eaf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Apr 2023 11:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682621406; x=1685213406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSw1IlHabKdeoJWFqhha6ktdPaX7I8X8moKzfrrA+xs=;
        b=c5VdzcPthUwYt+fAt1IPr3kLAhLRh0w+qstLZEj8WYb3uGognGMUbKZJcJEN83rBrU
         9hD046zwbrCiaOfD1uTLKwJDo1lFoSaiBiNWwuRuQKyvCfZy5s42WTg7XiDWyGXOSReW
         a9732IBAlF6O1sT9IdCv1z3pwsPDR23SFeox4kc2hdvejZwFLzFQ05zJ63YjgYMYRPxB
         4C0leKMWCzdn9wnfYPJWY5uuynAGH+W8SwZHElwsF9WzL3eqP/Y07NsbjYR35wgMguu6
         IleTVey38i11ADRQi/9hbvnFKkrXd0IL0ovdSq/58MXpc5sLLrLq2RykDGZSnK50qlKJ
         rDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682621406; x=1685213406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSw1IlHabKdeoJWFqhha6ktdPaX7I8X8moKzfrrA+xs=;
        b=Enti7niP/Jp6qEiZcSXunW1SzgZwIR/O8Emd1zhnZ8s0kXU+KuiODjXXTL/P37uBss
         /MKHrj9j05c0+nTzC44/H5pDMaw7me3AN6QoUGGfH7Lgo733uT06+TuL7e/kmonImAtc
         Ient0FDq/EI0YD/bQx+7VTgjorXJB3zr8ZAqXh2/UaTnj8ETlmjBWMX8kzQU4OYibFFh
         cjLOyy0SvxOSuLJQYcRE75Q9yr1HCp0ut7kcnAHs0vI1JloO4H09v6enrT35/l3gTrbu
         dqfwcebFrv2+xU9++Ng0NVkEh/nMemmq2+RZZytr02GDKlmmk06TpsuRFAK/TQAc+x5p
         I1Ng==
X-Gm-Message-State: AC+VfDwtVOTZH9GMYaNYcWQC4vwGmWidtjQfIJ1o7gKyJWhke/28e4qT
        KO1CBUs0F53ybGg041vnYto7N/CgrER+/zIcnIX4JEWhIw+fpwMC
X-Google-Smtp-Source: ACHHUZ6mPFjhxOsaKkHe5R6CyJoROA03B2FebAR7i2VDpHZLUTA4rOp0dcOgq61wZgaMqoBMzbi8GOPCWZkxhuNRlTA=
X-Received: by 2002:a05:6808:60f:b0:38e:8d92:5884 with SMTP id
 y15-20020a056808060f00b0038e8d925884mr1092207oih.12.1682621406035; Thu, 27
 Apr 2023 11:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <CACk7upyDgd8kCY+8j+RMJz35GXrF=bwRzDNH76Oh8q4nB8i0KQ@mail.gmail.com>
In-Reply-To: <CACk7upyDgd8kCY+8j+RMJz35GXrF=bwRzDNH76Oh8q4nB8i0KQ@mail.gmail.com>
From:   Raul Cheleguini <raul.cheleguini@gmail.com>
Date:   Thu, 27 Apr 2023 15:49:29 -0300
Message-ID: <CACk7upyDxpy45wEWXi_EU_r7F8WeD2bObSHRRo82HGTrYGXNHQ@mail.gmail.com>
Subject: Re: unexpected SMP command errors with controller ATS2851
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Mar 24, 2023 at 12:17=E2=80=AFAM Raul Cheleguini
<raul.cheleguini@gmail.com> wrote:
>
> Hi everyone,
>
> I'm trying to understand and narrow down a pairing problem with this
> controller that I'm trying to make it work in Linux.
>
> When pairing, the negotiation does not complete and the system logs
> the following messages:
>
> Bluetooth: hci0: unexpected SMP command 0x08 from dd:5e:b9:fe:49:3f
> Bluetooth: hci0: unexpected SMP command 0x09 from dd:5e:b9:fe:49:3f
> Bluetooth: hci0: Opcode 0x200d failed: -110
> Bluetooth: hci0: request failed to create LE connection: err -110
>
> (dd:5e:b9:fe:49:3f is my bluetooth mouse)
>
> After some debug I found the condition that refuses the SMP commands and
> drops them:
>
> net/bluetooth/smp.c in smp_sig_channel()
>
> if (smp && !test_and_clear_bit(code, &smp->allow_cmd))
>     goto drop;
>
> The interesting part is that if I disable this condition with comments,
> the pairing process manages to complete and my bluetooth mouse starts to =
work
> (even with some errors in logs):
>
> Bluetooth: hci0: Opcode 0x200d failed: -110
> Bluetooth: hci0: request failed to create LE connection: err -110
> hid: raw HID events driver (C) Jiri Kosina
> input: Logi M650 L Mouse as /devices/virtual/misc/uhid/0005:046D:B02A.000=
1/
> input/input6
> hid-generic 0005:046D:B02A.0001: input,hidraw0: BLUETOOTH HID v0.09 Mouse
> [Logi M650 L] on f4:4e:fc:c0:de:5e
> Bluetooth: hci0: Opcode 0x200d failed: -110
> Bluetooth: hci0: request failed to create LE connection: err -110
>
> Logs from bluetoothd receiving the mouse data events:
>
> bluetoothd[576]: src/shared/att.c:can_read_data() (chan 0x55f8ad8db380)
> ATT PDU received: 0x1b
> bluetoothd[576]: src/shared/att.c:can_read_data() (chan 0x55f8ad8db380)
> ATT PDU received: 0x1b
> bluetoothd[576]: src/shared/att.c:can_read_data() (chan 0x55f8ad8db380)
> ATT PDU received: 0x1b
>
> I kindly ask guidance on what could be done in these cases or any hints
> how to further debug this issue.
>
> For context, the controller works in other systems using generic drivers.
>
> Regards,
> Raul.

For the benefit of any novice who may face similar situation in future:

The error "unexpected SMP command 0x08" indicates that command 0x08
(SMP_CMD_IDENT_INFO) arrives before it has been allowed. That is part smp
implementation, it allows commands and responds to them in the expected
context, otherwise it drops them.

In this particular situation, we enter a condition in hci_encrypt_change_ev=
t()
[1] that results in an unrelated HCI command being sent during the time we
should be preparing to receive command 0x08. The command 0x08 arrives befor=
e
it has been allowed and this confusion eventually leads to a disconnect eve=
nt.

According to my raw notes, 0x08 is allowed in smp_allow_key_dist(), as
a result of a callback chain for this type of connection/adapter:

hci_encrypt_cfm > security_cfm_cb >
l2cap_security_cfm > smp_resume_cb > smp_distribute_keys > smp_allow_key_di=
st

Regards,
Raul.

[1]
https://elixir.bootlin.com/linux/v6.3/source/net/bluetooth/hci_event.c#L367=
0

Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64493C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Jul 2022 17:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiGURw2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jul 2022 13:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbiGURw1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jul 2022 13:52:27 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336E882106
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 10:52:25 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a10so2714040ljj.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 10:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7pIihlto31zrnxhoK6BS4G1M5FEZnKI/gZ0yDbNGCPQ=;
        b=GsP+bDj+IAqWzuoC5FKKwRIDcO6jW9IyrvF3e41JG1foA/LsS/pup/5etCiN9N949s
         T84Vn56/qWfCqf36PU5L7cmjw568hl0VjXfoT3iAuSD7e9TIcqlDirfhOJSd/GQ1pxue
         EvU6KTvnSE3lVqWCc+92vD88W0RBGcAppO/WOESjDOOo0xKxLlhC6o6M/+wxQUHX7ZZl
         cALUuMcCaEC6o3EIkqr3R9zkMbJnYOtjIF1ETkMA7joDsN0SxbjmU8GOEkf7NrIsa2Po
         P4u/Dh2aj/hOwnkukyd1qBW/nBPhTvwjN94vNOs/+ZkbsO3PeS38kVXkDYTzJQb7qech
         WzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7pIihlto31zrnxhoK6BS4G1M5FEZnKI/gZ0yDbNGCPQ=;
        b=OAHJ7HoFj+mUrFd91No35EeDIHdu5mdYE8LQfd8sVhiFAcTpmJAJ/l7jw/c01wuYmi
         kaaaaUeCS0lsCzMVwPgNsy+vI+d+SAOcLkOtl9t0gx90rVfOPRJN8A6BGamRi8SoAFnu
         UElu0/LdS3IxW6gyzNwpOPJYK1qAO/xjmZiTNjTN4WHastX5hVObFaFGeC0K+jP6+waY
         0t5RwBvoCcLhz5J9c/TdxiMJ7+nnj15aFFqMC0pgEG9rYq5vzTCuYdcZ0AQ2m5ecFJL4
         Smld5+s7oLddqUd/WMHvUztgn2q6zJq+nzNPQhrdkJaNtDkmKsoRyJbfQlJ8Wkm4J73t
         AsgA==
X-Gm-Message-State: AJIora+3G9WHT+fefyZyHR43nLXtMNzCZ207JEefj2/tOuAz+9rUkPlq
        mrRx0bPRPYNFlTuITW2N+YxhN51YBke/m8fIli3ZDpxCxJsrnw==
X-Google-Smtp-Source: AGRyM1vULElNEjj153roKZmkoqHQrZo6jmezTywto2Ca/uKgJVLCD948M4LOD53JQbB1A800sI/AFdXp6fJKAU9IFac=
X-Received: by 2002:a2e:7314:0:b0:25d:d79a:550c with SMTP id
 o20-20020a2e7314000000b0025dd79a550cmr3215305ljc.260.1658425943287; Thu, 21
 Jul 2022 10:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <01bb77a3-f138-7488-9ca9-71ec4f7d21a7@eknoes.de>
In-Reply-To: <01bb77a3-f138-7488-9ca9-71ec4f7d21a7@eknoes.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 21 Jul 2022 10:52:11 -0700
Message-ID: <CABBYNZ+015snDMtHOKox1iJrpdR3Jp8kXYCujMT=UNjjnDTzQA@mail.gmail.com>
Subject: Re: [BUG] Null pointer deref in aosp_do_open/msft_do_open
To:     =?UTF-8?Q?S=C3=B6nke_Huster?= <soenke.huster@eknoes.de>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi S=C3=B6nke,

On Thu, Jul 21, 2022 at 3:16 AM S=C3=B6nke Huster <soenke.huster@eknoes.de>=
 wrote:
>
> Hi,
>
> My fuzzer found two null pointer exceptions in aosp_do_open and msft_do_o=
pen, both triggered by the
> same frame sequence on the current bluetooth-next master.
>
>       BUG: kernel NULL pointer dereference, address: 0000000000000070
>       #PF: supervisor read access in kernel mode
>       #PF: error_code(0x0000) - not-present page
>       PGD 0 P4D 0
>       Oops: 0000 [#1] PREEMPT SMP NOPTI
>       CPU: 0 PID: 41 Comm: kworker/u3:0 Not tainted 5.18.0-rc7-00850-g33b=
44d809538 #1
>       Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.1=
6.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>       Workqueue: hci0 hci_power_on
>       RIP: 0010:aosp_do_open+0x7e/0x230
>       Call Trace:
>        <TASK>
>        hci_dev_open_sync+0x98b/0x1060
>        hci_power_on+0x84/0x350
>        process_one_work+0x2a6/0x5d0
>        worker_thread+0x4a/0x3d0
>        ? process_one_work+0x5d0/0x5d0
>        kthread+0xed/0x120
>        ? kthread_complete_and_exit+0x20/0x20
>        ret_from_fork+0x22/0x30
>        </TASK>
>
> The null pointer deref occurs in the skb length check (net/bluetooth/aosp=
.c:64), the skb returned
> previously by __hci_cmd_sync is null:
>
>         /* LE Get Vendor Capabilities Command */
>         skb =3D __hci_cmd_sync(hdev, hci_opcode_pack(0x3f, 0x153), 0, NUL=
L,
>                              HCI_CMD_TIMEOUT);
>         if (IS_ERR(skb)) {
>                 bt_dev_err(hdev, "AOSP get vendor capabilities (%ld)",
>                            PTR_ERR(skb));
>                 return;
>         }
>
>         /* A basic length check */
>         if (skb->len < VENDOR_CAPA_BASE_SIZE)
>
> Bisected to: [d0b137062b2de75b264b84143d21c98abc5f5ad2] Bluetooth: hci_sy=
nc: Rework init stages
>
> It occurs when an AOSP resp. MSFT capable controller sends the following =
two different
> Command Status (0x0f) for Reset (0x0c03) on initialization:
>
> Status Octet: Unknown HCI Command (0x01)
> 0000   04 0f 04 01 02 03 0c
>
> Status Octet: Pending (0x00)
> 0000   04 0f 04 00 02 03 0c
>
> The problem seems to be that __hci_cmd_sync returns null, and not an PTR_=
ERR. The affected code
> for msft_do_open is similar (msft.c:128ff):
>
>         skb =3D __hci_cmd_sync(hdev, hdev->msft_opcode, sizeof(cp), &cp,
>                              HCI_CMD_TIMEOUT);
>         if (IS_ERR(skb)) {
>                 bt_dev_err(hdev, "Failed to read MSFT supported features =
(%ld)",
>                            PTR_ERR(skb));
>                 return false;
>         }
>
>         if (skb->len < sizeof(*rp)) {
>
> Which one is triggered depends on the device reporting itself as either A=
OSP or MSFT capable.
> If it indicates both, it depends on timing.
>
> I think that can only be triggered by a malicious or broken Bluetooth con=
troller, but there
> might be an underlying issue with __hci_cmd_sync returning null instead o=
f an ERR_PTR.

Yep that is most likely a Command Status being returned which isn't
expected for the commands above:

    /* If command return a status event skb will be set to NULL as there ar=
e
     * no parameters, in case of failure IS_ERR(skb) would have be set to
     * the actual error would be found with PTR_ERR(skb).
     */
    if (!skb)
        return 0;

So perhaps we should convert these checks to IS_ERR_OR_NULL.

> Best
> S=C3=B6nke



--=20
Luiz Augusto von Dentz

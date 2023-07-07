Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FEAEB64DA
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jul 2023 19:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjGGTGq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jul 2023 15:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjGGTGl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jul 2023 15:06:41 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607C22139
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jul 2023 12:06:19 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b69dcf45faso36767711fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jul 2023 12:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688756777; x=1691348777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHlDqfRUL8EGIOUgo9KI4m/6GsCafBDKSdkxesx61Hk=;
        b=aaZ4/ztks5H4kz8SiWWMfUEXqQdIOAQ/nkalG7jDvQoPucGoRnUEj0eUBB/+ZXcZz8
         QJlviv3oEuCYgFwsYRMJR3ic07MhppwRUDe1gqPn5CL793X07TkelOJ0t/Y2vPuBp/y7
         FF0UPYoWnTvwdkxJjOXVwlHx+WeS95AJzFjuLHie65b1QmYlD7mjhD9JBFq1EQpr/c26
         cF08lx5Az5xpb1lKdgHDURfznbQqM+TfVIaEVAC0Y54K0mERGOB9lipndw+Ccz7ckOk5
         zZHUNYprtDUrmqdAzvKesJP+vcfvgS6ayU/xY5DqZIN+mChELMHnnqxoN0/w4VCpGl1Q
         scww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688756777; x=1691348777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHlDqfRUL8EGIOUgo9KI4m/6GsCafBDKSdkxesx61Hk=;
        b=exktT4Xo01VpWj8U4xafoUF7kC9E1ljYcqrGW+aSDLqSmMivsb4zL3Bzsc9yDeFiXj
         OVVZMtsmRB5SDXO9rUIImCX/Y+79lTc3uS9ZNyvKVNyliT8nS2JDXWStVeF+E3UQnU/r
         EHx0XhOXdC3VVh3tjmKOICQ4nQ6HijUrEEpsFip5bavWE33UB2nCFXteLzC4oHoAJqW2
         ac0M11B38N3QLFevzyNiW6Af9aNIsK4AYYXbflMqUOjwggtNyVXpf1Gy1lok/4QWypPu
         M5+7kJ/AfGdiKImNMPjpDKtj5ZmnShZ0orJ790K9UFh59nOINWvA43tWHWPH3jJof1iO
         R/iA==
X-Gm-Message-State: ABy/qLYvTtTBHPZq/1l4sIk3FN+BCjrTy5elGLkAd0gbMDl4AvDDvHac
        sph1kV6PQbD/fa8PUjnTXb32A2QSF/awM7kZ1X/JsfzQ6Z8=
X-Google-Smtp-Source: APBJJlF9og6c2XCHoHzhsL85RDA3Vy/uoB/YbXBPzSmqXmKEAMFvSD7Z+IBEaaL8NKScFoM9ieGkaU9FTL6UEuYSxGY=
X-Received: by 2002:a2e:9958:0:b0:2b6:dec9:2812 with SMTP id
 r24-20020a2e9958000000b002b6dec92812mr4351105ljj.33.1688756777281; Fri, 07
 Jul 2023 12:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <ME3PR01MB56237F9982C4F3C9201AFF1FF02DA@ME3PR01MB5623.ausprd01.prod.outlook.com>
In-Reply-To: <ME3PR01MB56237F9982C4F3C9201AFF1FF02DA@ME3PR01MB5623.ausprd01.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 7 Jul 2023 12:06:04 -0700
Message-ID: <CABBYNZ+Q1iupoeK8GJbWcHRgrhNRjZKhS+Gu-DhO7Vx_wiqqeA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix for Bluetooth SIG test L2CAP/COS/CED/BI-02-C
To:     "Xigang(Ted) Feng" <Xigang.Feng@gallagher.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Xigang,

On Thu, Jul 6, 2023 at 7:46=E2=80=AFPM Xigang(Ted) Feng
<Xigang.Feng@gallagher.com> wrote:
>
> This test case is for verifying the L2CAP signalling PDUs that have inval=
id length are properly handled.
> With this patch, the "L2CAP: Command Reject" packet is sent correctly to =
the malformed signal packet
> contained in "L2CAP: Connection Request" packet.
>
> BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 3, Part A page 1041
>
> 'When a packet is received with a Code field that is unknown or disallowe=
d on the
> signalling channel it is received on, an L2CAP_COMMAND_REJECT_RSP
> packet (defined in Section 4.1) is sent in response.'
>
> Before this patch:
>
> > ACL Data RX: Handle 1 flags 0x02 dlen 15
>       L2CAP: Connection Request (0x02) ident 3 len 4
>         PSM: 1 (0x0001)
>         Source CID: 64
>         malformed signal packet
>         00 00 00                                         ...
> < ACL Data TX: Handle 1 flags 0x00 dlen 16
>       L2CAP: Connection Response (0x03) ident 3 len 8
>         Destination CID: 64
>         Source CID: 64
>         Result: Connection successful (0x0000)
>         Status: No further information available (0x0000)
> < ACL Data TX: Handle 1 flags 0x00 dlen 23
>       L2CAP: Configure Request (0x04) ident 3 len 15
>         Destination CID: 64
>         Flags: 0x0000
>         Option: Retransmission and Flow Control (0x04) [mandatory]
>           Mode: Basic (0x00)
>           TX window size: 0
>           Max transmit: 0
>           Retransmission timeout: 0
>           Monitor timeout: 0
>           Maximum PDU size: 0
> > HCI Event: Number of Completed Packets (0x13) plen 5
>         Num handles: 1
>         Handle: 1
>         Count: 2
> > ACL Data RX: Handle 1 flags 0x02 dlen 25
>       L2CAP: Configure Response (0x05) ident 3 len 17
>         Source CID: 64
>         Flags: 0x0000
>         Result: Success (0x0000)
>         Option: Retransmission and Flow Control (0x04) [mandatory]
>           Mode: Basic (0x00)
>           TX window size: 0
>           Max transmit: 0
>           Retransmission timeout: 0
>           Monitor timeout: 0
>           Maximum PDU size: 0
> < ACL Data TX: Handle 1 flags 0x00 dlen 12
>       L2CAP: Disconnection Request (0x06) ident 4 len 4
>         Destination CID: 64
>         Source CID: 64
> > HCI Event: Number of Completed Packets (0x13) plen 5
>         Num handles: 1
>         Handle: 1
>         Count: 1
> > ACL Data RX: Handle 1 flags 0x02 dlen 12
>       L2CAP: Disconnection Response (0x07) ident 4 len 4
>         Destination CID: 64
>         Source CID: 64
> < HCI Command: Disconnect (0x01|0x0006) plen 3
>         Handle: 1
>         Reason: Remote User Terminated Connection (0x13)
>
> After this patch:
>
> > ACL Data RX: Handle 1 flags 0x02 dlen 15
>       L2CAP: Connection Request (0x02) ident 3 len 4
>         PSM: 4113 (0x1011)
>         Source CID: 64
>         malformed signal packet
>         00 00 00                                         ...
> < ACL Data TX: Handle 1 flags 0x00 dlen 16
>       L2CAP: Connection Response (0x03) ident 3 len 8
>         Destination CID: 64
>         Source CID: 64
>         Result: Connection successful (0x0000)
>         Status: No further information available (0x0000)
> < ACL Data TX: Handle 1 flags 0x00 dlen 23
>       L2CAP: Configure Request (0x04) ident 3 len 15
>         Destination CID: 64
>         Flags: 0x0000
>         Option: Retransmission and Flow Control (0x04) [mandatory]
>           Mode: Basic (0x00)
>           TX window size: 0
>           Max transmit: 0
>           Retransmission timeout: 0
>           Monitor timeout: 0
>           Maximum PDU size: 0

Looks like we are still sending a Configure Request which is sort of
useless if we are sending a Reject in the follow up command.

> < ACL Data TX: Handle 1 flags 0x00 dlen 10
>       L2CAP: Command Reject (0x01) ident 0 len 2
>         Reason: Command not understood (0x0000)
> > HCI Event: Number of Completed Packets (0x13) plen 5
>         Num handles: 1
>         Handle: 1 Address: 00:1B:DC:F4:B3:E1 (Vencer Co., Ltd.)
>         Count: 2
> > HCI Event: Number of Completed Packets (0x13) plen 5
>        Num handles: 1
>         Handle: 1 Address: 00:1B:DC:F4:B3:E1 (Vencer Co., Ltd.)
>         Count: 1
> > ACL Data RX: Handle 1 flags 0x02 dlen 25
>       L2CAP: Configure Response (0x05) ident 3 len 17
>         Source CID: 64
>         Flags: 0x0000
>         Result: Success (0x0000)
>         Option: Retransmission and Flow Control (0x04) [mandatory]
>           Mode: Basic (0x00)
>           TX window size: 0
>           Max transmit: 0
>           Retransmission timeout: 0
>           Monitor timeout: 0
>           Maximum PDU size: 0
>
> Signed-off-by: Xigang(Ted) Feng <Xigang.Feng@gallagher.com>
> ---
>  net/bluetooth/l2cap_core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 17ca13e8c044..c3af7727ee1e 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -6534,6 +6534,14 @@ static inline void l2cap_sig_channel(struct l2cap_=
conn *conn,
>                 skb_pull(skb, len);
>         }
>
> +       if (skb->len) {
> +               struct l2cap_cmd_rej_unk rej;
> +
> +               rej.reason =3D cpu_to_le16(L2CAP_REJ_NOT_UNDERSTOOD);
> +               l2cap_send_cmd(conn, 0, L2CAP_COMMAND_REJ,
> +                                       sizeof(rej), &rej);
> +       }
> +
>  drop:
>         kfree_skb(skb);
>  }
> --
> 2.34.1
> ________________________________
>  This email is confidential and may contain information subject to legal =
privilege. If you are not the intended recipient please advise us of our er=
ror by return e-mail then delete this email and any attached files. You may=
 not copy, disclose or use the contents in any way. The views expressed in =
this email may not be those of Gallagher Group Ltd or subsidiary companies =
thereof.
> ________________________________



--=20
Luiz Augusto von Dentz

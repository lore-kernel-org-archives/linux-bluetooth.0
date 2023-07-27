Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4ECEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jul 2023 22:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjG0WeC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jul 2023 18:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbjG0WeA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jul 2023 18:34:00 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6699171D
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 15:33:19 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b701e1ca63so23273821fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 15:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690497177; x=1691101977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XQu2ovVujkoYV9YXdAATZBMCCwfcl6QvW+JuCF56gc=;
        b=IND5pmeB3IDX0zO+veeVjmrunI9S/E1VdgY/WAs3dFl4GGv93T44MUmUkMQi9pB8nO
         hcvGL76IC/u1zjE2QwwZ1Bxgzg1NQgslMTWtWoJ2c013i4n+BcZIbiTTx17kLpxBvAXh
         D7ihjVkpyhGI30OoOa90lzVwdKoPxkUJ/80rubX4uw+1ZYIQGi2mbjzoLgJEYInscMkK
         sysdbkCWkkIDLtLOP4lFQ6yNeAHPrGeNSj665aBny727ti1jEQDvBh8ab3chGLK09xiD
         vzLjWZacnhxj/DbF2m124Jh2/rFdoCAXG1ll98MIfVAA9OABJk3kQXX0dhUke1J5kwIq
         kJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690497177; x=1691101977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4XQu2ovVujkoYV9YXdAATZBMCCwfcl6QvW+JuCF56gc=;
        b=N8kMEsNS+UJSuYis9y/t3VjwbQ3/SmtIMCvPQF/TjIEbslsvu4xh3z/oJsBsnkeKnA
         Le6kC+6h0oWmXRrfYFP+2O4lAGFimYUCaVVZiNG6no7/ioqF+P7HeevpyJi02aregEjO
         v+YNdSNv520Oy4szH3ze1HsctaMka996bEbv9FBey4CLrvSZnyIvbmkGdWTDXp0Qq9C0
         c3EM8xeeSBHmhPhysyLpOM7M6dFfZrOzpQZ+GL46WlgOSUYEUCqN6j/4pvEBcKGjY1Op
         zCt1Wa809aU0+GIdD+6yOwp5WFAVR3BpacqlGsvuMj98kBQTQXWKa7h6XnPcDAGokH8A
         gt3g==
X-Gm-Message-State: ABy/qLa0ceqAqpqftUGauIBftRJoQItJwauQBC+2D2fZhe0IgfVt+nF8
        uG1IK7gHg1+Fpw9G17X95Et3ejc+pS8ABohwIm+YP/4z
X-Google-Smtp-Source: APBJJlEjkb/8RBNx7Wk31CLHYFWkrMdTCEurZAqtym5g4QYIS3nUIQ/RArzI/TIczpti9T25MOs7tHVg8UR53PUtc9I=
X-Received: by 2002:a2e:7a05:0:b0:2b6:a763:5d13 with SMTP id
 v5-20020a2e7a05000000b002b6a7635d13mr270968ljc.27.1690497177273; Thu, 27 Jul
 2023 15:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <ME3PR01MB56237F9982C4F3C9201AFF1FF02DA@ME3PR01MB5623.ausprd01.prod.outlook.com>
 <CABBYNZ+Q1iupoeK8GJbWcHRgrhNRjZKhS+Gu-DhO7Vx_wiqqeA@mail.gmail.com>
 <ME3PR01MB56234E61153A7358403B834AF032A@ME3PR01MB5623.ausprd01.prod.outlook.com>
 <CABBYNZJVgV7sy9HO37ZD=0XCT+JBu+NAeYYuzcok1LobW9nN9A@mail.gmail.com>
In-Reply-To: <CABBYNZJVgV7sy9HO37ZD=0XCT+JBu+NAeYYuzcok1LobW9nN9A@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 27 Jul 2023 15:32:44 -0700
Message-ID: <CABBYNZK48oTH9UKfmOMHgH-v=tk0TSHQo6PJDC+ngQdaw=scpA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix for Bluetooth SIG test L2CAP/COS/CED/BI-02-C
To:     "Xigang(Ted) Feng" <Xigang.Feng@gallagher.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ted,

On Fri, Jul 14, 2023 at 3:27=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi,
>
> On Sat, Jul 8, 2023 at 4:26=E2=80=AFPM Xigang(Ted) Feng
> <Xigang.Feng@gallagher.com> wrote:
> >
> > Hi Luiz,
> >
> > > On Thu, Jul 6, 2023 at 7:46=E2=80=AFPM Xigang(Ted) Feng
> > > <Xigang.Feng@gallagher.com> wrote:
> > > >
> > > > This test case is for verifying the L2CAP signalling PDUs that have=
 invalid length
> > > are properly handled.
> > > > With this patch, the "L2CAP: Command Reject" packet is sent correct=
ly to the
> > > malformed signal packet
> > > > contained in "L2CAP: Connection Request" packet.
> > > >
> > > > BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 3, Part A page 1041
> > > >
> > > > 'When a packet is received with a Code field that is unknown or dis=
allowed on
> > > the
> > > > signalling channel it is received on, an L2CAP_COMMAND_REJECT_RSP
> > > > packet (defined in Section 4.1) is sent in response.'
> > > >
> > > > Before this patch:
> > > >
> > > > > ACL Data RX: Handle 1 flags 0x02 dlen 15
> > > >       L2CAP: Connection Request (0x02) ident 3 len 4
> > > >         PSM: 1 (0x0001)
> > > >         Source CID: 64
> > > >         malformed signal packet
> > > >         00 00 00                                         ...
> > > > < ACL Data TX: Handle 1 flags 0x00 dlen 16
> > > >       L2CAP: Connection Response (0x03) ident 3 len 8
> > > >         Destination CID: 64
> > > >         Source CID: 64
> > > >         Result: Connection successful (0x0000)
> > > >         Status: No further information available (0x0000)
> > > > < ACL Data TX: Handle 1 flags 0x00 dlen 23
> > > >       L2CAP: Configure Request (0x04) ident 3 len 15
> > > >         Destination CID: 64
> > > >         Flags: 0x0000
> > > >         Option: Retransmission and Flow Control (0x04) [mandatory]
> > > >           Mode: Basic (0x00)
> > > >           TX window size: 0
> > > >           Max transmit: 0
> > > >           Retransmission timeout: 0
> > > >           Monitor timeout: 0
> > > >           Maximum PDU size: 0
> > > > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > >         Num handles: 1
> > > >         Handle: 1
> > > >         Count: 2
> > > > > ACL Data RX: Handle 1 flags 0x02 dlen 25
> > > >       L2CAP: Configure Response (0x05) ident 3 len 17
> > > >         Source CID: 64
> > > >         Flags: 0x0000
> > > >         Result: Success (0x0000)
> > > >         Option: Retransmission and Flow Control (0x04) [mandatory]
> > > >           Mode: Basic (0x00)
> > > >           TX window size: 0
> > > >           Max transmit: 0
> > > >           Retransmission timeout: 0
> > > >           Monitor timeout: 0
> > > >           Maximum PDU size: 0
> > > > < ACL Data TX: Handle 1 flags 0x00 dlen 12
> > > >       L2CAP: Disconnection Request (0x06) ident 4 len 4
> > > >         Destination CID: 64
> > > >         Source CID: 64
> > > > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > >         Num handles: 1
> > > >         Handle: 1
> > > >         Count: 1
> > > > > ACL Data RX: Handle 1 flags 0x02 dlen 12
> > > >       L2CAP: Disconnection Response (0x07) ident 4 len 4
> > > >         Destination CID: 64
> > > >         Source CID: 64
> > > > < HCI Command: Disconnect (0x01|0x0006) plen 3
> > > >         Handle: 1
> > > >         Reason: Remote User Terminated Connection (0x13)
> > > >
> > > > After this patch:
> > > >
> > > > > ACL Data RX: Handle 1 flags 0x02 dlen 15
> > > >       L2CAP: Connection Request (0x02) ident 3 len 4
> > > >         PSM: 4113 (0x1011)
> > > >         Source CID: 64
> > > >         malformed signal packet
> > > >         00 00 00                                         ...
> > > > < ACL Data TX: Handle 1 flags 0x00 dlen 16
> > > >       L2CAP: Connection Response (0x03) ident 3 len 8
> > > >         Destination CID: 64
> > > >         Source CID: 64
> > > >         Result: Connection successful (0x0000)
> > > >         Status: No further information available (0x0000)
> > > > < ACL Data TX: Handle 1 flags 0x00 dlen 23
> > > >       L2CAP: Configure Request (0x04) ident 3 len 15
> > > >         Destination CID: 64
> > > >         Flags: 0x0000
> > > >         Option: Retransmission and Flow Control (0x04) [mandatory]
> > > >           Mode: Basic (0x00)
> > > >           TX window size: 0
> > > >           Max transmit: 0
> > > >           Retransmission timeout: 0
> > > >           Monitor timeout: 0
> > > >           Maximum PDU size: 0
> > >
> > > Looks like we are still sending a Configure Request which is sort of
> > > useless if we are sending a Reject in the follow up command.
> >
> > I'm following the test case "L2CAP/COS/CED/BI-02-C" in " L2CAP Test Sui=
te" from Bluetooth SIG.
> > In Test Procedure, step 3 sends a L2CAP_CONNECTION_REQ with three extra=
 bytes of 0.
> >
> > Step 4 sends back L2CAP_CONNECTION_RSP to indicate the connection estab=
lished successfully,
> > And send L2CAP_COMMAND_REJECT_RSP to reject the unknow command(the extr=
a three bytes of 0) contained in L2CAP_CONNECTION_REQ.
>
> Well I guess that is assuming the stack would consider the extra bytes
> as a different command, in which case the PDU flow is correct but then
> we probably need to check for unparsed bytes for all commands, not
> just L2CAP_CONNECTION_REQ. Perhaps we need to take a look at the
> errata which added this test to know exactly the intent of such test,
> if I recall correctly L2CAP signalling channel supports more than one
> outstanding command at the time, so perhaps it is valid to send
> multiple commands in a row which is why this tests is done with extra
> bytes at the end to simulate another command.

Any chance to update these changes? Or are you not planning on
continuing working on them?

> > In step 5, the Lower Tester can continue sending L2CAP_CONFIGURATION_RE=
Q because the connection has been established successfully,
> > So in my opinion, the Configure Request sent by IUT is also a correct b=
ehaviour.
> >
> > >
> > > > < ACL Data TX: Handle 1 flags 0x00 dlen 10
> > > >       L2CAP: Command Reject (0x01) ident 0 len 2
> > > >         Reason: Command not understood (0x0000)
> > > > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > >         Num handles: 1
> > > >         Handle: 1 Address: 00:1B:DC:F4:B3:E1 (Vencer Co., Ltd.)
> > > >         Count: 2
> > > > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > >        Num handles: 1
> > > >         Handle: 1 Address: 00:1B:DC:F4:B3:E1 (Vencer Co., Ltd.)
> > > >         Count: 1
> > > > > ACL Data RX: Handle 1 flags 0x02 dlen 25
> > > >       L2CAP: Configure Response (0x05) ident 3 len 17
> > > >         Source CID: 64
> > > >         Flags: 0x0000
> > > >         Result: Success (0x0000)
> > > >         Option: Retransmission and Flow Control (0x04) [mandatory]
> > > >           Mode: Basic (0x00)
> > > >           TX window size: 0
> > > >           Max transmit: 0
> > > >           Retransmission timeout: 0
> > > >           Monitor timeout: 0
> > > >           Maximum PDU size: 0
> > > >
> > > > Signed-off-by: Xigang(Ted) Feng <Xigang.Feng@gallagher.com>
> > > > ---
> > > >  net/bluetooth/l2cap_core.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.=
c
> > > > index 17ca13e8c044..c3af7727ee1e 100644
> > > > --- a/net/bluetooth/l2cap_core.c
> > > > +++ b/net/bluetooth/l2cap_core.c
> > > > @@ -6534,6 +6534,14 @@ static inline void l2cap_sig_channel(struct
> > > l2cap_conn *conn,
> > > >                 skb_pull(skb, len);
> > > >         }
> > > >
> > > > +       if (skb->len) {
> > > > +               struct l2cap_cmd_rej_unk rej;
> > > > +
> > > > +               rej.reason =3D cpu_to_le16(L2CAP_REJ_NOT_UNDERSTOOD=
);
> > > > +               l2cap_send_cmd(conn, 0, L2CAP_COMMAND_REJ,
> > > > +                                       sizeof(rej), &rej);
> > > > +       }
> > > > +
> > > >  drop:
> > > >         kfree_skb(skb);
> > > >  }
> > > > --
> > > > 2.34.1
> > > --
> > > Luiz Augusto von Dentz
> >
> > Best Regards,
> > Xigang
> > ________________________________
> >  This email is confidential and may contain information subject to lega=
l privilege. If you are not the intended recipient please advise us of our =
error by return e-mail then delete this email and any attached files. You m=
ay not copy, disclose or use the contents in any way. The views expressed i=
n this email may not be those of Gallagher Group Ltd or subsidiary companie=
s thereof.
> > ________________________________
>
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFCBEB64DC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Jul 2023 22:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjGNW13 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Jul 2023 18:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGNW12 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Jul 2023 18:27:28 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374BE2D6B
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jul 2023 15:27:27 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b73564e98dso37298051fa.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jul 2023 15:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689373645; x=1691965645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5oPsES2No7xOLymYkw1AUabB8HHkZhIxD3txB8kJe8=;
        b=dtb1fVfLmpPw2EmMTw/+ZKQfB7G5vmmVuGI+9/IleQDpVi59VEtefnt7BtWOTjcxoA
         9Yc7IiZvOFfKmCrfNQLGyvZ4278VwNs/srED3cQ1PzJv2F6Rxd6FRkHrT2Lh5WkQ5zTw
         S705oAW/1LJyrNEf23tfD/fdrkX25+YHgcMt0JrTVr2HKV1LwW5eYI+V4JsbkiTO2wf3
         dSmGKmzVFuFbhhY9mk6sfIaK9CBJDTVftNAf82YJafmNQ1IcWKVPO5OWAR0Mp7yR8TZV
         k2mRHq20l2pxAx5iMifM2XQCI6xNFioMKKewkLNicS8jtQgFUQmogiFaT8opn364GWgX
         MChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689373645; x=1691965645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5oPsES2No7xOLymYkw1AUabB8HHkZhIxD3txB8kJe8=;
        b=XWYGwyR35072YgICl5tXk8Hok+vLHtN422CYIr9YTuwbxWzrI7+ZO6sbq/sBaLuyZB
         yfk11AQ4GKdk+/YFwGtp3qmvR1OtZorVyDUJs8NzJJzuRfknDondBCV4qEtaQGJUfa7c
         PvXBZCFAe6mQ3cIfv4q5fE0MmAhm+qXz0w7O94xCKYsJyi33lygc4mEl17pekTNBATJ1
         0N3ojrTMcPR+2rX+PyzUy+fDsjbS4ySZ3mCE+snSnWELHJ6xB/HLvu2vDBAHBsD4EBqx
         Y4W6MlUe2FgNX1JfQNcPzz91KBCuKtO2s5oejWob5rq67g6menoZc9QGXi6/qGjd6GkI
         1IeQ==
X-Gm-Message-State: ABy/qLZESn1BYo4Ppfax9zf6xTimNXw4aMDgTVo4OyD7uoQazhDFGwb8
        G8OT0V2FKzEI4OOaRyAbivjY2/paHe1Qlp28ZnbHTW9+ZuE=
X-Google-Smtp-Source: APBJJlHOq4yLVu4FbdQQoXRpiI7VrvUw04O76AmloAZ3iZOtsiFJrSJdtrkiSfXDGigkLuutC96OVpZ0kaWhW1+djCQ=
X-Received: by 2002:a2e:900c:0:b0:2b6:e7b7:a163 with SMTP id
 h12-20020a2e900c000000b002b6e7b7a163mr4689709ljg.27.1689373645078; Fri, 14
 Jul 2023 15:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <ME3PR01MB56237F9982C4F3C9201AFF1FF02DA@ME3PR01MB5623.ausprd01.prod.outlook.com>
 <CABBYNZ+Q1iupoeK8GJbWcHRgrhNRjZKhS+Gu-DhO7Vx_wiqqeA@mail.gmail.com> <ME3PR01MB56234E61153A7358403B834AF032A@ME3PR01MB5623.ausprd01.prod.outlook.com>
In-Reply-To: <ME3PR01MB56234E61153A7358403B834AF032A@ME3PR01MB5623.ausprd01.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 14 Jul 2023 15:27:12 -0700
Message-ID: <CABBYNZJVgV7sy9HO37ZD=0XCT+JBu+NAeYYuzcok1LobW9nN9A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix for Bluetooth SIG test L2CAP/COS/CED/BI-02-C
To:     "Xigang(Ted) Feng" <Xigang.Feng@gallagher.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Sat, Jul 8, 2023 at 4:26=E2=80=AFPM Xigang(Ted) Feng
<Xigang.Feng@gallagher.com> wrote:
>
> Hi Luiz,
>
> > On Thu, Jul 6, 2023 at 7:46=E2=80=AFPM Xigang(Ted) Feng
> > <Xigang.Feng@gallagher.com> wrote:
> > >
> > > This test case is for verifying the L2CAP signalling PDUs that have i=
nvalid length
> > are properly handled.
> > > With this patch, the "L2CAP: Command Reject" packet is sent correctly=
 to the
> > malformed signal packet
> > > contained in "L2CAP: Connection Request" packet.
> > >
> > > BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 3, Part A page 1041
> > >
> > > 'When a packet is received with a Code field that is unknown or disal=
lowed on
> > the
> > > signalling channel it is received on, an L2CAP_COMMAND_REJECT_RSP
> > > packet (defined in Section 4.1) is sent in response.'
> > >
> > > Before this patch:
> > >
> > > > ACL Data RX: Handle 1 flags 0x02 dlen 15
> > >       L2CAP: Connection Request (0x02) ident 3 len 4
> > >         PSM: 1 (0x0001)
> > >         Source CID: 64
> > >         malformed signal packet
> > >         00 00 00                                         ...
> > > < ACL Data TX: Handle 1 flags 0x00 dlen 16
> > >       L2CAP: Connection Response (0x03) ident 3 len 8
> > >         Destination CID: 64
> > >         Source CID: 64
> > >         Result: Connection successful (0x0000)
> > >         Status: No further information available (0x0000)
> > > < ACL Data TX: Handle 1 flags 0x00 dlen 23
> > >       L2CAP: Configure Request (0x04) ident 3 len 15
> > >         Destination CID: 64
> > >         Flags: 0x0000
> > >         Option: Retransmission and Flow Control (0x04) [mandatory]
> > >           Mode: Basic (0x00)
> > >           TX window size: 0
> > >           Max transmit: 0
> > >           Retransmission timeout: 0
> > >           Monitor timeout: 0
> > >           Maximum PDU size: 0
> > > > HCI Event: Number of Completed Packets (0x13) plen 5
> > >         Num handles: 1
> > >         Handle: 1
> > >         Count: 2
> > > > ACL Data RX: Handle 1 flags 0x02 dlen 25
> > >       L2CAP: Configure Response (0x05) ident 3 len 17
> > >         Source CID: 64
> > >         Flags: 0x0000
> > >         Result: Success (0x0000)
> > >         Option: Retransmission and Flow Control (0x04) [mandatory]
> > >           Mode: Basic (0x00)
> > >           TX window size: 0
> > >           Max transmit: 0
> > >           Retransmission timeout: 0
> > >           Monitor timeout: 0
> > >           Maximum PDU size: 0
> > > < ACL Data TX: Handle 1 flags 0x00 dlen 12
> > >       L2CAP: Disconnection Request (0x06) ident 4 len 4
> > >         Destination CID: 64
> > >         Source CID: 64
> > > > HCI Event: Number of Completed Packets (0x13) plen 5
> > >         Num handles: 1
> > >         Handle: 1
> > >         Count: 1
> > > > ACL Data RX: Handle 1 flags 0x02 dlen 12
> > >       L2CAP: Disconnection Response (0x07) ident 4 len 4
> > >         Destination CID: 64
> > >         Source CID: 64
> > > < HCI Command: Disconnect (0x01|0x0006) plen 3
> > >         Handle: 1
> > >         Reason: Remote User Terminated Connection (0x13)
> > >
> > > After this patch:
> > >
> > > > ACL Data RX: Handle 1 flags 0x02 dlen 15
> > >       L2CAP: Connection Request (0x02) ident 3 len 4
> > >         PSM: 4113 (0x1011)
> > >         Source CID: 64
> > >         malformed signal packet
> > >         00 00 00                                         ...
> > > < ACL Data TX: Handle 1 flags 0x00 dlen 16
> > >       L2CAP: Connection Response (0x03) ident 3 len 8
> > >         Destination CID: 64
> > >         Source CID: 64
> > >         Result: Connection successful (0x0000)
> > >         Status: No further information available (0x0000)
> > > < ACL Data TX: Handle 1 flags 0x00 dlen 23
> > >       L2CAP: Configure Request (0x04) ident 3 len 15
> > >         Destination CID: 64
> > >         Flags: 0x0000
> > >         Option: Retransmission and Flow Control (0x04) [mandatory]
> > >           Mode: Basic (0x00)
> > >           TX window size: 0
> > >           Max transmit: 0
> > >           Retransmission timeout: 0
> > >           Monitor timeout: 0
> > >           Maximum PDU size: 0
> >
> > Looks like we are still sending a Configure Request which is sort of
> > useless if we are sending a Reject in the follow up command.
>
> I'm following the test case "L2CAP/COS/CED/BI-02-C" in " L2CAP Test Suite=
" from Bluetooth SIG.
> In Test Procedure, step 3 sends a L2CAP_CONNECTION_REQ with three extra b=
ytes of 0.
>
> Step 4 sends back L2CAP_CONNECTION_RSP to indicate the connection establi=
shed successfully,
> And send L2CAP_COMMAND_REJECT_RSP to reject the unknow command(the extra =
three bytes of 0) contained in L2CAP_CONNECTION_REQ.

Well I guess that is assuming the stack would consider the extra bytes
as a different command, in which case the PDU flow is correct but then
we probably need to check for unparsed bytes for all commands, not
just L2CAP_CONNECTION_REQ. Perhaps we need to take a look at the
errata which added this test to know exactly the intent of such test,
if I recall correctly L2CAP signalling channel supports more than one
outstanding command at the time, so perhaps it is valid to send
multiple commands in a row which is why this tests is done with extra
bytes at the end to simulate another command.

> In step 5, the Lower Tester can continue sending L2CAP_CONFIGURATION_REQ =
because the connection has been established successfully,
> So in my opinion, the Configure Request sent by IUT is also a correct beh=
aviour.
>
> >
> > > < ACL Data TX: Handle 1 flags 0x00 dlen 10
> > >       L2CAP: Command Reject (0x01) ident 0 len 2
> > >         Reason: Command not understood (0x0000)
> > > > HCI Event: Number of Completed Packets (0x13) plen 5
> > >         Num handles: 1
> > >         Handle: 1 Address: 00:1B:DC:F4:B3:E1 (Vencer Co., Ltd.)
> > >         Count: 2
> > > > HCI Event: Number of Completed Packets (0x13) plen 5
> > >        Num handles: 1
> > >         Handle: 1 Address: 00:1B:DC:F4:B3:E1 (Vencer Co., Ltd.)
> > >         Count: 1
> > > > ACL Data RX: Handle 1 flags 0x02 dlen 25
> > >       L2CAP: Configure Response (0x05) ident 3 len 17
> > >         Source CID: 64
> > >         Flags: 0x0000
> > >         Result: Success (0x0000)
> > >         Option: Retransmission and Flow Control (0x04) [mandatory]
> > >           Mode: Basic (0x00)
> > >           TX window size: 0
> > >           Max transmit: 0
> > >           Retransmission timeout: 0
> > >           Monitor timeout: 0
> > >           Maximum PDU size: 0
> > >
> > > Signed-off-by: Xigang(Ted) Feng <Xigang.Feng@gallagher.com>
> > > ---
> > >  net/bluetooth/l2cap_core.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > > index 17ca13e8c044..c3af7727ee1e 100644
> > > --- a/net/bluetooth/l2cap_core.c
> > > +++ b/net/bluetooth/l2cap_core.c
> > > @@ -6534,6 +6534,14 @@ static inline void l2cap_sig_channel(struct
> > l2cap_conn *conn,
> > >                 skb_pull(skb, len);
> > >         }
> > >
> > > +       if (skb->len) {
> > > +               struct l2cap_cmd_rej_unk rej;
> > > +
> > > +               rej.reason =3D cpu_to_le16(L2CAP_REJ_NOT_UNDERSTOOD);
> > > +               l2cap_send_cmd(conn, 0, L2CAP_COMMAND_REJ,
> > > +                                       sizeof(rej), &rej);
> > > +       }
> > > +
> > >  drop:
> > >         kfree_skb(skb);
> > >  }
> > > --
> > > 2.34.1
> > --
> > Luiz Augusto von Dentz
>
> Best Regards,
> Xigang
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

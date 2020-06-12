Return-Path: <SRS0=RDM4=7Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C355C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 09:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D5FC20801
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 09:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K1+I39ar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgFLJ1h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Jun 2020 05:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgFLJ1h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Jun 2020 05:27:37 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12049C03E96F
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2020 02:27:37 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id mb16so9429162ejb.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2020 02:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dCk37B/h0vBb6V74rwNY9TowK68T/jCy+jx0W/nHW7I=;
        b=K1+I39arBbQ1KVnx3UjsPTj8WDeg0cx6Ie9xN1IkQl1RzA17jj7pwUtHz3tz3h4tKs
         4y6ltiRnqLRgE4SnoYCHkTikyfiAx/rTS5K0pPMbks3N8ErUClzueI6zdDCuM776l4cU
         EMjE5DdkecFiBcCnFxbXpfeaW0qXGVTtAlpi9CiL7aNePp4fFAv03SBlgOBZhnr60kJU
         HvJLxRViuLriVylRcPOpjkZ8cBz0B6j8A6O7NUwTuWtNI3e+J71n+zBuzyIJS0XPPMu8
         /2XDC1YEMbT8L9DBU84iTk4XwvpdjUIEukTNiAAHnaznHqmrIfgaHgMDHDnAcTq/csJ6
         YZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dCk37B/h0vBb6V74rwNY9TowK68T/jCy+jx0W/nHW7I=;
        b=Om5/8VeKNPzbV1rOl/dkvPrfPsDAWf09wTN9psrMCVz6d2tAdlmj6IuLFdk61Nt6iZ
         3ktmPc6z0GTzccCaHr/2Kpdob4kUj+ED2R7f4IpSNFJU/lokPl4sDq94u8ewbasf5T6B
         aRnc5AnmNc1gLJjhV3IXy/nbnfDKERxUzdsGxTcxaGuIkeq6Xf05S5kUOMvcCiEnohGw
         jJLYS6O1TbPPqgWVYG3l4l1/zWEthUC7bIl8hkxnRWPfKWUT5SYYv0nG9nWVVVA7Qxik
         Vsup83Ol/Bg1Wo6cAJqv6T77KrrymzIl/cXO9yPFkCrpaRUpXxg633ntPYhWOonFYuvu
         mZvA==
X-Gm-Message-State: AOAM530mc7loPwsSNlyDr0WUMQaXBFBF+a91qVNsQwXJMLT0+Pxc/Rgn
        WGo0bqwr0BwgJVu/r5x1O+nu8kdkqub+trS8mIMV6w==
X-Google-Smtp-Source: ABdhPJzC1io943TWjjLLOKTm7QcnQH31nQY5FFmqDaTq9NLIbtqXwItIMaGwwUHz3TVsnKqXEq5p4LvYET37WpC7DHs=
X-Received: by 2002:a17:906:ca54:: with SMTP id jx20mr13154885ejb.549.1591954055319;
 Fri, 12 Jun 2020 02:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAPHZWUe9sLt8jsD57i3=PQxMfjODP7dUYLBm2qpSXFdgd9cvAQ@mail.gmail.com>
 <64A824C9-7C3C-4B08-8A9E-827121C4786D@holtmann.org> <CABBYNZJtgCNeZCYQ9tWno9qD9Vi2AaJNLH5TLxMtASHS-c+ySQ@mail.gmail.com>
 <CAPHZWUd=t6icDXpz=td0teDoKHtE6FMH3OPE5R+BH53GOrXAdg@mail.gmail.com>
 <558DADDA-AC07-4463-A94E-085B16976AAB@holtmann.org> <CAPHZWUeo3sAGsgAapYYZTSt_apKvP-2LHOxBbYF_8pcaCzYn1Q@mail.gmail.com>
 <CABBYNZJjhrTS+zkTqEu=8Nby7LUddwb0BUNVdkzDTACU-YZKrw@mail.gmail.com> <CABBYNZJNoiEdt2yi3CFbELRGRFrH+SwGzbnwXM_8OO=fattfZg@mail.gmail.com>
In-Reply-To: <CABBYNZJNoiEdt2yi3CFbELRGRFrH+SwGzbnwXM_8OO=fattfZg@mail.gmail.com>
From:   Yun-hao Chung <howardchung@google.com>
Date:   Fri, 12 Jun 2020 17:27:23 +0800
Message-ID: <CAPHZWUehLnwWONewZZrBSMjsU9fU1Bt5p7PsicMvAAsDeSJu9g@mail.gmail.com>
Subject: Re: Should we disable ERTM as default?
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Thanks for the patch. Unfortunately PTS folks told me the issue was
caused by bluez initiating AVDTP connection while PTS was expecting to
initiate the connection by itself.
So it's not related to l2cap channel type. Thanks anyway!


On Tue, Jun 9, 2020 at 4:28 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Yun-hao,
>
> On Mon, Jun 8, 2020 at 9:15 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Yun-hao,
> >
> > On Mon, Jun 8, 2020 at 6:11 AM Yun-hao Chung <howardchung@google.com> w=
rote:
> > >
> > > Hi Marcel,
> > >
> > > Here is the piece of the btmon trace.  What should be the next step?
> > >
> > > < ACL Data TX: Handle 256 flags 0x00 dlen 6
> > >       Channel: 66 len 2 [PSM 25 mode Basic (0x00)] {chan 2}
> > >       AVDTP: Discover (0x01) Command (0x00) type 0x00 label 3 nosp 0
> > > > HCI Event: Number of Completed Packets (0x13) plen 5
> > >         Num handles: 1
> > >         Handle: 256
> > >         Count: 1
> > > > HCI Event: Number of Completed Packets (0x13) plen 5
> > >         Num handles: 1
> > >         Handle: 256
> > >         Count: 1
> > > > ACL Data RX: Handle 256 flags 0x02 dlen 8
> > >       Channel: 66 len 4 [PSM 25 mode Basic (0x00)] {chan 2}
> > >       AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 3=
 nosp 0
> > >         ACP SEID: 1
> > >           Media Type: Audio (0x00)
> > >           SEP Type: SNK (0x01)
> > >           In use: No
> > > < ACL Data TX: Handle 256 flags 0x00 dlen 18
> > >       Channel: 66 len 14 [PSM 25 mode Basic (0x00)] {chan 2}
> > >       AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label =
4 nosp 0
> > >         ACP SEID: 1
> > >         INT SEID: 1
> > >         Service Category: Media Transport (0x01)
> > >         Service Category: Media Codec (0x07)
> > >           Media Type: Audio (0x00)
> > >           Media Codec: SBC (0x00)
> > >             Frequency: 48000 (0x10)
> > >             Channel Mode: Joint Stereo (0x01)
> > >             Block Length: 16 (0x10)
> > >             Subbands: 8 (0x04)
> > >             Allocation Method: Loudness (0x01)
> > >             Minimum Bitpool: 2
> > >             Maximum Bitpool: 64
> > > > HCI Event: Number of Completed Packets (0x13) plen 5
> > >         Num handles: 1
> > >         Handle: 256
> > >         Count: 1
> > > > ACL Data RX: Handle 256 flags 0x02 dlen 6
> > >       Channel: 66 len 2 [PSM 25 mode Basic (0x00)] {chan 2}
> > >       AVDTP: Set Configuration (0x03) Response Accept (0x02) type 0x0=
0 label 4 nosp 0
> > > < ACL Data TX: Handle 256 flags 0x00 dlen 7
> > >       Channel: 66 len 3 [PSM 25 mode Basic (0x00)] {chan 2}
> > >       AVDTP: Open (0x06) Command (0x00) type 0x00 label 5 nosp 0
> > >         ACP SEID: 1
> > > > HCI Event: Number of Completed Packets (0x13) plen 5
> > >         Num handles: 1
> > >         Handle: 256
> > >         Count: 1
> > > > ACL Data RX: Handle 256 flags 0x02 dlen 6
> > >       Channel: 66 len 2 [PSM 25 mode Basic (0x00)] {chan 2}
> > >       AVDTP: Open (0x06) Response Accept (0x02) type 0x00 label 5 nos=
p 0
> > > < ACL Data TX: Handle 256 flags 0x00 dlen 12
> > >       L2CAP: Connection Request (0x02) ident 6 len 4
> > >         PSM: 25 (0x0019)
> > >         Source CID: 67
> > > > HCI Event: Number of Completed Packets (0x13) plen 5
> > >         Num handles: 1
> > >         Handle: 256
> > >         Count: 1
> > > > ACL Data RX: Handle 256 flags 0x02 dlen 16
> > >       L2CAP: Connection Response (0x03) ident 6 len 8
> > >         Destination CID: 67
> > >         Source CID: 67
> > >         Result: Connection pending (0x0001)
> > >         Status: No further information available (0x0000)
> > > > ACL Data RX: Handle 256 flags 0x02 dlen 16
> > >       L2CAP: Connection Response (0x03) ident 6 len 8
> > >         Destination CID: 67
> > >         Source CID: 67
> > >         Result: Connection successful (0x0000)
> > >         Status: No further information available (0x0000)
> > > < ACL Data TX: Handle 256 flags 0x00 dlen 23
> > >       L2CAP: Configure Request (0x04) ident 7 len 15
> > >         Destination CID: 67
> > >         Flags: 0x0000
> > >         Option: Retransmission and Flow Control (0x04) [mandatory]
> > >           Mode: Basic (0x00)
> > >           TX window size: 0
> > >           Max transmit: 0
> > >           Retransmission timeout: 0
> > >           Monitor timeout: 0
> > >           Maximum PDU size: 0
> > > > ACL Data RX: Handle 256 flags 0x02 dlen 23
> > >       L2CAP: Configure Request (0x04) ident 222 len 15
> > >         Destination CID: 67
> > >         Flags: 0x0000
> > >         Option: Retransmission and Flow Control (0x04) [mandatory]
> > >           Mode: Streaming (0x04)
> >
> > Looks like we should be using BT_IO_MODE_STREAMING with MPS then.
> >
> > >           TX window size: 0
> > >           Max transmit: 0
> > >           Retransmission timeout: 0
> > >           Monitor timeout: 0
> > >           Maximum PDU size: 672
> > > < ACL Data TX: Handle 256 flags 0x00 dlen 25
> > >       L2CAP: Configure Response (0x05) ident 222 len 17
> > >         Source CID: 67
> > >         Flags: 0x0000
> > >         Result: Failure - unacceptable parameters (0x0001)
> > >         Option: Retransmission and Flow Control (0x04) [mandatory]
> > >           Mode: Basic (0x00)
> > >           TX window size: 0
> > >           Max transmit: 0
> > >           Retransmission timeout: 0
> > >           Monitor timeout: 0
> > >           Maximum PDU size: 672
> > > > HCI Event: Number of Completed Packets (0x13) plen 5
> > >         Num handles: 1
> > >         Handle: 256
> > >         Count: 1
> > > > HCI Event: Number of Completed Packets (0x13) plen 5
> > >         Num handles: 1
> > >         Handle: 256
> > >         Count: 1
> > > > ACL Data RX: Handle 256 flags 0x02 dlen 29
> > >       L2CAP: Configure Response (0x05) ident 7 len 21
> > >         Source CID: 67
> > >         Flags: 0x0000
> > >         Result: Success (0x0000)
> > >         Option: Maximum Transmission Unit (0x01) [mandatory]
> > >           MTU: 672
> > >         Option: Retransmission and Flow Control (0x04) [mandatory]
> > >           Mode: Basic (0x00)
> > >           TX window size: 0
> > >           Max transmit: 0
> > >           Retransmission timeout: 0
> > >           Monitor timeout: 0
> > >           Maximum PDU size: 0
> > > > ACL Data RX: Handle 256 flags 0x02 dlen 12
> > >       L2CAP: Configure Request (0x04) ident 223 len 4
> > >         Destination CID: 67
> > >         Flags: 0x0000
> > > < ACL Data TX: Handle 256 flags 0x00 dlen 18
> > >       L2CAP: Configure Response (0x05) ident 223 len 10
> > >         Source CID: 67
> > >         Flags: 0x0000
> > >         Result: Success (0x0000)
> > >         Option: Maximum Transmission Unit (0x01) [mandatory]
> > >           MTU: 672
> > >
> > > Thanks.
> > >
> > > On Mon, Jun 8, 2020 at 3:58 PM Marcel Holtmann <marcel@holtmann.org> =
wrote:
> > >>
> > >> Hi Yun-hao,
> > >>
> > >> > I think it is more likely to be the PTS's limitations. I realized =
the
> > >> > problem is in the media channel not in the signaling channel. PTS
> > >> > wants to use streaming mode, but bluez rejects it, and then PTS ab=
orts
> > >> > the test. According to the MPS 1.0 Spec 6.2, L2CAP streaming mode =
is
> > >> > the recommendation for optimization when using MPS media control
> > >> > channels, so I think bluez doesn't do anything wrong during this t=
est.
> > >>
> > >> do you have the btmon trace for this. I think we should accept ERTM =
on the media channel. The unfortunate part is that control and media channe=
ls both use PSM 25 and so we can=E2=80=99t be really selective when we are =
the acceptor. If MPS wants us to accept ERTM on the media channel we should=
 allow. For all I care we can even accept it on the control channel, but it=
 is just a waste of overhead on the L2CAP headers. Actually the new Enhance=
d Flow Control mode on BR/EDR would be more efficient for A2DP.
> >
> > Perhaps we can default to Streaming mode if MPS is enabled, we could
> > actually do use it only for the transport channel while initiating but
> > as a receiver I don't think it is possible to change after listen.
>
> I've sent a patch implementing this, let me know if that works with PTS.
>
> --
> Luiz Augusto von Dentz

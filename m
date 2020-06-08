Return-Path: <SRS0=ITyu=7V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6561C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jun 2020 16:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 859D3206D5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jun 2020 16:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwSxGzlo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbgFHQP5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730267AbgFHQP4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Jun 2020 12:15:56 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAD5C08C5C2
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2020 09:15:56 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id d67so15812223oig.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2020 09:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g0M0F5wHMTj8FDNJ3mXnejn9idvuLFWAl4fsqrleEAs=;
        b=MwSxGzlorBwiFU9lPGEdv2+qVk9G9/fcboLUe+pGpiym+l0nMrjE5MfBg3kgFk5iDv
         gLy2ahYMf1LCbdJPa9ikXDowI+OCMK5lqct0gk+Q8zjYfsEABg1cmU3per3MveR78cuR
         /vpjko6MqRPgsLKjuzkabsTMdJLztGM6OhdWhJzwJwwdM7WaCW72y5ScSK8OOifQQMei
         35a1UmJ9hgWiIMTBLmLD1xOaX7b791sOCZAexkbta4mpyjCnzMN31/0nU1MqCO4MWARs
         lpTWaITWB7ahnzsQm834t6yJERSkL+ObCjVvwTQclShOQKs8uaxNYhw0tCy6FMAjyQaG
         fW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g0M0F5wHMTj8FDNJ3mXnejn9idvuLFWAl4fsqrleEAs=;
        b=G+kLjrQzN0kpD0ZKZvXttxjEGUOQPJIhsPloulSNg/z7X4Lzrdqqy9wYigt0O/8W9u
         GNH6WMIy/6iyedTbocmE5XrcQZe7CAcRpP5lkoW2hI3DNVBZV5aGCrPS8CTlTfWFXpJS
         9qSQJk0B6434rF4DKSBoDSy5Ng9rRLFrvi1xkWUW5k7L7yUGLpE6UZhsNV4H1/RUaWUQ
         LbY0R8RG829ouhwDqm7zbNl6gTaexpdlk4srZ74iz+lFrvX1iKaT4hVw8OldoogVDzfj
         M+54c5uzEl3W+rkvF/P6bTzh5Echv3cFUKv1k4qjrU1IlXt3ap1yXLRnanfS4HWVgq33
         ko4A==
X-Gm-Message-State: AOAM531SBz/AE2DlTXAZwu5VTWvhlzBpw61cmn4CAC4ZFCmfrOZb9PyF
        LzAeMgidShlmdS9CH90prreI2XwEnIiJtcPUxPSyiA==
X-Google-Smtp-Source: ABdhPJwYqgaj+NlV7kqgVGkp3L2jGMcBliIAWztrYRbtmAR2P/ZN6ms46WhXTuCqOc/pItatRdQhJ08pZJRxv4TRE0s=
X-Received: by 2002:aca:fdc3:: with SMTP id b186mr109573oii.82.1591632954187;
 Mon, 08 Jun 2020 09:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAPHZWUe9sLt8jsD57i3=PQxMfjODP7dUYLBm2qpSXFdgd9cvAQ@mail.gmail.com>
 <64A824C9-7C3C-4B08-8A9E-827121C4786D@holtmann.org> <CABBYNZJtgCNeZCYQ9tWno9qD9Vi2AaJNLH5TLxMtASHS-c+ySQ@mail.gmail.com>
 <CAPHZWUd=t6icDXpz=td0teDoKHtE6FMH3OPE5R+BH53GOrXAdg@mail.gmail.com>
 <558DADDA-AC07-4463-A94E-085B16976AAB@holtmann.org> <CAPHZWUeo3sAGsgAapYYZTSt_apKvP-2LHOxBbYF_8pcaCzYn1Q@mail.gmail.com>
In-Reply-To: <CAPHZWUeo3sAGsgAapYYZTSt_apKvP-2LHOxBbYF_8pcaCzYn1Q@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 8 Jun 2020 09:15:42 -0700
Message-ID: <CABBYNZJjhrTS+zkTqEu=8Nby7LUddwb0BUNVdkzDTACU-YZKrw@mail.gmail.com>
Subject: Re: Should we disable ERTM as default?
To:     Yun-hao Chung <howardchung@google.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        ChromeOS BT Qualification <chromeos-bt-qual@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Yun-hao,

On Mon, Jun 8, 2020 at 6:11 AM Yun-hao Chung <howardchung@google.com> wrote=
:
>
> Hi Marcel,
>
> Here is the piece of the btmon trace.  What should be the next step?
>
> < ACL Data TX: Handle 256 flags 0x00 dlen 6
>       Channel: 66 len 2 [PSM 25 mode Basic (0x00)] {chan 2}
>       AVDTP: Discover (0x01) Command (0x00) type 0x00 label 3 nosp 0
> > HCI Event: Number of Completed Packets (0x13) plen 5
>         Num handles: 1
>         Handle: 256
>         Count: 1
> > HCI Event: Number of Completed Packets (0x13) plen 5
>         Num handles: 1
>         Handle: 256
>         Count: 1
> > ACL Data RX: Handle 256 flags 0x02 dlen 8
>       Channel: 66 len 4 [PSM 25 mode Basic (0x00)] {chan 2}
>       AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 3 nos=
p 0
>         ACP SEID: 1
>           Media Type: Audio (0x00)
>           SEP Type: SNK (0x01)
>           In use: No
> < ACL Data TX: Handle 256 flags 0x00 dlen 18
>       Channel: 66 len 14 [PSM 25 mode Basic (0x00)] {chan 2}
>       AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 4 no=
sp 0
>         ACP SEID: 1
>         INT SEID: 1
>         Service Category: Media Transport (0x01)
>         Service Category: Media Codec (0x07)
>           Media Type: Audio (0x00)
>           Media Codec: SBC (0x00)
>             Frequency: 48000 (0x10)
>             Channel Mode: Joint Stereo (0x01)
>             Block Length: 16 (0x10)
>             Subbands: 8 (0x04)
>             Allocation Method: Loudness (0x01)
>             Minimum Bitpool: 2
>             Maximum Bitpool: 64
> > HCI Event: Number of Completed Packets (0x13) plen 5
>         Num handles: 1
>         Handle: 256
>         Count: 1
> > ACL Data RX: Handle 256 flags 0x02 dlen 6
>       Channel: 66 len 2 [PSM 25 mode Basic (0x00)] {chan 2}
>       AVDTP: Set Configuration (0x03) Response Accept (0x02) type 0x00 la=
bel 4 nosp 0
> < ACL Data TX: Handle 256 flags 0x00 dlen 7
>       Channel: 66 len 3 [PSM 25 mode Basic (0x00)] {chan 2}
>       AVDTP: Open (0x06) Command (0x00) type 0x00 label 5 nosp 0
>         ACP SEID: 1
> > HCI Event: Number of Completed Packets (0x13) plen 5
>         Num handles: 1
>         Handle: 256
>         Count: 1
> > ACL Data RX: Handle 256 flags 0x02 dlen 6
>       Channel: 66 len 2 [PSM 25 mode Basic (0x00)] {chan 2}
>       AVDTP: Open (0x06) Response Accept (0x02) type 0x00 label 5 nosp 0
> < ACL Data TX: Handle 256 flags 0x00 dlen 12
>       L2CAP: Connection Request (0x02) ident 6 len 4
>         PSM: 25 (0x0019)
>         Source CID: 67
> > HCI Event: Number of Completed Packets (0x13) plen 5
>         Num handles: 1
>         Handle: 256
>         Count: 1
> > ACL Data RX: Handle 256 flags 0x02 dlen 16
>       L2CAP: Connection Response (0x03) ident 6 len 8
>         Destination CID: 67
>         Source CID: 67
>         Result: Connection pending (0x0001)
>         Status: No further information available (0x0000)
> > ACL Data RX: Handle 256 flags 0x02 dlen 16
>       L2CAP: Connection Response (0x03) ident 6 len 8
>         Destination CID: 67
>         Source CID: 67
>         Result: Connection successful (0x0000)
>         Status: No further information available (0x0000)
> < ACL Data TX: Handle 256 flags 0x00 dlen 23
>       L2CAP: Configure Request (0x04) ident 7 len 15
>         Destination CID: 67
>         Flags: 0x0000
>         Option: Retransmission and Flow Control (0x04) [mandatory]
>           Mode: Basic (0x00)
>           TX window size: 0
>           Max transmit: 0
>           Retransmission timeout: 0
>           Monitor timeout: 0
>           Maximum PDU size: 0
> > ACL Data RX: Handle 256 flags 0x02 dlen 23
>       L2CAP: Configure Request (0x04) ident 222 len 15
>         Destination CID: 67
>         Flags: 0x0000
>         Option: Retransmission and Flow Control (0x04) [mandatory]
>           Mode: Streaming (0x04)

Looks like we should be using BT_IO_MODE_STREAMING with MPS then.

>           TX window size: 0
>           Max transmit: 0
>           Retransmission timeout: 0
>           Monitor timeout: 0
>           Maximum PDU size: 672
> < ACL Data TX: Handle 256 flags 0x00 dlen 25
>       L2CAP: Configure Response (0x05) ident 222 len 17
>         Source CID: 67
>         Flags: 0x0000
>         Result: Failure - unacceptable parameters (0x0001)
>         Option: Retransmission and Flow Control (0x04) [mandatory]
>           Mode: Basic (0x00)
>           TX window size: 0
>           Max transmit: 0
>           Retransmission timeout: 0
>           Monitor timeout: 0
>           Maximum PDU size: 672
> > HCI Event: Number of Completed Packets (0x13) plen 5
>         Num handles: 1
>         Handle: 256
>         Count: 1
> > HCI Event: Number of Completed Packets (0x13) plen 5
>         Num handles: 1
>         Handle: 256
>         Count: 1
> > ACL Data RX: Handle 256 flags 0x02 dlen 29
>       L2CAP: Configure Response (0x05) ident 7 len 21
>         Source CID: 67
>         Flags: 0x0000
>         Result: Success (0x0000)
>         Option: Maximum Transmission Unit (0x01) [mandatory]
>           MTU: 672
>         Option: Retransmission and Flow Control (0x04) [mandatory]
>           Mode: Basic (0x00)
>           TX window size: 0
>           Max transmit: 0
>           Retransmission timeout: 0
>           Monitor timeout: 0
>           Maximum PDU size: 0
> > ACL Data RX: Handle 256 flags 0x02 dlen 12
>       L2CAP: Configure Request (0x04) ident 223 len 4
>         Destination CID: 67
>         Flags: 0x0000
> < ACL Data TX: Handle 256 flags 0x00 dlen 18
>       L2CAP: Configure Response (0x05) ident 223 len 10
>         Source CID: 67
>         Flags: 0x0000
>         Result: Success (0x0000)
>         Option: Maximum Transmission Unit (0x01) [mandatory]
>           MTU: 672
>
> Thanks.
>
> On Mon, Jun 8, 2020 at 3:58 PM Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>>
>> Hi Yun-hao,
>>
>> > I think it is more likely to be the PTS's limitations. I realized the
>> > problem is in the media channel not in the signaling channel. PTS
>> > wants to use streaming mode, but bluez rejects it, and then PTS aborts
>> > the test. According to the MPS 1.0 Spec 6.2, L2CAP streaming mode is
>> > the recommendation for optimization when using MPS media control
>> > channels, so I think bluez doesn't do anything wrong during this test.
>>
>> do you have the btmon trace for this. I think we should accept ERTM on t=
he media channel. The unfortunate part is that control and media channels b=
oth use PSM 25 and so we can=E2=80=99t be really selective when we are the =
acceptor. If MPS wants us to accept ERTM on the media channel we should all=
ow. For all I care we can even accept it on the control channel, but it is =
just a waste of overhead on the L2CAP headers. Actually the new Enhanced Fl=
ow Control mode on BR/EDR would be more efficient for A2DP.

Perhaps we can default to Streaming mode if MPS is enabled, we could
actually do use it only for the transport channel while initiating but
as a receiver I don't think it is possible to change after listen.

--=20
Luiz Augusto von Dentz

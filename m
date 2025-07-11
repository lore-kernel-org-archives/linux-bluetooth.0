Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D59E2E975D
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752245843; cv=none; b=SCX1D1ir0zs+/EolKIzlL7hdP2DPpBA9iSJ5o8Scp50EYD8y2Rtx3q6c+kluLJIm/nwZbmm4pjzILUhlyT1ysBGt62grigN64E9bHjgBY/fbIonwrYxaURNCTMWw/IpzkizZR4ly5PEfa3zLVVjXJQe86je7TxrBZHL+morGAIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752245843; c=relaxed/simple;
	bh=lo0gya9MuCQIl0HYmv3JaN6Loud60mjPNBM64aksNio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LU+CaMa3Nsq4x16wL8pZFYhxrMg7fyUnGZhXccYldyzOVUtTWdWiLlXcSJ9G+DkZHmYxphkDANhrmuXYNwku3y8OKlpw5+rjebxYthYjpI0u8QboqQFLDY9juxTkd7z9RZELE40fcW4OZep2hCRQ2fTCorlkJlPoLF8hkii2QFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mj7XcRv8; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mj7XcRv8"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32b2f5d91c8so16492251fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 07:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752245839; x=1752850639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BQlIVKmVU455fX+YG00bFJHC580UGTwU5yOPYwzrpY=;
        b=mj7XcRv8hEoua4w980AvCE36hX/MDYwZWE8+v6WWlkDKGHYeYu8ySSuSVr9mVFxyW1
         qiuIwxRprpZj2w/2eYlSqX36G+ddiSqF4JTDi8l2dfG15GOqDhgeHcfAz72nd9K3UeDB
         CVw5eI4aezen6Hp3T403OQjL0z2mwFtcnvDwnp1DVOgm2ZzFfU1qxKF2VD33aXv8oW1j
         5ikf21iEzFLXV/k6RV+9M9Ij9/rgVaG+nQUmqk7v/mqqj0AVbiaZPVCp0yNQpHJi5fhn
         z5+TfS92NWV6ycur4/o8KPqSZb8Dje/jzI6AX1FID9JIzNjfr9ibZbJbGHgznVLN9sr7
         skUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752245839; x=1752850639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BQlIVKmVU455fX+YG00bFJHC580UGTwU5yOPYwzrpY=;
        b=fHpdehBzKEv6x5BsFxqw+CZvvtqATU37pR+IXKqnB4lCKeqQrQOGfXWW1i6hT3NCwX
         N5//seMhqg1JmOV6yMZpxylWyky//6hCnYUWAoXTZtRaQ4tPhIKLz2iECZ70c3m9/nMI
         tievAwcR0EXx288VuLd4wvegjbYftSF+qsGsstTpgPLde2XvXxeVd4Cqk00ZY5hUKPV1
         gBnH3H4HfnjYSLTKfnBwO/ScEQ5OXgEYATZFwYByETN9sYB5bSrjiGTyKOiP9KPVXD7h
         gCAAHz4VieoIZTDQdvWEKH2cDI/y1expVday+Xo8DYZkrqQdyK8WtAwvfzmlXqowcMVX
         VaSg==
X-Forwarded-Encrypted: i=1; AJvYcCVGWs0T3vht/uw7H8p9nh1+MVmYRSRmeVVnunNz1STM//3u+2Zfq/h3N+itQiQmOVGU0Grb1fun/3LRw416bQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBK95vOBuZ+lwrfnXxu+sYuU+KWuASjPZ21T60gouGKe/QpAYU
	/Wr7bk0+YdcpfYev5ARysxDNFcGJiWAAD/pa+CG7W1M7jaVMGum+qOKvcQSvn/1x9pZqQOtf7U5
	UwqSiLN2jdQTibShsXavU5NClqlhoJw258g==
X-Gm-Gg: ASbGncu5lCkXLKm/JGCVzQ/BgFxaQHKpjBUrMQDjRSehm6+Xoumle0mKgA4ak2Lmmol
	u3sVZlLpx4DBeZME+jCbg0hGu3QguFlapptAioKXbDUHtEw2hK3f0CisQv+IXnWLQhOtV/vOHOw
	S221fBslnMk1CYk9fviudgds0ENc9hzJ29/vkDHWjy9uSZSSg6RsXYB+ypsAvABrp4RlenJM970
	FrNaw==
X-Google-Smtp-Source: AGHT+IEypChEW2uXkfj6TxaDUkgaLBMRdr0yBlttPk8bMPKkZDg/zbtyk25iP80LDmB2kXdJKwiAsb1mIIFVgPLY3ZM=
X-Received: by 2002:a2e:9219:0:b0:32a:7e4c:e915 with SMTP id
 38308e7fff4ca-3305344f522mr12111591fa.29.1752245839075; Fri, 11 Jul 2025
 07:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612075034.190194-1-frederic.danis@collabora.com> <1241dea72ce758a6f5eccd73cefca8df802916b7.camel@iki.fi>
In-Reply-To: <1241dea72ce758a6f5eccd73cefca8df802916b7.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 11 Jul 2025 10:57:05 -0400
X-Gm-Features: Ac12FXz1oyJNSIZnU6rxmI5L-7_-7nrtV-x_FK2NFEOIFNcknZInrBOqmfiyzms
Message-ID: <CABBYNZ+denmT8Sre7KEmMTwGzpWXCo0pS5TRtNoukv0ZGBA7wg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix L2CAP MTU negotiation
To: Pauli Virtanen <pav@iki.fi>
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Fri, Jul 11, 2025 at 9:53=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> to, 2025-06-12 kello 09:50 +0200, Fr=C3=A9d=C3=A9ric Danis kirjoitti:
> > OBEX download from iPhone is currently slow due to small packet size
> > used to transfer data which doesn't follow the MTU negotiated during
> > L2CAP connection, i.e. 672 bytes instead of 32767:
>
> There are some reports that appear to indicate this commit causes
> regressions for A2DP:
>
> https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/=
149#note_285698
>
> https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4793#note_30012=
87

Might be a good idea to create a github issue for it, doesn't seem
like the above issues had collected any btmon traces yet, perhaps the
MTU is not updated or left to 0? Anyway we may want to add a test in
l2cap-tester to try to reproduce the same scenario.

>
> >
> >   < ACL Data TX: Handle 11 flags 0x00 dlen 12
> >       L2CAP: Connection Request (0x02) ident 18 len 4
> >         PSM: 4103 (0x1007)
> >         Source CID: 72
> >   > ACL Data RX: Handle 11 flags 0x02 dlen 16
> >       L2CAP: Connection Response (0x03) ident 18 len 8
> >         Destination CID: 14608
> >         Source CID: 72
> >         Result: Connection successful (0x0000)
> >         Status: No further information available (0x0000)
> >   < ACL Data TX: Handle 11 flags 0x00 dlen 27
> >       L2CAP: Configure Request (0x04) ident 20 len 19
> >         Destination CID: 14608
> >         Flags: 0x0000
> >         Option: Maximum Transmission Unit (0x01) [mandatory]
> >           MTU: 32767
> >         Option: Retransmission and Flow Control (0x04) [mandatory]
> >           Mode: Enhanced Retransmission (0x03)
> >           TX window size: 63
> >           Max transmit: 3
> >           Retransmission timeout: 2000
> >           Monitor timeout: 12000
> >           Maximum PDU size: 1009
> >   > ACL Data RX: Handle 11 flags 0x02 dlen 26
> >       L2CAP: Configure Request (0x04) ident 72 len 18
> >         Destination CID: 72
> >         Flags: 0x0000
> >         Option: Retransmission and Flow Control (0x04) [mandatory]
> >           Mode: Enhanced Retransmission (0x03)
> >           TX window size: 32
> >           Max transmit: 255
> >           Retransmission timeout: 0
> >           Monitor timeout: 0
> >           Maximum PDU size: 65527
> >         Option: Frame Check Sequence (0x05) [mandatory]
> >           FCS: 16-bit FCS (0x01)
> >   < ACL Data TX: Handle 11 flags 0x00 dlen 29
> >       L2CAP: Configure Response (0x05) ident 72 len 21
> >         Source CID: 14608
> >         Flags: 0x0000
> >         Result: Success (0x0000)
> >         Option: Maximum Transmission Unit (0x01) [mandatory]
> >           MTU: 672
> >         Option: Retransmission and Flow Control (0x04) [mandatory]
> >           Mode: Enhanced Retransmission (0x03)
> >           TX window size: 32
> >           Max transmit: 255
> >           Retransmission timeout: 2000
> >           Monitor timeout: 12000
> >           Maximum PDU size: 1009
> >   > ACL Data RX: Handle 11 flags 0x02 dlen 32
> >       L2CAP: Configure Response (0x05) ident 20 len 24
> >         Source CID: 72
> >         Flags: 0x0000
> >         Result: Success (0x0000)
> >         Option: Maximum Transmission Unit (0x01) [mandatory]
> >           MTU: 32767
> >         Option: Retransmission and Flow Control (0x04) [mandatory]
> >           Mode: Enhanced Retransmission (0x03)
> >           TX window size: 63
> >           Max transmit: 3
> >           Retransmission timeout: 2000
> >           Monitor timeout: 12000
> >           Maximum PDU size: 1009
> >         Option: Frame Check Sequence (0x05) [mandatory]
> >           FCS: 16-bit FCS (0x01)
> >   ...
> >   > ACL Data RX: Handle 11 flags 0x02 dlen 680
> >       Channel: 72 len 676 ctrl 0x0202 [PSM 4103 mode Enhanced Retransmi=
ssion (0x03)] {chan 8}
> >       I-frame: Unsegmented TxSeq 1 ReqSeq 2
> >   < ACL Data TX: Handle 11 flags 0x00 dlen 13
> >       Channel: 14608 len 9 ctrl 0x0204 [PSM 4103 mode Enhanced Retransm=
ission (0x03)] {chan 8}
> >       I-frame: Unsegmented TxSeq 2 ReqSeq 2
> >   > ACL Data RX: Handle 11 flags 0x02 dlen 680
> >       Channel: 72 len 676 ctrl 0x0304 [PSM 4103 mode Enhanced Retransmi=
ssion (0x03)] {chan 8}
> >       I-frame: Unsegmented TxSeq 2 ReqSeq 3
> >
> > The MTUs are negotiated for each direction. In this traces 32767 for
> > iPhone->localhost and no MTU for localhost->iPhone, which based on
> > '4.4 L2CAP_CONFIGURATION_REQ' (Core specification v5.4, Vol. 3, Part
> > A):
> >
> >   The only parameters that should be included in the
> >   L2CAP_CONFIGURATION_REQ packet are those that require different
> >   values than the default or previously agreed values.
> >   ...
> >   Any missing configuration parameters are assumed to have their
> >   most recently explicitly or implicitly accepted values.
> >
> > and '5.1 Maximum transmission unit (MTU)':
> >
> >   If the remote device sends a positive L2CAP_CONFIGURATION_RSP
> >   packet it should include the actual MTU to be used on this channel
> >   for traffic flowing into the local device.
> >   ...
> >   The default value is 672 octets.
> >
> > is set by BlueZ to 672 bytes.
> >
> > It seems that the iPhone used the lowest negotiated value to transfer
> > data to the localhost instead of the negotiated one for the incoming
> > direction.
> >
> > This could be fixed by using the MTU negotiated for the other
> > direction, if exists, in the L2CAP_CONFIGURATION_RSP.
> > This allows to use segmented packets as in the following traces:
> >
> >   < ACL Data TX: Handle 11 flags 0x00 dlen 12
> >         L2CAP: Connection Request (0x02) ident 22 len 4
> >           PSM: 4103 (0x1007)
> >           Source CID: 72
> >   < ACL Data TX: Handle 11 flags 0x00 dlen 27
> >         L2CAP: Configure Request (0x04) ident 24 len 19
> >           Destination CID: 2832
> >           Flags: 0x0000
> >           Option: Maximum Transmission Unit (0x01) [mandatory]
> >             MTU: 32767
> >           Option: Retransmission and Flow Control (0x04) [mandatory]
> >             Mode: Enhanced Retransmission (0x03)
> >             TX window size: 63
> >             Max transmit: 3
> >             Retransmission timeout: 2000
> >             Monitor timeout: 12000
> >             Maximum PDU size: 1009
> >   > ACL Data RX: Handle 11 flags 0x02 dlen 26
> >         L2CAP: Configure Request (0x04) ident 15 len 18
> >           Destination CID: 72
> >           Flags: 0x0000
> >           Option: Retransmission and Flow Control (0x04) [mandatory]
> >             Mode: Enhanced Retransmission (0x03)
> >             TX window size: 32
> >             Max transmit: 255
> >             Retransmission timeout: 0
> >             Monitor timeout: 0
> >             Maximum PDU size: 65527
> >           Option: Frame Check Sequence (0x05) [mandatory]
> >             FCS: 16-bit FCS (0x01)
> >   < ACL Data TX: Handle 11 flags 0x00 dlen 29
> >         L2CAP: Configure Response (0x05) ident 15 len 21
> >           Source CID: 2832
> >           Flags: 0x0000
> >           Result: Success (0x0000)
> >           Option: Maximum Transmission Unit (0x01) [mandatory]
> >             MTU: 32767
> >           Option: Retransmission and Flow Control (0x04) [mandatory]
> >             Mode: Enhanced Retransmission (0x03)
> >             TX window size: 32
> >             Max transmit: 255
> >             Retransmission timeout: 2000
> >             Monitor timeout: 12000
> >             Maximum PDU size: 1009
> >   > ACL Data RX: Handle 11 flags 0x02 dlen 32
> >         L2CAP: Configure Response (0x05) ident 24 len 24
> >           Source CID: 72
> >           Flags: 0x0000
> >           Result: Success (0x0000)
> >           Option: Maximum Transmission Unit (0x01) [mandatory]
> >             MTU: 32767
> >           Option: Retransmission and Flow Control (0x04) [mandatory]
> >             Mode: Enhanced Retransmission (0x03)
> >             TX window size: 63
> >             Max transmit: 3
> >             Retransmission timeout: 2000
> >             Monitor timeout: 12000
> >             Maximum PDU size: 1009
> >           Option: Frame Check Sequence (0x05) [mandatory]
> >             FCS: 16-bit FCS (0x01)
> >   ...
> >   > ACL Data RX: Handle 11 flags 0x02 dlen 1009
> >         Channel: 72 len 1005 ctrl 0x4202 [PSM 4103 mode Enhanced Retran=
smission (0x03)] {chan 8}
> >         I-frame: Start (len 21884) TxSeq 1 ReqSeq 2
> >   > ACL Data RX: Handle 11 flags 0x02 dlen 1009
> >         Channel: 72 len 1005 ctrl 0xc204 [PSM 4103 mode Enhanced Retran=
smission (0x03)] {chan 8}
> >         I-frame: Continuation TxSeq 2 ReqSeq 2
> >
> > This has been tested with kernel 5.4 and BlueZ 5.77.
> >
> > Signed-off-by: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
> > ---
> >  net/bluetooth/l2cap_core.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index a5bde5db58ef..40daa38276f3 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -3415,7 +3415,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan=
 *chan, void *data, size_t data
> >       struct l2cap_conf_rfc rfc =3D { .mode =3D L2CAP_MODE_BASIC };
> >       struct l2cap_conf_efs efs;
> >       u8 remote_efs =3D 0;
> > -     u16 mtu =3D L2CAP_DEFAULT_MTU;
> > +     u16 mtu =3D 0;
> >       u16 result =3D L2CAP_CONF_SUCCESS;
> >       u16 size;
> >
> > @@ -3520,6 +3520,13 @@ static int l2cap_parse_conf_req(struct l2cap_cha=
n *chan, void *data, size_t data
> >               /* Configure output options and let the other side know
> >                * which ones we don't like. */
> >
> > +             /* If MTU is not provided in configure request, use the m=
ost recently
> > +              * explicitly or implicitly accepted value for the other =
direction,
> > +              * or the default value.
> > +              */
> > +             if (mtu =3D=3D 0)
> > +                     mtu =3D chan->imtu ? chan->imtu : L2CAP_DEFAULT_M=
TU;
> > +
> >               if (mtu < L2CAP_DEFAULT_MIN_MTU)
> >                       result =3D L2CAP_CONF_UNACCEPT;
> >               else {
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz

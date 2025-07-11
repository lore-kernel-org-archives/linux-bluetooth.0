Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9707482
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752246561; cv=pass; b=BZkLotSaAK3q9J5G6VnKlPdbbuMfRIN0iAeV1TdgEo8LWC7HLIlkZUXnPmPPS93FNS+r/bjf7Rmm77b3Gisl2eToBtb0cdEKphTrxKpaY27bmzf0UyLXw9yyhCYGCMXAM+Pk7Hw2I9HcRqDgfyG+ErtdkD8jCaJekiaQlSx33Js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752246561; c=relaxed/simple;
	bh=6w5qFynwNaOuv4b/J7PXPFOeIgc3gbXCLFezH7OAE5U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lowmdVdZYU9uc1GjOQ9TFXgHanktVWtnI1hKOCTPoKvdKHhK4er0V//XURCysEy98x+3Tq6VJ9mjdbUL+oVhFtFMi5FYSiJiLj14KB2FHlUFlCak58oshhBXZuzBC4/DIfgwDy6jQpNtZj12KsLU3Lcr9YiBmpXMcnNuHpqVv60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=d/n2a1Tf; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="d/n2a1Tf"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bdw925Hbwz49Pv6;
	Fri, 11 Jul 2025 18:09:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1752246551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mh7j1/LzI/f02EiRdJhvwfNlqo7ntvHKNrXXN/P5wEk=;
	b=d/n2a1TfuAOCz22D0OYYAXdPC1NfLAdfn911eNhjjv1a360vVekoICRED8M4YI8DzCwoYB
	83UqLdpjIoI6P7bt9BFHwjtj5z3tfBWluvTBEtNIf2d8+sDLboG37tWRciUvS4IEIKG+oR
	QFzwTtK2AN9E5V3dlNwILOxZG4DvJWRwdt9yWXgHyfseyuaEwGCRc/QWy4ACuMkS/d/OUC
	Pe+7Zn0Ja/ihuj7xi1sMM3R1NCBMlG5EpsuRowz67/NgL4JIFHqmEPqGSQhaJzUqoj8yXO
	YWsZepPxTKzK16CC0EIE/7qcAODsG8WBDIb26gNlxRpLG7UjG8BGCDQF0u9QVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1752246551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mh7j1/LzI/f02EiRdJhvwfNlqo7ntvHKNrXXN/P5wEk=;
	b=u8LMpYcvfswL9+50j/TG6pOBtH7p8dY+sg420o+OJfP0UYAbex9vls4jSljQTy1qyr787l
	Ndt2z9y50mab3XpsiYADe3X1ZUWQh4s5JtB9fmUMcxMu2++BbVq4i8xtkNPfmDraBZYJXU
	A6tS3Gw2PHxIr9//FD9UbRSw2VC8A7BOa3QFMgmReN9U2T9VOCzAspjCS2WzjnngEX0011
	PUt/XQvhojBd60dnbefa8j3IaZKRE4IXFA/glMpEZ7E4WGe4BcBZ2Ui5kr21oGpFKnzm3H
	9ZkyJIKej2Dxii/yCF9VJhFKBhszUCIMMH0bxGs6nSYvsEiqnISIdXaAR1FSyQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1752246551; a=rsa-sha256;
	cv=none;
	b=H+BHaec5Z4RVSzPe3frBpGeBgfWtVoGmrMTTJypuAMlrfxpi0T8wYM7/of4f5PPLtt/P5W
	URd7YEtHxBHEnvfRrnEHCpPwKW0Un0ZjYrrIDaGRRRLzhJYNSWdXyBSvVNXW3XpK5xyEAL
	N3F7LpmfxDVD0/JYFpRDj0CJLWlpBCmUB3jSJhXQOpjp9CIuxrGTm+WZiy/iWjrM3SecBK
	TD6k1ANSpHIBubDTmllSvaFReW8sSRPSY6Zl7HtfLrF8u5E4ovM/8wL2Dz5mWpQBaFBUE8
	4IO6HST9TBvSvD8Zv6OoEF6KQHsnpiuODA89kMSRaukHGE0b4TVlcESP+blBwg==
Message-ID: <52cca42a5becc66e4a33bde09b9413b9f32822f1.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix L2CAP MTU negotiation
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis@collabora.com>, 
	linux-bluetooth@vger.kernel.org
Date: Fri, 11 Jul 2025 18:09:09 +0300
In-Reply-To: <CABBYNZ+denmT8Sre7KEmMTwGzpWXCo0pS5TRtNoukv0ZGBA7wg@mail.gmail.com>
References: <20250612075034.190194-1-frederic.danis@collabora.com>
	 <1241dea72ce758a6f5eccd73cefca8df802916b7.camel@iki.fi>
	 <CABBYNZ+denmT8Sre7KEmMTwGzpWXCo0pS5TRtNoukv0ZGBA7wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz,

pe, 2025-07-11 kello 10:57 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Fri, Jul 11, 2025 at 9:53=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > Hi,
> >=20
> > to, 2025-06-12 kello 09:50 +0200, Fr=C3=A9d=C3=A9ric Danis kirjoitti:
> > > OBEX download from iPhone is currently slow due to small packet size
> > > used to transfer data which doesn't follow the MTU negotiated during
> > > L2CAP connection, i.e. 672 bytes instead of 32767:
> >=20
> > There are some reports that appear to indicate this commit causes
> > regressions for A2DP:
> >=20
> > https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issue=
s/149#note_285698
> >=20
> > https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4793#note_300=
1287
>=20
> Might be a good idea to create a github issue for it, doesn't seem
> like the above issues had collected any btmon traces yet, perhaps the
> MTU is not updated or left to 0? Anyway we may want to add a test in
> l2cap-tester to try to reproduce the same scenario.

The first link had btmon traces, and here's another:

https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4793#note_2999272

>=20
> >=20
> > >=20
> > >   < ACL Data TX: Handle 11 flags 0x00 dlen 12
> > >       L2CAP: Connection Request (0x02) ident 18 len 4
> > >         PSM: 4103 (0x1007)
> > >         Source CID: 72
> > >   > ACL Data RX: Handle 11 flags 0x02 dlen 16
> > >       L2CAP: Connection Response (0x03) ident 18 len 8
> > >         Destination CID: 14608
> > >         Source CID: 72
> > >         Result: Connection successful (0x0000)
> > >         Status: No further information available (0x0000)
> > >   < ACL Data TX: Handle 11 flags 0x00 dlen 27
> > >       L2CAP: Configure Request (0x04) ident 20 len 19
> > >         Destination CID: 14608
> > >         Flags: 0x0000
> > >         Option: Maximum Transmission Unit (0x01) [mandatory]
> > >           MTU: 32767
> > >         Option: Retransmission and Flow Control (0x04) [mandatory]
> > >           Mode: Enhanced Retransmission (0x03)
> > >           TX window size: 63
> > >           Max transmit: 3
> > >           Retransmission timeout: 2000
> > >           Monitor timeout: 12000
> > >           Maximum PDU size: 1009
> > >   > ACL Data RX: Handle 11 flags 0x02 dlen 26
> > >       L2CAP: Configure Request (0x04) ident 72 len 18
> > >         Destination CID: 72
> > >         Flags: 0x0000
> > >         Option: Retransmission and Flow Control (0x04) [mandatory]
> > >           Mode: Enhanced Retransmission (0x03)
> > >           TX window size: 32
> > >           Max transmit: 255
> > >           Retransmission timeout: 0
> > >           Monitor timeout: 0
> > >           Maximum PDU size: 65527
> > >         Option: Frame Check Sequence (0x05) [mandatory]
> > >           FCS: 16-bit FCS (0x01)
> > >   < ACL Data TX: Handle 11 flags 0x00 dlen 29
> > >       L2CAP: Configure Response (0x05) ident 72 len 21
> > >         Source CID: 14608
> > >         Flags: 0x0000
> > >         Result: Success (0x0000)
> > >         Option: Maximum Transmission Unit (0x01) [mandatory]
> > >           MTU: 672
> > >         Option: Retransmission and Flow Control (0x04) [mandatory]
> > >           Mode: Enhanced Retransmission (0x03)
> > >           TX window size: 32
> > >           Max transmit: 255
> > >           Retransmission timeout: 2000
> > >           Monitor timeout: 12000
> > >           Maximum PDU size: 1009
> > >   > ACL Data RX: Handle 11 flags 0x02 dlen 32
> > >       L2CAP: Configure Response (0x05) ident 20 len 24
> > >         Source CID: 72
> > >         Flags: 0x0000
> > >         Result: Success (0x0000)
> > >         Option: Maximum Transmission Unit (0x01) [mandatory]
> > >           MTU: 32767
> > >         Option: Retransmission and Flow Control (0x04) [mandatory]
> > >           Mode: Enhanced Retransmission (0x03)
> > >           TX window size: 63
> > >           Max transmit: 3
> > >           Retransmission timeout: 2000
> > >           Monitor timeout: 12000
> > >           Maximum PDU size: 1009
> > >         Option: Frame Check Sequence (0x05) [mandatory]
> > >           FCS: 16-bit FCS (0x01)
> > >   ...
> > >   > ACL Data RX: Handle 11 flags 0x02 dlen 680
> > >       Channel: 72 len 676 ctrl 0x0202 [PSM 4103 mode Enhanced Retrans=
mission (0x03)] {chan 8}
> > >       I-frame: Unsegmented TxSeq 1 ReqSeq 2
> > >   < ACL Data TX: Handle 11 flags 0x00 dlen 13
> > >       Channel: 14608 len 9 ctrl 0x0204 [PSM 4103 mode Enhanced Retran=
smission (0x03)] {chan 8}
> > >       I-frame: Unsegmented TxSeq 2 ReqSeq 2
> > >   > ACL Data RX: Handle 11 flags 0x02 dlen 680
> > >       Channel: 72 len 676 ctrl 0x0304 [PSM 4103 mode Enhanced Retrans=
mission (0x03)] {chan 8}
> > >       I-frame: Unsegmented TxSeq 2 ReqSeq 3
> > >=20
> > > The MTUs are negotiated for each direction. In this traces 32767 for
> > > iPhone->localhost and no MTU for localhost->iPhone, which based on
> > > '4.4 L2CAP_CONFIGURATION_REQ' (Core specification v5.4, Vol. 3, Part
> > > A):
> > >=20
> > >   The only parameters that should be included in the
> > >   L2CAP_CONFIGURATION_REQ packet are those that require different
> > >   values than the default or previously agreed values.
> > >   ...
> > >   Any missing configuration parameters are assumed to have their
> > >   most recently explicitly or implicitly accepted values.
> > >=20
> > > and '5.1 Maximum transmission unit (MTU)':
> > >=20
> > >   If the remote device sends a positive L2CAP_CONFIGURATION_RSP
> > >   packet it should include the actual MTU to be used on this channel
> > >   for traffic flowing into the local device.
> > >   ...
> > >   The default value is 672 octets.
> > >=20
> > > is set by BlueZ to 672 bytes.
> > >=20
> > > It seems that the iPhone used the lowest negotiated value to transfer
> > > data to the localhost instead of the negotiated one for the incoming
> > > direction.
> > >=20
> > > This could be fixed by using the MTU negotiated for the other
> > > direction, if exists, in the L2CAP_CONFIGURATION_RSP.
> > > This allows to use segmented packets as in the following traces:
> > >=20
> > >   < ACL Data TX: Handle 11 flags 0x00 dlen 12
> > >         L2CAP: Connection Request (0x02) ident 22 len 4
> > >           PSM: 4103 (0x1007)
> > >           Source CID: 72
> > >   < ACL Data TX: Handle 11 flags 0x00 dlen 27
> > >         L2CAP: Configure Request (0x04) ident 24 len 19
> > >           Destination CID: 2832
> > >           Flags: 0x0000
> > >           Option: Maximum Transmission Unit (0x01) [mandatory]
> > >             MTU: 32767
> > >           Option: Retransmission and Flow Control (0x04) [mandatory]
> > >             Mode: Enhanced Retransmission (0x03)
> > >             TX window size: 63
> > >             Max transmit: 3
> > >             Retransmission timeout: 2000
> > >             Monitor timeout: 12000
> > >             Maximum PDU size: 1009
> > >   > ACL Data RX: Handle 11 flags 0x02 dlen 26
> > >         L2CAP: Configure Request (0x04) ident 15 len 18
> > >           Destination CID: 72
> > >           Flags: 0x0000
> > >           Option: Retransmission and Flow Control (0x04) [mandatory]
> > >             Mode: Enhanced Retransmission (0x03)
> > >             TX window size: 32
> > >             Max transmit: 255
> > >             Retransmission timeout: 0
> > >             Monitor timeout: 0
> > >             Maximum PDU size: 65527
> > >           Option: Frame Check Sequence (0x05) [mandatory]
> > >             FCS: 16-bit FCS (0x01)
> > >   < ACL Data TX: Handle 11 flags 0x00 dlen 29
> > >         L2CAP: Configure Response (0x05) ident 15 len 21
> > >           Source CID: 2832
> > >           Flags: 0x0000
> > >           Result: Success (0x0000)
> > >           Option: Maximum Transmission Unit (0x01) [mandatory]
> > >             MTU: 32767
> > >           Option: Retransmission and Flow Control (0x04) [mandatory]
> > >             Mode: Enhanced Retransmission (0x03)
> > >             TX window size: 32
> > >             Max transmit: 255
> > >             Retransmission timeout: 2000
> > >             Monitor timeout: 12000
> > >             Maximum PDU size: 1009
> > >   > ACL Data RX: Handle 11 flags 0x02 dlen 32
> > >         L2CAP: Configure Response (0x05) ident 24 len 24
> > >           Source CID: 72
> > >           Flags: 0x0000
> > >           Result: Success (0x0000)
> > >           Option: Maximum Transmission Unit (0x01) [mandatory]
> > >             MTU: 32767
> > >           Option: Retransmission and Flow Control (0x04) [mandatory]
> > >             Mode: Enhanced Retransmission (0x03)
> > >             TX window size: 63
> > >             Max transmit: 3
> > >             Retransmission timeout: 2000
> > >             Monitor timeout: 12000
> > >             Maximum PDU size: 1009
> > >           Option: Frame Check Sequence (0x05) [mandatory]
> > >             FCS: 16-bit FCS (0x01)
> > >   ...
> > >   > ACL Data RX: Handle 11 flags 0x02 dlen 1009
> > >         Channel: 72 len 1005 ctrl 0x4202 [PSM 4103 mode Enhanced Retr=
ansmission (0x03)] {chan 8}
> > >         I-frame: Start (len 21884) TxSeq 1 ReqSeq 2
> > >   > ACL Data RX: Handle 11 flags 0x02 dlen 1009
> > >         Channel: 72 len 1005 ctrl 0xc204 [PSM 4103 mode Enhanced Retr=
ansmission (0x03)] {chan 8}
> > >         I-frame: Continuation TxSeq 2 ReqSeq 2
> > >=20
> > > This has been tested with kernel 5.4 and BlueZ 5.77.
> > >=20
> > > Signed-off-by: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com=
>
> > > ---
> > >  net/bluetooth/l2cap_core.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > > index a5bde5db58ef..40daa38276f3 100644
> > > --- a/net/bluetooth/l2cap_core.c
> > > +++ b/net/bluetooth/l2cap_core.c
> > > @@ -3415,7 +3415,7 @@ static int l2cap_parse_conf_req(struct l2cap_ch=
an *chan, void *data, size_t data
> > >       struct l2cap_conf_rfc rfc =3D { .mode =3D L2CAP_MODE_BASIC };
> > >       struct l2cap_conf_efs efs;
> > >       u8 remote_efs =3D 0;
> > > -     u16 mtu =3D L2CAP_DEFAULT_MTU;
> > > +     u16 mtu =3D 0;
> > >       u16 result =3D L2CAP_CONF_SUCCESS;
> > >       u16 size;
> > >=20
> > > @@ -3520,6 +3520,13 @@ static int l2cap_parse_conf_req(struct l2cap_c=
han *chan, void *data, size_t data
> > >               /* Configure output options and let the other side know
> > >                * which ones we don't like. */
> > >=20
> > > +             /* If MTU is not provided in configure request, use the=
 most recently
> > > +              * explicitly or implicitly accepted value for the othe=
r direction,
> > > +              * or the default value.
> > > +              */
> > > +             if (mtu =3D=3D 0)
> > > +                     mtu =3D chan->imtu ? chan->imtu : L2CAP_DEFAULT=
_MTU;
> > > +
> > >               if (mtu < L2CAP_DEFAULT_MIN_MTU)
> > >                       result =3D L2CAP_CONF_UNACCEPT;
> > >               else {
> >=20
> > --
> > Pauli Virtanen
>=20
>=20

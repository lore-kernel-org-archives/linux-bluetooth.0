Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0475A311C02
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 16:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754929569; cv=pass; b=CHx/Ud4ZkhlBATDtBqf8BEINSbyatHb5krT3zG6yr44QcCu6ylg1w5tPTKSXZEMTfIRDzoVlq7AuMAxeGflUERmDTETAV3D1kZ9rZNczjDlZhSXbEaFQxDx4jCNURSHKkv08WlUWtIgZqaWXpDtdWObaSjmy8/Xk3l2e1s81wWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754929569; c=relaxed/simple;
	bh=OorRBJZZ58Ccc69taHRqDY5fJ8stNDrmV30/BVFBY54=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o5dAA22tOt2wqmuYuPC+rFO6cs4yWY8NC7ODBymWsFETn9wcyYVZsLrKH/U77Th55da/myWQuROWx/RIgvgGK5c51L6CxtJp0ip6iRmOHBJgVqLRqxKQtGw9mBh19GV+vY6CQM8Jqm4rsd7oDrU3pUlxyDHzjmpwX07LMcKKW+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=qtP1T0IK; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="qtP1T0IK"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4c10PG3j6gz49Q51;
	Mon, 11 Aug 2025 19:25:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1754929554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Ro0AUkH8+Z4zFOCtD247VI+g0C6HkAXvvbWV6AFE0o=;
	b=qtP1T0IKNyDfhO+bgmBUb3noTsSW6J0I3B+pXBRx+RiS4ur+UKVJm6uxTjr70kggv36Jw5
	4cydXTrWbOBxcxtZ4lHgEj8225DUCKQ4ixo8a+RaYLO9Fd+GiLMZ2k3bwIK2koS9JxOrZ4
	vUTTt/xLBIosgJM1rQjKf4ndXlIpTaWK/ZAsW7ufCeexUYZz6hP7BL52AlkDg9MWqLGiQo
	+pTmzhlkeIUoAIXO24eESk8PAmWgt/5AHFVbdPmtbXcqhrlmuL2cuMOwnWPdQknC65/GWP
	1rhsxcLlhYdtWwbqphULn9h7VgcZH5Sivci2Gu6pjIikOZRygnRrsVnuW2fm5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1754929554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Ro0AUkH8+Z4zFOCtD247VI+g0C6HkAXvvbWV6AFE0o=;
	b=ErZKaxyz9hcxMTRkw3bL4FYPIq5GvygYrGdxct6WJ3Z960Hhr10CEhnb8XsTbYcwOwRVjO
	00b4lr6PHtAahx4aFJPlH3Zdv00Zna4rCDxraZY6kqT2HZUYTMWQAnwdXpSg2cZGDCbMNS
	xU9C4MtBV9+4mrOPdpCYDqtzgeHD58tEWO4y5tL6ns8IIaxsajchqBIlE2SHfug5EFctqR
	N+6JZNH7W+bSuP5RMRvmZ36MrlaYxW6hL1e8A6Mc7jVC1aRcPHtyn8BF5+gZkyxNVwhmEU
	UON2TgdLzWzDwp/NByT53XsNkgbtknn5TFNcsAbSEoMvyxOn8W2lwz3Omczsig==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pauli.virtanen@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1754929554; a=rsa-sha256;
	cv=none;
	b=gCCioTwF2vVuIQOpeY5QV65/cLxtOxWoxBcQJAkWv7fgqFAb/v5L2TfVB6cKHDEK5QQQW+
	28aOI4iE/3574qCG5OFBCuIg7NpwmyUOthGCEjAOrXqiwAWh4jxPbVVS0Ak+/2y53CU/ZD
	QqnWpA+qBp+1POOzG0NT2xSPKykbf4upFDau1zrOq8+tXFAxovp82VUP/xcPO1uG2mqriO
	R+fX2ODXNIgj013+q2+TJZEkq0moeHV7856h5cgiVt3/iHZjvQ2rrdci6/F516n3KcsalH
	wQA8lzbuB+nQd6QG/y3jq+NLpkfWH0M7I02kZm/W0ogQwhF7AyNAy5WVkP9PlQ==
Message-ID: <f4460cda0599338abc381e1d3dd16872ce52eb68.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: hci_event: fix MTU for BN == 0 in CIS
 Established
From: Pauli Virtanen <pauli.virtanen@iki.fi>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 11 Aug 2025 19:25:53 +0300
In-Reply-To: <c1ae36fe-90d8-4c3a-a011-6191c150d16f@molgen.mpg.de>
References: 
	<cc0cd5d3cd7ed9b081b60f34f97ed9c39a820935.1754728503.git.pav@iki.fi>
	 <f0ec9c48-39ae-4ab2-b62f-f688dd16f3bf@molgen.mpg.de>
	 <a58c9a4f08bc07af959ea3e8cef9ac96a366b79f.camel@iki.fi>
	 <c1ae36fe-90d8-4c3a-a011-6191c150d16f@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

su, 2025-08-10 kello 09:15 +0200, Paul Menzel kirjoitti:
> Dear Pauli,
>=20
>=20
> Thank you for your reply.
>=20
> Am 09.08.25 um 11:43 schrieb Pauli Virtanen:
>=20
> > la, 2025-08-09 kello 11:24 +0200, Paul Menzel kirjoitti:
>=20
> [=E2=80=A6]
>=20
> > > Am 09.08.25 um 10:36 schrieb Pauli Virtanen:
> > > > BN =3D=3D 0x00 in CIS Established means no isochronous data for the
> > > > corresponding direction (Core v6.1 pp. 2394). In this case SDU MTU
> > > > should be 0.
> > > >=20
> > > > However, the specification does not say the Max_PDU_C_To_P or P_To_=
C are
> > > > then zero.  Intel AX210 in Framed CIS mode sets nonzero Max_PDU for
> > > > direction with zero BN.  This causes failure later when we try to L=
E
> > > > Setup ISO Data Path for disabled direction, which is disallowed (Co=
re
> > > > v6.1 pp. 2750).
> > > >=20
> > > > Fix by setting SDU MTU to 0 if BN =3D=3D 0.
> > >=20
> > > Do you have command how to reproduce this on the device?
> >=20
> > As noted in the text above, try to create framed unidirectional CIS on
> > this particular controller, e.g. for 44.1kHz audio.
>=20
> Indeed, I read that. But I have no idea how to do that. Is that possible=
=20
> with the tools, or does this need to be coded explicitly?

This should always happen if you try to create a 44.1 kHz
unidirectional audio stream (they are always framed).

You can do this in Pipewire(master) + BlueZ(master) <-> Pipewire+BlueZ
configuration for example, you'll need to make it use the 44.1kHz in
config or just edit bap-codec-lc3.c

Or, you can do it with bluetoothctl, don't remember the exact syntax
now.

> > > > Fixes: 2be22f1941d5f ("Bluetooth: hci_event: Fix parsing of CIS Est=
ablished Event")
> > > > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > > > ---
> > > >    net/bluetooth/hci_event.c | 8 ++++----
> > > >    1 file changed, 4 insertions(+), 4 deletions(-)
> > > >=20
> > > > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > > > index 4f0a6116291e..fe7cdd67ad2a 100644
> > > > --- a/net/bluetooth/hci_event.c
> > > > +++ b/net/bluetooth/hci_event.c
> > > > @@ -6745,8 +6745,8 @@ static void hci_le_cis_established_evt(struct=
 hci_dev *hdev, void *data,
> > > >    		qos->ucast.out.latency =3D
> > > >    			DIV_ROUND_CLOSEST(get_unaligned_le24(ev->p_latency),
> > > >    					  1000);
> > > > -		qos->ucast.in.sdu =3D le16_to_cpu(ev->c_mtu);
> > > > -		qos->ucast.out.sdu =3D le16_to_cpu(ev->p_mtu);
> > > > +		qos->ucast.in.sdu =3D ev->c_bn ? le16_to_cpu(ev->c_mtu) : 0;
> > > > +		qos->ucast.out.sdu =3D ev->p_bn ? le16_to_cpu(ev->p_mtu) : 0;
> > > >    		qos->ucast.in.phy =3D ev->c_phy;
> > > >    		qos->ucast.out.phy =3D ev->p_phy;
> > > >    		break;
> > > > @@ -6760,8 +6760,8 @@ static void hci_le_cis_established_evt(struct=
 hci_dev *hdev, void *data,
> > > >    		qos->ucast.in.latency =3D
> > > >    			DIV_ROUND_CLOSEST(get_unaligned_le24(ev->p_latency),
> > > >    					  1000);
> > > > -		qos->ucast.out.sdu =3D le16_to_cpu(ev->c_mtu);
> > > > -		qos->ucast.in.sdu =3D le16_to_cpu(ev->p_mtu);
> > > > +		qos->ucast.out.sdu =3D ev->c_bn ? le16_to_cpu(ev->c_mtu) : 0;
> > > > +		qos->ucast.in.sdu =3D ev->p_bn ? le16_to_cpu(ev->p_mtu) : 0;
> > > >    		qos->ucast.out.phy =3D ev->c_phy;
> > > >    		qos->ucast.in.phy =3D ev->p_phy;
> > > >    		break;
> > >=20
> > > Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>=20
> Kind regards,
>=20
> Paul

--=20
Pauli Virtanen

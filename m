Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFB4241114
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 Aug 2025 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754732593; cv=pass; b=rxkJ69UeNHdGlZgYWMzF3juV1XpRJZ4bVeD7pBtJzBVgetL0GLXXMkvDjjGNLbBsm8/9tKl5mBN0dQZpOaTIsdwucvQ3FIgRIJ8Bl1+LZxe6d5wBR10BLp+6XwzzPck7Wdeo5uzbKhthsoM0y7did1a2XrNJJXtgMivTksI1rwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754732593; c=relaxed/simple;
	bh=A1ARGw1iRSxtj+yeLRzx+AHvf4Ml9QZkU0hmJsTFZ1A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BsW76FEtQMI5GRZK5jjAyZnHCsfYplSkIwDkCVf9gJPnQYCSRVPk1U3WSYdPdRnDt2oqzCQ5V1j3LKbCtKBYFialqcymJV12z7UFuXDbDqi+eJBD0/Pb7SV1StmbMr2Zc8Qzcf5m+CLkT2t05xgop2mpymf1iqBDPfqF45xBIU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=lYS7vH4A; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="lYS7vH4A"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bzbYL3j2Sz49PwS;
	Sat,  9 Aug 2025 12:43:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1754732582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cym1+jLSj5pyRCa7GdTu2j7UHO0kL5R40YM4OHFBT70=;
	b=lYS7vH4AKm5v2CMgmxn7MoTVPFG50n7ZzUtAHJzllX1ermPIX/6EVXVuLLVST4V+GdbM5v
	rhi7v2tCIdmS41sCkQFiEaXJRuW4BhCEzc3yhy3e/napu78cHXsvhntxy1GKzOJgWFhNir
	2MQIOZtU2INYUmayyB6GIKGRBu0ScxrtkG8NhDaeFhNFidDtYFrx4bV3L2T6Vom4KHJ4Ow
	3RhyoqTIYR8l7UUFxQ23M7O18TWKdzAFdQsASGZX/BpYHNiWYiHMncdihBFZCxf93J7/HW
	NbRwBWo9SYaBJFGRGnDu3nmHf4ehdyLi9kT+6FsUNPXn6zXVRLtEIZbXRXvrOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1754732582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cym1+jLSj5pyRCa7GdTu2j7UHO0kL5R40YM4OHFBT70=;
	b=K+nW7hloh7f72LNwWPqMbiBdSGIwdfhZNE7WrhlJFlh1/W5NSJLNX6V/Uu5vfhVkxdcD8K
	rcj1QIQnjeOY1DEoQTw9QYDq07KEj9wdOwhYUxumGFtSWVVcSYRTAMTkhejp9ZLEGluL17
	c72QsUAj8h5PnFAezylU/IFeN3gdgZH+WlF77BK+FKF0vn9v4khaklFLOYz/bLpuPBkKMk
	Nmso21jVLVMHD9wuKlUXl+HiIvulB8XLOqXsgqzxxVaVuhH17hgUef6tMcEzgSugyFcvy1
	Ea/FiRPtdDsAwlZFanVShMFIa+Kr/fQNMmrhF+ZbvsoJl9jD814tyxMNMhds4g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pauli.virtanen@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1754732582; a=rsa-sha256;
	cv=none;
	b=MBFPhH98xXZO+wKYxN+OivBVch8yCez+ZGW1RGunqeAcODc+LFbmE60Zj25QvyAY3m8DXj
	UgveC0ySZJQBU2nhVpPluqWCW6mjxC2CQuMi/xbe8O1u9vFn13WAuHVSpW1s+ylIQDUkIM
	t37rkS8SpWcA4Gd7B1hWGZOVTCfPkkfoRMMr17tR/X4HysCl70LSwITjohT+zBn9ahrFM6
	Fo56KLbqY564uPEWjkKSs3IEQvghFkYMpsbpom6xWT4PQVJVbvQFSqIRk0PWSL9RckZp7c
	VdBXmsm5rude4/pmf1RuikQ1a2HabaA+GMMXJ1BxkTejJ2mH2h+uu+LmnKyqtQ==
Message-ID: <a58c9a4f08bc07af959ea3e8cef9ac96a366b79f.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: hci_event: fix MTU for BN == 0 in CIS
 Established
From: Pauli Virtanen <pauli.virtanen@iki.fi>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 09 Aug 2025 12:43:01 +0300
In-Reply-To: <f0ec9c48-39ae-4ab2-b62f-f688dd16f3bf@molgen.mpg.de>
References: 
	<cc0cd5d3cd7ed9b081b60f34f97ed9c39a820935.1754728503.git.pav@iki.fi>
	 <f0ec9c48-39ae-4ab2-b62f-f688dd16f3bf@molgen.mpg.de>
Autocrypt: addr=pauli.virtanen@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

la, 2025-08-09 kello 11:24 +0200, Paul Menzel kirjoitti:
> Dear Pauli,
>=20
>=20
> Thank you for the patch.
>=20
> Am 09.08.25 um 10:36 schrieb Pauli Virtanen:
> > BN =3D=3D 0x00 in CIS Established means no isochronous data for the
> > corresponding direction (Core v6.1 pp. 2394). In this case SDU MTU
> > should be 0.
> >=20
> > However, the specification does not say the Max_PDU_C_To_P or P_To_C ar=
e
> > then zero.  Intel AX210 in Framed CIS mode sets nonzero Max_PDU for
> > direction with zero BN.  This causes failure later when we try to LE
> > Setup ISO Data Path for disabled direction, which is disallowed (Core
> > v6.1 pp. 2750).
> >=20
> > Fix by setting SDU MTU to 0 if BN =3D=3D 0.
>=20
> Do you have command how to reproduce this on the device?

As noted in the text above, try to create framed unidirectional CIS on
this particular controller, e.g. for 44.1kHz audio.

> > Fixes: 2be22f1941d5f ("Bluetooth: hci_event: Fix parsing of CIS Establi=
shed Event")
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > ---
> >   net/bluetooth/hci_event.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 4f0a6116291e..fe7cdd67ad2a 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -6745,8 +6745,8 @@ static void hci_le_cis_established_evt(struct hci=
_dev *hdev, void *data,
> >   		qos->ucast.out.latency =3D
> >   			DIV_ROUND_CLOSEST(get_unaligned_le24(ev->p_latency),
> >   					  1000);
> > -		qos->ucast.in.sdu =3D le16_to_cpu(ev->c_mtu);
> > -		qos->ucast.out.sdu =3D le16_to_cpu(ev->p_mtu);
> > +		qos->ucast.in.sdu =3D ev->c_bn ? le16_to_cpu(ev->c_mtu) : 0;
> > +		qos->ucast.out.sdu =3D ev->p_bn ? le16_to_cpu(ev->p_mtu) : 0;
> >   		qos->ucast.in.phy =3D ev->c_phy;
> >   		qos->ucast.out.phy =3D ev->p_phy;
> >   		break;
> > @@ -6760,8 +6760,8 @@ static void hci_le_cis_established_evt(struct hci=
_dev *hdev, void *data,
> >   		qos->ucast.in.latency =3D
> >   			DIV_ROUND_CLOSEST(get_unaligned_le24(ev->p_latency),
> >   					  1000);
> > -		qos->ucast.out.sdu =3D le16_to_cpu(ev->c_mtu);
> > -		qos->ucast.in.sdu =3D le16_to_cpu(ev->p_mtu);
> > +		qos->ucast.out.sdu =3D ev->c_bn ? le16_to_cpu(ev->c_mtu) : 0;
> > +		qos->ucast.in.sdu =3D ev->p_bn ? le16_to_cpu(ev->p_mtu) : 0;
> >   		qos->ucast.out.phy =3D ev->c_phy;
> >   		qos->ucast.in.phy =3D ev->p_phy;
> >   		break;
>=20
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>=20
>=20
> Kind regards,
>=20
> Paul

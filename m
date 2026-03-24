Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71833B0AFE
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 22:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389702; cv=pass; b=mVweFhGRlSoWp9xLA1Z+vlr64EO5vXYHEtpZsfx7tO6t4jhdbcZsRgpb7E0p7hgWnj1rgtm+BM2MTaMbk8XQz5QWd0wtgH37hSM+kd3xXluI3CfD3gkIiZBq56eGXAPzhAZTSamt1nJ//mPCPhtSrODdLqqtIVXnflWVQlc8ZGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389702; c=relaxed/simple;
	bh=o8lTw2ItO5L/qFbtcXcpqFdd/Z8bInRtvMGoRVJsu7E=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AvuDdTHhMke8DGsg9BfdEQIXuYS+oP59nOETLsvjAFWt94YzE14UN5igHrAKPtUhkkhhglaO+QY6ZTDTAtYE264N6Uji5YrFMjb14TyeLSmIVZ8wDlRublo8qP3zFaP+r+RbsufHP1JjZTT1GeqM5WGREcrxKXVTGWWzCT/3z5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=KrFxdKJn; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="KrFxdKJn"
Received: from [192.168.1.195] (unknown [IPv6:2a02:6ea0:1508:6::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fgPBn0hK9z49Q5g
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 00:01:36 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1774389697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=o8lTw2ItO5L/qFbtcXcpqFdd/Z8bInRtvMGoRVJsu7E=;
	b=KrFxdKJnhgEPtJkzWlhhkHL9kN413eVviADI5r+IlOZNzRjuVrxVfeimicqvQ3hLu1NhCQ
	hqIJIdpIJ12sUM+8qvN3uZT6PTDyqAftcw8pxLnHxvHR1Xl8eLRpN91N1ES2Kgb6sSxMkL
	JOIpv46RucucDkOyqkehwakysuTGOdI5t8mQNuEtw2+d7uxQoi6hMhfzOHLrH/uP+aLNcC
	D2A36/WJS6nOXWhkDqboSEs7lc0lLlhx+LpOb+uEj87uKf9sC0BzAjre3RPSgDXYbNJwPN
	nY3At957vCL/z/opOMDlCakTJtKZnbGndAYZ5ACzBSRYaJaIP6hTEAWGd5Z93A==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1774389697;
	b=ReJ/Ot6T3aJeAjEtXA9ar7fBDdmrZZUsuxblA4L7BwRCrsMyq2l6xOhmH4SOFpX5CekMB1
	QyjM2I6qlhoaWJwqIGfOHmvxcC+srYOG9I2qh+AmTiudluL/K8iUpajfVq/yZXb7d/vFN7
	/D9pkCQoayVMLXVJXfzikJdWld1ddErxTTzTX0YhmNYkRzb21Esi1vlxCHFlaUEDN8rdad
	IqsxBCx6xDt/hBWnffyGtkTLgsQdR9IMUlvF/IKBQttkDEqQ+bcH0PJLmqevW7w/ZDdw2k
	VaX+O/fI3XN4bKsoZkeWsFOjDsTaCKpNxS+rfx+HOXhlhksC1shyOsLKXSMVUA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1774389697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=o8lTw2ItO5L/qFbtcXcpqFdd/Z8bInRtvMGoRVJsu7E=;
	b=aGDOEbZf4rvkp0LsxQ3MhQwfIxERDPN/LCUYFhlpcK1C92qYyOt/zJdjEn7vQsN0sWQNFJ
	SIBkM/0+qqooXlM+YJnXpdhbjNUBbsoCNwUZdz7k8ER9DY0peBBd6x3wjlv5AhuBqrHMVO
	oWgO1tpiPWPIhPvjMjI+ijiwtqr4rvy8HfQk4JQsD1T/ZPlYNsXqk2jHOwtcuass4ZHu0x
	AkwYfHQadBrEfzTryPsk9rG2IU/afY4l9/gyfo3DNRuS2Zrw5LAZYq6vAyQvhDiYofHyYt
	02IRkEI2x8q0Gh10W1LA0ApISMbV1UMs3wTVMh4Ise50TlVKgr3TSoByLiWlJw==
Message-ID: <ba772bc3777d19c5db441c3bacaea2b78112cdda.camel@iki.fi>
Subject: Re: [RFC PATCH 2/2] Bluetooth: produce HW TX timestamps for ISO
 from LE Read ISO TX Sync
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Date: Wed, 25 Mar 2026 00:01:35 +0200
In-Reply-To: <a44bc1d9fc69341e59df05f4988844f64a2bcdef.camel@iki.fi>
References: <cover.1773245666.git.pav@iki.fi>
		 <1a4411e9ac1d6b5daa53aac78ca495c2db1b18a4.1773245666.git.pav@iki.fi>
		 <CABBYNZJ8wEaZi3cGB3Dogo5xtHV8brY76J7tRdNpLozaVn36LA@mail.gmail.com>
	 <a44bc1d9fc69341e59df05f4988844f64a2bcdef.camel@iki.fi>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

ke, 2026-03-11 kello 23:19 +0200, Pauli Virtanen kirjoitti:
> Hi Luiz,
[clip]
> > Interesting analysis. I thought the sequence number for NOCP must
> > match the sequence number set by the host when sending the packet,
> > and
> > its sole purpose was to be able to fetch the hardware time. Did you
> > observe something different? If the sequence number had to
> > synchronize
> > with a clock, the host would need to generate empty packets even when
> > there is nothing to transmit. This would consume power and memory
> > solely to keep the sequence number in sync with the clock. I don't
> > actually understand why NOCP was even used with ISO if the intention
> > was to use sequence numbers like above, at very least NOCP should
> > have
> > been updated to carry the hardware clock and other timing information
> > directly rather than using another command that consumes even more
> > system power and memory.
>=20
> There's no relationship to NOCP specified in Core Spec, it's pretty
> vague. However, I don't see any other way for host to get clock sync
> for TX than via NOCP (at least for <1 packet accuracy).
>=20
> It would indeed make most sense that sequence number is what the host
> sent in the ISO packet, but it is not specified. Core Specification
> v6.2 Vol 6 Part G Sec 2 also says:
>=20
> """
> SDUs sent to the upper layer by the ISOAL shall be given a sequence
> number which is initialized to 0 when the CIS or BIS is created. SDUs
> received by the ISOAL from the upper layer shall be given a sequence
> number which is initialized to 0 when the CIS or BIS is created. The
> upper layer may synchronize its sequence number with the sequence
> number in the ISOAL once the Datapath is configured and the link is
> established.
> """
>=20
> so one gets the impression controller shall assign new sequence numbers
> and use those, and host shall "synchronize" to it in some unspecified
> way.
>=20
> I saw some related discussions by the Zephyr people, I think the
> outcome was along the lines that the spec is so vague that these
> features are unusable.
>=20
> Some clarifications would be useful here, as I don't get what was the
> way the spec intends that these are used.
>=20
> ***
>=20
> IIRC, in the controllers I tested (Intel AX210, Realtek 8761CU) the
> returned timestamp and sequence number are always zero, so they haven't
> actually implemented the command. I'd have to check what Mediatek
> MT7925 does, it was at least setting RX timestamps properly.
>=20
> In Zephyr IIRC controller-assigned sequence number is used, but I'd
> have to double check this.

Retest:

MT7925 firmware produces LE Read ISO TX Sync responses with sequence
numbers from host ISO packets, but timestamp is always 0.

RTL8176CU firmware also produces responses with sequence numbers from
host ISO packets, but timestamp is always 0.

Intel AX210 produces responses with both sequence number and timestamp
0.

Zephyr produces responses with controller's own sequence numbering,
host ISO packet seqnum is only used for determining skipped packets.
Provides timestamps.


MT/RTL/Intel seem to have same interpretation although none of them
actually implements the command.


> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Userspace application t=
hat handle these timestamps must
> > > then be
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * prepared that the ISO t=
imestamp is reported on the wrong
> > > packet
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * depending on controller=
. Actual packet TX must rely on
> > > backpressure
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * (monitoring packet comp=
letion via COMPLETION tstamp),
> > > and the
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * timestamps are useful o=
nly for aligning the playback of
> > > multiple ISO
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * streams.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(&ssh, 0, sizeof(ssh));
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* SDU Reference =3D BIG/CIG Re=
ference - Time_Offset */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ssh.hwtstamp =3D us_to_ktime(__=
le32_to_cpu(rp->timestamp) -
> > > offset);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* The value may be 0, but skb_=
tstamp_tx() does not allow
> > > reporting zero
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * HW timestamp. Offset by=
 1 ns as a workaround.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ssh.hwtstamp +=3D 1;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skb_tstamp_tx(conn->tx_q.iso_la=
st_tx, &ssh);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree_skb(conn->tx_q.iso_last_t=
x);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conn->tx_q.iso_last_tx =3D NULL=
;
> > > +
> > > +unlock:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hci_dev_unlock(hdev);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return rp->status;
> > > +}
> > > +
> > > =C2=A0static u8 hci_cc_le_read_buffer_size_v2(struct hci_dev *hdev, v=
oid
> > > *data,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct sk_buff *skb)
> > > =C2=A0{
> > > @@ -4224,6 +4299,8 @@ static const struct hci_cc {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HCI_CC(HCI_OP_LE_READ_TRAN=
SMIT_POWER,
> > > hci_cc_le_read_transmit_power,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sizeof(struct hci_rp_le_read_transmit_power)),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HCI_CC_STATUS(HCI_OP_LE_SE=
T_PRIVACY_MODE,
> > > hci_cc_le_set_privacy_mode),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HCI_CC(HCI_OP_LE_READ_ISO_TX_SY=
NC,
> > > hci_cc_le_read_iso_tx_sync,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 sizeof(struct hci_rp_le_read_iso_tx_sync)),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HCI_CC(HCI_OP_LE_READ_BUFF=
ER_SIZE_V2,
> > > hci_cc_le_read_buffer_size_v2,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sizeof(struct hci_rp_le_read_buffer_size_v2)),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HCI_CC_VL(HCI_OP_LE_SET_CI=
G_PARAMS,
> > > hci_cc_le_set_cig_params,
> > > @@ -4509,7 +4586,7 @@ static void hci_num_comp_pkts_evt(struct
> > > hci_dev *hdev, void *data,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < count; ++i)
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hci_conn=
_tx_dequeue(conn);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hci_conn=
_tx_dequeue(conn, (i =3D=3D count -
> > > 1));
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 switch (conn->type) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 case ACL_LINK:
> > > --
> > > 2.53.0
> > >=20
> > >=20
> >=20

--=20
Pauli Virtanen

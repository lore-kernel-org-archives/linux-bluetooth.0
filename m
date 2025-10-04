Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F10B246BD7
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Oct 2025 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759593882; cv=pass; b=FfUct/M/8aCAovEIqZDYKDUv350+3ViTcNeAO3CAk2r21lGjqc632FiG/HyxOXZcNu9tUG13nQcmuTyxDSxT1h2bI9e0fgGqRO+8g9sCeNRUcMoVDYe0eS0WE4uA88J421YWoJ3eQ25KB5oI494d2ARVbdRGmv+d89DXfMOmTlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759593882; c=relaxed/simple;
	bh=SdEgdZmZ7j5+hT6kLQpgTYnLQBulzyfWrNDN86KBnOc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nrt9jpuDgkNFqbWyBKkXuFaPqkHoKIJ9xrzwqYq2vyadPHT1gaoQipteA/Nww8jlxcB8B2HvvJ4x+01IpkNuJOIAFpFZcttYhbLEPbcQYezo8jNgiubI1RtkZGmI/UoVZFaD/Xg5VTiKFTdD1Rf4t8xupNE9kH+pnIUUkN8oNn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=OLM7wH6I; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="OLM7wH6I"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4cf9Mh0Pz6z49PvY;
	Sat,  4 Oct 2025 19:04:31 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1759593872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+TGZ8t4L3kXzuulxE1BJazWJ4FbBCLcSA+eyUlpKaWU=;
	b=OLM7wH6IhgK9SgA207BICujiiabiuXSM/Z80sJqDtqP3ZNkqM3Rhu72fVxaIrlt8i0IIJV
	ZKxaOxYyQOuzk4bQxffC3NdE5T2OkS0CEKwuS5+btUAewT5GjSA8wgZuv4Bg0cllMTM8ao
	bnSlGY9g5vF35sR6aXKLadQ/JwIrr1Z39Jo2iErpB46eaponjb4BbgTmHgV5psSUrwSfEE
	9YOXKTq3v0daCBJ3efgvIPrGj+OkksmFf3IFpL4Nej5iLHbPYHyCR2h9PsxOTMjBoxUvsx
	Nak04ja8eybnW/ombyO6C6bzBhp5U1/lA1stH1ibdXxYtSWG/9Dum0KxoM7eVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1759593872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+TGZ8t4L3kXzuulxE1BJazWJ4FbBCLcSA+eyUlpKaWU=;
	b=W02zWtbW79qJSfyWJOQmrGvI8t4MPQRyOmKCffbhK3gin4xw3ivFquHv0rD5dDRur8Vhvc
	RUCWPE/A8+t7F9belXbarutRcvijVp+/OIkGr5q0/HsSC1QkOrKOnw43t6pmpbr7mqo+q9
	jQtocRk1mbuN3GS55o5n4qNwSnqtqcfaJsV6FLMrkvctY+dkgGbAwdSOV8Tem9uFSL9YVY
	Xi0gAKWJE5+EQvwUBEX5FgftpuWkORGyCvm7GYi8H3rlQxq2MDlIGMWO1bYmEdfbSk7JfM
	PpnaGgJWlidjhlu5/VCqQkMJWcDYdnxBd0dhbGAVStHwz3sP4Oq81CjKq6/Bqg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1759593872; a=rsa-sha256;
	cv=none;
	b=kBSWDT3aalFCv+y6zHG5q27i4v5qhmADnGE01vq+0y3usWGlldYTGnuKwUxzqLzp+G6Sk6
	b436tgy7xpnKE754VzkurhUT9k99Or+97qnvPVY/oQ3C3yeuFxm6c5mTBJwAeQ/zWGcZIT
	LC4HVqTHOSMxXR29+zOi/r1vIDT3kruaMi7ISDZ/iS1eMJSHqiBb2YTmKSuPZemcSLXbYJ
	q1X12Jkko9djVwhhMwiaxqNEanEvejt/epai2PBDNaTmxu8O4QILvYkfTqrmCvbF9dYViM
	v4Ume8iFaECeyY0cxnrh/rGw1/LFj/uJCma0UgXJonX14MDWAAiiiuNkmNYgqg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pauli.virtanen@iki.fi
Message-ID: <851c70ee159d777610c906ca882fcab2f5efd80e.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: MGMT: fix crash in set_mesh_sync and
 set_mesh_complete
From: Pauli Virtanen <pauli.virtanen@iki.fi>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 04 Oct 2025 19:04:30 +0300
In-Reply-To: <eea69851-226e-4e39-aadd-42453fa1bf27@molgen.mpg.de>
References: 
	<f206fc905f5c747b309d6063acd0128189661576.1759517776.git.pav@iki.fi>
	 <eea69851-226e-4e39-aadd-42453fa1bf27@molgen.mpg.de>
Autocrypt: addr=pauli.virtanen@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

la, 2025-10-04 kello 17:46 +0200, Paul Menzel kirjoitti:
> Dear Pauli,
>=20
>=20
> Thank you for your patch.
>=20
>=20
> Am 03.10.25 um 21:07 schrieb Pauli Virtanen:
> > There is a BUG: KASAN: stack-out-of-bounds in set_mesh_sync due to
> > memcpy from badly declared on-stack flexible array.
> >=20
> > Another crash is in set_mesh_complete() due to double list_del via
> > mgmt_pending_valid + mgmt_pending_remove.
> >=20
> > Use DEFINE_FLEX to declare the flexible array right, and don't memcpy
> > outside bounds.
> >=20
> > As mgmt_pending_valid removes the cmd from list, use mgmt_pending_free,
> > and also report status on error.
> >=20
> > Fixes: 302a1f674c00d ("Bluetooth: MGMT: Fix possible UAFs")
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > ---
> >   include/net/bluetooth/mgmt.h |  2 +-
> >   net/bluetooth/mgmt.c         | 26 +++++++++++++++-----------
> >   2 files changed, 16 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.=
h
> > index 74edea06985b..bca0333f1e99 100644
> > --- a/include/net/bluetooth/mgmt.h
> > +++ b/include/net/bluetooth/mgmt.h
> > @@ -853,7 +853,7 @@ struct mgmt_cp_set_mesh {
> >   	__le16 window;
> >   	__le16 period;
> >   	__u8   num_ad_types;
> > -	__u8   ad_types[];
> > +	__u8   ad_types[] __counted_by(num_ad_types);
> >   } __packed;
> >   #define MGMT_SET_MESH_RECEIVER_SIZE	6
> >  =20
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index a3d16eece0d2..24e335e3a727 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -2175,19 +2175,24 @@ static void set_mesh_complete(struct hci_dev *h=
dev, void *data, int err)
> >   	sk =3D cmd->sk;
> >  =20
> >   	if (status) {
> > +		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER,
> > +				status);
> >   		mgmt_pending_foreach(MGMT_OP_SET_MESH_RECEIVER, hdev, true,
> >   				     cmd_status_rsp, &status);
> > -		return;
> > +		goto done;
> >   	}
> >  =20
> > -	mgmt_pending_remove(cmd);
> >   	mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER, 0, NULL, =
0);
> > +
> > +done:
> > +	mgmt_pending_free(cmd);
> >   }
> >  =20
> >   static int set_mesh_sync(struct hci_dev *hdev, void *data)
> >   {
> >   	struct mgmt_pending_cmd *cmd =3D data;
> > -	struct mgmt_cp_set_mesh cp;
> > +	DEFINE_FLEX(struct mgmt_cp_set_mesh, cp, ad_types, num_ad_types,
> > +		    sizeof(hdev->mesh_ad_types));
> >   	size_t len;
> >  =20
> >   	mutex_lock(&hdev->mgmt_pending_lock);
> > @@ -2197,27 +2202,26 @@ static int set_mesh_sync(struct hci_dev *hdev, =
void *data)
> >   		return -ECANCELED;
> >   	}
> >  =20
> > -	memcpy(&cp, cmd->param, sizeof(cp));
> > +	len =3D cmd->param_len;
> > +	memcpy(cp, cmd->param, min(__struct_size(cp), len));
> >  =20
> >   	mutex_unlock(&hdev->mgmt_pending_lock);
> >  =20
> > -	len =3D cmd->param_len;
> > -
> >   	memset(hdev->mesh_ad_types, 0, sizeof(hdev->mesh_ad_types));
> >  =20
> > -	if (cp.enable)
> > +	if (cp->enable)
> >   		hci_dev_set_flag(hdev, HCI_MESH);
> >   	else
> >   		hci_dev_clear_flag(hdev, HCI_MESH);
> >  =20
> > -	hdev->le_scan_interval =3D __le16_to_cpu(cp.period);
> > -	hdev->le_scan_window =3D __le16_to_cpu(cp.window);
> > +	hdev->le_scan_interval =3D __le16_to_cpu(cp->period);
> > +	hdev->le_scan_window =3D __le16_to_cpu(cp->window);
> >  =20
> > -	len -=3D sizeof(cp);
> > +	len -=3D sizeof(struct mgmt_cp_set_mesh);
> >  =20
> >   	/* If filters don't fit, forward all adv pkts */
> >   	if (len <=3D sizeof(hdev->mesh_ad_types))
> > -		memcpy(hdev->mesh_ad_types, cp.ad_types, len);
> > +		memcpy(hdev->mesh_ad_types, cp->ad_types, len);
> >  =20
> >   	hci_update_passive_scan_sync(hdev);
> >   	return 0;
>=20
> Would it be possible to make this two commits? Either way:
>=20
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Both issues were introduced in 302a1f674c00d, which is why also the fix
here is a single patch.

>=20
>=20
> Kind regards,
>=20
> Paul

--=20
Pauli Virtanen

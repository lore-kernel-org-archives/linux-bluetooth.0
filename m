Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FCC1DDC3B
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 20:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740083216; cv=pass; b=qsxILFYFN7BEAkyNDi8lXdv2FP4ewbMDyqxz3oPbTla/xtlW3Qo/jm0paSjlc1qDTk6YFVv+UoJydWP/J7GWI+uLTQe0634kmrQpNppwZExH9CEuwn1NzuRHJMPram8gcBwxZ0yuWMEBa4D8a40n0Co2/uWq7Hl3OH7+mtLvnRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740083216; c=relaxed/simple;
	bh=hcJyJL7Db0cdZa/ZQyMzNZRevxhecNZfeN9X4mXd80s=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LNdsRLpdMX6Ufk3dQHNkyFjFwmAZtLfKogDNcpugzFRRjB9t8CwETPcPdd8pdnpApeKaEGiNn8fmx2feumFz4x0M4rUqMoPizLdS0D23RKa0MuuayJ4AV8A3PnSr2vxN6b72GUNkg1L9hrN2ppKFmKDsJ7BGhHjirrJMsyZr2l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=C1HW/w1y; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="C1HW/w1y"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4YzPtf5RJ8z49Q0F;
	Thu, 20 Feb 2025 22:26:50 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1740083211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=10NWBhDQHPVK3FKC4cqNXbNDeeXcPADwiUipcsc80co=;
	b=C1HW/w1yEzNW3X83fJE6JvyZ0CtSy3Yzsm7PB8UzXmVL9619sE2Onelk8Dm85MyVbSRIWR
	VRogpyCUgQjF+xMzwQBmPnuC0yo3SMrcmt1FieQ3pbl/51Vd892BxbHPaM5dt9rMPxS0qH
	x7I0T2wE+OqS+SZFWtP3BL/WM9vtraemop7TKyqo2yc7mh7YcanZ9ctuSrWXgREJAPmnUp
	DqSIEEN0LIOsjGfOv35G5msmE88Ygo3q+kLu5ZKEg8JKaLzt6f8BEqZXZloCFuT1qNiC9x
	bRo/4DWMner4CAKbMeT3/OnQje7UR4TVjSx+OmX1MuoE4H0ydSl8rhc9AN+yVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1740083211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=10NWBhDQHPVK3FKC4cqNXbNDeeXcPADwiUipcsc80co=;
	b=skCtJGPCblFxvUpwvaapZXfHYZNEoETlWP8JsSBcqWtnMvI7VH9sF066YyIpPro+i4VExj
	tYuO/OROyPMTFky7QU6farWMFhSiWRBcC8DpVd6kSEvk5MNjpnhCZCpWCL00oSUxHd5kkN
	x48R53FSAh/xu2jrlRUl4dBNppeAp9nO9sv0hLUDcRCAT2Dfh415HW4Kv4v/0KjD4ZpBCF
	YukhTLDvwQpynfSbr315ic8mVOqAblLhpGb1Dv1gQOkeSYYkEgQ6jgweTVKSHS+jwuPthG
	ycYV6RNsiw8rGh49XBL/2XhdAguFXS5ab7TAaJxJTZCNVw0d79vo7BA52o6PzQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1740083211; a=rsa-sha256;
	cv=none;
	b=Qtsj/HI9lPZGb5bVWB3OGaR9H6CBvptreOSwrnplE/3B0E800XvadiFvLT5xIQ9ZcM1AVy
	brU2VolWXiQvcVeynxGlg/DlZdm56x+i/aDtY7sdGc+/d3ARD0mCD9N7lILRP1S+EoJ7Kj
	xv4DjqEOxS+ij5zXnLb6Yzs66VNi4GIwVmdUqrFcZ/nH0icr4cfVTnJ8E+IGz7tewMuT8j
	G2aGi/MppOHU8F4tDCX3tIVPRoexs0XMk9bSx2p2pnbnlNBV/GjVZirXwHv42nXnz2817l
	1Cr7faj2ml+wjIF7ZHM9iXo1XqeQ+5kfL3wk1UUm7JxHh/16kVQBrR9pnjDziA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <7b563cafc5b7d3ad23e845f409cf9b992e37ac79.camel@iki.fi>
Subject: Re: [PATCH v1] Bluetooth: hci_core: Enable buffer flow control for
 SCO/eSCO
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Thu, 20 Feb 2025 22:26:49 +0200
In-Reply-To: <20250218214344.1519862-1-luiz.dentz@gmail.com>
References: <20250218214344.1519862-1-luiz.dentz@gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz,

ti, 2025-02-18 kello 16:43 -0500, Luiz Augusto von Dentz kirjoitti:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> This enables buffer flow controler for SCO/eSCO which apparently for
> some reason has not been in use up until now which caused sco_cnt to
> never be updated, but recently this has caused the following problem:

Should this first check or explicitly enable
Synchronous_Flow_Control_Enable setting, via
HCI_Read/Write_Synchronous_Flow_Control_Enable?

IIRC SCO packets by default don't generate Number of Completed Packets,
so is there something that is incrementing sco_cnt?

> < HCI Command: Read Buffer Size (0x04|0x0005) plen 0
> > HCI Event: Command Complete (0x0e) plen 11
>       Read Buffer Size (0x04|0x0005) ncmd 1
>         Status: Success (0x00)
>         ACL MTU: 1021 ACL max packet: 5
>         SCO MTU: 240  SCO max packet: 8
> ...
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> < SCO Data TX: Handle 257 flags 0x00 dlen 120
> > HCI Event: Hardware Error (0x10) plen 1
>         Code: 0x0a
>=20
> Fixes: 7fedd3bb6b77 ("Bluetooth: Prioritize SCO traffic")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/hci_core.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index e7ec12437c8b..5c88d3816c6a 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3564,6 +3564,7 @@ static void hci_sched_sco(struct hci_dev *hdev)
>  			BT_DBG("skb %p len %d", skb, skb->len);
>  			hci_send_frame(hdev, skb);
> =20
> +			hdev->sco_cnt--;
>  			conn->sent++;
>  			if (conn->sent =3D=3D ~0)
>  				conn->sent =3D 0;
> @@ -3588,6 +3589,7 @@ static void hci_sched_esco(struct hci_dev *hdev)
>  			BT_DBG("skb %p len %d", skb, skb->len);
>  			hci_send_frame(hdev, skb);
> =20
> +			hdev->sco_cnt--;
>  			conn->sent++;
>  			if (conn->sent =3D=3D ~0)
>  				conn->sent =3D 0;

--=20
Pauli Virtanen

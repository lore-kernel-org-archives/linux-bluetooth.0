Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C6C2264B8
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185457; cv=pass; b=FctGeJuhjMUfs4+tyL/L/bHJEEg6f5ow7dXJldR3cuVxkcQa8yPmrn7PbQ4tSHPKiC5PEDIrcHhwxBVGoExh7KuTijXPNLKmQLe/cqxGcd3881aXu96JfLYA3xXSbxwki8N12N59ofJrNAMJawN/s7nOJ2+u0Pw+QOnPpzHhS7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185457; c=relaxed/simple;
	bh=jP33aDtEMoVO6IHDmyfnfFfe1i4Pik6Kkjw9X5IIb9A=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iCWET5h7hitCbvtfNr727LQe6Wvk8G45j8x2ixs9mUqtvvMLKG7t6DjtS7EphMSRJx51qxuxBnOdNhiNWH75qYJMOv+7TobKb445e80H89sjGbtwdacB7XOMIxoV+r3fdbWNs3ntTogmSVSszyr4pIqPKRoil5Xw2YAKdqW3zzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=NXJHJ8oP; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="NXJHJ8oP"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4c2q2K6Mg6z49Q5Y;
	Thu, 14 Aug 2025 18:30:49 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1755185449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=w/2iybGzUfazh0ZwUBHrA8pyRKwsBE28V8cRjGlVJFc=;
	b=NXJHJ8oPKB6ZYu/X1GT4UTDV/tUiK9K5EJWeSzHYq2zWbnKNCy2u/1sPFPHRGUFVqvyIEq
	GJWk2msY4ua94tdxR7hjclgXN11JB2gucZguXEvbsuXWSzU50kN/8xp16zvz4ZrcQBFWlR
	7tMLz1FLhQdOlHglxwYmckDF22y2NgU7GMwBR7Dge+zas2Ak0UGVic8HMpmhOIuqTMhXg+
	9uDomMyWyWc9x7BV3Z0ICS84imdeF2SBrnGHGrL/43I73Mtx8l0tme2dug4xpz1SmQ7hsD
	ldifddXFmMESNyG/lLeFnLIlSeHrzNekml2U4a70gApIF1IXXxZLIBho0w+0CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1755185449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=w/2iybGzUfazh0ZwUBHrA8pyRKwsBE28V8cRjGlVJFc=;
	b=b5aebNnl3//88I0K5ws6AQJbsjmp3qx9/Pt9hJ+l6/pndkqhWaAAevgwtac7GGA6M9qMKJ
	5H9urP9itRc2cWqaEXsQ/wFq6AAvZ2MpXbXP2C5fTIA1MtYJnbf8tGIEy14BSuxarImi2L
	b2DzVcNSWL5oJIhQryQkfJWwBCaH1guRznOsnAXlFIVE1EgeWplwapqD39lMJUmT3MiyED
	CusFUJzU/KFSgQyIRFicagv5j2e5UobBPBe9Kfl8b7l21bXRCdTvhEiXMwOhPFpDtCnVb4
	Xbk6kIywUzKGN8jgfKGguBFlZqj2Q7OeI4Ow7yhkfJk0L9Oc14RtXjz3eu+CIQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1755185449; a=rsa-sha256;
	cv=none;
	b=G2bzMpHGbxAyK9SJPbK5agg95z4cMKGBoQiiRTIPb6vUyB9HteA1fZ5cd7tZi0bFpXTGOA
	jUgXZ7tqXjE+fjG6+7h5/2G1rpnHmxqWCyKrRmL/TWJD4AqEVdRQkwx0b8lIQxNYsimCrQ
	MefkNtAp5iTyibTSSO9GrBQqB+cyoeYSeQPO0Ck1VFt4Qi/OQgew0iWJwDY/Sf6sqINo1o
	z0YlJC2wS8JUZU3F9pxh+CwZlWXmZ1foMbJaU4ph+iytaB4EOpO4TpZBNltnvH9QcuS8x1
	KwVrykii/dbKDLE5RTeYe2amZTgYQo92oShS8H9DCowu3QBLFq9pUnQ5VYrqyg==
Message-ID: <6311cc4c8ab9a9c5b14d3c4aa1f9b213fd064d6d.camel@iki.fi>
Subject: Re: [PATCH v3 3/5] Bluetooth: hci_conn: Make unacked packet
 handling more robust
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Thu, 14 Aug 2025 18:30:49 +0300
In-Reply-To: <20250813211511.90866-3-luiz.dentz@gmail.com>
References: <20250813211511.90866-1-luiz.dentz@gmail.com>
	 <20250813211511.90866-3-luiz.dentz@gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
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

ke, 2025-08-13 kello 17:15 -0400, Luiz Augusto von Dentz kirjoitti:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> This attempts to make unacked packet handling more robust by detecting
> if there are no connections left then restore all buffers of the
> respective pool.
>=20
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/hci_conn.c | 34 ++++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
>=20
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 9d2324eb1211..d2f0c3c0f0ae 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1151,22 +1151,44 @@ void hci_conn_del(struct hci_conn *conn)
>  	disable_delayed_work_sync(&conn->auto_accept_work);
>  	disable_delayed_work_sync(&conn->idle_work);
> =20
> -	/* Handle unnacked frames */
> +	/* Handle unnacked frames:
> +	 *
> +	 * - In case there are no connection restore all buffers to the pool
> +	 * - Otherwise restore just the buffers considered in transit for the
> +	 *   hci_conn
> +	 */
>  	switch (conn->type) {
>  	case ACL_LINK:
> -		hdev->acl_cnt +=3D conn->sent;
> +		if (!hci_conn_num(hdev, ACL_LINK))
> +			hdev->acl_cnt =3D hdev->acl_pkts;
> +		else
> +			hdev->acl_cnt +=3D conn->sent;
>  		break;
>  	case LE_LINK:
>  		cancel_delayed_work(&conn->le_conn_timeout);
> =20
> -		if (hdev->le_pkts)
> -			hdev->le_cnt +=3D conn->sent;
> -		else
> -			hdev->acl_cnt +=3D conn->sent;
> +		if (hdev->le_pkts) {
> +			if (!hci_conn_num(hdev, LE_LINK))
> +				hdev->le_cnt =3D hdev->le_pkts;
> +			else
> +				hdev->le_cnt +=3D conn->sent;
> +		} else {
> +			if (!hci_conn_num(hdev, LE_LINK) &&
> +			    !hci_conn_num(hdev, ACL_LINK))
> +				hdev->acl_cnt =3D hdev->acl_pkts;
> +			else
> +				hdev->acl_cnt +=3D conn->sent;
> +		}
>  		break;
>  	case CIS_LINK:
>  	case BIS_LINK:
>  	case PA_LINK:
> +		if (!hci_conn_num(hdev, CIS_LINK) &&
> +		    !hci_conn_num(hdev, BIS_LINK) &&
> +		    !hci_conn_num(hdev, PA_LINK))
> +			hdev->iso_cnt =3D hdev->iso_pkts;
> +		else
> +			hdev->iso_cnt +=3D conn->sent;
>  		hdev->iso_cnt +=3D conn->sent;

The last hdev->iso_cnt +=3D conn->sent; probably should be removed.

>  		break;
>  	}

--=20
Pauli Virtanen

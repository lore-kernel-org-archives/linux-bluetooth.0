Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C044D9F77;
	Mon, 21 Sep 2026 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009823; cv=pass; b=GbZ85/qC2tA0N6l0oCg74yD8fpeSACBg2Oc0FASRLJt4PZsHjQbCLLir1MamgshPC6e2xBJsPNbFVW/tG5nxdzugdxLV1kEYwvdqMJZN6WjiFPBb0ZsLbUBLz/SoetTrLzzijwFtkwRd6CROzMMzqD8ghUGbet2HHyrrtBabof4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009823; c=relaxed/simple;
	bh=a9JHPLzL8uadT1BYJ5SmI2W45iYhN70ewHYi/XhrxzE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IyNUySb/MLq4bPJx0ZYyyhR3KnO0LECosqwe26/gcckqPQKy2t1wD8wOizZ2uC9Mxen68jcv9/bohqPjb47O3ApDh3Xo9wZrz2gca5w5aif14Dq7hhZqM5o3Wuz9nbNUA6Fl2X7ntv4kWVs3idvyqGW06rCnpFS5tm3dZU64LKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=PsigL38f; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="PsigL38f"
Received: from [192.168.1.195] (unknown [IPv6:2a03:1b20:4:f011::d901])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hpTsW2G1fz49Q7P;
	Mon, 21 Sep 2026 19:56:47 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1790009809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2Uc9fDI+27C4yl9EmZRkeFOxnfPE6pVGIux3WmNo0LQ=;
	b=PsigL38fzfR9kmGyc+40q+3NmZmSAvGLgFzYeVhhrH2B44H+41yDGzQVhTaTJqLPBlmWOk
	vHS7ddTuJtNoGMVrFiH1O9EKfMohH/Va822y+LxuE/X+95R1rj8nG9rOtnB908qNNJDs3Y
	qXxn26HIwHN6CPsveAl9C/JQOPQCzGjjH1XRU/0XgxRwmNtf0psD/tVIHIml9E/a7JgTf8
	9LSv1La5mV2mRso1QN8E9ruMihG/V8ahwg9x3eMp7avAgYSfUgOZs8hRm+SpS7kUTVw8OZ
	dJSE+d8LotOsiV5hI3Jb+itUvN1CoQ0f4X7lUm9nCA4i5ei/+garKV7Rtre55Q==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1790009809;
	b=rr2CT7wlyMgxn6GXdm5J53dfhsnaezbr0TgBtH1N8i+ZfHd915sETWVW3UdT1LhxinxZTo
	NblHBIDL7ppUK1tB+mlMvU2Jlfx+EABhnWFignEwjbYXlBBhdz0wJ8/Rgs6tD+pM32hcNR
	wJVYHx0P46W72+ffdWFncE1quku3dNvdY7dLpMcfh3Hk/RQE9xV2rp8MjYLyZW1OEsLOso
	kj8tHSNyH8bf9c/mUsVnHYZAW8hdyl0icsFAB+ZJbnnytuuy2Mi0DONOt9k4PyU4WBdYq6
	JB4F0W01o/CFUHzuPppN6UEqgv/Tgh0iGbDbrKtFDnAEi3eeSwYWWBGIbxYYmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1790009809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2Uc9fDI+27C4yl9EmZRkeFOxnfPE6pVGIux3WmNo0LQ=;
	b=u8kbxClr+WR0RVTqu5FQZiZHlHyTiQHNtNk29TjiaTrd/9RmhvkY5Czz1QmFNn5g+d2NWM
	i/5eb4ot4b/B1knwh3dIVzhZoLv1PMElVcSJCFm9F2G9LIOQmKpUDNYLMBf4YlLZ7+Zhoa
	yl5Rt5+zitHqon4lyajqR/odcp1ZqpzF1yJoTc/WBwalfPxuZBIeCoGPcj+gA1wU2IAtVY
	jX/3S65ZfOHhSIeWk5dgBYU2ODh55anT8XIhtty3pWOUg7g1uqbmHPjbfr1MthuPzQMR0G
	IZaW000CoAt/ukNz1pjX3j11kn32/0u//oJWMablBIP4tX1b60JxodJq14EQGw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <a0d9ba78f7d3598494f2a6ed31afd789972a1d72.camel@iki.fi>
Subject: Re: [PATCH 1/5] Bluetooth: L2CAP: ignore close requests for deleted
 channels
From: Pauli Virtanen <pav@iki.fi>
To: Cen Zhang <zzzccc427@gmail.com>, Tejun Heo <tj@kernel.org>, Lai
 Jiangshan	 <jiangshanlai@gmail.com>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marco Elver
 <elver@google.com>, Jukka Rissanen	 <jukka.rissanen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	baijiaju1990@gmail.com, jjzuming@gmail.com
Date: Mon, 21 Sep 2026 19:56:44 +0300
In-Reply-To: <pm-series-6lowpan-lifecycle-82fab5876048c8c9503c-1@gmail.com>
References: <pm-series-6lowpan-lifecycle-82fab5876048c8c9503c-0@gmail.com>
	 <pm-series-6lowpan-lifecycle-82fab5876048c8c9503c-1@gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ma, 2026-09-21 kello 23:38 +0800, Cen Zhang kirjoitti:
> l2cap_chan_del() keeps chan->conn alive until channel destruction and
> marks removal with FLAG_DEL, but does not necessarily change the state.
> A caller retaining a temporary reference can therefore enter
> l2cap_chan_close_unlocked() after deletion and follow a stale connected
> state, rearming the channel timer and sending another disconnection
> request for a channel no longer on the connection list.
>=20
> Check FLAG_DEL after taking the channel and connection locks so that
> concurrent deletion is serialized with the decision to close. Return
> without further timer or signaling work when the channel is deleted.
>=20
> Fixes: b66774b48dd9 ("Bluetooth: L2CAP: Fix UAF in channel timeout by hol=
ding conn ref")
> Assisted-by: LLM
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> ---
>  net/bluetooth/l2cap_core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 49a998804908..65e957fdc7ae 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -939,8 +939,10 @@ void l2cap_chan_close_unlocked(struct l2cap_chan *ch=
an, int reason)
> =20
>  	have_conn =3D l2cap_chan_lock_conn(chan);
> =20
> -	/* Context analysis: consider chan->conn->lock held also if conn NULL *=
/
> -	context_unsafe(__l2cap_chan_close(chan, reason));
> +	if (!test_bit(FLAG_DEL, &chan->flags)) {
> +		/* Consider chan->conn->lock held also if conn NULL */
> +		context_unsafe(__l2cap_chan_close(chan, reason));

This probably would better be further down in __l2cap_chan_close()
together with the other state check.

> +	}
> =20
>  	l2cap_chan_unlock_conn(chan, have_conn);
>  }
>=20
> base-commit: 019debf20bfd648b40ba10377ee0168db5eb241e

--=20
Pauli Virtanen

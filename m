Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4D2253B59
	for <linux-bluetooth@vger.kernel.org>; Sun, 28 Sep 2025 21:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759096566; cv=pass; b=dewi1YoDMjiUFczNf5RHTWf3QpQdrn1YR+khCfgd0nAAmOK9JzoHnpNhwlN7TYPbPjAnab2wSLGiv3y1CxC0c4i0vB1PfbBu9LkZmJUiblrCadV4PlULOP68TDsAag/26fmZiVI0wp7D6KJDIYX4IAy5FfR2+K0yq9QHAN+i1tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759096566; c=relaxed/simple;
	bh=T1C0KkYm26o0DYub9pnWdVcq0l+F80TBwZJA+VW0NEU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ic290tzhy6TKDG5pI/lC4NaZAr76Vquj9vGus2V432OuP7XQ9BSRt0EPTciXFIlLnFVXiYVbHFS9cncmy76WXJEEjCJgcSBrsMFMFjDIgXec8Z5OL4ISr0ScjFM9ADEELOKmx/+qdmE2l/sIdF+M8ukKPrHwvYz5g/xVCRQXvp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=MVVXZdHu; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="MVVXZdHu"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4cZdRs2lztz49Q5h;
	Mon, 29 Sep 2025 00:55:53 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1759096553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=deKSGn5DWD6ooF+6kcttIggIkMC0jGVOCF6/G394z1k=;
	b=MVVXZdHukyZtMWJFwBfdudUbRWFcqmirOc3wiFJxbTbCgJSE++x0BY90Lz650yLjxX3DZl
	r1a/XdzL+nynAdXdtvbMlOWBDa8IAA2vQRGp8aDXL4dgliod6ba7gzWApXLRNOJUMSMoBX
	/cx7qAqt+CijnmpKQEDtPIY0dSMgrOqTFdvLgJe4MCrQjRmJ2f/lfEUYkjBif8qZ+pIDHa
	bwrwG+iSbJPL7YHD1hls1y4Uf9aqm0AHgSy5y6XKN+0Mw55slAcF0nHkQVQeA8SUQYF6nP
	NTA7JzgTG9Nji7wEZ/HWc/MijrLitOEcY3wCraOXaOqzVWevwfKUoKXxpCOMkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1759096553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=deKSGn5DWD6ooF+6kcttIggIkMC0jGVOCF6/G394z1k=;
	b=CCihEsWbSZF3A6N34m592eTcBl7ZVerFuRpmLwoLCD2Gxz0rQMDx4EOQUr4RVZ4hgwQnBW
	9UhRtKL8w+DeF+AOh5yzeSm1pQEeV2kZCdVIPYLnIkQ0GEiOgobOERSUimmtPK140uCxzd
	h/UXNE2lnqsdGpOdTXi1b7sM43ZajNMqwp9IRH7Drei4adEiB7niFAB1mSxoxjAS8CFr9s
	ITLmUUF+MJaE9QGTdUMiagSAsj2ZVesQCCxfGAXnA55V5QzCn5YzllE2y2S7IhIsHFANZU
	T4NTRhOx1iJcw9T/isrYyUYartp5fguLBkFeILpsLYj6E2IhTo1QIG3rVaD4+A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1759096553; a=rsa-sha256;
	cv=none;
	b=HEKH7QrzrOnNPgof//I1vNrs89S/vl7OZly6U5j4d+Q5I0Y1hXZ2Mm+RFrhK8FIcKC+kux
	swR1Fgs5BOSlh3zqG8Ldmq8a+7q5rWQ9HymDlciEuZ9dwq+Oe8BitpARyMWUh6szp/O6gk
	TjzOMJFDcZffu8qYda4BGp7Xqal4GeqnvGsDWiW/BQjiPwDH9mHp/Akd0JTjstQGKnBucn
	z9dBALp4qSp3tzzXH2RbTGHlQVbi2iEj39UMn4e0LazV10/LjDwHMeTpkR5O+JXTr2Cj01
	zuaHj79jD6IO8dU8H/o7SeiGMV/GR+OHeleMCWvqCJ2z99U00ykJKzM47ct1TA==
Message-ID: <8aaf09361ab3eed55be5d008a775a87f761a13e7.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: hci_sync: fix race in
 hci_cmd_sync_dequeue_once
From: Pauli Virtanen <pav@iki.fi>
To: Cen Zhang <zzzccc427@163.com>
Cc: linux-bluetooth@vger.kernel.org, Cen Zhang <zzzccc427@gmail.com>
Date: Mon, 29 Sep 2025 00:55:52 +0300
In-Reply-To: <20250928110740.137220-1-zzzccc427@163.com>
References: <20250928110740.137220-1-zzzccc427@163.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
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

su, 2025-09-28 kello 11:07 +0000, Cen Zhang kirjoitti:
> From: Cen Zhang <zzzccc427@gmail.com>
>=20
> hci_cmd_sync_dequeue_once() does lookup and then cancel
> the entry under two separate lock sections. Meanwhile,
> hci_cmd_sync_work() can also delete the same entry,
> leading to double list_del() and "UAF".
>=20
> Fix this by holding cmd_sync_work_lock across both
> lookup and cancel, so that the entry cannot be removed
> concurrently.
>=20
> Reported-by: Cen Zhang <zzzccc427@gmail.com>
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> ---
>  net/bluetooth/hci_sync.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index b6f888d83..f059b19fe 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -862,12 +862,13 @@ bool hci_cmd_sync_dequeue_once(struct hci_dev *hdev=
,
>  			       void *data, hci_cmd_sync_work_destroy_t destroy)
>  {
>  	struct hci_cmd_sync_work_entry *entry;
> -
> -	entry =3D hci_cmd_sync_lookup_entry(hdev, func, data, destroy);
> +	mutex_lock(&hdev->cmd_sync_work_lock);
> +	entry =3D _hci_cmd_sync_lookup_entry(hdev, func, data, destroy);
>  	if (!entry)

Need unlock also in this branch.

>  		return false;
> =20
> -	hci_cmd_sync_cancel_entry(hdev, entry);
> +	_hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
> +	mutex_unlock(&hdev->cmd_sync_work_lock);
> =20
>  	return true;
>  }

--=20
Pauli Virtanen

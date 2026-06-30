Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D547A340A6A;
	Tue, 30 Jun 2026 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782846648; cv=pass; b=L+pxFfLs8zx3mgEes6tsrquoKHKheo3F4PbdnHDNe4euEPo6JuIx2quPgWcBxammWxaG11Tx9POoXnajFR3QcXGy6BmfVOywXIt19Ch8fRR96R8twW8NmLe6GB4mIusx6M5kIQ+bctb3XdS4SPhgpOGqMziW1djsCf7Nu6Zs8d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782846648; c=relaxed/simple;
	bh=y8gjwL4/a7r6fz2NBmkQNw0OT2SQaXgTU1f2/kLWodI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qwOhKz0h6oQZUqb4lvAvyCF8UKbMVLUCqhviNT80qLd7IL4HVjxfADDTTy8sThichFdGUnr1MlHZpSHl+Dx+WEJ+iFrpw4I2uGWXRBP8nLwhDGnuAPk62Fka1tU3FkXWP6RMdhV/gLJahA1YOvlw3e5mecvr5859Wz+Bfe83ft4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=sVbSxewj; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="sVbSxewj"
Received: from [192.168.1.196] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4gqXdH2lv8z49Pxd;
	Tue, 30 Jun 2026 22:04:35 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1782846276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9nbJpUGpEw2+GCtoobGilrwfIs0Msy8sz0H9ItOrRc0=;
	b=sVbSxewjzxdu4QcO1AOPDqbYJ5sG9ZaoRD/C1QW+PjTM4AdsELTt6FQS/8H0S7zTcuT/87
	8US6m/jzpmrDL5ccYeC/PYU/JYCzBLYIMMjAFndvwu9MKkHwB+fiVnXsBTpDtmh0S5Wu5V
	4pmrI4WIZlGh6RouVfFp2mpNB6A07p2q+b7V4YiQwa7lTEemJFxiseCY2uNmsMM5eYxka9
	G66BCl4IZz9DHxpULQlt7Z9x0a4Zv3Fue2NF6jGxVnonbOIXTwQotEYJHfBSaGgW3GX2K7
	8V4PRRf1Ubutwd+GCXMAv15alneB5b67IfAWkPnI2XazNp9OQoSN2ZmaX+phQQ==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1782846276;
	b=gORSEL7bIlD0813SnxvGS15b9J/Ep01Cbabajy62379/vEu19coc/OQDpDIvluklHvPc9R
	eWLBw7zVTq3KO0nGrPh0Hmsa9hgD69h7nvkx5oemoQeXTK4YMoUo88Fq3qmXMx2aMiByUZ
	F9cBecbm0VhHA2EFkjg0nQc0TEYhNSAu91GBuluNtGUYoEfVscPc8R7cgHOFWOpzc5Q30m
	r7NZBQPs+fNksz+AXqiD58S7uJPT3Ai+urbKjwi4Um+/PwW4anPjsG1gLOVBZtnBtxif5N
	YvZVzhOm2J0qHKDZG+3RjAbGZL4CWDVeCwHP+/2bIr90yvjew8/yaaO50X4jbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1782846276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9nbJpUGpEw2+GCtoobGilrwfIs0Msy8sz0H9ItOrRc0=;
	b=wZCFhFSucDMip6fhNNdS8R2hRnpz+Unz5FCZgcFYbYsf82bWAAPHgbdvruj2ReSSKck/95
	Kgp+6lbTk8gHww9iW7OAgBOVvZlRXt8zU3mPt8FlmZWYlU0XUxV3wHq6ipYwujAuA/ywKN
	CTJ4tIJ1iG8nb6VVlWjQR2rtaoep7HfU9t/lyFZixEmOF6CCol0FxrGirsGJ5wfegnMVOy
	WgiqWD2Ad/j7tZEzt7kaoZqx4KRKqITpDFT92haUI7JfjQ1tOMJOzvK5TfWCdsb6ATlW7m
	nMiLXUyYgAjE4c7VfQApd8l9k05Egypjom++hSUactMQJ/1mN8LGooRXbxGS2A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <e69f21b1ea68ddba54f43430b7c50e2c13bfbac6.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: bpa10x: check response length in
 bpa10x_setup()
From: Pauli Virtanen <pav@iki.fi>
To: Weiming Shi <bestswngs@gmail.com>, Marcel Holtmann
 <marcel@holtmann.org>,  Luiz Augusto von Dentz	 <luiz.dentz@gmail.com>
Cc: Johan Hedberg <johan.hedberg@intel.com>,
 linux-bluetooth@vger.kernel.org, 	linux-kernel@vger.kernel.org, Xiang Mei
 <xmei5@asu.edu>
Date: Tue, 30 Jun 2026 22:04:34 +0300
In-Reply-To: <20260630062759.2769059-3-bestswngs@gmail.com>
References: <20260630062759.2769059-3-bestswngs@gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ma, 2026-06-29 kello 23:28 -0700, Weiming Shi kirjoitti:
> bpa10x_setup() sends the vendor command 0xfc0e and passes the response
> to bt_dev_info() and hci_set_fw_info() as a "%s" string starting at
> skb->data + 1, without checking the length:
>=20
> 	bt_dev_info(hdev, "%s", (char *)(skb->data + 1));
> 	hci_set_fw_info(hdev, "%s", skb->data + 1);
>=20
> A device that returns a one-byte response (status only) leaves
> skb->data + 1 past the end of the data, and the %s walk reads adjacent
> slab memory until it meets a NUL. The same happens when the payload is
> not NUL-terminated within skb->len. The out-of-bounds bytes end up in
> the kernel log and the firmware-info debugfs file.
>=20
> Bail out if the response is too short or not NUL-terminated.
>=20
> Fixes: ddd68ec8f484 ("Bluetooth: bpa10x: Read revision information in set=
up stage")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  drivers/bluetooth/bpa10x.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
> index 2ae38a321c4b..07c6ed6f18ac 100644
> --- a/drivers/bluetooth/bpa10x.c
> +++ b/drivers/bluetooth/bpa10x.c
> @@ -255,6 +255,12 @@ static int bpa10x_setup(struct hci_dev *hdev)
>  	if (IS_ERR(skb))
>  		return PTR_ERR(skb);
> =20
> +	/* Reject a short or non-terminated response before the %s reads. */
> +	if (skb->len < 2 || skb->data[skb->len - 1] !=3D '\0') {
> +		kfree_skb(skb);
> +		return -EILSEQ;
> +	}

Was this tested on real hardware?

With an out-of-bounds access fix like the above in btmtk some weeks
ago, it turned out HW actually was sending truncated data, and it was
found only later in production use that the driver was broken by the
fix.

> +
>  	bt_dev_info(hdev, "%s", (char *)(skb->data + 1));
> =20
>  	hci_set_fw_info(hdev, "%s", skb->data + 1);

--=20
Pauli Virtanen

Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CDA39281D
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781620721; cv=pass; b=qip7PRydD80xuDlaY3C8QX4vw6dO6C1Or+2UYZIjaSeHtIiZTPlFfsqUh6n1215lI3ANmBg9/zeI542KqUG7JQz7qhJAltN6s+9cAjqGrvHNg/J7DTD3ybRCkPbYILZY0nCcDH9rQDDLBu6+bOTxF8tLjcpfDKElhuQyl0Su3lQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781620721; c=relaxed/simple;
	bh=+ZBoVaUcZcM4gC9ZkRpgEzmMSXm7YXQPZN1mvo1prf8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aHHT1EwXaArd5HBtrzIAZ0ahlXTTHTh0qIGTHqrR5x777DI248OT52EJK2uDgiyV4ZUoBUndlvkC4kfzfBQddm5cX36Wb3fQActjfdnlva/bORVONmXG5rCVTUAFjL2CSsYKZPOulxz06eRhwVO/Nss14gaabTlkHDATSQbk+E8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=whl0/0zh; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="whl0/0zh"
Received: from [192.168.1.196] (unknown [IPv6:2a03:1b20:d:f011:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4gfqNp6Mj1z49Q3Z;
	Tue, 16 Jun 2026 17:38:34 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1781620716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eFhyPpcewz99R1eMaL1v0Y411PF2xXadTNs4TZuGD88=;
	b=whl0/0zhuouIH+3R0DEB2wR9J/BXnuKNSiqF43z6IaW2EYJl+NBdM9/lfpTIO+w44+pLPY
	0nvzycP3+SDsqvcKZIlZsBfIz372kF38FZULAePEEEtLUVFSUVAs/G4QiHrxI9dqF83ZX6
	vY2WpWy056qyoNP0VUTbFoSDt/HEmr8OBhvyDPK2XIddxXNEXBUZwxJ/rlNyuBY3pODDDs
	+cAqPWvhYGNK+96YzseIUOhEfN/bpqUTNYhnhr/EC/wyxw8xKNvXEPgWH2xyM3sz7PTIAS
	4o/Z4Sdp1rPcNZJfmTXPzfhr7jv6ggpeaWqocYE2/KCE6ttUHExIsBwfH5/MgQ==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1781620716;
	b=Yq3SLyWt9KkxEzCuejMnoyaWOAOfLukDrsyNcdDycSrG7DKKPEdpt8IiNerhExGNUPnsyw
	dsVDw7lMX921DFmQe27xqZApGYuveDV2ZUYfv4FTn7N2rVnFTpJ0wZUGaQpXRwPUiom1GQ
	ZTmA8XpKkPXhHa6lYDpYccSjEU8EFjWHMPMvKMXH3RtmnRWrl6M7VzKSpsIHIrQHTVJ/qE
	OnyCVSGGS/UtD7CnMqNgce4FYzveWmqK3u/UlEj2joSozqauEWtF8nrjzfNxF43/+tP3PL
	R3+nyj86ar7P22TzuSM30zWJcD2LA7tiO3Mj0dfm5rlKTvaM8Qv6MF31Sr5scA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1781620716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eFhyPpcewz99R1eMaL1v0Y411PF2xXadTNs4TZuGD88=;
	b=D8fsG/tfoOygj3QfFYnGzkEchm3XKc0CgXXeZtckznTIz5QwVk3Obc9Z729zwHNK5WebXi
	C2Dt5lbE8XyjIAyf6EhPqc8nYkgogfbR8/C4zUjlPn/aByjICkvMFdpCiM1OKLwJ/EZjnu
	9R3uoNQ6BbyuEGdN9P5+Pjx1va+80Gn4UpWikOxJYImaijA9atTO3ANmbUNt77xOAme4I0
	PCdO+rOy0qWfzZpxyUpSoxX4A87WnRMS9hMpIyT0+RuVXlafEfFHgFqRANDDiZs4vuTtCs
	hdC6G0/V2DM7yKY9SR7a8IlwqWak9ZTT1co1CFMN2DrfkqjA9jnn2iAcr22hKw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <cb14eaa1c566ed30119ca66bff0484192f852e91.camel@iki.fi>
Subject: Re: [PATCH v1] Bluetooth: btmtk: Add MT7928 support
From: Pauli Virtanen <pav@iki.fi>
To: Chris Lu <chris.lu@mediatek.com>, Marcel Holtmann <marcel@holtmann.org>,
  Johan Hedberg <johan.hedberg@gmail.com>, Luiz Von Dentz
 <luiz.dentz@gmail.com>
Cc: Sean Wang <sean.wang@mediatek.com>, Will Lee <will-cy.Lee@mediatek.com>,
  SS Wu <ss.wu@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
 linux-bluetooth	 <linux-bluetooth@vger.kernel.org>, linux-mediatek	
 <linux-mediatek@lists.infradead.org>
Date: Tue, 16 Jun 2026 17:38:32 +0300
In-Reply-To: <20260616030132.532184-1-chris.lu@mediatek.com>
References: <20260616030132.532184-1-chris.lu@mediatek.com>
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

ti, 2026-06-16 kello 11:01 +0800, Chris Lu kirjoitti:
> Add support for MT7928 (device ID 0x7935) which requires additional
> firmware (CBMCU firmware) loading before Bluetooth firmware.
>=20
> Implement two-phase CBMCU firmware download: Phase 1 loads
> section with type 0x5 containing global descriptor,
> section maps and signature data; Phase 2 loads remaining
> firmware sections. Add retry mechanism for concurrent download
> protection.
>=20
> After CBMCU firmware loads successfully, the driver continues
> to load corresponding BT firmware based on device ID through
> fallthrough to case 0x7922/0x7925.
>=20
> Signed-off-by: Chris Lu <chris.lu@mediatek.com>
> ---
[clip]
> diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
> index c83c24897c95..6d3bf6b74a1d 100644
> --- a/drivers/bluetooth/btmtk.h
> +++ b/drivers/bluetooth/btmtk.h
> @@ -9,6 +9,8 @@
>  #define FIRMWARE_MT7961		"mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin"
>  #define FIRMWARE_MT7925		"mediatek/mt7925/BT_RAM_CODE_MT7925_1_1_hdr.bin=
"
>  #define FIRMWARE_MT7927		"mediatek/mt7927/BT_RAM_CODE_MT6639_2_1_hdr.bin=
"
> +#define FIRMWARE_MT7928		"mediatek/mt7928/BT_RAM_CODE_MT7935_1_1_hdr.bin=
"
> +#define FIRMWARE_MT7928_CBMCU	"mediatek/mt7928/CBMCU_CODE_MT7935_1_1.bin=
"

Are these firmware names correct?=C2=A0

The above names for MT7928 say MT79**35** not MT7928?

> =20
>  #define HCI_EV_WMT 0xe4
>  #define HCI_WMT_MAX_EVENT_SIZE		64
> @@ -54,6 +56,7 @@ enum {
>  	BTMTK_WMT_RST =3D 0x7,
>  	BTMTK_WMT_REGISTER =3D 0x8,
>  	BTMTK_WMT_SEMAPHORE =3D 0x17,
> +	BTMTK_WMT_CBMCU_DWNLD =3D 0x58,
>  };
> =20
>  enum {

--=20
Pauli Virtanen

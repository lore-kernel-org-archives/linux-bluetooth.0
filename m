Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.31
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793241175;
	b=fx3087vMrxX6PBMYcuc/bXR7EZSFbqiR7gpFC49Ltfd5yx7RLfYmTyS6X0zs4f4VMTBg
	 zbaKrRVFqY+WBTk9ZYL+cpAc0x54c0ea82wELvccAlOk0e4+UTyUz+Z7yVAwakbHtINCs
	 DGVEuUi2ljfQznDGp5ZH5fkzuUTNwqoCMialIwnqr0+ptxtO8ypc8xAqqGUqv3CG/Z8z5
	 K17CpXchljG1WunccaN4ox38g/wHwwbwnFA4UEoLYQY8JScHYwN6rqxMSN7f/bSjbUlPN
	 WVXTsX6BAxhWeCBakLpuHNcuMyishSVX57phiysLEuwHo1U23ghAc/ytou3JWQEEd5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793241175;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=5HAya7AXrvW9nuDMyU/T5LGM7V6HXtcY2BGF7KxiYmA=;
	b=HXQLjgz85Jlxd5hcb+cE8OTRZU7hRNaWdhbS4RSohxFlv4Wv6rW2A+VzOhrnmozU5Td4
	 7gavlctJKbyr7AnvZSgvCnFPgETOo/qms0G64QAibE/YP24Z2SSGDpcYjexct6Lnrw64I
	 2WHEmwTGdNQ6jp0aQeCRQTukJfzPAe77fTTzAHVL4r0W5sUoKgtwBR7vOHJCaeYTwR1Fi
	 swq86QwDwAS8tsLzL5bdkbKG0UXHSyLo0CVYD0HYN8RifY+juWBm0dnLIfDCWhNbacuWp
	 qj5wm2iTK3OWKpHun1b6LRbI/WiNhm6WuWvaeRUXW1xFetLQ70O7bRz1iJ+bFOcAPCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=AIb5uj4v;
	arc=none smtp.remote-ip=79.135.106.31
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B386F606A31D
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 02:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B386F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=AIb5uj4v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793241171; x=1793500371;
	bh=5HAya7AXrvW9nuDMyU/T5LGM7V6HXtcY2BGF7KxiYmA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=AIb5uj4vlwZR3NhO90Y28Cxnm8lT1hWVpiUmMdgYWn7QcwXQpIGWgcdUZPaGOTj8e
	 5BVE0UKK4keJnZU9sqCeBsQQe9I1qcdkNs23PyCm4j3w4C02kducuw08RtzD+th0cN
	 Hhic35jHrw9uF02lIq71gTYEvLTb2KRXrylbklH+VqIJCuCodU5dqTcLvH/ewwWAgM
	 0q8JOFg9nBi+hCIDQ42DLXDWRqLbVKice7RtT0ppXLxbLSadIWAaVJnI9A5w5en7Id
	 +tnJ+bDf20jl8xjrQlGezi+JV7DbmzWRF5VJ8FW5yISkvq+sRQQxxz/lfV5n0MutAI
	 kBtMn6nTq4zsg==
Date: Thu, 29 Oct 2026 02:32:46 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org
Subject: [RFC PATCH v3 0/1] Bluetooth: btusb: UB500 reported maximum data length
Message-ID: <20261029023235.1280321-1-cochcoder@proton.me>
In-Reply-To: <20261013032742.497402-1-cochcoder@proton.me>
References: <20261013032742.497402-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 86604828647744461e295fc629aa5efc46e70b8c
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

LE Read Maximum Data Length reports TX/RX251, while LE Read Buffer
Size reports 27/eight. A separate raw HCI test verified sixteen
251-byte packets received byte-for-byte intact and completed, with
one packet outstanding at a time.

RFC v3 replaces 167 with the reported maximum TX length, retaining
eight LE credits. This establishes HCI251 acceptance, not physical
pool capacity or an absolute HCI limit. Audio with the revised
callback remains untested.

Prepared with LLM assistance.

Kyle

Kyle Pepper (1):
  Bluetooth: btusb: test reported maximum LE length on TP-Link UB500

 drivers/bluetooth/btusb_main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)


base-commit: 1081a6ef8f1e0661fd52eb3f878691b0b96cdff9
--=20
2.56.0



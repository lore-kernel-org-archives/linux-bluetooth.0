Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5202FF171;
	Fri, 31 Oct 2025 12:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761912526; cv=none; b=XJA87wdcnhF27Kz4nv02HT/EBdTQvkT8lp+KRYQcpxqZN1McznFS+kavixSq9Mk4T//oGBCY4SrZuh7hRMbpftKRIspHpnqqOH7vdQb+u8ILe21fPXIEKQe8ugPbaoVFdrUGXwEo2auXjEvQtpCpw4zWsAsdLWkz971i1zKQsZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761912526; c=relaxed/simple;
	bh=SZx9q5FT7jkLhrtVZdQfrXQnqqJEd+DLV6e5DXpeOW0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=FYGtiPAXwLW0RyXSOliXJBNPzKXqi5frDfYTsbYkpUQ7ZYi9bkTiOsQHcaH6R+ncUMRFG78e410VMRKrkbD8obGmKMNdGsqXKDXrAYgVlHnUNr/80Q0gaExnsoIkAOpyphwdEwr2eX2JW6257wYOgCco1Jrqix5mabuQRBU+rZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=NcTFBGiP; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="NcTFBGiP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761912517; x=1762517317; i=markus.elfring@web.de;
	bh=77H304v2oEAsybYUoCCJKlyosSP6AJdQwZgTWr2LmDI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NcTFBGiPq7X/Misf2zXjklFqFK7vDmP3wdxX5tX49pjdzSKi1Yu6/Fub/iI0U2tv
	 DUmhgLDt27qP9z0tDxf8+THXQ/rp7yxGAAkzethvXQ2/d6X8WtDjGaIZZn8fjb3YH
	 tBa5U/fHfC+xrZ+m7k9pQuow8VqRov5zblBe7vt0t4p6nj58dDJNFp3jzPLnNrAfw
	 V8wcOcCfsxa06XCdZq3h5eF6rQo6dbLrlXYwh1/2Grpkdt8xSz9ckg01fYZ4sNSMc
	 seN3uLvaB1s9e39xF65f3T0JixDXvi94xUVgWWoOaxxMNh57ECAldsE/LL7NTsyUL
	 4+G+UczLOCFmnHLlsQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.206]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MWQyX-1vmgbm1jJr-00QNYb; Fri, 31
 Oct 2025 13:08:37 +0100
Message-ID: <578671da-c290-422d-8f30-55448d024d55@web.de>
Date: Fri, 31 Oct 2025 13:08:36 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-bluetooth@vger.kernel.org, Bing Zhao <bzhao@marvell.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>, Rahul Tank <rahult@marvell.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Miaoqian Lin <linmq006@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] Bluetooth: btmrvl_sdio: Use pointer from memcpy() call for
 assignment in btmrvl_sdio_host_to_card()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:05Qe4+kJy1dvuS6XrdePRseMBfnJt0Z8MimS48E0cfjCxlkD3vi
 ez3kinSke8h0Wm0tUuvXT5XNvyq/EgCGFpUuQf+pb6T94A0IaoW2eBSR+3+TR/PZv/hmAnE
 xvCYwsjFo2mMRZr2n5OuC+N2mCHUjZ+eqaQ3VDyvk7nB8FZ3jVkpuHofLeAE7HCxnXtV7hV
 VltUnA8TNrVFK3iMaFUUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o1Gxme3jJjU=;tvUHHheinL4xO++mUbG3bjJXx2Z
 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
 qgBTsARa7PwO++mVvJDhtubyCqKjGuSyIOvV9M

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 31 Oct 2025 12:59:00 +0100

A pointer was assigned to a variable. The same pointer was used for
the destination parameter of a memcpy() call.
This function is documented in the way that the same value is returned.
Thus convert two separate statements into a direct variable assignment for
the return value from a memory copy action.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/bluetooth/btmrvl_sdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sd=
io.c
index 93932a0d8625..3120d2beeaa8 100644
=2D-- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -1111,8 +1111,8 @@ static int btmrvl_sdio_host_to_card(struct btmrvl_pr=
ivate *priv,
 		tmpbuf =3D kzalloc(tmpbufsz, GFP_KERNEL);
 		if (!tmpbuf)
 			return -ENOMEM;
-		buf =3D (u8 *) ALIGN_ADDR(tmpbuf, BTSDIO_DMA_ALIGN);
-		memcpy(buf, payload, nb);
+
+		buf =3D memcpy((u8 *)ALIGN_ADDR(tmpbuf, BTSDIO_DMA_ALIGN), payload, nb)=
;
 	}
=20
 	sdio_claim_host(card->func);
=2D-=20
2.51.1


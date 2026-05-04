Received: from mail-106105.protonmail.ch (mail-106105.protonmail.ch [79.135.106.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6623A378812
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777906247; cv=none; b=ckUefq6bd4Mqz8FWMNFxNBKFsV8i6j52ImMnOyZ2Y7BtnVguwQUTslVTaBJFCvyn6BUpcEToTK4pVec3MhsTf8ji0GZk5NriXyxk2fO3+HSF8a3LiuGkVeHdPBm3mP1xteIylr/bBLV7iW/++WORGsPhKmZGGO4FVukqJ12+aVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777906247; c=relaxed/simple;
	bh=IvHy6kRgcArF9M9TBY0PEQuXDneqNLPa3WEAfPS7Rdg=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Bf+NQ9cuMWxA8VSzYMDACidr6n6IP5haa3WWQS8xFPI+PgEe2Ub8ikfHpMewADw+XVxR2PJqd5Euq0rbUbgPOfq9h2ZCu/Sk3A+TD1iST9b4CZJ3TNKclLjvny36XgvZy+PDbckBhmnzHnnopALNLYpsh9LajxbWMzFYypt9b74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fluentlogic.org; spf=pass smtp.mailfrom=fluentlogic.org; dkim=pass (2048-bit key) header.d=fluentlogic.org header.i=@fluentlogic.org header.b=tdjp4vtk; arc=none smtp.client-ip=79.135.106.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fluentlogic.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluentlogic.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluentlogic.org header.i=@fluentlogic.org header.b="tdjp4vtk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluentlogic.org;
	s=protonmail; t=1777906242; x=1778165442;
	bh=tXdCp5b9j24/u65d9mGsQRGA1asy0/TlL3DnszGkEUs=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=tdjp4vtkG6dnQ3Z0I8bdP+Qg0ubqd798aFfsjc08qEX6Vz8xcmRIsitvtXBwTjoJP
	 0rQodV78LSSg90DskerRtkwI5Yz0ifOj073TD5TSPGWAtgn5AFYFxjB8ioc2KQ3l3a
	 gLRIylEVj8rZK5rfNioz8UFrcm4Z94hjcP+bfQ/0uS9Ymf++uRR/Y6UujCo7H/pZdM
	 1Bn6c8recb6Tplt2UlVGKDsPTX/0xAOUCCdVreUtccsMSGyPdsOsvPRpD/Rjpa2ACq
	 ur3JlGZn4CZ2nA5fuzHWwdKFNsM2Ad+Jo3R/LM6cjmacxXCzqW1KTaZsT+/SM3QZKk
	 J/w7FCS1s+G9g==
Date: Mon, 04 May 2026 14:50:38 +0000
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: admin <admin@fluentlogic.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH BlueZ] sdp: fix overflow in sdp_extract_seqtype()
Message-ID: <yOqVLTbtJxpC_gx7otX_BNS0iLh7JlU7MCD2nqptPKZfZv7gmto_BKGqaQDOrN3BX_p_QwxMEpyX6dhwiEFnCSl5U07KWDk81YvABZVf82M=@fluentlogic.org>
Feedback-ID: 121058281:user:proton
X-Pm-Message-ID: 76ddeaf07d2f2b3a51a4112b54fbbb89119db203
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

To: linux-bluetooth@vger.kernel.orgSubject: [PATCH BlueZ] sdp: fix overflow=
 in sdp_extract_seqtype()

From: Martin Brodeur <admin@fluentlogic.org>

bt_get_be32() returns uint32_t. Assigning directly to the
int *size parameter sign-extends values greater than INT_MAX
to negative, bypassing sequence-length sanity checks in
extract_seq() and sdp_extract_pdu() callers.

Store the result in a uint32_t first and return an error if
the value exceeds INT_MAX. This closes the residual paths not
covered by commit 31e4fb1.

Reported-by: Martin Brodeur <admin@fluentlogic.org>
---
 lib/bluetooth/sdp.c | 9 +++++++--
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/bluetooth/sdp.c b/lib/bluetooth/sdp.c
index 7210ce0..3295fc0 100644
--- a/lib/bluetooth/sdp.c
+++ b/lib/bluetooth/sdp.c
@@ -1249,7 +1249,15 @@ int sdp_extract_seqtype(const uint8_t *buf, int bufs=
ize, uint8_t *dtdp, int *siz
                        SDPERR("Unexpected end of packet");
                        return 0;
                }
-       *size =3D bt_get_be32(buf);
+       {
+               uint32_t val32 =3D bt_get_be32(buf);
+
+               if (val32 > INT_MAX) {
+                       SDPERR("Sequence length overflow");
+                       return 0;
+               }
+               *size =3D (int) val32;
+       }
                scanned +=3D sizeof(uint32_t);
                break;
        default:



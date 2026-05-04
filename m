Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B592423182D
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 17:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777916214; cv=none; b=U+DOyqx8/2XTfaAJ2UwZmJt7dScZr6K2+WH2Ue8gm3xdUbeXzukb7LzUynyGFfLikRYEHgsA6BMxAIuUhfn1Mb3wORQrfpqV+X1rj8e75tQhQiR4kaDXL1qATH8EV6ZMksOcMMDfhTnExnOjBQG7Eeuj0cO3+dvaVckYluKHf+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777916214; c=relaxed/simple;
	bh=aJpZx/7znJX7qGPAwO5PXU8utHY7/zIi2mGeUgupoVU=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=FgWwLoAZH5KtZqJJ3adzfFO3gNYPXFJpsSheXNbEXQ8Tua0TZLN8rxCofOZ2/0IDMT0snCFRnfksMN3Fixz36tTDPPlkmSB2P0JUMzkQ4ZNzTIEcpuR9kT9eTzT/IemICNLlX4cZV3S+N94C3B0P6ZcmXmWz8WjIQ2U0tL3vXDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fluentlogic.org; spf=pass smtp.mailfrom=fluentlogic.org; dkim=pass (2048-bit key) header.d=fluentlogic.org header.i=@fluentlogic.org header.b=uzAckPwT; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fluentlogic.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluentlogic.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluentlogic.org header.i=@fluentlogic.org header.b="uzAckPwT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluentlogic.org;
	s=protonmail; t=1777916193; x=1778175393;
	bh=aJpZx/7znJX7qGPAwO5PXU8utHY7/zIi2mGeUgupoVU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=uzAckPwTXstEyuWnUOZltIVjSj/NhJOWBDJBM7t9OVKLkp2edS1LAD9R8M/tqoOcm
	 g3Rs26Zw2mxJcaTaA+rVvTXi4XThc+8Td1dd5WS3Fhf/lbhHfLsHeiwVpsBrimFdat
	 OYyG9G0v5hghCGyhC4yr3fdvmb0zF5E+6ry3v1cMiDYFfcnbNlpFklznibD7a4nDgr
	 1tguFx09ZDthvxUfcKEwlBy3hQ1VGvnaigGCqkBGmfzed+/VmZfo8HjL4ordpbDoi0
	 KhtvcDt0nG0lXglbdH3eGRhZURPHFzz/L510ADNLVhkBBjLdJtrUCO2ogD2+Pa87Dm
	 nTWXKUQ3uDEUw==
Date: Mon, 04 May 2026 17:36:27 +0000
To: linux-bluetooth@vger.kernel.org
From: Martin Brodeur <admin@fluentlogic.org>
Cc: Martin Brodeur <admin@fluentlogic.org>
Subject: [PATCH] sdp: fix overflow in sdp_extract_seqtype()
Message-ID: <20260504173622.37463-1-admin@fluentlogic.org>
Feedback-ID: 121058281:user:proton
X-Pm-Message-ID: 262f2122276fc516e6dec7144105ea38c3103040
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

bt_get_be32() returns uint32_t. Assigning directly to the
int *size parameter sign-extends values greater than INT_MAX
to negative, bypassing sequence-length sanity checks in
extract_seq() and sdp_extract_pdu() callers.

Store the result in a uint32_t first and return an error if
the value exceeds INT_MAX. This closes the residual paths not
covered by commit 31e4fb1498f4 ("monitor: Add decoding support for HIDS 1.1=
 flags and attributes").

Reported-by: Martin Brodeur <admin@fluentlogic.org>
---
 lib/bluetooth/sdp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/bluetooth/sdp.c b/lib/bluetooth/sdp.c
index 7210ce0..d0c681e 100644
--- a/lib/bluetooth/sdp.c
+++ b/lib/bluetooth/sdp.c
@@ -1249,7 +1249,14 @@ int sdp_extract_seqtype(const uint8_t *buf, int bufs=
ize, uint8_t *dtdp, int *siz
 =09=09=09SDPERR("Unexpected end of packet");
 =09=09=09return 0;
 =09=09}
-=09=09*size =3D bt_get_be32(buf);
+=09=09{
+=09=09=09uint32_t val32 =3D bt_get_be32(buf);
+=09=09=09if (val32 > INT_MAX) {
+=09=09=09=09SDPERR("Sequence length overflow");
+=09=09=09=09return 0;
+=09=09=09}
+=09=09=09*size =3D (int) val32;
+=09=09}
 =09=09scanned +=3D sizeof(uint32_t);
 =09=09break;
 =09default:
--=20
2.39.5 (Apple Git-154)



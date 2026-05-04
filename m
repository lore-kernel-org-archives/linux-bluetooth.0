Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DA5232395
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777913226; cv=none; b=KB5izsWRYhSBt5pigNzrhz6zRSVFqeDtnK/GLvVSmvHs1/4TMGN7NjfM5rDO/3etM4eDGyu6yAtV/UOmn7hhADI57Rw3Ul/gtCMpiyCMi0C8bQhz2yQYQ1ZMK86BZD3YObf2qKHvD8uU9Ake1xcn3a4G5CBMFBn6D1ub+K0ssvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777913226; c=relaxed/simple;
	bh=cZGeO8plVLVYPeDv5ZZ+RShFYGhwURQ9M+t5/4e3Rwc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=GOiEsDv/iIYnxdDoUVkR8iSIF07uLS5OAGCvgYn79UDkfw+Hfsgha6KuooLFCyeqUn8iRxLDnquUe5YnAUF295pa1ZUx2lUqDgvDDOd4jT2HgTVxnw8cw2ehbXg84P3k1d6ew8NPeTNPm7b04ArHMHLWzdm7QyU+R6uDUczmObQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fluentlogic.org; spf=pass smtp.mailfrom=fluentlogic.org; dkim=pass (2048-bit key) header.d=fluentlogic.org header.i=@fluentlogic.org header.b=dVE7Bxtm; arc=none smtp.client-ip=109.224.244.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fluentlogic.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluentlogic.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluentlogic.org header.i=@fluentlogic.org header.b="dVE7Bxtm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluentlogic.org;
	s=protonmail; t=1777913218; x=1778172418;
	bh=cZGeO8plVLVYPeDv5ZZ+RShFYGhwURQ9M+t5/4e3Rwc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=dVE7Bxtm2QHTUDadINo5ADOmAC8IVtXhu/O8coa+K/sUE99fBC9TYQkdutyHTjbpn
	 iyV3xW0k5WPMdVMDzSCsPE1Bdjpr0s8IbEjuGXNxisU2j1dWRZIeq34xLFc0GiUhEN
	 e1ZZyrnNZBMAK0Z/F3YqkZc5JCXtwzL1kOWfloKJd74LFYlWSVEo8S/XxbTyrbpBoY
	 TetvTzW2K58Liv+//0XnIGMwpW8NflSLgYEYWqeast8PBpRbrxoZcKeuebPduibG0i
	 hzLt+Y3Nv1Xy1bUO9EmfuZj22o5gzavRnla2Sq1uBlJtFyZ07glIzvxxqtFDs03qx6
	 EGR72OKnOWsQg==
Date: Mon, 04 May 2026 16:46:54 +0000
To: linux-bluetooth@vger.kernel.org
From: Martin Brodeur <admin@fluentlogic.org>
Cc: luiz.von.dentz@intel.com, Martin Brodeur <admin@fluentlogic.org>
Subject: [PATCH BlueZ v2] sdp: fix overflow in sdp_extract_seqtype()
Message-ID: <20260504164649.31170-1-admin@fluentlogic.org>
Feedback-ID: 121058281:user:proton
X-Pm-Message-ID: 4189215a1eef2dfadb421f16502d1a4e581f0542
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

bt_get_be32() returns uint32_t. Assigning the result directly
to the int *size parameter sign-extends values greater than
INT_MAX to negative, bypassing sequence-length sanity checks
in extract_seq() and sdp_extract_pdu() callers.

Store the result in a uint32_t first and reject values that
exceed INT_MAX before assigning to *size.

Reported-by: Martin Brodeur <admin@fluentlogic.org>
---
 lib/bluetooth/sdp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/bluetooth/sdp.c b/lib/bluetooth/sdp.c
index 7210ce0..3295fc0 100644
--- a/lib/bluetooth/sdp.c
+++ b/lib/bluetooth/sdp.c
@@ -1249,7 +1249,15 @@ int sdp_extract_seqtype(const uint8_t *buf, int bufs=
ize, uint8_t *dtdp, int *siz
 =09=09=09SDPERR("Unexpected end of packet");
 =09=09=09return 0;
 =09=09}
-=09=09*size =3D bt_get_be32(buf);
+=09=09{
+=09=09=09uint32_t val32 =3D bt_get_be32(buf);
+
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



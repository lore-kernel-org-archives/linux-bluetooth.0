Received: from sonic316-12.consmr.mail.bf2.yahoo.com (sonic316-12.consmr.mail.bf2.yahoo.com [74.6.130.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0739B4964F
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 03:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.130.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787628288; cv=none; b=r4d0xOn/piGYmsx7CwavgxvWZjQ40JP0TsPJcWD9Omy79s9Zou7JNY4kE0A4apCE700BhidIHZbaMgJMn1txdfFHbcmzociNyoDMS1proFPtpf8vjennmY+cMWdH5q8qV/xUn9UUn0vGONOE2puVWvaktpg6xNF6rdyUUHBm4ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787628288; c=relaxed/simple;
	bh=gEqY542nWI7jaGdIH7s9eq22jA5v+80Q3+f584ZMhdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=YsubYnvKVeamDHcRcvKqGuMXKqpKKAtID/Qc0AaQ3AyqKEU1WxmN7c3ss5/xXLEIDUh4+dcfr2EPmfLwmh/j8tMGwWmW5LxnlAbdmMH1hnEfjulIrDSnQZIHP/5svhqK/p0+YvNZjx9OJh1BobfrHJOyAeLk+4aGKHJuRBJKgr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Fx1EjAxb; arc=none smtp.client-ip=74.6.130.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Fx1EjAxb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1787628286; bh=Ht80eOL3J9fW/1ANz9+fII2GCQ1OruFFSHzUGOEyJ20=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=Fx1EjAxbuhKfb8y6CSRGMMGn8xfr4GbpoOUnAOClFidPeUH5FIcGLC6kt64M7MtYlGBX6ZAM0AwcuqLiDbpNZgL4wr5qrKeOe96iUDl1T7iA/2herWosEGNXwv8Z/OzbvaBKzH6jpZ+wPq7pZCz01ATzgSb7+VkRFqrs1hRkZ7emz8SEGheim8V0SVJ9X740nE8rPw0nZHBboUoRl/xeZVLS+x0ISBiJkGah4UryKuRvLu8NqTowETP6VAZNKwFwdGc29+un1L1dZNqfiy4unIN/lCSdiEc5GtnHe1Fu3cx6Cov/z5Ye/P3IBijXFmCPL5gybVksF6t2R/jSFVWRJA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1787628286; bh=r4TMVSjMrkIVV+gGKLDwU8GoCgKQDmW+LZ6u98obzgc=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=LImNWPy2DTFwoBSY+MGEMdioGQA8rimOGAQHL0Dgy/5oHWXfPAkGW7Wu3mgJ1XDd7yGWXoekhbO/8bWnqUWdIuJIRsJKQ3h08TNVkpW1xdfuCd7E26KSbPGw+iTTCP3vl8oIuhNdV+ZRm+Xa+5KDHeQxhHdN7+hXpeI8YDNckM+iowZs5iLeEZ5QxIczRxMy+iBSG7h7VmNy/sstJQt8yoU3oZ7xZOwBSvzHvt5jnvaGbZsi/88j0iKw/qAIFm7Ky0riMNW2WfHkbF5MKENaFrllU4n+n/gs2kaoVOMChm72v4QagXNdxxGNCTdfC0HSxujaHcwdvoDWUWwIAOabrw==
X-YMail-OSG: VNsXUkEVM1ku9D8NKzZQ5k.mK07G6DuVDfUfl0DbbN5v3obRIYt19m9yUvW7Q7u
 kUVFUMy8rymYr4g5bLXcSC0GKc5U2BvnEH1jJqgxIwecfoUjilVfozmF3GR4INKXacKC3Nzoc.3q
 YA9d0ULMLKFzLl_ApbRkOE5jmnzDhyfxXkCC9EzqA_G3tdwBvX8YHb_.MiGDMk2Aty4gvZJrefiE
 K09DE534G34GJLMJ6TmBg5e2QWOLsqsB86cxuhnSBe.XNcdcgr2qXfNpHyt29ySDHtS4IKXCINaL
 jQaNMdFoiQZR.6HLYWFxlX4qVH5prp1xDsaN8IbIeFiGxcNZW2OIUv7uX0hRF3GX6ToLh9nJSzU.
 POaLcaeERq5Ohg_bCmqFnEUAshQ3yPfOVGu2U6VvCBE0hUxgDMLUQLv_Kil6WTtm4sQWd9t6am0S
 kUz2T4OztN_1dA7_2wMta6vhAUX0aCym8zqLzAqdh0eAIIGT1VojgZTnWyo6I5WP0VcqP_AuQpFZ
 aZbPOB4qRkGP5oX6__4MwS6wnoJCuPVuec6k5HkXEo49Lc5wSo3EDGrGr5POVeiHdvzBOtBX05Qo
 jlKI6y_NHM2hv2i4cKJcCso6rdTRhaUWUm9dRvtBuENJSsQabQ9GahRg9YsXXLJ9PdlZ7jA7ee2T
 jdWDZpjNi2ZTa7OQKPo_cqJHe3.1qaO4HygQFmhZXzc3LUdLfyYO91uETNeF_NNfkdNekVoSFA2k
 g2oHwFfgQtozFOtdGGqBl2WsJx1ciz.rxrxtZ9c15Z3DGQ2le19ebXLgzdo7CEfasEho7CcbWjj9
 w1323QcScciiB.T_isx_1W8TKxRTp5_3UkdKrUt1kSTPTafBItRu1KjgW5sZaXcqB__rWWyIoJ2Y
 xfn2zBCyWTnRErXc1IL49jqAIxdNwzotoRDTCjEx5lvCBcjQ42BzOVcOTLHJd9.5PeDljCdC.k8X
 Sfqc11CMaF237cIbq_Ig0EgZ4L3nZnaLhu_krnKHc2T7TgQaPIihFwuqK5PRVQC4CSrOaNef5i.D
 Tbw0XMFDwDbeP4EYdNVK_sMAGv9V8gtQdcwjrsrOksVwgC93dy.g.wJMThkP0_nbnNBCqVCVa0Vg
 LrJlh6ZHccYZeUiOsZwcOtTWdTI1mo3oHyQhLJ4AtoHHWwT4PbCFs_NqV9VEJsqDGDXpPW8tSdp3
 7qAodPx6ixN0C1C.ExBnJN2Ue3YGhvqGVGvP3F5rU6WJykHlmd0b98AspCOKQxB.Ij_eJ9W3kWzJ
 o3jVWKGBXj1qNjHAf.FD6iwQOXBtmGLruqsgnza9SYZ9jeBjE4YkVqfyzIMIGatBnl6VWbRnxkw3
 76gW8D1oC6qEb6G72FSPMxkaiAvIXV7sNsnUgKxUOyZNwklfdAqRHX7cu2zna7ZgKvYB2YEDdjhW
 40wEdh2jxrRiCcQWZRJNQNdR8ikjnh4HXM_g5.KxmQbmssQcEwF7QQOdgESusW.GPERiwEusEnmn
 a.m858WsksWcBXDyM_NJlA_BeISqO_3Ky8IR1poUQejF4gpmlEFy4PFT2Mi2ZfUl2.P2VgtyStb2
 laymmFBf5IGgxM2vGYRWcl4MvB0F15O8QfM0XMoNc31eaJEcoEaL89VjSk6R2Zi4mMwnV32hyxcH
 8lb.Xovxa3HD5bGj09605hC6SWuhf0zS9o5jwXonmkhwU4fgwbm6_a9Ve56s7NeVu6JRWzCs1DD4
 J2gU7ABEbq.gVpkdPKJzG2JNLIBRCueQmgVaKojR8E8Q80WE9ZforHVAm_0QE7K56UI0_YeOj3P0
 1eES8cjXeSEsohB13IcxquTcqQRgU3TAQ0Iq.FDEJ3W76cn2W6zZLuiilS.3eyZy6RYL_e3XXRam
 NpiMhKfkmYDGIskrRPprjRb4EYvdAnjggc3Qgj4fBhdXQZ_BjgW6TG.Gb_kXcgqz9pxMFGXaawwC
 iD6LUfZiO3gw3DuIESQAGVq8EZ13d38BTXP6nMzJRnWy2ZF_EpRQZbcepf6zTq4wC9yJBbknGga1
 Wqs0JwSwjlIO.dVV_GGRdGLhSRJa3l7yizPeflMdCi4ujPCdIDyqRV13o.7NJ0vLxj6vSwi5pXdM
 iJhYLaH2s1Fwv5AQxcgQRTNc1igwl1PyxX30Y_rR5cfUdor7Jx8KQjirzSNNsUZLZA1lGAm9fHW0
 XPdseW5tOK5V1e14NPbi9KL3jNIZRDikc4QyLHmmMxWrDfzEGhKW2dEZBbkKgaxOF3kUwKl8DRKp
 DcEBzyiWnWbwCckIsLntDAjzKDeh95FIfVnlwBw--
X-Sonic-MF: <deaner92@yahoo.com>
X-Sonic-ID: db997625-f6eb-433e-9764-633b6d2519e1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Tue, 25 Aug 2026 03:24:46 +0000
Received: by hermes--production-bf1-54b5569bdc-6kxfq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9d986a8971b5a1dd233f68e5f351685a;
          Tue, 25 Aug 2026 02:42:11 +0000 (UTC)
From: Jeremy Dean <deaner92@yahoo.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Jeremy Dean <deaner92@yahoo.com>
Subject: [PATCH v2] Bluetooth: Fix code style error
Date: Tue, 25 Aug 2026 02:41:48 +0000
Message-ID: <20260825024148.101643-1-deaner92@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260825024148.101643-1-deaner92.ref@yahoo.com>

checkpatch.pl flags the zero-length array members in struct
qca_dump_hdr:

    ERROR: Use C99 flexible arrays - see https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
    #3110: FILE: drivers/bluetooth/btusb.c:3110:
    + u8 data0[0];

Replace them them with DECLARE_FLEX_ARRAY(), since C99 flexible array
members are not permitted inside unions or as the sole member of
a struct.

The struct layout is unchanged, and everything compiles with the change.

Link: https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
Signed-off-by: Jeremy Dean <deaner92@yahoo.com>
---
 drivers/bluetooth/btusb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8f7ed469cac6..b78c4a0e75fd 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3103,10 +3103,10 @@ struct qca_dump_hdr {
 	__le16 seqno;
 	u8 reserved;
 	union {
-		u8 data[0];
+		DECLARE_FLEX_ARRAY(u8, data);
 		struct {
 			__le32 ram_dump_size;
-			u8 data0[0];
+			DECLARE_FLEX_ARRAY(u8, data0);
 		} __packed;
 	};
 } __packed;
-- 
2.43.0


Received: from sonic313-15.consmr.mail.bf2.yahoo.com (sonic313-15.consmr.mail.bf2.yahoo.com [74.6.133.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56A6126BE1
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 02:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.133.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786761737; cv=none; b=hYC8ap0UrWtVCPxeRmDAH/URUAH6mB/XdkUTIdvCv3GG+CPFOTXDuUU4gMdJM2HTt0EdiOJtM59aqd6zEPhuEGTjVXfaI0+myiB2a9mNfM8Ywve9eSpUfo1PEMslHGCMsV5f2Xh6pNDt6ysrQvMsNP84JB71QgDovmZRO51Ep0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786761737; c=relaxed/simple;
	bh=Dms7BAbaegS3O29hEUCmaITgxL9HXmTSHyZjCYxxmFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khUvG4zZ5aK6Catq5AAvSaPipLQ5fv1UjHJ8V3f2tvbqW7QHhNXOApt7ik5XBQdflILHb5kfhhjMKApgg0i0LgQoWBgOV6W/q7XUaiMGUXgKXlnWwRF/TPkL0Z0M3riODOzB+1ZycrlaJ2OiXFlrg5OvJv1M6sjozXjSmZ0lWOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ilK4UyVb; arc=none smtp.client-ip=74.6.133.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ilK4UyVb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1786761735; bh=Dms7BAbaegS3O29hEUCmaITgxL9HXmTSHyZjCYxxmFE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ilK4UyVbY2EBo20n016UJoxFyiPu8MLaN7UCFsvRiWeQZ+PnVPD9DBRmIy8mndJgXIgGVVDDyS41NPZpTQIKOXlcv+ukbckDp7uG8XFck125L7GxeOY19y3b2aApqGDkMkESjd/7owXcj4j7+AFEsQXMpWoEHNeMYu9zSpP9dx33WU/L35pB7n8Oihxb4+ey54s6tZIBsD8J8zuMaTnN4SMe++0qr1PJeri/sc9cO9dZk7U+DPYoPLHNyuILdHUwkkx50R/KD164ngA8xRirxZ0ChoCgoX+gmYZBj2O1A3n1keNNm5IvKkdVWSxPRpBNK1iytq7hSGLkFrng5l6oTA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1786761735; bh=dBIrulJIFxh5Sx7FBgeAopyG0gwtmsuAJPHp7RJmBjd=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=bq6gj5TtTaiqnw5lytx8nLTOagfQMl2jHtLdAlQAXlSp2Ia54JZsbEbC1cRDu+k5aPgiLbfoXIXoUwtRP2GmBfAy25aoULpf3qo8vMv+6FE1QATgcgyIFZDTS0QMYU4GRwVhJYyYRqjx7dvfFPPnlhLzV2v70UJm50ocFtdMTzx8a9wlBhk/IVo4cci8UQVTrmOAxuC1xAe3NIWbAdTaQh+wIRWFWFzy5cZ+vwwZ4iz9KOM9sws264yvZfWuxX3uFgeZx1NNEw7OfwGTG5MfKxmnzBmRD6JJajaIJQhHbEC1IufArvj0N1LpCbY0voZZTl0Xef00zapMKBEhQfRh2w==
X-YMail-OSG: S19Bk_kVM1n35a17CqaGKGG3uCuysjGc1yXecPsJH9gmwgCsAgjML8K8FH.Db5f
 ad8.MS_Ajqo0keAT_EiiVrdf75Rcki4yr423jbK.vThA57alxHJpWlli0RONraRP8iLBU7S82skS
 ks2o2kIs9irZos5yoidJL6.TFY2ivnWg29CLgPv.1OKo7sjt3nc0lcPYFnFWK8Jjxjd.gl2sWUOM
 LwpU_0R5lR6R.Mhfy.39Db1lo9ceSsUIqQpRVTAtWNukO_bGAc0PYry7owRolzlhk.cjChUSgf2g
 rIjLt9WEtwSFZ6D0heeCkrvldjiiA.qlw0l699WwIWBQBAFntn8jVuojAOpENmQsZbqZ5Sgw1a29
 5dnRZreMZwb5XSEhh0kRPR4nRcL9yo5Ymjx2_o4QjKkcQWM9zRMItvyC.OpoQ5xPa5_L54Jz3X6T
 0X1pPjtqMSA0tJ6GZme3Dj8GIiqc2hZO8l4O.KRbFHXpaFE5xhAuzZhquWMG30xW0ZBzHoIc2RbG
 tADR6Qldi0G95kC5e8LwcQw1ZgThq_2WVMGd9tCHtKcLtFHtM_NxRUQ.5oT.ROYbI7F7_elW4hKg
 7XcjPXMcjx_8HNxFGQD5y3m3ntAS8uZB8CDUOqHCpB0WdRNgvvc5gW.JM8zJSndwBnDxJqTbW1F3
 4WEbLttDhJKxgiJP.sdAlGJxbMK1s3FpT_XwFWA1IbrkiqmIPgHCQDFqZNXxkflH0ToAG9S8GwNU
 8qUG6MwqqjLrjZplEzKu4AZJl_YlSCX.Wso6s6RAcUtbI.Cc5IgeP9S1t1X0sB_dOOpQlXyG28Vm
 qX9EuSkUf3iqUoVthsN8fHT3Xp9DIufaAp68shydcrREJmUUmLWzlufsRgvcC8z4FkiVS6qJgmhK
 4DYRlYDI9V4Y5PKKLtp2uWbNzSLCd4LtsiZbQFgNxL.7H1fQD.G0ed3P6na_SwAsQskj3dhqnSFD
 Q6BYD.QqnPG17TPRaDuo_2stFnTzTp7ZU4DC_2DpXf6MWXuDhFr.gES9O6fTKRR8dLhMvjU4LV0.
 EmYZiTeo4FhP.ky0NqjmHcmL1ivNtvpy5amqEzrNQZLIGLXUyjYrMPdqMrfQRxtmPfkJFfhmAezy
 PYTAcOUsfXDRbs0a8L0A1H7uj_O0iW3wHmd7bZL1Qvynz1Clm29hP4mNs2NfUGT56r9HTEsJB0BB
 UbVgJWGgv9bbosVSGDwxdq__kp1sYH57e9mPr20zVZVrWhje0g0AsfI7ThB5BWUFAVJEqmPxdi6K
 erYw6SOZjzkgDIT5cRI8aOWaBcozKTIdW.mrD5wOyCTkMXcDpVu95_dOl4.k0lqQqX.NtAeVeFfy
 qgPK.TkJZnkUmwHAinM0VFto5xjigkODLxC3E7.wRluMi4XXdESmHnfaEDh4M7rc_Cbx3hU78iPO
 GIfOffoozVlESYRhDGyxfF52Gh4QX29vLaDZgZJKjUZ9Wb0XUJ0IryPE_7gy7vVG.eEOVEix.Ckj
 sl.XLKT6fbd5CoziwuCbjJ_Zr18E3qhuMucf1PkuyAEQ95.a5DgWuvJwtcqMXwz_5orNFizXUJ2i
 O550g189Of2khjpe282VIpeOZybDQnQh_i6KSgzyxZ8bs4GYN9Bv_3NFG_1y0ZPB_khdnVqT2IkT
 rIWXiZRe2xovsxU.aCMmx_.YkuOBrty4.sgEUk4HDhfMpgIJkxLjzFY9AmzArsdHL51Y7c41zN9z
 cZ4T4d1K6xEcrOPo4Vp8oFmb43wSRft6gn1KdRm17n6Ba2lncJiWTVnNE653hAbEOE4Dn.TpF9GF
 elQxqQ1dRu_mesWRyA3d1YLVnc.bcGNNyn21PqpsfMmlR1BRAvNqMeM7hMX6g.BmA5e67EfWw0CZ
 YPs4cbuWY3CC7gEBBeP8i5AHkOpNqY4JNkXCCP0JS6MJmnWvNa7WTmg6xsesi.IJhGUTQF81nvfx
 .z.gZBA3begtUfRcXjRQ.kqFRWLx9JzOlPJuEiDE7HawQxWmNaRYYIM_fxPJgXPKfJPGEnHySKqz
 FDsILaCKHtF4qo0Vl14.aTkROBWEM_ApohycDsqOYkrmqUZL6Ok546wmA3wt4PPrzjJM9M2y20Gq
 9NEIi5eJxU6mqOChV8EFeNUZNYOQrVYztJVGXwO06rSCByQz3kPQS0JYev.21odji4UVyRb9uGrN
 UviAFW1_4qYJrmPZY7fZVnH0QUEg6KKl4MAQfvcwQM.Sgo8HfLWpk7r88_7etX1AMtA7kRl9PoeP
 fa226xHb9KoRbpMucOp6J2mCRCMkmKwABY.Gi
X-Sonic-MF: <deaner92@yahoo.com>
X-Sonic-ID: a1f7a8a0-0186-4317-b552-4058cd35c125
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Sat, 15 Aug 2026 02:42:15 +0000
Received: by hermes--production-bf1-54b5569bdc-79vtl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 138283dac323a1a027ecdbedbbdc7afa;
          Sat, 15 Aug 2026 02:21:31 +0000 (UTC)
From: Jeremy Dean <deaner92@yahoo.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btusb: Use DECLARE_FLEX_ARRAY() for qca_dump_hdr
Date: Sat, 15 Aug 2026 02:21:18 +0000
Message-ID: <20260815022118.4272-1-deaner92@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728212431.106411-1-deaner92@yahoo.com>
References: <20260728212431.106411-1-deaner92@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's been a week or two -- has anyone had a chance to look at this?
Any initial suggestions are invited.

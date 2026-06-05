Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C7A39D6FD
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2026 09:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780652190; cv=none; b=j/Y03uysyOsJ8xj6sRoBgAxTXFlFKeKgrZ1MWKdqAKfwKUh3tOL9ma80awabaU5AFyDkh2UcPtmAVRD8StlX93QMZwnVdGxUcR683UuaCB/3Alt2UHDQElpxaE2X+F1zi45pKay4lmhZE6cbPv0x71WMQjQSAy8mQhstQ0L5TZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780652190; c=relaxed/simple;
	bh=YsnRz2hBVk6ys6lo0SuTbHaaBb/790TEBSCxUrNtdZ0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gFOs4Zx/ftEZKCzWosY8DTWLXUj8BN7vaVJvAtXFYGvpcXPsyWzV1ET8nHDy3H8wMtYy1hzXtS4BxFa1DA66CPFDXPxJqLYmJI3CaUUUZ+lcWyoG+Xd0OKr7HVoRoHpl5HzRVKNva7efgmBzQKQSgFWCraEqemxaPZ4MKlBHnTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9EB4C3EC01;
	Fri,  5 Jun 2026 09:36:27 +0000 (UTC)
Message-ID: <636d288343bfcadb333e4b9e1c1b88bba121cdff.camel@hadess.net>
Subject: Re: [PATCH BlueZ v1] test-mesh-crypto: Don't attempt to run test if
 AF_ALG is not available
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Fri, 05 Jun 2026 11:36:27 +0200
In-Reply-To: <20260522164912.3253018-1-luiz.dentz@gmail.com>
References: <20260522164912.3253018-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTEERlHbVYOwfkkzUG6rDT9j39Vg9sAF6K8wS+cZM/Q0W9K4A88EinDG34ATFrywwVKKIG1/Sg1F0D4wuhBal/WPVAoeQ7kXRmACELnerI9HgpXeGlqPfXUGt0We+R8/jC1iEfbDyKRrUvntx5+hFqvGQ/AAGp2MzZaKkkiqEhKoC7f+/ihCzIisWFvTVUE3Iz1rFu8Djfz0vMDLKYZ8CYotS+8k+Mebxej7l8MZ32v2KqOSoyFZaODC78skJq2qA1k0Rryp8PIQuTR7SgcXvwg7ffZfg2eFp6uYP+Tr8tGbGRSa53I9O/gWJArWcMmaheqGZ1JvkDNdquN68J+e8etOOXVjXw8WqNA8m33yxQ20EVVMxKNwOym0yoyJ/EI8teQxZiD4gERiJEEWhafaVIkJuoMZAhciZeYHucQHinkHLRipeGB9VJCrMWbprzw5Rop0cCWOdhNhBPwV989H/AXJvCMSGCRfc2EEoLp5QaqLhUz39xidK/b42DK9n2HJlpaGDCNMNDDUSN7+0+Ugl8ppZpKJIu4NOe4ZYHNFWY3L1HTke4sr1KuxgeCpLVcGHgXLK1+sTMgcmA67jV0Q3ONiw0DdEV2eqsN6HRkM4vKz6QbvoGisMwnXKnoxZbD61DKQ2K1cFudx0H12bO9M8MKGhMhWL7RCagocch4sBqZZ4g

On Fri, 2026-05-22 at 12:49 -0400, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> This make use of mesh_crypto_check_avail to check if AF_ALG is
> available
> and if not just bail out which is similar to how test-crypto handles
> when bt_crypto_new returns NULL.

Skipped tests should return "77" instead.

I've sent a patch to fix that.

> ---
> =C2=A0unit/test-mesh-crypto.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/unit/test-mesh-crypto.c b/unit/test-mesh-crypto.c
> index 36cae70a68a4..24fbbba33298 100644
> --- a/unit/test-mesh-crypto.c
> +++ b/unit/test-mesh-crypto.c
> @@ -2132,6 +2132,9 @@ int main(int argc, char *argv[])
> =C2=A0{
> =C2=A0	l_log_set_stderr();
> =C2=A0
> +	if (!mesh_crypto_check_avail())
> +		return 0;
> +
> =C2=A0	/* Section 8.1 Sample Data Tests */
> =C2=A0	check_s1(&s8_1_1);
> =C2=A0	check_k1(&s8_1_2);

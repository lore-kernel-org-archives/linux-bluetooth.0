Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993C12F691D
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 08:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560127; cv=none; b=UZD/TjwFMJzLPFgvnPwrMvuWeO3+gLZCvf+sNcmfEDScsj4zX+FJenHrq1+psCtdC6M/ehgyjUopN3VG4KaCd3THUJJhQivDs/uBz/m7x/QtT/0w8nSkWVsqpiu7WzIi1VkMdp4n7dPkUeTMtHTtMcyFpIDRNkQESFXteDg0FrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560127; c=relaxed/simple;
	bh=JxHT+43PRKRJHGCfzcs/JYllr9YHOyLekjqw4LLH8SI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WtViVgYzAPh2It6W/kDwB9lWTN7upY2Gd7oRpNNCN9z/7+sGPr1ventqZGmRbqfxRUynfj8c9ZpjHMXWf/ZFu9BEj1mfPZHCtjC0m1np6xFQswiqKL1KK06P0sE8zqdAPzBO18ZJQV4CF4muXOPMpB4d6dcvNggJrpnVxm5x3Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id A528E3ED90;
	Thu,  4 Jun 2026 08:01:56 +0000 (UTC)
Message-ID: <0159a5eae53a5e9632be527db5f36155eca8aee0.camel@hadess.net>
Subject: Re: [Patch] support libical 4.0
From: Bastien Nocera <hadess@hadess.net>
To: Funda Wang <fundawang@yeah.net>, linux-bluetooth@vger.kernel.org
Date: Thu, 04 Jun 2026 10:01:55 +0200
In-Reply-To: <99b4c20de30a2991509b78db7751bd78044ad83d.camel@hadess.net>
References: <1445e90e.ded.19e159db7d2.Coremail.fundawang@yeah.net>
	 <99b4c20de30a2991509b78db7751bd78044ad83d.camel@hadess.net>
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
X-GND-Score: -100
X-GND-Cause: dmFkZTEma5E86DW+TWNa+HN8BZ7GVb5wIDqFmsYUhW0VNKhBJz9V73HeGFFKufz1qwVJVmRx9I4fmp9PbmUrjW1bqSvgbgbqFi4Uz9w+lRSrjUykU0Ct0VpLMGSui4BvZ5itToQ+87GkPuiA2FKmMLfO4akdxjtWXYQev2IPrbcutQ5NSFhd0AZsHcd/okjAkpkb5BwD0Y6DDtxFuEGzc6VX14oLKNH8U22FPr9QAMPYtbdg8fac4tYpmQFdbrpgdNecMw02aNpGzOaKMtPfiYfLmcUBOJ3fuJEpPT1rXvSJbGLZTHz7KN3JUQpCuEVo5sm+GpU1ZJFuMEGayuMOUpF57X+8C7CL/zI3fyUcxfICVqQCnypTjgKLbPJtTeP5uwzNvIErpWy6zgsZ/9gunQMiYRaN3SMG+g6S99Ch/mA1eNuisdJNhBt4R3TFtiQ8UXWI/y6sNn4CJo5vdUWD3pzR7sl7CtxICtP0aocVvfoIpVBoVzDwTw20mPzG7ipu6/MgK2YqSzrR7fpi2DshdQ9aFm9kuKi19V3ddck6NBWk7+nJkgPfklFVLPHSk5CdD/Zb/lB1MUAKa4kksh1lsKy8NczBbF1DMdGxDPA+TxCdbDSsV1uHrG6VFPtm82zAqHUohpgFJFsoQUwOJl4jT9gABp+m+xgmrbxZ0AoAIHQ7FmBwpA
X-GND-State: clean

On Mon, 2026-05-11 at 09:44 +0200, Bastien Nocera wrote:
> On Mon, 2026-05-11 at 13:58 +0800, Funda Wang wrote:
> > Hello,
> >=20
> > Since libical 4.0 [1], pkgconfig files of libical have been
> > splitted
> > into several files according to libraries. The libical pkgconfig
> > check need to be tweaked to check libicalvcal. Patch attached.
>=20
> That breaks libical < 4.0, which is still the current version on most
> stable distributions.

I read the patch incorrectly, and it doe work with older versions of
libical.

>=20
> And please follow the instructions at:
> https://github.com/bluez/bluez/blob/master/HACKING#L98
> for how to send patches.

I've re-sent the patch in the proper format so it can be included in
the upcoming release.

>=20
> Regards
>=20
> >=20
> > Thanks.
> >=20
> > [1]: https://github.com/libical/libical/pull/988

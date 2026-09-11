Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335C63A8384
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 17:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146289; cv=pass; b=KrCZXAfAz8qku8SRL6t1FyF20gxbjL8xUOXIc9BefQjLz6Gsz3sH3d+fJ6IJ9PTdEcFoRF2RNFswjYe5FrVtWHM9LwrWB3GRY86qEn2LO11vMw+Wm2M2l+T4ecohcitH3Kap3ZqCmOZdfJsaqUgvJ/3Nxs7SOU7VxdbaXH2Jmzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146289; c=relaxed/simple;
	bh=z7swO+cM2ZKk84XOTW2LCsHA3+DzhC2cwOW2GzfepYU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=caKRkvn7qlsCbOi+0vzGRWc9hnaj7V6HbOanO3FjnmUPYfRKBTF5o8vNCp/cKhv1I5Rx4UaqDzYxbAUsjVbzrxsfUUsaW3S4Yxl7iUDR8PChQp1aFdjHqXcec98N6/n7CVo0LiezuY2Aj2Mo9DBuUV5XZ7/L+DDm1yT7KjBsMNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=a73Fu1sw; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="a73Fu1sw"
Received: from [192.168.1.195] (unknown [IPv6:2a02:6ea0:1508:9::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hhLWC62pyz49Pxl;
	Fri, 11 Sep 2026 20:04:39 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1789146280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z7swO+cM2ZKk84XOTW2LCsHA3+DzhC2cwOW2GzfepYU=;
	b=a73Fu1sw+v5tjVfFEEgvowwbnVmRf862WebnoIn2FtFP37qnX2HnSPl/0Fn0oWDQldRXhV
	j4nk46oE1t9Tkrqnnbftf+vYI+5Y9wZl6SDfPYNQ+4o12goS64Ms5Bsxpw5+M87m3Uvc4M
	8PN+vklTVdsjDEUjlBuBsuKgTSB+9BHY14P04mZxAi2Q9XG9wHuWvu4d9Nx62sBZzhxW9L
	cxbYyy5tZoH/NPDR/Cp50fl4hEoEw7jdwc4JeQOB/R7JYPSrHWAUEjHTDHVxiNXHrJaVPU
	phWHt3UN2U2ECGjyXZL5sQZwrJBei5VIwDutckzYXSLNCjGUobTLG1uHMYZwLQ==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1789146280;
	b=PkbESsHIxM4iHXBOZ32muJ4B82Xbl/oXqsAHtTGou5k6tQ38jZ0Sa23RgKMyNwX/t8ANkY
	YQL0I2aakluae2ZlpX0FqDK19bVuN95+PQ05EP/o6AtwAFAlSUkguvnofWaLbsBmU9DiCN
	l0NUBE8a7abl0oywhnPKVQFueTkmsM43KooyFZoSVCGTjcz4F0WdJfkcwU7oIe4YBCctHA
	g4pEjQjbDGQ8crmewllcW1W5gnPu6sCYK9MTKRXSZagYuFshjJ7dKbBJ+Xbu7ztYbFtXpl
	Fi8O/8kX4GWyE6JlvqhH3NXZPcRXLJy3fUW5tXNMa4f5fvW4NRo2n7CVf7JeNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1789146280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z7swO+cM2ZKk84XOTW2LCsHA3+DzhC2cwOW2GzfepYU=;
	b=DeR6qK0Zcq/3Nts385dV80nwHHgfBVrOYwBHor6C8LteAqqn/p1kF8PrXZZ9z1UBCrBaKp
	VhndlTAAxIi2LxFmIi9a95J6/CASRBk57kc8sFnbizSF7KmK+Z6nEiYyMtv93A72rBoAXc
	ixAQ7hfYx923tHzVgAzASt0zNX0Kkau6+a4bVoy+q9NTWQtHQgm+fRXYnv3kZxwfw2QnyB
	l0eh5vJ/kVHx2NZ/RejehdIE3WRerveOYjYLpJ69VuujbCFFF7McJeZ8/7r1FvkcCtwDNW
	4sYxOqK9SzjNkdWm4IPNTOhyr2/4asUU7bm0DcFRC5sGYcFfnSuG3++1Q39Wqg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <79e343abe97dfb706c5b267810051c75b61cb360.camel@iki.fi>
Subject: Re: [PATCH BlueZ v7 0/9] Functional/integration testing
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
Date: Fri, 11 Sep 2026 20:04:38 +0300
In-Reply-To: <CABBYNZK6UVawo5+2y+OYPa2F7q=k-3GnWUcVMX3CGLutdL6Hcw@mail.gmail.com>
References: <cover.1788712996.git.pav@iki.fi>
	 <178889520963.3704993.9911217550470009790.git-patchwork-notify@kernel.org>
	 <CABBYNZJmYqh6ZJ2wAjauP5mkK5gxgyRY8-EnKZ6v3tPNe5=6Ww@mail.gmail.com>
	 <CABBYNZKW=W8_Q+KXmGmn9gt7hN74H_EO0mSd2vOzqM64yoGWmg@mail.gmail.com>
	 <32f2cdeea1561dce8a974196bebbdd1b688e4542.camel@iki.fi>
	 <CABBYNZK6UVawo5+2y+OYPa2F7q=k-3GnWUcVMX3CGLutdL6Hcw@mail.gmail.com>
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

pe, 2026-09-11 kello 12:31 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Fri, Sep 11, 2026 at 12:08=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrot=
e:
> >=20
> > Hi,
> >=20
> > to, 2026-09-10 kello 13:47 -0400, Luiz Augusto von Dentz kirjoitti:
> > [clip]
> > > While chatting with @Bastien Nocera he suggested moving
> > > https://github.com/pv/bluez-ci-image/ under bluez organization to mak=
e
> > > it easier to manage. Perhaps the same should happen for
> > > https://github.com/pv/pytest-bluezenv.
> > >=20
> > > There is some documentation on how to do it, if you agree, on:
> > > https://docs.github.com/en/repositories/creating-and-managing-reposit=
ories/transferring-a-repository
> >=20
> > The plan was that bluez-ci-image would be moved under bluez org. Image
> > name needs to be updated in the workflow scripts for the image and
> > action-ci, see
> > https://github.com/bluez/action-ci/pull/7#issue-4699895038
> >=20
> > > There is some documentation on how to do it, if you agree, on:
> > >=20
> > https://docs.github.com/en/repositories/creating-and-managing-repositor=
ies/transferring-a-repository
> >=20
> > This appears to require I'm member of the bluez org, as it complains I
> > don't have permissions to create public repositories there.
> >=20
> > ***
>=20
> I've sent you an invite. Let me know if you still can't transfer; then
> maybe I need to create the repo or give you more permissions.

It's now at https://github.com/bluez/ci-image

The built image is private currently,=C2=A0I don't have permissions to make
it public which would make testing easier. The visibility can be
changed in Package settings at

https://github.com/bluez/ci-image/pkgs/container/ci-image

> > pytest-bluezenv would need BlueZ organization account on pypi.org so
> > releases can be done,
> >=20
> > https://packaging.python.org/en/latest/guides/publishing-package-distri=
bution-releases-using-github-actions-ci-cd-workflows/#trusted-publishing
>=20
> Ok, I guess you did this for the existing tree, right? Perhaps once we
> transfer it, you can request the update under your existing account,
> or are you saying we should request a separate account for BlueZ just
> in case we need to publish more packages, so we can reuse the BlueZ
> account. Btw, once you are a member of BlueZ you can probably submit
> an account request on our behalf, anyway I can submit it if you don't
> want to do it.

The account would be for publishing releases on pypi.org, I can see to
set it up.

--=20
Pauli Virtanen

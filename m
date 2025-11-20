Received: from mail-10696.protonmail.ch (mail-10696.protonmail.ch [79.135.106.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7106A36829C
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Nov 2025 16:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656545; cv=none; b=tH14n+hr+XQHhrpcTYKgPUKJJ80/E4G3k8ytwNQoxQzGFY/k2HPjcADHAK101ipWUDx85a5rA7zaAm5CiEV+mp0NwVn50EEQY0yM9ggAV7BcIT4UVygLP1AqY8BG2uI+SnaVQpPkAAdf2HQV3RZIv5bSrJvLgMYaFw36DPOFp7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656545; c=relaxed/simple;
	bh=GBkQ1JbR6NLWGklNBVUTymBXokpM+ZlthrIhnJ2rMDc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3xw4PKZEja3ziESmpp1KA5zeHUpEaxmWIANHDrzscfwyJSGOw0eqE2fy9k9SM+C5tHEY8sBOv2++Fdh6RJ0qTaGnfacOcNWeUy1hQwNztIX1CfYZ6qPCWS5BF3OL0hapuk48Qa1ivT1lBAN27Bt7LzBJntidcolj/1oEcPk58s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=CFdM2NWy; arc=none smtp.client-ip=79.135.106.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="CFdM2NWy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1763656534; x=1763915734;
	bh=GBkQ1JbR6NLWGklNBVUTymBXokpM+ZlthrIhnJ2rMDc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CFdM2NWyWK7lybgBQjQZtA0UoBIZ9LSThnV222rMXNWf5DdHRZh4L3CqBW0soCZq8
	 cjobLjJkTFXdQ0VNm0hFkJmFIrO57GKersw3/uDyUJjm48cuBINff483X1PAftAcvX
	 gFe+I8fZywGm3wSejyF9yOBlzGA6M31bTsSpYyM+vPHSVZACSe9lIMkCjwDuJhcccB
	 cUvwqeZg1SSali3KtpPXtHABayzdqF5ajnFvgXTNK+EptK2VwcjGfeqAG8SsA/jPfe
	 i8+ZnbHD/Nvl2UbNHzE2nNyvC5L83mkdSrNhBhFCCSmVpPDnWsRA9iSK40+pf82E/z
	 /0Nkz0jbkDztA==
Date: Thu, 20 Nov 2025 16:35:27 +0000
To: Doug Anderson <dianders@chromium.org>
From: incogcyberpunk@proton.me
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>, "sean.wang@mediatek.com" <sean.wang@mediatek.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] Bluetooth adapter provided by `btusb` not recognized since v6.13.2
Message-ID: <dA269ZfA6vvmePZBF3DBULVIDsK_zAWujzWKpPy44BQ0QGB6t6pG5JVTt8lwsArauLABj3oMiZVMEzM8GzjJKgx1iqQNwkICiGq9cNtaZak=@proton.me>
In-Reply-To: <CAD=FV=XUFEMAuLiFUR7pvPsWJP=_A=6=UGrFX9mobTV1M0gN=w@mail.gmail.com>
References: <jOB6zqCC3xjlPPJXwPYPb4MxHJOhxVgp380ayP7lYq-aT2iA5D8YCdMeCvq5Cp_ICZmqjpfgX8o9siQdlPu9DY4qgnL_zCjgqP23fXc-P4U=@proton.me> <T4YKnjuw-ZdA4uQjGVxQh-vqahAK_69kn20zfC_8R45iOxbdjo_tlIDwP5rTUyjn3NVUHYhG09VO2ryFtfLtgptBBhfXggFNAD2CVAwPcjU=@proton.me> <CAD=FV=WDx-WcosBWf2yd3sLx5pEyjOgbs_Y5RBF=+b=0q3dBww@mail.gmail.com> <5rFwJreAVujrYXDGZZxW32PHa6HZ29PEP4R5-dqS9dbU3FI__qe3zIUx31TIHO_LjuURCSwaGucSFBPeXAjf00XzAxTzXbmf1AaY6neyQ3Q=@proton.me> <CAD=FV=UCnt3nUktRyzUDp1agDFp3ZJo=t+xBbLCD6W7Jd0aF7Q@mail.gmail.com> <5vLxmZlxKXfznaWPi2ndxyj90dJN1FML_fINz027uaJP2rZK_nQu_41m7WA7Gnc1yy_XLw8KMWF18Y_keW-qKjHy0BBOQl0A92QiY7Kg004=@proton.me> <CAD=FV=WRYYYB+G4-7y7uVR8QCEEMp2iRfmtsAa29UfyNCVD=4Q@mail.gmail.com> <YrzH4CVQLf1BjCQDuWEnQ5oxWGrsTge_CHmEViJEDklOFwbMEylpl2KnmeiG1EgCm62OKNFG1JRu_b2bOVUbZZOZQwcSNHbUO1gR1GiN1rI=@proton.me> <CAD=FV=XUFEMAuLiFUR7pvPsWJP=_A=6=UGrFX9mobTV1M0gN=w@mail.gmail.com>
Feedback-ID: 139104781:user:proton
X-Pm-Message-ID: 58729f77840557f265d5a6332c1da46dca59b84c
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

So, now does this patch for the regression gets merged upstream for the nex=
t mainline and stable releases ?=20


Regards,=20
IncogCyberpunk=20


Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45981849;
	Sun,  5 May 2024 10:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714905062; cv=none; b=G5973t2PRoOHEo6hVcF7752BzFDRNeR536L9uyrgdtsKgNRbUW6T9kR/qoYCb1F08lwT29sth7/e8ywevH6oYbL20c4b8kiwzBf0nlrZdbneJmyq3gZA4xIxQa8OwsfGA7NwtYE9HQqmTllnigBZGlldWo0LOto5ex9FFsYWEJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714905062; c=relaxed/simple;
	bh=lmYUyRZqt4VeqnRX5yKD8WzCCYGdm9jSGKvpPNU6ebE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZqrtj4kuxHQiaIXZJctujX450uvd0MhtbGccYJwUVwPdwW0iBui+DDg5zqHs5WmobkpAnxKGNOpLRPWYgyXCCKR/ZdqWsTRhagMK4F0qeL2ZV8aSWNcEwwKt59R5ZG4GycLUFRsuW6qBiVWPK9VlNUDHQEQ5Ous2my4ccy6S3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Y8G8VjW0; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Y8G8VjW0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714905056; x=1715509856; i=markus.elfring@web.de;
	bh=lmYUyRZqt4VeqnRX5yKD8WzCCYGdm9jSGKvpPNU6ebE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Y8G8VjW00jhjc+d55+67vkBiqupH0jCrTuvL68KC6MNA45BXOJ9njP+NnXWm9oQi
	 Uaye+AfwQumd1sflKJ1XluvvdBXZS6LsxxRcYbvcFlCO01EkJN3hwrnFHMzRcQkB4
	 nzCWl3Rbru9T2vDNoEsdomSjARcUVa3eDzk6WtP7AlI5o480k9ezCYvc4+5pY57UD
	 N8JuCiQ/YzguG1k/1/pADuoI+CleFekkX+W60niL7mtz86FqI/M7aBflhf2g2FZmi
	 TVW8Tm+pkoAJ1EjrGf4bqV4cKXhzuuN9GFnghD83kfN/mrBt1lj8hoLAjzG1bhyv0
	 8l5Ds2XZIqO5tS1m+w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1JAm-1s5Clh3dIg-003LgR; Sun, 05
 May 2024 12:30:56 +0200
Message-ID: <31f78b18-0caa-45c0-af84-c95d525a13dc@web.de>
Date: Sun, 5 May 2024 12:30:54 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bluetooth: qca: Use common error handling code in two functions
To: Julia Lawall <julia.lawall@inria.fr>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <fd9f738e-8e78-4afb-96fd-907f72fb4e13@web.de>
 <alpine.DEB.2.22.394.2405051105000.3397@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2405051105000.3397@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gsfazNnTrq021Kj/cnctGof1DoBOC1zAs8MxqeLWz6QCZG83Njh
 YPVEZ3fTOC5k4wiGy10KB3ZJQ3wRpiZw3VLyEULZen5Qd6fRFB6AzZIFiPq7DuajXbD8Pda
 +eVKia6xWwRYoK1OPtT4ibzv3PblV9PN6zYS+rimPGPzmcsc/20j+diE77CB4AJGd3Fb9I4
 whT98KIigRHc9uhBmieWA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C9cD6zfGOxE=;tV93v73JML6i1PpzlTZrOOrzw9L
 U5eR6xr1gf9QiVCI5VBzhYCRutSZkK/YZKvV8HggMxIoz7IF7sy7BlYZ1GGR5/NYCz2m2Fp8i
 YvNlage2+nAKpsyT7ncocGE6vRKhhjRHavq5zFSCPlb2a1OLAExwghZWqMkGvQdsdLNQU4iow
 63Pi6dI0r8vnpkDs8+jVSCa6yPHJ+6VXqBKxjL9AOwH+YEHRmTdtr/uDITexhl1eU/1NV8v+1
 vl1Sjj5L/it97+I2qTpkAP0phAUB8sHGFrG8rNdE8NQfnt2mPYNOzH23MlaI0/KKp/nCMtec6
 yCNqkAtsAAWtrtpVcTgHovrBJAia3AsYWL5rmU5BFVw6/e/QplG8bFSPGYxl1QHgLkP1nCPQC
 ApavJ1lV2+EKvUfFrb+OSMuRIdMWUMqXN2YUhzWXKI1umoGIxspy63ciJ9JXG8FsGsmY5L4aO
 /iHsuYR4t3A5kSaC2nWOXqh/a8neFhiE83UIm+DD5Uj/B0J7NvKjMiksTgVT9YwhG0kFHcQdJ
 ASAFfRC1I5cyNBzpdqjn/UBNeeyIcLBTSpNiHOZIvE0chTvGGyt4juaPL87nfVQ6xdT9uYXTa
 7R/rCZfgoecl4Qp+a8831prZGxhKqKQ3i3P1xzA9cfQVmiu3QEzp4VUaf4NrvIwTHioRQcq9G
 MgsMh5Muf+azTRjM1x8SxX5Mf/QgZtDRMdtHHxI9yK8lOL/dcU24TXBqpnvYjMZrifOywLNhS
 1OiwSjW3uJgEuTcCrQyaEOZ5X+LcMdTLmj9rGNlaknoGX9kxFhEv/0QCIzY3AnjKGBIV6iQxZ
 XhxoX/Cb9n6eIFwhLjOEC3O0wBcjTWZeXuQBKgiLf5MAEmbcpZp2hDn83TDGBGLtE8

>> Add a jump target so that the setting of an error code can be better re=
used
>> at the end of these function implementations.
=E2=80=A6
> This reduces readability, and backwards jumps are rarely desirable.

Would you like to support any other design approaches better for
the reduction of questionable source code duplication?

Regards,
Markus

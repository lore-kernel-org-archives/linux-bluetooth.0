Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE183FF8B0;
	Tue, 25 Aug 2026 12:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662335; cv=none; b=D3BMIa0S+UZaI2I4jzjKMVQoQiv+0f/doztuDMJLNfivJtqSWN2ChRGJTSPyNp0imChgdKS6ufPSv57YoS5L465d5T+y7ywr/0rov0fmLvZj88F06+cPPSeA3mCnSbrsl2Z9o2jziH4YWNs2JikLdKhixOqA6jQBpl5fgsPMUkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662335; c=relaxed/simple;
	bh=c/tgeOqNZmNBCpIpYagisF5S52+Z0rmfm7KP2mmvEOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fR+1WIU76PnV/K4vL9z0whT58ocW4UNl/Js1kAAUdNuWpTKElXumIJAOzBzYAJjvPJPqWUSfumXW4eUwHtFvvQGBhy5JEOaxuopkmZBhHEMWDU8mr8sAJRdoJ+CKoHgHD0fYzBqPJVWKbc0cjenYSLYFCqH6IPAqHwLTqJzmTXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=aOrp2S9I; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="aOrp2S9I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787662325; x=1788267125; i=markus.elfring@web.de;
	bh=0A6+RJYgEoDGr2WxcoFBUybCUvprHwj6reMfDh19ATU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aOrp2S9I2S5Nomc4jTGmMP4Y3kl8Ndln6tse63Djx0QIUbgMdLryupXklM0YMOTd
	 bNm0XMb0mNuy+DZgBuqUPbHN4mlmnDhpjt5Hny2ACY2OL0n7uizni1pR/BtRckONr
	 UQJWietbbCCs2b1RKaZIL4BURN93suaYh+x0zWH8YpWJ5b+ijxDkSkwoHauiEHPmu
	 ONR7iGuWi/lNPa7EPJEST5lc3KmImXwRmsQVnhnNg8Kv+YwezV1E9Z15FF6QeBbbn
	 vtDOnWzPMzrZWjnY0rJCU3NAH1Y5Hzp50IVIqcJqpgH2x8VegdZ5Nok3cdcOfrtT6
	 93XIdpEEOW1QJb4OVw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7Nig-1wzx5l2mUe-00C4NL; Tue, 25
 Aug 2026 14:52:05 +0200
Message-ID: <04cdba23-c8f7-496e-890d-9e1dd6694e06@web.de>
Date: Tue, 25 Aug 2026 14:52:03 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: Fix code style error
To: Jeremy Dean <deaner92@yahoo.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20260825122207.101868-1-deaner92.ref@yahoo.com>
 <20260825122207.101868-1-deaner92@yahoo.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260825122207.101868-1-deaner92@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C4kIZmuJj1YYVqGskzaZ0uUZAkMriuuGrnif1NT7EB4tt8EZv0I
 5NElDm8QZ1nYJKJmB3NZg2yTJ703mz5YIwM7D6bcOpVvFbiMmQEECAjlEKJE69wo9lLXhk3
 TMdCQMlDc6JnQe4kZ6gCj+jtCTx/l2uk+LZyNL2q644tpFw/8a0KQBRgAyFRJH1g8YQ1vZ5
 VBeT89kOjxVhRjjUSX5bA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bxv/7nVW1K8=;gCgC+SNKVbGVXJAsC7YhD7hY1tg
 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

=E2=80=A6
> ---
>  drivers/bluetooth/btusb.c | 4 ++--=E2=80=A6

Some contributors would appreciate patch version descriptions.
https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+pre=
viously+submitted+patch%22
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.2-rc7#n310

Regards,
Markus

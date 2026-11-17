Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=2.228.72.60
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794905009;
	b=Szu950mJHc7dTqT24Rjr7cPmyVeoA0c0ao2dy8EjHdozF8S8acTNVfWh0jZvpvjxVapN
	 EbTYNlvZkdur9dR/nBukiGOwAZY24Gs+fe09LFE7FLafpa6ec6ALZuSEWvKSSbbQ16i7n
	 w2poUEPmF9JaLfXO3bdstce6qIxDWHYvoH8+Fie2h1JA/yoxuzWhBkE1Vtey2Yp5OmOhI
	 5kzcZaQGWvvFCsQQYOw44SfxZ483261Qy8MqBrQxGHJtyiOrHk/r+ed5zBMkbxrySvvSC
	 t+8Va4pP7rq94H07RCsle/1EK+E/YMnoFxMkViEWeWnibsZlH9VunZu034bJYM+sq/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794905009;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=NHiK2JM9Dc1535FPsjALnJbR7iSvNJ3qM3fLUhpAxxY=;
	b=GwlHjOUuNPNUQtG3NEPSeojPhOK9bywqUtxUDr8IGoSUYHoHew+xLQsUmhr5v0Bsthqq
	 sd0aG268/m3AWS2+reiG2DILmQ39b1i7Q0LnMyV/a47pWMP2qtHEFglmPSZfuH/0lLjeu
	 DUB9286djc2eBjQ4SUYbTXFWbDMFJLwmzfgJ8iu6PES7qF3tnWs9pDP71PTkRFNcEF4IZ
	 5GCKvQtCwggBrIkGLFDY1K1Qkjr5A6sjRZy7Mz+KtNwwKAK+zEilUJ+rNSRFeJZMG8Jl9
	 0U2n/tOgRD2Cg1xFUJOMtaQlvHPgXCsAd2rbj7UMgrhvD5iDQoMi0AwDiW77mrmEndA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewiz.org;
	spf=pass smtp.mailfrom=codewiz.org;
	dkim=pass header.d=codewiz.org header.i=@codewiz.org header.a=rsa-sha256 header.s=mail header.b=f0opFOd6;
	arc=none smtp.remote-ip=2.228.72.60
Received: from morpheus.develer.net (morpheus.develer.net [2.228.72.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CD1606A335
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 08:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89CD1606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codewiz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewiz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=codewiz.org header.i=@codewiz.org header.a=rsa-sha256 header.s=mail header.b=f0opFOd6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codewiz.org; s=mail;
	t=1794905005; bh=AYtO/1cXe2gBX2Vg/uqTnc4obosSKJ08uh8c9reeyX8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f0opFOd6AoO1FaPCX5LpLxeom/NnOvcf9nf1Y9E+UNcIb2RgVjx9JWDkJoD2+FyWJ
	 mq2iq0ayDkfYpzjNRn3Ko97bnIDizT+ErEKAHGSO19X+rFWMrJDQ9Opn3ItsP9xcU0
	 hpmxv0klnmKDLaYUNmNGz15xKGNWN8syMsKG+G0s=
Received: from [IPV6:2404:7a80:ff26:6c00:9b02:5fd4:b92c:dc74] (unknown [IPv6:2404:7a80:ff26:6c00:9b02:5fd4:b92c:dc74])
	(Authenticated sender: bernie)
	by morpheus.develer.net (Postfix) with ESMTPSA id D9B88247E99;
	Tue, 17 Nov 2026 09:43:24 +0100 (CET)
Message-ID: <442b021f-3cb7-4e2e-b4da-7b33cf66de83@codewiz.org>
Date: Tue, 17 Nov 2026 17:43:21 +0900
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH BlueZ 1/2] cups: Read the IEEE 1284 device ID over SDP
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20261113093428.2971436-1-bernie@codewiz.org>
 <20261113093428.2971436-2-bernie@codewiz.org>
 <CABBYNZL1Hn8dyNfd+xMkXxyVvZxqLH=ZcbSCtjKqLXi6RFeNew@mail.gmail.com>
Content-Language: en-US
From: Bernie Innocenti <bernie@codewiz.org>
Autocrypt: addr=bernie@codewiz.org; keydata=
 xjMEXxKIihYJKwYBBAHaRw8BAQdAEaAGAHL1d+7jYCkWrJabzd1reJYnxeoh45PTz8+7ERXN
 JUJlcm5pZSBJbm5vY2VudGkgPGJlcm5pZUBjb2Rld2l6Lm9yZz7CkAQTFggAOBYhBGkdgfqR
 5j+13Wxn/QvieBz8fxukBQJfEoiKAhsDBQsJCAcDBRUKCQgLBRYDAgEAAh4BAheAAAoJEAvi
 eBz8fxuk7PEBALTnPaPxYWXvPXxQ7WLcd4BvcfxIh+86O8sfh+OK9M87AP431LAnBx6lLArU
 8sXlHi9kq5Nx0FEeD0iQkl4f+Wk9C844BF8SiIoSCisGAQQBl1UBBQEBB0CyluVyxU6BIr7q
 8dkdVt2C6CHSNE1gcNoIOTD3xcG7AgMBCAfCeAQYFggAIBYhBGkdgfqR5j+13Wxn/QvieBz8
 fxukBQJfEoiKAhsMAAoJEAvieBz8fxukLC0A/jSvI5r8WmvrN7GMalg1PqF5JEruVtMIZaTY
 LD/ARox4AP9mgTyGs+XWQvqdw5FiEcAVQal6BT1xTiLFq48PN/v4Aw==
In-Reply-To: <CABBYNZL1Hn8dyNfd+xMkXxyVvZxqLH=ZcbSCtjKqLXi6RFeNew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/14/26 01:35, Luiz Augusto von Dentz wrote:
> Copilot found a problem:
> 
> https://github.com/bluez/bluez/pull/2822#pullrequestreview-5894605131
Thank you, I believe I have addressed it in v2.

Let me know if I should open a GH PR instead of sending patches to the 
list (that would be my preferred workflow).

_ // Bernie Innocenti
\X/  https://codewiz.org/

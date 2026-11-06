Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.248.207
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793963579;
	b=jvhKlh1CI+ta7gv6XvZYqaHtm46/giQXM1Ec9HoGBdAB9i0/6MmaO+7rWRSpXHf1J8Ey
	 SpOKj4kDdGOZySfYamfepZ4M5bpSCURhthbaaIc9ZIGdDgGWCseNiJYFjZyzlltTkFBw1
	 f2U1b4lpZzTObRuK2an8RdfsaBYr44BfFOXMUs+KgGjLAiY0BNtISmRvglikirJp4oT/E
	 hY/7C6G8bSuTlixmtrtnHsXdTZoYuYbHTSc8GSZPdCVUhVs+ijNBe79bOmwrV+xMSl4zT
	 SK0JnQBYPMrjz0hIN17Wgg4gM1lPkhc85QnMs8UHM8IRN9f7zo0TD671tjNt40EGOnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793963579;
	h=DMARC-Filter:Date:X-Lima-ML-UUID:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=uOlICXe5m6UkPEsKQm5ZQ2HRTSw6FYz/OTKxqH66Wss=;
	b=4100thI1V9EOt9ly5JiXV9DXsLGl4sKdFC6mMjfZXV56kCbkXYI/vyozbKUPygUHcjUj
	 /BoxlNjPRcVIhFt1GqPY9eiLD/14lf17Xb3u8P9la0N2pGbz+sOzcTJKpHkwlxVZg9MSL
	 kioIqnQL3UZwlj8sa4DMb23Sd5tFPNRn4LTgKnULttHMD6qedvZtB7bujUz1E76kSwgcA
	 gRGljMZnpPyQBt1F5xkYm2SRrs/O8Z01cOk1USVwUNBvT7F3tTRE5dqRCbIliwo9y1+KO
	 ZyLntmVj0L+kfSMxINWn76/KrsrKXDegQgAxCBqsA1HueK6GfkbUGEaKgkl9vlQwIkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=deq.rocks;
	spf=none smtp.mailfrom=deq.rocks;
	dkim=pass header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b="h5JU/H53";
	arc=none smtp.remote-ip=91.216.248.207
Received: from mx5.mail-out.lima-city.de (mx5.mail-out.lima-city.de [91.216.248.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD42606A333;
	Fri,  6 Nov 2026 11:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FD42606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=h5JU/H53
Date: Fri, 6 Nov 2026 12:12:50 +0100
X-Lima-ML-UUID: 21ffc2cf-d5b5-4b50-bff9-4d2e6e69e61b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1793963574;
	bh=uOlICXe5m6UkPEsKQm5ZQ2HRTSw6FYz/OTKxqH66Wss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h5JU/H53ovbcvOj9+4xwyKZtltEwUv5agWdUg/jQ7GqdM26PDum6snSV/4YFPG1fG
	 SbN9TAjgfxPK/5YVKP10X3R5Isn2FdfgVTJLZ/lO/qPBcXkyEeB6WYP3onoGtXXKNk
	 S+0Yqu4DV3FsKXwQ8eODr8JhLbSt1M+D5EabULuP/rfjug1oxH4Jr+9bk86CaIkEo9
	 PzHG9wAM/xhyckWLV/9LsoPcxmoeopCG02BKo+JW//M4aTJvP1rfFCeqc5Fhl7Q0ST
	 +2fh/+4cTqdMSBESXqsp/AFlHnmnqm38p6GL6BTUM1JrWPF5DxRiqHyBAppirQm/KC
	 JdHIgN6H74zgQ==
From: =?UTF-8?B?QW5kcsOp?= Eikmeyer <dev@deq.rocks>
To: Sasha Finkelstein <k@chaosmail.tech>
Cc: Myria Sarvay <myrialsarvay@gmail.com>, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, sven@kernel.org, j@jannau.net,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Yossef Osman
 <Yossef.Osman@proton.me>, Aditya Garg <aditya.garg@linux.dev>
Subject: Re: [PATCH v2 1/2] Bluetooth: btbcm: raise ACL priority on Apple
 Broadcom controllers
Message-ID: <20261106121250.0caf3299@kait2en-mbp15-1>
In-Reply-To: <5F81A6CC-46B6-4C45-BB05-8483057EEE7C@chaosmail.tech>
References: <20261105085750.120392-1-dev@deq.rocks>
	<20261105085750.120392-2-dev@deq.rocks>
	<au1uH6uxtsw2vHfP@macbookair>
	<20261106083339.677cc75d@kait2en-mbp15-1>
	<CB3B84A2-76AD-45F5-B2B9-39E5A9ED3BE7@chaosmail.tech>
	<20261106113946.60c6c5f6@kait2en-mbp15-1>
	<5F81A6CC-46B6-4C45-BB05-8483057EEE7C@chaosmail.tech>
Organization: KaiT2en
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Nov 2026 11:53:13 +0100
Sasha Finkelstein <k@chaosmail.tech> wrote:

> Sleep. I intened to say sleep and I have no idea how I managed to typo
> it as stream, but that is what I meant. Sorry.

Bwah! Well... np. But you know we are using s3 on T2? So the
controller will be off to Nirvana anyways. My last info is that Asahi
is stuck on s2? So even when testing with s2 on T2, we have UART
transport on the 4634 chips... So if at all the 4377 on 9,1 and 15,4
T2s is in question, right?

Andre

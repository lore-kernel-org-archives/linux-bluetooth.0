Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.81.229.115
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958079;
	b=N4s9FPljdjIgvgLHnfGMdyYlHbLch43uH9YTx2/UC3bdY5wAC/q4l1RRydJ9G1PHhKhZ
	 A+5h16lNFY4O60vgxXV6x2oG9GxErS6l0hZKIFKduQUz8ObDByXEtyVPXrmKzDt1VNA+N
	 DWzEodNsJlMgLlBEGnojwVXuHWx8OXQt1lg2ZoEWbabw5JTIXesajOZulyzgYjT0cMkDz
	 yjCaArtg5Lsu4dRnAuy8xQ44w6geb1hqVjrB5478s3IaBF1uFOuQRNBuf8EN+C0JM8wA6
	 qL3CMRU7FycRlFHhIcUFGsFKWRiGMAltv7+xNlObiLwdYGqIqCEstiY99vUmaoq7LVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958079;
	h=DMARC-Filter:Received:DKIM-Signature:Content-Type:MIME-Version:
	 Subject:From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To;
	bh=YfbuL9NipT5CUX35p4YpXm85UJ/pLix7zAUVyhBYcLM=;
	b=bXeBQhboasaA751JiLC0LPHT9PBDfEISTP5W6osM5RDT1Qneo7hdVm7cgTwoM0ff5+V6
	 kTgazXnV4KXhNJA75rOnsWf5MTaGcQoHrmacnI8FUzWlQG5Bk6edpIFea0FJKHnKYYn5u
	 pn1ttyLU54jgSY4ZblfKbrJzRYO44jPNx851ANlR7sDmFXhN/y1CxtSI1G+2/DXcXcvhL
	 iw7dsVzu4DouVa7E32SiRtyKGbmAyX45F5vy9CIfcnSz+afZ3SD1IegEUmQ9y/2MfWNpg
	 vDGPK+wg6XANb8cnqDOruVTe0cbG+ly0vtQFLNTbxNvDVlcqU5HZxavlVTUtDc5rkFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chaosmail.tech;
	spf=pass smtp.mailfrom=chaosmail.tech;
	dkim=pass header.d=chaosmail.tech header.i=@chaosmail.tech header.a=rsa-sha256 header.s=mail header.b=sCZijAZD;
	arc=none smtp.remote-ip=77.81.229.115
Received: from chaosmail.tech (chaosmail.tech [77.81.229.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD419606A337;
	Fri,  6 Nov 2026 09:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD419606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chaosmail.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chaosmail.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chaosmail.tech header.i=@chaosmail.tech header.a=rsa-sha256 header.s=mail header.b=sCZijAZD
Received: by chaosmail.tech (Postfix) id 5625C1CA444;
	Fri, 06 Nov 2026 09:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chaosmail.tech;
	s=mail; t=1793958069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YfbuL9NipT5CUX35p4YpXm85UJ/pLix7zAUVyhBYcLM=;
	b=sCZijAZDd9/SGpPGFxtA64PrWjVAfOoTxQ+oP2NzEcuKFZxZbjRLYNDbBBGO/UByN4lGcs
	ZrIeVD9/xINk1sveibgB0JKkkw2WAtBDbMQ9DqRg9xYrhqNEKq7lv7MTEKWYof7a0SCug4
	Uri69wI3+2hA/uQrn2MgrKfT4f48X1Q=
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] Bluetooth: btbcm: raise ACL priority on Apple
 Broadcom controllers
From: Sasha Finkelstein <k@chaosmail.tech>
In-Reply-To: <20261106083339.677cc75d@kait2en-mbp15-1>
Date: Fri, 6 Nov 2026 10:40:58 +0100
Cc: Myria Sarvay <myrialsarvay@gmail.com>,
 marcel@holtmann.org,
 luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 sven@kernel.org,
 j@jannau.net,
 asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 Yossef Osman <Yossef.Osman@proton.me>,
 Aditya Garg <aditya.garg@linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CB3B84A2-76AD-45F5-B2B9-39E5A9ED3BE7@chaosmail.tech>
References: <20261105085750.120392-1-dev@deq.rocks>
 <20261105085750.120392-2-dev@deq.rocks> <au1uH6uxtsw2vHfP@macbookair>
 <20261106083339.677cc75d@kait2en-mbp15-1>
To: =?utf-8?Q?Andr=C3=A9_Eikmeyer?= <dev@deq.rocks>

On Nov 6, 2026, at 08:33, Andr=C3=A9 Eikmeyer <dev@deq.rocks> wrote:
>=20
> I'll drop 1/2 and send the hci_bcm part on top of
> Sasha's patch once I've tested. Then we should have it nice and
> consistent.

You probably shouldn't, or at least base it on v2, not v3 (that one
ended up being a bad idea and caused firmware timeouts, so Asahi
downstream ships something more similar to v2).

In addition - have your tests included entering and exiting stream with
an ACL link active? That part always caused problems for me.


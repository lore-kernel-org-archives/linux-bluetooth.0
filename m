Received: from mail-106104.protonmail.ch (mail-106104.protonmail.ch [79.135.106.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470344C10C9
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272377; cv=none; b=rmkcVRWJI88JmxWbvnX2yW+ro7yeh2SV6tKKk5nY/DjF0WaaDJ9KReD2zcrqsyI7SvWipVAHryFURE3LLPQcP6E/3L2gMATirho1sO723SVWXR8n1KfIHjW0PkWtXWrLeUnC76aHu3jlwi7YWVBbPfA9qOnMjA1wmEYKjiIaGWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272377; c=relaxed/simple;
	bh=I/aL5RPuPnylSm1p0HkGL1qSUDBTfmZ3Z2MEbsMXDSU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eOKFwbraoJcARqI0GRAWqpytJ4IF0oPzKVZGBUJfCqiFxxkLDJLFqqbxgRV58mV8Nn2x7ztW1L2NntU08feC96bKZhxafuJhVolvAhvS5GZKgu63n6Yah2iRnPTrAV+HUjFVTuS9QWIvQrzFjsatiidSBiHgzNsT5gohnLEiZ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=WJPHGQAE; arc=none smtp.client-ip=79.135.106.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="WJPHGQAE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1790272371; x=1790531571;
	bh=I/aL5RPuPnylSm1p0HkGL1qSUDBTfmZ3Z2MEbsMXDSU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WJPHGQAEe3cTEweMZsJIt4mSmDHQ/ed+tPIAI5nvJi6Q88Kpic9vaRumxyb4C80Gp
	 fIb4Y67EzqcaJXsGG3Jb1r7uPlIbaxXS2MkHEwGZhNlIUt1nYwWRdy29BUaftfnzrr
	 Vo+UGts86jmpijzmIzKDjY8wEICzdRJCYdcUBKDx9B4p8dhAAK8wVXEC3XKppH4XIv
	 agTQumlfcY+hk0PXGIyM6zZt8yxK71ID6xWMQ6D7kc+f/CIyR858Xo2kS+LxZefbch
	 qWBI33/59Wm7vWEK60eFyDZtKtfUSP3PeWXvKGKq7ukxwiAdt94UBV9ipjjBbXbDwr
	 p1x4QBJnVZOuA==
Date: Thu, 24 Sep 2026 17:52:47 +0000
To: Pauli Virtanen <pav@iki.fi>
From: dt <derektern@proton.me>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2] Bluetooth: btmtk: don't generate bogus ISO packets from zero padding
Message-ID: <uI6rH2cpN9VV5eZ8IdurmEg9qH4Vnth3L3uYaFHvcpXJ9ja2vBneScb0R_5lEDGlRO5T6Bb-hgXA2YIt_ZC3d_JdHo2HgGmxrxh_1GkkaCk=@proton.me>
In-Reply-To: <e4b4da9d018ab26c5376fef47476b8852222eb07.camel@iki.fi>
References: <fp1LLpMjte31CZfdRymzNx8DeLqozYHgFf2TAKxtIiHEkPcykA5jgtuDuZYcJTb5vPGpPkgB8GoVoX5_821oWe9NvenZdL4kwrxyCuanlw8=@proton.me> <e4b4da9d018ab26c5376fef47476b8852222eb07.camel@iki.fi>
Feedback-ID: 213585229:user:proton
X-Pm-Message-ID: df44e1e695f2945b59bb1b0669badff95c7f2914
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On 16 September you wrote:
> There was no comment / fix from Mediatek, so it probably should be
> resent since it seems like driver bug.

Could you refresh/resend this patch, or point me to a replacement if I
have missed one? I checked Linux mainline, stable 7.2.7 and
bluetooth-next today; btmtk_recv_isopkt() still lacks the padding filter.

I am still carrying the local adaptation on my MT7925 and would like to
retire it once an upstream fix is available. As reported on 17 September,
firmware build 20260813113236 exhibited the phantom handle-zero ISO
packets, and the adaptation removed them. I am still using that firmware.

For clarity, my adaptation uses the existing device ID and omits the
once-per-device warning; I have not hardware-tested the exact upstream
v2. I can test your refreshed revision before supplying a Tested-by for
that exact patch.

Thanks,
Derek


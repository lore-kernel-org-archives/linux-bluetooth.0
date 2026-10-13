Received: from mail-24430.protonmail.ch (mail-24430.protonmail.ch [109.224.244.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E8B517BB5
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902465; cv=none; b=MeKVpW9xEYg0wiRosfb3mc9z4rb0e48bIHpwv5G5Rr1s5S98573vc1YeIYeXSankJ0TTJKGsbPR2HYAFX8BjqUizmCtMxJUZvCMMk8hohJLDjA7q28VrFU9Evwfz8ilJrDvPX7Ie+LUgtKvKjpoiDWe1ZyMXno+cxyUu6ufzSCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902465; c=relaxed/simple;
	bh=Knyg1eGY/24N+B3mUzbdi0IL1ZaLh+/WexIOA3FWA8E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TM8sm4ZJsKO1rqyiBU8XDp6CL5KHpo6MFBVtNItO3FRbcmKVssbija5jhj60/wuIzZeg01+BRsM9ZfMmnMyhGq5ZMEwGr9o3ysJOzo7B0OKPwSNFhVBaBuMPKtUQKpFd74iAKzWa224/PnPGPMSpiNTVeuK3QWXoxb/D+c9Gdi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=fbF8/Xhq; arc=none smtp.client-ip=109.224.244.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="fbF8/Xhq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791902452; x=1792161652;
	bh=Knyg1eGY/24N+B3mUzbdi0IL1ZaLh+/WexIOA3FWA8E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=fbF8/XhqCmtGg+IcN7Mpk9Qawu9KfCxyTeAUfzYl88ln4vo6xpsrIBP+JPl+AWVhS
	 IVywqsQn4UeGDvqwUd+7rWyRXqqWU6VrXwzKu7dyT65+BklbaUdm1UFBbMokr5RASX
	 hpuk8ASYcuLcZvv47zlr/r7dMsYUZ2SQjETjKU2UBwDTwAe9N06Jj335kzvK4oWG+Z
	 sqxDhs5kQSeghvjLOao1aLZ33MEZEGYSIxqW3oKo+Lz7F8nM2+6HfXxAky9BDm/Lek
	 Zkosj8vwI3osihU+v9T0ILLKVpY8ccJboeLwVqeHlJQ9T3SZU+1sqx4IDtI+rbhaev
	 9mMTPzO2gnI3w==
Date: Tue, 13 Oct 2026 14:40:49 +0000
To: Pauli Virtanen <pav@iki.fi>
From: dt <derektern@proton.me>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2] Bluetooth: btmtk: don't generate bogus ISO packets from zero padding
Message-ID: <J3DTIOm26VPmRQxbaFuf_tTRFcN5sTc2wkM_6mtmgidrgPnZc7pgqR-LFI9BxR7grHfdq-H4BieuiZ5Gwa9_Qb9nDVQfN0KhREuXSFBlNbk=@proton.me>
In-Reply-To: <e4b4da9d018ab26c5376fef47476b8852222eb07.camel@iki.fi>
References: <fp1LLpMjte31CZfdRymzNx8DeLqozYHgFf2TAKxtIiHEkPcykA5jgtuDuZYcJTb5vPGpPkgB8GoVoX5_821oWe9NvenZdL4kwrxyCuanlw8=@proton.me> <e4b4da9d018ab26c5376fef47476b8852222eb07.camel@iki.fi>
Feedback-ID: 213585229:user:proton
X-Pm-Message-ID: 1d941d7b6373cd483068120e7022780a632b38ca
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

Following up on 24 September: could you refresh/resend the MT7925 padding
fix? If you are busy, I can prepare a refresh preserving your authorship.

It is still absent from mainline, Bluetooth-next and stable v7.2.9,
checked on 13 October. Our local adaptation removes the phantom handle-zero
ISO packets; upstreaming would fix that parsing defect and let me retire
the private driver rebuilt for kernel updates.

I have not hardware-tested your exact v2. I can test the refreshed revision
before supplying a Tested-by.

Thanks,
Derek



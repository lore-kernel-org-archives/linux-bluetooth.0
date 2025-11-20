Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9C62367CE;
	Thu, 20 Nov 2025 01:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763600649; cv=none; b=MchLCLTopcd7x5k7SRaXQFbm42UxR4Wube2fQB8rqZ7OQ0t/6zqsOxvh0BBIpHT2oQCMRYYHEnRkcG5vCEh2jQXZY4Vl79xYP3emd5ttzXXuIU9Z91kpi4ZuE4XfCXk2TXFbJIHxIbEONLigiSmFfnUOAHizUfqupcKfvunouiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763600649; c=relaxed/simple;
	bh=hybVc2PVzV+uCQGS90l3v01J7xJYpVWu+1OFHT7Olno=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LMqR/5jGI3LBn76tOgWNoj7/JZ9z4Y9vx8TL0cuETJuhu1mxRDjnT0jFmHozCQF/T7m2nsw68D99Nl/wTFAEGjDEHiZqUX5da94T952k+JvLSKPq2hUzveo9SXot+ly505klNjUQ2TSyyR0gqwWI0GwZ4hk51AvIKyNge+l43O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=J1xskUiC; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="J1xskUiC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1763600638; x=1763859838;
	bh=hybVc2PVzV+uCQGS90l3v01J7xJYpVWu+1OFHT7Olno=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=J1xskUiCmZU/l7O5ZQOyZCIlDF1YNZwYK0m2jxDbK3jadt9K5+NZO1dqDZtLO7qCR
	 V5nimtxakGIv2KzihqtwIFUxTjCx/zm6vwD52O2P0fodRZdqi2DH9wzFuSSuM+izPE
	 1YeumCzfWxO8bvBuapKvM+Ye4cZdj6bQVYleEHeXpYkWpGfptnQ3O3KSZGwTfjRghW
	 YagX56Bgt3rUr5aV6RM5Y5/1PY3ONccVLUrw8KsK/3MSp4z/KwCUufnH5TmK9xxynp
	 b51k5r52rSauIKHmmwf922mvWEyQWMt/WjbCwro7/T4IXCjCOSlGVWclepyBvQ59t+
	 hGn7F5ZrGnPQw==
Date: Thu, 20 Nov 2025 01:03:52 +0000
To: Doug Anderson <dianders@chromium.org>
From: incogcyberpunk@proton.me
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>, "sean.wang@mediatek.com" <sean.wang@mediatek.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] Bluetooth adapter provided by `btusb` not recognized since v6.13.2
Message-ID: <5vLxmZlxKXfznaWPi2ndxyj90dJN1FML_fINz027uaJP2rZK_nQu_41m7WA7Gnc1yy_XLw8KMWF18Y_keW-qKjHy0BBOQl0A92QiY7Kg004=@proton.me>
In-Reply-To: <CAD=FV=UCnt3nUktRyzUDp1agDFp3ZJo=t+xBbLCD6W7Jd0aF7Q@mail.gmail.com>
References: <jOB6zqCC3xjlPPJXwPYPb4MxHJOhxVgp380ayP7lYq-aT2iA5D8YCdMeCvq5Cp_ICZmqjpfgX8o9siQdlPu9DY4qgnL_zCjgqP23fXc-P4U=@proton.me> <1b59d3c2-1ed0-40df-a3ba-cca2316e866b@leemhuis.info> <a03739b9-3a54-4ecb-b55f-6aaa69da3fc6@leemhuis.info> <a380d061-479e-4713-bddd-1d6571ca7e86@leemhuis.info> <CAD=FV=Xt58+WGK_j_TvTxpUfXrm-=Cec1-oodkuf5xiDGrsKuA@mail.gmail.com> <T4YKnjuw-ZdA4uQjGVxQh-vqahAK_69kn20zfC_8R45iOxbdjo_tlIDwP5rTUyjn3NVUHYhG09VO2ryFtfLtgptBBhfXggFNAD2CVAwPcjU=@proton.me> <CAD=FV=WDx-WcosBWf2yd3sLx5pEyjOgbs_Y5RBF=+b=0q3dBww@mail.gmail.com> <5rFwJreAVujrYXDGZZxW32PHa6HZ29PEP4R5-dqS9dbU3FI__qe3zIUx31TIHO_LjuURCSwaGucSFBPeXAjf00XzAxTzXbmf1AaY6neyQ3Q=@proton.me> <CAD=FV=UCnt3nUktRyzUDp1agDFp3ZJo=t+xBbLCD6W7Jd0aF7Q@mail.gmail.com>
Feedback-ID: 139104781:user:proton
X-Pm-Message-ID: 54985176daf3b3c18fa490ff021a273b849cfc7b
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Excellant , i will reply to the lore so that further progress from the Blue=
tooth maintainers can take place.

Also ,
 Yes .Simply because this is an unknown territory for me, i had a hard time=
 understanding the problems just from the commit patch message.

I would be grateful if I could understand how the `btmtk_data->isopkt_intf`=
 being NULL caused a crash due to the commit in 6.13.2 and what it means to=
 say `Prior to that
commit we'd pass the NULL pointer directly to
usb_driver_claim_interface() which would detect it and return an
error, which was handled.`.
How was the pointer passed directly such that the device_lock mutex , worke=
d in an undesired manner to lock the adapter and turn it on.

Sorry, for the trouble and the redundancy.

Regards,
IncogCyberpunk



Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C222EC57D
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 08:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763539531; cv=none; b=gnhPXGNdBU3DdNz1xajXcaSZfav2yTDb7XQVBk4nIW7ON2b+znh8K+HUh+sil3MA+k9x6VdoASiSaAcrd/W0ubCUIEETM68aA0T1sEp02097KPj51P2cXExLlgCeFDoZPdSrR/LRsEQI/UOGTDXlTUw+ceq+iL5NzEnjvwDa61o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763539531; c=relaxed/simple;
	bh=g/nXq5YJbfrBdvHpPUzeZ167NmrlKeebNVn25iInSgI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=td0EcdnCO36h9bUSC+nyWlPzso2XiwC5D5qzDYp1WSZ1pe5PhrV4sz82EKeMGTrf1h9BX9ArTbYiKGR9MJQFoBIosTBJ3lKwiGooggwEYiyXKXDDJtLDLUC7ku/DxPV/vpTlRUs3LrkdceTJ0tHMZ3zK+X+cWmrBWVRCZJ/kC0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=YYfw72Td; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="YYfw72Td"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1763539512; x=1763798712;
	bh=znxvF9AOPIONJcCehlaSf8jw3nZQLs+vyIuCIwXVlXI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YYfw72Td3uQtNfcwhXZ3haXq7HU5umov5Cg/t+SIp8MXUVYMbWRI3W1aJcc01ra4J
	 KWomvvhIMq7F+kP0AV6LwjIKGGB3UXnqarjIZxTYtaZlehdxQuxt3CH1AZgVZqNFhy
	 yM9D1/PQ/+wiAbQ7w6q3/FrYU7ue6+JctphrFu7gpbnJwB0u0lTNJalqO7rKvnkhP3
	 HSitkrfZnUxVE0cpQDbgE1ScaX4zPwgMIqCRyWrfrg56hWeiGVf5kaJEHL+hDPyo1M
	 SDurVHhYl1Sq23b6669VhnpU1GnA++N6V4hRDMpg0f1zSr7mRhP6fxiYyB2zq9um3g
	 2Zb8kJ+d2JUYg==
Date: Wed, 19 Nov 2025 08:05:08 +0000
To: Doug Anderson <dianders@chromium.org>
From: incogcyberpunk@proton.me
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>, "sean.wang@mediatek.com" <sean.wang@mediatek.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] Bluetooth adapter provided by `btusb` not recognized since v6.13.2
Message-ID: <T4YKnjuw-ZdA4uQjGVxQh-vqahAK_69kn20zfC_8R45iOxbdjo_tlIDwP5rTUyjn3NVUHYhG09VO2ryFtfLtgptBBhfXggFNAD2CVAwPcjU=@proton.me>
In-Reply-To: <CAD=FV=Xt58+WGK_j_TvTxpUfXrm-=Cec1-oodkuf5xiDGrsKuA@mail.gmail.com>
References: <jOB6zqCC3xjlPPJXwPYPb4MxHJOhxVgp380ayP7lYq-aT2iA5D8YCdMeCvq5Cp_ICZmqjpfgX8o9siQdlPu9DY4qgnL_zCjgqP23fXc-P4U=@proton.me> <1b59d3c2-1ed0-40df-a3ba-cca2316e866b@leemhuis.info> <a03739b9-3a54-4ecb-b55f-6aaa69da3fc6@leemhuis.info> <a380d061-479e-4713-bddd-1d6571ca7e86@leemhuis.info> <CAD=FV=Xt58+WGK_j_TvTxpUfXrm-=Cec1-oodkuf5xiDGrsKuA@mail.gmail.com>
Feedback-ID: 139104781:user:proton
X-Pm-Message-ID: d96e1c15b550ab54f6ecd597074999307838f10b
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I can confirm that reverting the commit `Bluetooth: btusb: mediatek: Add lo=
cks for usb_driver_claim_interface()` with the following commit details , s=
olves this regression that has been present in both the stable and the main=
line kernels since 6.13.2

Commit Details:
- Title: Bluetooth: btusb: mediatek: Add locks for usb_driver_claim_interfa=
ce()
- commit id: 4194766ec8756f4f654d595ae49962acbac49490
- [ Upstream commit e9087e828827e5a5c85e124ce77503f2b81c3491 ]
- Author: Douglas Anderson <dianders@chromium.org>
- Date:   Wed Jan 15 19:36:36 2025 -0800

Reverting the above mentioned commit and building the latest mainline kerne=
l without the trouble-causing commit fixes the issue and the bluetooth adap=
ter now is properly recognized and bluetooth works flawlessly. 

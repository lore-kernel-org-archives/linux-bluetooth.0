Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3D3437862
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2026 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362138; cv=none; b=c0PnRWC4xBe+jkCZ4MLBeR4xX01wJcaHBs02FO4zQtZT/Jeho1ZyO4LOOA1wAcnZPOPwLp5/uZqv+3BY3zvEqSzCg1YStDQkfnJMgCsONO31Lfur1A/a5qd1o6UNSiWagPHWv6SO47gIVVXAIcWO3B0W1SgB/OW1CgfWOpIpmsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362138; c=relaxed/simple;
	bh=+93hx6XVp6hnWKYUhk6yq/sXR5a08PxGewfyuomRE2A=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:Mime-Version:
	 References:In-Reply-To; b=Hge59aRnDum1NQwt01BXd9Mpn4XiRzA47rRR7NJ2RP4IWws7iwuxJdXEA+ZHzhQbhDA2DuiFRzMkOn2sB7zEuZOBNAHC5NSupIHoYfivPE9L0oDXxXGTkQMG/IkusqHG3NjNPpeSitNIfULv8Q1vR41+h7bX31VgN2i69+td67w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=RQuPLUX0; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Kh0B5ylV; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="RQuPLUX0";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Kh0B5ylV"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=RQuPLUX0AgnrLZJVUCxiIX2ZUpaP1ztnxfTSLd3J638vuJAV0mNnU23tAHs/oqGSuezVvg6sE7n8eAS3PPn1ARRIJylwsWEkt1nwMCWgI81iAUBp6jwf+A8idEvKwQMqkMg87gNtBmqPYm2RPs8LA+vLQHvMxQzRpRornwiCQqMRfs1rHy6/+PL93xICFOQCcFDv5jBYdP0dKSRw/vq0W9CzBCBAMua+cdhsG2jFe+aBWPeY2kypG+KIvzo3I+PNh48aBp0NqSYpDbRmGgzMY6FKxVrEppInCWsZZM1b5GxrTyb4msGJx1e2ca7zy1riYiCwLTotlIk4rQiImwmCZQ==; s=purelymail3; d=rcpassos.me; v=1; bh=+93hx6XVp6hnWKYUhk6yq/sXR5a08PxGewfyuomRE2A=; h=Received:Date:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=Kh0B5ylVuJIOUxKMm9ypUEKa6ixP4vE15z0DtWFF61NlVf8pt8FKaKDmK/s4EsIpBfN37fLPK+ZXuP32a8tEkXAl1N9nhcx0G4KTwd127+X5LnqjkTh4wOxdeqXmzvjyawp2UV0DVO9d8WXL48p0hV24kYA8C3uZglEepYCZBP5qF5Xi1RJHUzIQ3oGwLY5OIHVk66CwqvHc9WJOF4bbRAPEBqcrtucY4mR2dMvV7HQeMLl4h1fg3lKemsz99DQPN4Ms57GqvlNqefOcdcQMAWdgUH/cViQZUypnksYa9iZ98t3kWtNGZvmVn1bHh8ZRZdaJtAWaFv0fHbTuToKJSQ==; s=purelymail3; d=purelymail.com; v=1; bh=+93hx6XVp6hnWKYUhk6yq/sXR5a08PxGewfyuomRE2A=; h=Feedback-ID:Received:Date:Subject:From:To;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-bluetooth@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 205051992;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 06 Jul 2026 18:21:59 +0000 (UTC)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 15:21:57 -0300
Message-Id: <DJRP3YO7Y0WK.20KNRZIMX1CYK@rcpassos.me>
Subject: Re: [PATCH v2] Bluetooth: Properly disable remote wakeup for
 MT7922/MT7925 on Ryzen platform
Cc: "Luiz Augusto von Dentz" <luiz.von.dentz@intel.com>,
 =?utf-8?b?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>,
 =?utf-8?b?V2lsbC1DWSBMZWUgKOadjuaUv+epjik=?= <Will-CY.Lee@mediatek.com>,
 =?utf-8?b?U1MgV3UgKOW3q+aGsuasoyk=?= <ss.wu@mediatek.com>,
 <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>
From: "Rafael Passos" <rafael@rcpassos.me>
To: "Rong Zhang" <i@rong.moe>, "Rafael Passos" <rafael@rcpassos.me>, "Marcel
 Holtmann" <marcel@holtmann.org>, "Luiz Augusto von Dentz"
 <luiz.dentz@gmail.com>, "Matthias Brugger" <matthias.bgg@gmail.com>,
 "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: aerc 0.21.0
References: <20260701-btmtk-ryzen-remote-wakeup-v2-1-767ac7907472@rong.moe>
 <DJRKO72HWZOI.QJYJUAC45QOJ@rcpassos.me>
 <79D5F3E6-8F40-4422-BB2D-16691E377394@rong.moe>
In-Reply-To: <79D5F3E6-8F40-4422-BB2D-16691E377394@rong.moe>

On Mon Jul 6, 2026 at 12:08 PM -03, Rong Zhang wrote:
> Hi Rafael,=20
>
> =E4=BA=8E 2026=E5=B9=B47=E6=9C=886=E6=97=A5 GMT+08:00 22:53:17=EF=BC=8CRa=
fael Passos <rafael@rcpassos.me> =E5=86=99=E9=81=93=EF=BC=9A
>>Tested-by: Rafael Passos <rafael@rcpassos.me>
>
> Thanks a lot for your testing!
>
> Your issue sounds related to the remote wakeup issue I am addressing. Aft=
er triggering the remote wakeup bug, rebooting the platform without a power=
 cycle [1] always causes a failure in USB enumeration before the driver pat=
h.

In my case, just the power cycle was not sufficient. I had to also
change settings in BIOS [1], and only then it came back.
Even after reverting all settings to the same state as before.

I was hoping to fix this in Kernel, but I don't see a way forward.
If you have any other ideas or patches to test, send them my way!
I will gladly help.

[1] I turned off sr-iov, resize-bar & disabled "Bluetooth On/Off".
In a previous attempt, fast-boot and TPM were also disabled.

Thanks,
Rafael Passos

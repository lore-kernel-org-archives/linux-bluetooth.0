Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AD7336884;
	Fri, 15 May 2026 03:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778814365; cv=none; b=tMFg46vF3P012Q5jMnKz8EC7BeBcHBu9lYLNGL1yQlQxBnE/E06mLzNkRJlE4eIQEYqIOov0wr/Ql7I5Epmn7JOt+g7QFrZ7OVEyuyzfhyCJrRgVuTXwaAS0Q7f8gMxdgkWgFKY1IVf5CovQyPMh3mOjnLhEM6P3w9XIK6JUCLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778814365; c=relaxed/simple;
	bh=LYQGEvEVcV3AIs0Ny3zGgrPXYS1qJF3UwgPdUJMJIrk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YrxkyaKluwF0O7l/CwJcb6l6tYmW/LwbjBWmrXbVw9mLgf2vxVoDLSO1RHS1PlpEtLG6owySP+yVbj46TbaiT1pwbdejPjbZ4nOyuhOIdKcdNb0D4iSvGgTTdUVibj7X82xI5zrslTEa7Db6VOmGP4LjwNfvuEaqMmDyZqAroY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Hf2It839; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Hf2It839"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1778814351; x=1779073551;
	bh=LYQGEvEVcV3AIs0Ny3zGgrPXYS1qJF3UwgPdUJMJIrk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Hf2It839cOvAq12R8X/mdZCLRIG7VUwm86SdkOT6Jp9KgIisSQTWC5Us6OoVM8zRK
	 2nd8GsirvTW+fNxy/v5lTBn/3RJ6hYyvnYUGx/Fk9u7WW8Ba9pCIjxkjzxEOdwGQ49
	 dDCHe0eyEHaZ4CH7InrqBZtPqgz/S9aUEH/0I/+WY5HEUcu9AJe+xrl+dcpN7yVl32
	 FfbH5bMh9vX5VGPiZjO+tR22WpMsbD6RvWa3IPND+gBfaU7gRJi/ZB/EkeDAy8oAEi
	 LjsrBs8lGkEJQXyt2Jww7bCqGwdvjyVtxyc7sG/mpEz1ZmrkIj/VXyptITBs+4iChB
	 T0BkKjQ8YDK/A==
Date: Fri, 15 May 2026 03:05:47 +0000
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
From: makro-kernel <makro-kernel@proton.me>
Cc: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "marcel@holtmann.org" <marcel@holtmann.org>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v2] Bluetooth: btusb: Allow firmware re-download when version matches
Message-ID: <pyDnxzJCoPEI1RC1YKwFmifUCtLhGfqiDRuJW_TmXYMxGeItEbAHog8wiBMhH2LmwCh4_wMCiAa-plN7WUSXUmX3Aimz7QudJwZLhBGH2Uo=@proton.me>
In-Reply-To: <51a08590-a662-45b2-ba04-195b020c26cd@oss.qualcomm.com>
References: <GCBTvsv1x8qAB3ZmSCpTLo7M63lTTXM2c5n1TJLmQuus0g4gViSSJVRZzl6CzehnMdSHDqtZkQA33RYCVSxdAm7tGEeVYCflhV3QgbLIcfg=@proton.me> <51a08590-a662-45b2-ba04-195b020c26cd@oss.qualcomm.com>
Feedback-ID: 197359692:user:proton
X-Pm-Message-ID: 4abaac1a7b3dcc253d596254f65b77a59cae78b5
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Shuai,

Thanks for testing. I agree, then the unconditional bypass in my patch
is too broad and a quirk-flag approach is better. I'll wait for your
patch to land and rebase on top.

Thanks,
Makro

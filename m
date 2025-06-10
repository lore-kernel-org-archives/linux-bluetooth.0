Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9D9264A65
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 21:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749589800; cv=none; b=dE8Grxu4bsq7Jmy6cFg8PaYd/dyjgvABRrU4r41P6BsjOINj+QLTeYjzC26sprdje+dL3s+3ijiextMSz3NOrWNlTWl2YKZy6ZhRYXeNfotf7JeJba2zt7iDXDA/fGoObyfAQ51+N0kfcBB9Nd+Ge8yEVIhD8V+s/tGHh7+2WNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749589800; c=relaxed/simple;
	bh=A4x1sW7TOArbvk97YSVSVrJPGWEsS1jKL0Zr3zrrdYs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cL0Vrp/I+EvZWG3+y2nOdAQaN2jgbCkOsj9URc24r8vfYNzj0WdDazeFdLX/XJLr98hy72hHgR3CDdbSeEOvcFYU5N7882tp1Q2OIJg08Kqku+N/+xIoTobFkOoFkuPzTCIAH0Fp8jqp8T4INJNtsdrmn+URmfj6Qcumfjk2QD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8ucVZFb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8ucVZFb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92283C4CEF0;
	Tue, 10 Jun 2025 21:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749589800;
	bh=A4x1sW7TOArbvk97YSVSVrJPGWEsS1jKL0Zr3zrrdYs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u8ucVZFbPcVjLmE+oGmSAwwVcvcj/U7KBfadPhlJUL2L3db7/84EAXRcF28GpZO9K
	 JmYuYbCFEXoUw8CcAnBGmK+rPYPu8Kw2ZbUfjzTi7GfdLxm6mIn6g8UByRBcUoOATa
	 HWAsRMoRDEAivCE8eS/IYs93y0mtTQEPMyND5Xtfo04raIBCQ6lPrT+RmWBwmXKSd7
	 TR9GNWHantmjutvy9Hg/ooR/BFqW+cQTVWasE6R2+Ul0bHdTRfZqdWVnrcLJso5TnT
	 n2v76etQHCQnPseNLEVwfQsqWFGiF/6u0J60mFpDO3SUxngDJ2ht75/HMBuheM0L8d
	 /8X4VlmltO2aQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B3D38111E3;
	Tue, 10 Jun 2025 21:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] bap: Fix not responding to SetConfiguration
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174958983099.2610421.18194377281493206269.git-patchwork-notify@kernel.org>
Date: Tue, 10 Jun 2025 21:10:30 +0000
References: <20250610185018.1141155-1-luiz.dentz@gmail.com>
In-Reply-To: <20250610185018.1141155-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 10 Jun 2025 14:50:18 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> For broadcast the SetConfiguration would call setup_config which were
> not calling the callback so no reply was generated which brakes the
> likes of client/script/broadcast-source.bt as endpoint.config would not
> complete without a reply.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] bap: Fix not responding to SetConfiguration
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=95b72bbf1fe4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



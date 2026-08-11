Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4504C3E1D02;
	Tue, 11 Aug 2026 20:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786479063; cv=none; b=gfjDCn37zvjRIMOtAfTEF4HDUhWY7DEumuIKK/vjxfAKXyMbAzTs95xm2jX5ZKvTKJ9r7cQ3HCOQplCcx8gZZfCgpdhonO9odofnsjGQ22/YM3EeY2CkZGByOm1cgsB2LyDyMSnwl3bGILItQW+dGhcFEpMFE2J7GfRZM9ywU5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786479063; c=relaxed/simple;
	bh=rJCZNb9bxlnmoOhCEzIMz2lGSckw3kkH81affYs0RG8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dVw5asAluvem5nr6t9u5g2vK0SmK7hoeh4N4Qi/wBmyAXGtrkYqdgRod/5Y76PaRLM+vnAcKS57g8g4pp0UKY90hLpPtpWej+ZRoCcy+4fvw/VsnATix4cXbFTijRkOFZ0YTO/CoXYwZZKk6c+Dry7OOfK6ZqNTDI6cBFmMEHE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqS54lOD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqS54lOD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4C21F00A3D;
	Tue, 11 Aug 2026 20:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786479062;
	bh=zCbFEcVz8XROHsghsdyjrRkRwMg7C1mHJm/SeYapjpk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HqS54lODLzjiapVebmhAJm32ko6fJbJYSpyHPyKj3gViG44u83cEMjA+TFHmgG6eI
	 mhQcWVG2x6ERGgQwiSopMixKYKMsuUqEoZsq/I2m9pczCmQSuhxquugRSVHACeTq03
	 ySVaY4pNiSnU4c9ChQI44OLqW81FUWO18OdlQF5EB52TbRK4VaBap5HxOB4fGJnTi0
	 9GaV5+spyIT/uS+oQmhOg9aRsu6eppRZC1bBtboki4EqoVqzfnq2uhZ4JJ+PV5q2HR
	 EoWqvDOXqBPnsGedfK0uIPNNduyXssKP5DPZjjrzZd1a6uT4mHJ24eyszzWLl3WcT3
	 8QEnpSjbRPb4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568EE3809A0A;
	Tue, 11 Aug 2026 20:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: bnep: refactor deprecated strcpy
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178647901788.1134064.15151706764322926988.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 20:10:17 +0000
References: <20260811094932.86448-1-ajithpv.linux@gmail.com>
In-Reply-To: <20260811094932.86448-1-ajithpv.linux@gmail.com>
To: Ajith P V <ajithpv.linux@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 11 Aug 2026 09:49:32 +0000 you wrote:
> The strcpy() function is deprecated across the kernel tree and
> moving towards complete elimination. It provides no verification
> limits against buffer overflows and does not guarantee strict boundary
> restrictions [1][2].
> 
> Replace instances of strcpy() in `net/bluetooth/bnep/core.c` with the safer
> strscpy() alternative. Since both target destination blocks are
> statically allocated fixed-size arrays within their structure definitions,
> leverage the compile time sizeof() operator to explicitly pass the
> destination buffer capacities.
> 
> [...]

Here is the summary with links:
  - Bluetooth: bnep: refactor deprecated strcpy
    https://git.kernel.org/bluetooth/bluetooth-next/c/6d5e3062ef68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



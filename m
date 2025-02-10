Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F64325A343
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Feb 2025 22:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739227207; cv=none; b=Gj1BnOthC7cTe8V64epyKINJN71vmX8MZ/Hf+GvCVckBtMSP2pi/NUn3Mg1uN84M+InBVfpfz7ZWnJhyCClwm68xgpLW2evOR5Ll/gNMxSLRlDr7XMkhSFmTNRdbcI69H/hngLRfTHqZP9ensUsLTEHfo7cNX3xJHVHCUd1xBoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739227207; c=relaxed/simple;
	bh=zfrBNWiuHhnLLgDiGF8EInscvbUiufm3CogbDLrrvys=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FqJt6ryo+45T3TRrkcRcfEP93umWsdsGF8fhIkzEOUWQBAL9G1d05RQ6vaIFLWi2y5N6Va2Ycoe1KJ/pDjKPEM7HVHUHBYdS5sFlpxbHV1jMsNjc/znjcV9c8bv+Jpa6MuEjnDO6L8EeOnOIoP04etd/+yOuBaJqH6tFIuXw/ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOM8c49z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOM8c49z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7210C4CED1;
	Mon, 10 Feb 2025 22:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739227206;
	bh=zfrBNWiuHhnLLgDiGF8EInscvbUiufm3CogbDLrrvys=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BOM8c49z5MMQ6GJzp7i+JykGRTuQWiWTyGj+z4aLQNDfIhOBj/0gpWyWgBBgbkJBE
	 Z4L7cnKGPQblPiJ32DpwX3ovRUMRGmP0D9kcqcrmM6dETfgDVP3sf5bTeDAJiknzFD
	 +LGJ0fUku5zJFJ3ua7kA2ovCsEXqW/01ke2Mu0ZUgO+N1ckOWLuZSU0hFakfPj2yPK
	 MndJScd7pPNhV1dxBW9420g/sifMp8o6y1itgF9EKM42PizbYJXeY7xgYVWsaSaMNP
	 TADf0jPEt55q6cN4wj0adfXIm1KdN11EbZgcZS614cpGNu8qq322VnNzOKo27EspLL
	 biivpeYFTyl8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE88A380AA66;
	Mon, 10 Feb 2025 22:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] build: check first before enabling -D_FORTIFY_SOURCE=3
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173922723554.3888187.3037664327161983580.git-patchwork-notify@kernel.org>
Date: Mon, 10 Feb 2025 22:40:35 +0000
References: <da7a417d9b27d26393d6c9f52f675e7ae0541e8b.1739007137.git.pav@iki.fi>
In-Reply-To: <da7a417d9b27d26393d6c9f52f675e7ae0541e8b.1739007137.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  8 Feb 2025 11:33:55 +0200 you wrote:
> With --disable-optimization, _FORTIFY_SOURCE=3 produces compiler
> warnings/errors:
> 
> /usr/include/features.h:422:4: error: #warning _FORTIFY_SOURCE requires compiling with optimization (-O) [-Werror=cpp]
>   422 | #  warning _FORTIFY_SOURCE requires compiling with optimization (-O)
> 
> Before enabling it for --enable-maintainer-mode, check the compiler
> doesn't fail when using the flag.
> 
> [...]

Here is the summary with links:
  - [BlueZ] build: check first before enabling -D_FORTIFY_SOURCE=3
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d3e40e82afba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



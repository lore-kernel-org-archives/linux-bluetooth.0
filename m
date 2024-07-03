Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7804017DA23
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019433; cv=none; b=jUZoNvF+d67FZt9vsJ+xvLn/avl7yrxKqTLvIresHnE9PMo0g6qHFvTCJgs4jAZ0aHrmADIH6AgxQhgDu3rR1qCVl8ouJeu9auetpz5DCV+G3Sk2JddT4f06uVkiVQ655v2vEYMoUCObSsbR2SabAqYgoVqcBU4A6/sp1MF4Ihg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019433; c=relaxed/simple;
	bh=ebOp78z0WkV8rdClB9kk3ddPtALlEu2GjY7VN94KC0Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XuX+nvHMJ/aBvMOpQDf2TvKR6TGCbUbjjgMsFwceIdOGWQYd7Pt2CRXSkEOwVJDYrUtvBBWfhdxfkZCNVR7ldFHtz+y5M2z0brX3iwIlWKWqM2fyXWOAn+FAahUZF968Hj0w/3bfa6P9aiYcn/03mHbrxWCmcC7ubgKyRu2rbK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZI52ZDMm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZI52ZDMm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A696C4AF0F;
	Wed,  3 Jul 2024 15:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720019433;
	bh=ebOp78z0WkV8rdClB9kk3ddPtALlEu2GjY7VN94KC0Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZI52ZDMmmyxK3Z3gKGd2m4KokYpJJ4ALbGWtpczvcyxBJdNuq8YT+mZPZ9ol4RB8i
	 bnB6UO1sy736ISDFz50M+A/XEYUomrsibwinsrkTQPIjgKDQZObuGv1x0wJ64XhgfQ
	 G0sYaNv7H6hH+IKK3cfZyEWZggfUV1GcQ6BiBuGBMBHJD1bNHel6VfzrW7l3repBAf
	 KrezZUZ8aUFzGQDTP33FlWfG4b3CmER1epEQGdh+uwlCoiLbtRwWqjYSP9zn1A/L6Q
	 wB8A40S/2zNQd1Q9cYmVkEM7ASoad1Nz0YovgmDQTp3pQWEiDofbZWFfA5pcV1342/
	 HXzSS5EUkHXyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4D3FAC43614;
	Wed,  3 Jul 2024 15:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] audio/a2dp: add NULL checks to find_remote_sep()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172001943331.18626.148779122153946099.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jul 2024 15:10:33 +0000
References: <20240702073955.10962-1-r.smirnov@omp.ru>
In-Reply-To: <20240702073955.10962-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 2 Jul 2024 10:39:55 +0300 you wrote:
> Make find_remote_sep() safe for passing NULL pointers.
> 
> Found with the SVACE static analysis tool.
> ---
>  profiles/audio/a2dp.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - [BlueZ,v1] audio/a2dp: add NULL checks to find_remote_sep()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=922a8a8bd494

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



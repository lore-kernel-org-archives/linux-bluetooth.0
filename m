Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE69302756
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778074262; cv=none; b=mcUOTRusFKDyRLVeji+8iOGB8UhVyroYuxi6N/h863iX/yTjvO2KAr4FT21A3Dd2KFSivv4h2jQHmIl2kdAxqqZ7zBCWMx2vjI7nNkazwrXF9caFF7uk+YLixoXqRqM57OJp8H+KzEdHwoZAeRZW4qm++3qS5BNKmE2tOkvvBaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778074262; c=relaxed/simple;
	bh=YnGGCBNFhE5Mbfm/MtH7waBFfIfatoSBNesVQEeQn64=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=afgpNVEDf42l8Uyh4ahkmvGrkRZuPcpPQMnGEfzjFm2EunmQp4FGHDVRLfKsSmaILowEq+nBEi99mGVISI8g1tH1S6JB8TLha2WaKj7CtuCJj+fxUrHYbZbYtgI8j55n6mrAEDYkfjdKVBuWucQar93ldD0R5I1SbeBC7pnG6EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKw3wg5T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKw3wg5T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6D0C2BCB8;
	Wed,  6 May 2026 13:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778074261;
	bh=YnGGCBNFhE5Mbfm/MtH7waBFfIfatoSBNesVQEeQn64=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pKw3wg5Tk9PFBX7vl/NNW6Djvnp9+5rqVd68whrC47PsVgUWeepreyvSY+pQpSMZx
	 luQ62/xo7/mfTsTskSEVL+LY42HrASMfdTpzoj9JAIbhrQX9xxOXxmFjd7FdLGajNO
	 fLl+TH2BjjxYsGcTP62UDDd5SGe6LNKEhm3LpyipREpWZ6HknNgx3juk7dzOrlrNwT
	 QGqqzgj3NpafGNRJAsnT7fuS3mTUaWj8sTaONLZdECr02yVamNDWI/zPfNFktIcPoo
	 MdBE/w0DnHHmJUP1l810HimRyWoaf+y+h0MWFKIKiCG6y0ic0eWLJpBZfC49ra2QdX
	 H3n0yCjJpIUug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9C7539307BD;
	Wed,  6 May 2026 13:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] monitor: Add features bits defined in 6.2
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177807421130.2587487.11389095373099968743.git-patchwork-notify@kernel.org>
Date: Wed, 06 May 2026 13:30:11 +0000
References: <20260504211303.1081876-1-luiz.dentz@gmail.com>
In-Reply-To: <20260504211303.1081876-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  4 May 2026 17:13:01 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds features bits defined as per core spec 6.2:
> https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core-62/out/en/low-energy-controller/link-layer-specification.html#UUID-56ada5ed-4ae3-acee-198f-27ead57d86f1
> ---
>  monitor/packet.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Here is the summary with links:
  - [BlueZ,v1,1/2] monitor: Add features bits defined in 6.2
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fda84f7004fa
  - [BlueZ,v1,2/2] monitor: Add decoding for Short Connection Interval feature
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=79cfd07224ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



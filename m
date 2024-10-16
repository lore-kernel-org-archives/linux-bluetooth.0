Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162CF3FBA5
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729094428; cv=none; b=CfZn9QJDgBL0vB7GbVWkgkVkWpsO8qCCE8auI1dRFZv+cA2zS3CcuRLpEfzpW3s0aAEIvjOIxzAy3Mi0B+F2Hu+8eeVNS7cV1ogUIKQaSLz0zhEC2HVGYnfT1Y4l5of1AVbRw1iFKOIQB/Nr69nKztZMjDBMuJX15yEv63y5a9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729094428; c=relaxed/simple;
	bh=OMw+4nJl+tOTmM7RQ1EcBxtHSDrFmvGDhkYRK3Ld3oU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GijvTHdeBvgnyyvXzoxX5qYIZe99HKg/zks4OWsYp1F5bg1QQmpnfXLOp1LGcwt2X16msbNdaF/ssPdOmwbeSesg7gAIzGVMhItshQORetPqU5fU6Vi17kcq0d+dESsnB3thNBAwiKwU02u7ceZEAPYgcyfTmlhDz0i4ClD2r0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bv4IBREv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bv4IBREv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A317AC4CECE;
	Wed, 16 Oct 2024 16:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729094427;
	bh=OMw+4nJl+tOTmM7RQ1EcBxtHSDrFmvGDhkYRK3Ld3oU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bv4IBREvxMu/U8zjxEAFMAbeizfgd1hM3lmpEh+P4KZi8ujHeP2cQTu5/yN9P/pDE
	 0P9svL7jsQNIqXWcgFIENUBN3hgSxjuZDRq4ojZPd8DGwQCyOmhTOD9Cmmom4L9s+H
	 O+ZV/IU0dXiIHOvnw/GVXi4npLYb8mcBEvpV963mPUfMsbWMNa5ca//ImlZFO7c9ek
	 Wx6bq8f84yniCr89tESdwXTG528eLLYNOjIwrg1WvPYCiw1vNUbmT3K2KScl2wtzun
	 O4pD/PJi46pkXdemvNLij0rfW01X3PrdVZIItiG0PRPXjjO8U+69zhccbyw6gfUqKx
	 b1clMA8R8C9Sw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DCB3822D30;
	Wed, 16 Oct 2024 16:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btintel: Add DSBR support for BlazarIW,
 BlazarU and GaP
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172909443273.1863747.6160988229948048528.git-patchwork-notify@kernel.org>
Date: Wed, 16 Oct 2024 16:00:32 +0000
References: <20241015122707.720187-1-kiran.k@intel.com>
In-Reply-To: <20241015122707.720187-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 15 Oct 2024 17:57:07 +0530 you wrote:
> Add DSBR support for BlazarIW, BlazarU and Gale Peak2 cores.
> 
> Refer commit eb9e749c0182 ("Bluetooth: btintel: Allow configuring drive
> strength of BRI") for details about DSBR.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btintel: Add DSBR support for BlazarIW, BlazarU and GaP
    https://git.kernel.org/bluetooth/bluetooth-next/c/c3d1fd9e646d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



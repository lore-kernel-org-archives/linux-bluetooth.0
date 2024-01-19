Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5121156B67
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jan 2024 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705696830; cv=none; b=PYQpwwzWBJI2hl3iz0YfB+N66DG9IxwxTLKtLd+k4ZzhKNLbe0vE8rF2hVZpgWqYJQUm/EIgo98i7n3UHEyqfqayiSketLKP8MrJoXsGaYPenkAs2JN/+bjN4/HLng2MoYfUgWXDlYiAF68e+er11aSi8UmrDYcnr23T7zaQgQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705696830; c=relaxed/simple;
	bh=Sv/etJX80H2lt5c6iVQuD0kA25cXsFbcNh41dVyJ2i0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k3+41e6ud+J8cWCYCr+3yQQ1ywOkzeGqmZLgNNZsgJyFMrsfUoiqzgLlY715kNyhA66sthbX1HSmrYqQ9DDLjuhNXM047kSHVdVQlBvvOUzgKom6Cfkmx82uWCU+kN+kh/5y9R2900bVimXR5zOAawdk6SK4I0ZrNKQd3ZOi1+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPOpQNG6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPOpQNG6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3225C433C7;
	Fri, 19 Jan 2024 20:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705696829;
	bh=Sv/etJX80H2lt5c6iVQuD0kA25cXsFbcNh41dVyJ2i0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JPOpQNG6GhPqV+RnYNAp6WFu5mhoW4ZFgCIM6Z6qWijXEkK7cZ8lMUbL3V/RYHzDu
	 30cKeIvuEC8s0MA0sdhc/xnnPJmmHst9tnuk/A+ZmeQJeQrLRY4cqVV2f632DPK/D+
	 ET3rGvRzlWl2fJBs6uPFqcaC2ow6zbeuSnQM8rMyLXTDlKFQ4MLlOr536sERkTe/pv
	 JTAr/QgPDOGMCs+nm3KupNbjZWR3Yh9XPPNyPCP+hFdW4eraEpc4RbK/gZXam8p9pG
	 ioCTdBvgjDZ2STP400ILb+rrwOmcs597xBLBYhet7Swyg9Xj6goemZ779C+QKr0OF3
	 dgRXv8fk5aAbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2AC3D8C985;
	Fri, 19 Jan 2024 20:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/2] player: Fix endpoint.config for broadcast
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170569682966.28212.6024962470599533663.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jan 2024 20:40:29 +0000
References: <20240118213314.2066415-1-luiz.dentz@gmail.com>
In-Reply-To: <20240118213314.2066415-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 18 Jan 2024 16:33:13 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> endpoint.config where taking different arguments for broadcast which is
> not recommended with shell as it doesn't support such a thing.
> 
> So instead of taking different arguments for broadcast both remote and
> local endpoints shall be passed but in case of broadcast sync both the
> remote and the local endpoint actually refer to the same endpoint
> registered by bluetoothctl:
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/2] player: Fix endpoint.config for broadcast
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4908e58bd1a9
  - [BlueZ,v2,2/2] bap: Fix crash when attempting to setup a broadcast source
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2ef2f122e608

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



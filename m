Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBB61BC58
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731338428; cv=none; b=W/LyMpe5pQvh5BJCcTrYIU2qo95bEwsqVxzQfIfFdI5kR5ejpxc6Ajwkrj4uxxSuAKxY/b+7HNBop6Vb+wvjZbIY4bU8fuleDBxCBy0IRCZ1hBwT0Ve2dpP2et2vt0+4m69pzCwfOQruPAAr/OSreiT/YDTiF3bWL9dOhL428Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731338428; c=relaxed/simple;
	bh=v7J1DOqLRlH9rTrN2j0HJOetXjkxRv7Z5x53G0V0wpQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WgMU5MWXGdrDq4qaRYF1PQhxywE53mlD8kljE4DRbEJnMi+YHz7x0sImt4Df/rj40pyrfiW35fNLpAK73Ipvd6p2+L4BzQmVi4iJ0t8qNoxR12KwdqRvnGciudT+gYApIuX98X8meQfaEgdC5iX30zl7mOK4ANoN9zuJzhkpm3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z815Ug7y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z815Ug7y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753BFC4CECF;
	Mon, 11 Nov 2024 15:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731338427;
	bh=v7J1DOqLRlH9rTrN2j0HJOetXjkxRv7Z5x53G0V0wpQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z815Ug7yxPEnqF6pD3gOjCqNHOvvhbbyG6ZVS3GHFcZ4I/zunlv6HKkD8nHPoGaDf
	 ixQyeQlSK36GdQQU98o+GXFgSBW9FBWNfsdajmEo8uRuKoKml1IRC2gm6sjfnbi8cc
	 78x/vAOOIwJSWKj/uIz6fh5b0gYsZuarlTGa9rnaB+6Bho73NdBytuRpbdVG3btIUK
	 MQJ7OIRwx/b8F9LmVuef9nYU+aNiXaAg/6UN1kJOZwfDQM1OQoI9RS/hO4y/uZP48T
	 95S2ChKwwk3lwaJOcAX9J5bW6Q4PTSqgPwjdkCUg/jAbyy8G8yHsFi2AGykv9gYcVQ
	 Z95lxuufZvmmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADB6E3809A80;
	Mon, 11 Nov 2024 15:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] obex: Fix the PBAP GET request in PTS testing
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173133843723.4067431.3117014448685173180.git-patchwork-notify@kernel.org>
Date: Mon, 11 Nov 2024 15:20:37 +0000
References: <20241111111625.1887695-1-quic_amisjain@quicinc.com>
In-Reply-To: <20241111111625.1887695-1-quic_amisjain@quicinc.com>
To: Amisha Jain <quic_amisjain@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com,
 quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 11 Nov 2024 16:46:25 +0530 you wrote:
> This change is required for passing below PTS testcases:
> 1. PBAP/PSE/PBD/BV-02-C
> 2. PBAP/PSE/PBD/BV-03-C
> 3. PBAP/PSE/PBD/BI-01-C
> 4. PBAP/PSE/PBD/BV-13-C
> 5. PBAP/PSE/PBD/BV-14-C
> 6. PBAP/PSE/PBD/BV-17-C
> 
> [...]

Here is the summary with links:
  - [v1] obex: Fix the PBAP GET request in PTS testing
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b22bbf873f81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



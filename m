Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3E71E4937
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jan 2025 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738182011; cv=none; b=Ck6an86keeViNyXc4rNL6WzhnvEGNfOU3+mt4WZ6XJamv9/DuIouilXAEfsiowCC8os2IWqrpHa8Mx+QIq2mHXmRtCv5bo5IuVFoA2UgER08dL3PYGmACmYmrA8hqanApv6FQyayQs6t0JWhrP+nXBTbuULuktDmjDFqFz0G/Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738182011; c=relaxed/simple;
	bh=kkG5ZKf7tzgq1NjGVj2blFgnW7PEPrsDWFOteDZ9Lc4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UatXSQ3hb5UtiGMqZg1fxor9AVGrIppPaxzdgolHqoIRKbl5C3PF0+R9s7QPxUVuEQA0K5gp5kx6KqkxXIZj2gdhpb/prGSYZh/S+X3K5wKKCOha0FmhNm1S2KJ6hhqJjIQ2CGKTXkZUTzNcxkrr4sIg4ek4FgpC05REyVjpjZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2fMq3sW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2fMq3sW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E896C4CEE4;
	Wed, 29 Jan 2025 20:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738182011;
	bh=kkG5ZKf7tzgq1NjGVj2blFgnW7PEPrsDWFOteDZ9Lc4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p2fMq3sWGcJrl+TgwIqCv63KXMBf5nIF1f7cEBDFXUqfHwkbmOs8x4JPpWVCP+0mz
	 a2dm7ItdqfpyYxWH8JddQ64VDSXb8fFge7L0ciVw0HEIOQUGdltIkS2qJL6NBxOqgQ
	 FDBLR/92RReSkLiLPjem2xo25QuucpYNhMYURk14aUKsKi05ph1HPALdFPcCCtg5j2
	 UfWmDYIWSAjXUQf56JZMyO351GbK4oya6k/6v0pdqIrhoocY4ajzEmezU9rypWdxMn
	 lRhHKO0tJtyoURyQfA0i4zq4/udSEEPiVyu02HwP1MK8xcSfZP/SsjnxqSbHElGg0K
	 0a18U1wWYvMPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71882380AA66;
	Wed, 29 Jan 2025 20:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btintel: Add DSBR support for ScP
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173818203723.417583.3423789804982645705.git-patchwork-notify@kernel.org>
Date: Wed, 29 Jan 2025 20:20:37 +0000
References: <20250129025817.65224-1-kiran.k@intel.com>
In-Reply-To: <20250129025817.65224-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
 vijay.satija@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 29 Jan 2025 08:28:17 +0530 you wrote:
> Add DSBR support for Scorpious Peak cores.
> 
> Refer commit eb9e749c0182 ("Bluetooth: btintel: Allow configuring drive
> strength of BRI") for details about DSBR.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btintel: Add DSBR support for ScP
    https://git.kernel.org/bluetooth/bluetooth-next/c/dba215063a95

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



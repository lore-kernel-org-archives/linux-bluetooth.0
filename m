Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626609;
	b=GVYHcrXIc+NpPKA9IbwtZcE2iCLAweyI4pjveXTddkbvYte//Spy9WrK1ecd0YeF6O5d
	 gWmDNf0pCcljlN1Bciy+shn5xl+6xRNznD6Qj6alJDDn8d0ZVsam+cq9F7PPy3vqD3Kua
	 yh/ZEzO7tl9AX7HTutBXtIripwFpUbyq29VuESooALUuXgdKDlPx9LYLLGMxSXWNoK8Mr
	 dUBlUut5pGW5OxP9ZX1fDAu4CMzoAMt+gV35aVKx5LXY8YHDlTWHXZnrka6awaOA1rrf3
	 N1RbUzUk0H2o7GPz6b7yCQngfnChCe/hYP2kj/qyIjn/3Aqm5NHVluMwGggBo+gUauA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626609;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=O+Mf/YE9MBw8zFYvWXyCCZ0WJkatZqqdz3sH1BgD5GM=;
	b=1DWPIIbXPmTdpsxvQrLyCRwzZHQnFPLV0CPG6PmtuM3yFCMJ2yhLk7w+wjqeUKnLlHW7
	 7HiZgv+y+IvgeXRB2e8Xd+iOepVbFSGWZiz/NEeAeOYr10KhkrW02Ijhs1vy0ovDnNakc
	 KDTAeWLq7eDTzKDbuKI29mkkYbKeTko+2yihvOygy5XFYleHKZ5FhYOIKOYgXUKatn1eR
	 uOEYNBU4XU3m3PY/MjK/+7u+/fACQwrW6ECdCtuwv7TItWw8jlcO0/3DCGZ9FhDL+1b7S
	 4T6GN4EFThp+JhbHy0OpGRcb/nyJ/xALnkBocWFf3cdEmE3e7tGOCfysoydYbYNesOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PxYb+dhN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F4D606A32A
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PxYb+dhN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FAD1F000C4;
	Wed, 25 Nov 2026 17:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795626609;
	bh=O+Mf/YE9MBw8zFYvWXyCCZ0WJkatZqqdz3sH1BgD5GM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PxYb+dhNk9BdJamVVUdyOXSW0B4LCX/UxjqVz8aGYKKf81xmnvtXG8hBhEL6Qk75V
	 dmSrVUHTa4KIKShcToyCo8VxbZcAgd2625CNraOgsYGX8Qx20g3mRfIt1wILiEp6Pv
	 khwxaIco0CF0X+NaPVRCJl7OCAh7lHxpvy3CwP/DZyicfMzgS4Iew8NWBYKDcCcZRG
	 EdIvBltx9YcKHSxe+7GDeSUhaodPS2S1SawQ2TE0+ekl6ZM7oTfmpfFQVKtKcTVeMU
	 tSh2bckLZI3DcFQPiD0k2MA5ts9lfhKw0pWXhtPr2TFZJQBZ1UBM+PyVeROwwCzkfb
	 59LtJz6AsPOQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5B5E3380821E;
	Wed, 25 Nov 2026 17:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] shared/bap: Don't fail an ASE CP write with an
 unknown opcode
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179562660826.1207837.2761269908450253334.git-patchwork-notify@kernel.org>
Date: Wed, 25 Nov 2026 17:10:08 +0000
References: <20261124133112.3956249-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20261124133112.3956249-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 24 Nov 2026 14:31:11 +0100 you wrote:
> A write of an unknown opcode to the ASE Control Point is answered with
> an Unsupported Opcode notification, but the write itself still fails
> with Request Not Supported, as ret keeps its initial value. The other
> Control Point errors, such as a truncated or zero ASEs write, are only
> reported in the notification and the write succeeds, so do the same
> for an unknown opcode.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] shared/bap: Don't fail an ASE CP write with an unknown opcode
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0fd6851e16b1
  - [BlueZ,2/2] unit/test-bap: Add test for an unknown ASE CP opcode
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0dc9b0db1fe6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



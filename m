Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795462814;
	b=jLcjzAo2QPwCE1xe0XPtlHMrXGWf3QkpjvIbVEC1VNku1KAURXeL0jAXqtUCO3sC26Cp
	 UVoEYBfuGwAcSBpXH48SQpprPCUJ5JFqeBCYnLteWOPoXWiqoqfw0/hESrLxYpR4aAOyN
	 FIgAIPXpxzaW6GxkAyURKkrP7WMNUYKbizbcRfPX3Qk99E6sL/qE/gxdd6n7iKKyfbvvc
	 L1P700+r90biNPH3HVBrKrDmdwVSwKCraI8VtWSaLn4++f9zhC5D5StvU7syUIKAEsWd5
	 Ap2sGbEWTJ9KM/8YrAKkJ4k+C+j69CNRrQutUGBqQcxvQfqAWvve6GEpOdZf/rPAjpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462814;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=0VEwrGikg9I4DT4AAgV4BRGQXnGrBXn/3w+rkzJENGw=;
	b=a2+EF9VDB2+UYsUrhuPhpyjvl6htp/WlHFBkZGOW624U7qNVI0GZQqfB5wfvMXHIVNEf
	 3Thcz+cARzmN1WM58JMwlqtoGt1kidyoOOI4pVQ/5j6VDwuCcPaARtilbL/PCBuO9pW/W
	 /KxIh5z+Lbo9cuX9vm7FFBpuqbuu5lmLXfCrQLkxp1ioenY04ZFjhPv49FxoI9n/4b2yn
	 MLBpWhxu4o4rdRcE/JrcKsAxyBsGuisaD3eM15Q7mtEXy7ZEk2ZGhh7awyccJfCPVh2Kf
	 PXVmm9rC5B0Fh3eJdE11W2NOi5Ic2AqOGNU9ErMg8OR6Da/DKNaZICYFKhMcharv83w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mhm4BorQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE26606A31F
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mhm4BorQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DA41F000EF;
	Mon, 23 Nov 2026 19:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795462813;
	bh=0VEwrGikg9I4DT4AAgV4BRGQXnGrBXn/3w+rkzJENGw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Mhm4BorQq0L3EVpJ66CezhTXPLiY7Quf0OT7TwlVy1xbybdHQ6J7lzyiD7jgV/is+
	 PKKxEHXqH6bxhPb4MgjiXhHD+oPwxJSTkG6hW2esVf57SQy1yLJahw8lwh6yk7rGQd
	 lZAITz+QtzasSusfPUekdIZr/49bNZ4I84KgYQuzUcW4rSucZNh2cgYqcH3dG7okBT
	 BS17o4LBwdT6a8CM8WtUH+brYB6nhl0TQVZ7R8CskvwAxqkuVSyJ1OWsDGinFyd/RN
	 m4gYx+Z1oecDuBuK+ttFyIhmkPPAPnWBkzf8QEniJcHxOjY+apEoHIso8vkn3yuw6q
	 y/LP6fU9eJaeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A38D392EE3B;
	Mon, 23 Nov 2026 19:40:13 +0000 (UTC)
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
Subject: Re: [PATCH v1 1/3] Revert "Bluetooth: btintel_pcie: sync mbox tlv
 parsing
 with GP0 alive interrupt"
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179546281177.3078240.11094667377301570869.git-patchwork-notify@kernel.org>
Date: Mon, 23 Nov 2026 19:40:11 +0000
References: <20261123065523.2769017-1-kiran.k@intel.com>
In-Reply-To: <20261123065523.2769017-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, chethan.tumkur.narayan@intel.com,
 chandrashekar.devegowda@intel.com, ravindra@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 23 Nov 2026 12:25:21 +0530 you wrote:
> This reverts commit d572ea4b621ce60279da5179a0c338660c8b7331.
> 
> That commit worked around invalid mbox TLV reads by making the mbox
> worker wait for the GP0 alive interrupt before the target access. The
> controller must not see an access to HBUS_TARG_WRPTR at the same time as
> an access to the PRPH_DEV_ADDR/PRPH_DEV_RD register pair. Waiting for GP0
> is not exhaustive: it only narrows the window for the mbox worker, and
> there are other cases where these accesses overlap, such as the other
> users of target access (hwexp, fwtrigger, coredump) and the TX doorbell.
> 
> [...]

Here is the summary with links:
  - [v1,1/3] Revert "Bluetooth: btintel_pcie: sync mbox tlv parsing with GP0 alive interrupt"
    https://git.kernel.org/bluetooth/bluetooth-next/c/35eb0a106542
  - [v1,2/3] Bluetooth: btintel_pcie: Serialize doorbell writes and target reads
    https://git.kernel.org/bluetooth/bluetooth-next/c/4c7812123eac
  - [v1,3/3] Bluetooth: btintel_pcie: Serialize MAC access requests
    https://git.kernel.org/bluetooth/bluetooth-next/c/5bf3a9b6b720

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



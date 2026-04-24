Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5717261C
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777042845; cv=none; b=OWRsOd0H4bZUGoTtGLB39jepU4M9tPeTBH4QY43g211k0jAZya6zJgttLYmgOSBjdpiKOkuQmfZK4nk8DJI7jGc2u0mOFE+SbAYS0iJ0wVP+QBEOhIO4tqQ4Dtiy6yKT5PWAaCPMA+vt5jpMxcwK+9YD/BNhBFXDgfCa0gWX81k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777042845; c=relaxed/simple;
	bh=Euo05ihb06bzJNRm4+kktbkrlEx/+/DC5u5oIlL5bsA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VxGUNv+sMYsPlswKJRDsqUZ1QTxAFvPlcu13cBvW6lYRVWfgnPnTX2z5nAiGjTvqZug5vgYHnhY+2hV9mN541MuBvXAiVSFHx/GF4Z9REhwybr76Y/aDcjyhxtzyoJZxZ+NuJ9L+9TBrh0j3sc/nw4NZpOLLia0hXerPbv6hqXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPXednew; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPXednew"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733E7C2BCB2;
	Fri, 24 Apr 2026 15:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777042845;
	bh=Euo05ihb06bzJNRm4+kktbkrlEx/+/DC5u5oIlL5bsA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BPXednewlGGvaXCa9n1/0/LX4ppdqbrqCjpJNhmnBV3RFqVfIeun/JOS6jLS9rVsF
	 2rIN0KjAHk1uMr/VglGBimZf0Yn4Hp18b4+6eHDL1ttwiLgXTpuq1bWHz9797cehAe
	 n9CrVf1KsgMfx7+4aOeiOoDc2bzuGk1kCa50ooP7VRUukuBXDHzNBwzMtMp/CARez8
	 N7vKp8U+BdLnXfHuyyICCSm+7YJXPQ793p/DSbj8IZFOtEFD5qSzGMusw8j+3OyYTY
	 E04sueg7zq3nYERejWN/kiq7Qk0qH29O9fkbrg9DN6sgrscY7Tw6u0NjC0/xsbueqn
	 aj1KFPJNYg31A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FB52381197D;
	Fri, 24 Apr 2026 15:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] src/shared: add custom CCC callbacks
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177704280604.1575268.379209060856591313.git-patchwork-notify@kernel.org>
Date: Fri, 24 Apr 2026 15:00:06 +0000
References: <20260424042830.2374708-1-prathm@qti.qualcomm.com>
In-Reply-To: <20260424042830.2374708-1-prathm@qti.qualcomm.com>
To: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 24 Apr 2026 09:58:30 +0530 you wrote:
> From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
> 
> Introduce custom CCC callbacks to allow interception of
> client notification subscription changes. This enables
> stack-level handling of CCC writes.
> ---
>  src/shared/gatt-db.c | 119 ++++++++++++++++++++++++++++++++++++++++++-
>  src/shared/gatt-db.h |   4 ++
>  2 files changed, 122 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v2] src/shared: add custom CCC callbacks
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=83ddf46ccc06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



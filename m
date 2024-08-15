Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1111DDF5
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Aug 2024 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723750830; cv=none; b=heR378gBovDqsZYuz8FKMC+POy7VQpyM4vL5g4JYJuUa7fAKcn/F2QybuG07kGCIzLxFVSJd8v+gdIr1vor5yocJytex0JRoURA6ox90qQqyXnu9CEmsunECJGijUEW7DKe0hmTz29bfQYO4YE7PPgC/jo2/YPEpa8zPjqH62oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723750830; c=relaxed/simple;
	bh=mUKfCToN8PCzg0qq+NXwNaRwdfYde9d7IcGOyFXPMPs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HUMMtwlrRT5xHZYLOshwChtXitQgI6MWprDtRrZgR44feTbtvLld3I7bjw1Q/DTrVWF6faXKQrkbCxzkBrlGdHmvKcjZ9wnovaeO5kaVnO5u21JQr5/BU82bkJJ/UUqIODvfN3wUZI1E6JkgY/i0C6qvPtloY519ushXlY6WZs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWOa2bRq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWOa2bRq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDBCC32786;
	Thu, 15 Aug 2024 19:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723750830;
	bh=mUKfCToN8PCzg0qq+NXwNaRwdfYde9d7IcGOyFXPMPs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DWOa2bRq7ZhLXv2axLkVlAHLPpjGXz1lGOORnHG7HKp6iIxzXl00P9dTFkw2qHXLE
	 vWeaPsUaxw+PZ96HtB2Xv4pFmNYPAbriLJZKvGuorNefTP2OPeR/5RRt3EIXLjVSoM
	 1jA2JTvlTB8K5kT5fDY5rSGIUUorGV+4KOD1FjEUIntEXkPS8TD5hMEEuPskCQeVHK
	 JIGwx1gaA63bkEu4gobFwlP2e89O4Xthp274X5+n0inBW4WET/KqS1eQqnCN/sBCrF
	 cjCGQIPtkLXy2CIRsnoAWmzyrFAdc7rzotAcynZr4rOZIyStMb3eiPtWjfFXk8FpjO
	 4Mg+5kWkKp6jQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E6C382327A;
	Thu, 15 Aug 2024 19:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] device: Promote Device.{AdvertisingData,
 AdvertisingFlags} to stable
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172375082926.2993361.681534947581679230.git-patchwork-notify@kernel.org>
Date: Thu, 15 Aug 2024 19:40:29 +0000
References: <20240814185714.844117-1-luiz.dentz@gmail.com>
In-Reply-To: <20240814185714.844117-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 14 Aug 2024 14:57:13 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This promotes AdvertisingData and AdvertisingFlags to stable so they can
> be used by upper layers without having to enable experimental.
> ---
>  doc/org.bluez.Device.rst | 8 ++++----
>  src/device.c             | 6 ++----
>  2 files changed, 6 insertions(+), 8 deletions(-)

Here is the summary with links:
  - [BlueZ,v1,1/2] device: Promote Device.{AdvertisingData, AdvertisingFlags} to stable
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c315b42e0538
  - [BlueZ,v1,2/2] adapter: Create devices if they are connectable
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=939133293829

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



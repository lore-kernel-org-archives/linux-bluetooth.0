Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09EE343D6E
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761141027; cv=none; b=R2dUM7L7tCJS7Le17izG82ZEb7hil69/70HaDjsLm9j15eo0eNyEUAZumJuszyvltzjr8gXy+J2uHEClumUAhr4TpDmRhZEwA6wBbhkYjD3bFdmFhFt2KlXEkDDLQ4CojpBOD77K3yQQXperncjPC0iH4mFciPqBXrllLJdTbuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761141027; c=relaxed/simple;
	bh=flHt45U2qDBg4JqmzcyqU09KpREduhveIgixm6/mcs8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m8vRNHI0a/eUyaC+KRwTSpMHFfulFzKdKJaz2GsgBXMz8Qiu5PXS/4Q3IOGr58gELh1EiqVa6Ndk5NJHFClI8NfhtCzHcyGcHm11pMmfiKlokl8MO3OiVCn6UVdQLK91+KG6/Lp00yGvkvAzkVCoYbQwZpgDP+XjminecOXww8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ev5VKJbI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ev5VKJbI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C585C4CEE7;
	Wed, 22 Oct 2025 13:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761141026;
	bh=flHt45U2qDBg4JqmzcyqU09KpREduhveIgixm6/mcs8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ev5VKJbI06M4bndbYeg81E9ec3YlmYrrIwORcpx5h3N1P+TC7IDCL2XAhBWTgehXU
	 vjDIeW8bqGIpLJCCAQcK0TXNjJuunGpuz3a4uA4mgXA1A80I3LFLT1cow2fW629MdC
	 D3I5fpuXGpJlwP6Ag3E20mzzyouTBHKuUOVn5pddNBoHJlt3Q5CWoT4dNJHLzkA6uA
	 9NyFL0OJd0Y+W2FDpUOoGfrmhqEgI84xQzFdbu3BLIB5+iknt0Appu6eDr5xX3hw3r
	 gYy4gJlJo1cqllZxrSOKGv/0+LTAR2RUlU5PFqzeaTpSid9+RQL5vFrj1w0cfWZvid
	 aQgOMR/yEfBDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3803A78A5D;
	Wed, 22 Oct 2025 13:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/2] Bluetooth: btintel_pcie: Support for S4
 (Hibernate)
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176114100751.1909224.7378874460518342218.git-patchwork-notify@kernel.org>
Date: Wed, 22 Oct 2025 13:50:07 +0000
References: <20251015093903.480282-1-ravindra@intel.com>
In-Reply-To: <20251015093903.480282-1-ravindra@intel.com>
To: Ravindra <ravindra@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, kiran.k@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 15 Oct 2025 15:09:02 +0530 you wrote:
> During S4 (hibernate), the Bluetooth device loses power. Upon resume,
> the driver performs the following actions:
> 
> 1. Unregisters hdev
> 2. Calls function level reset
> 3. Registers hdev
> 
> [...]

Here is the summary with links:
  - [v1,1/2] Bluetooth: btintel_pcie: Support for S4 (Hibernate)
    https://git.kernel.org/bluetooth/bluetooth-next/c/af904d7aca72
  - [v1,2/2] Bluetooth: btintel_pcie: Suspend/Resume: Controller doorbell interrupt handling
    https://git.kernel.org/bluetooth/bluetooth-next/c/fc7c3c61efe4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1192274B29
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160162; cv=none; b=WVF3ImMqVekVglUvse5XMcen9vra3M/JdaZ0eLEOW68oE4Nf4VNzCGpWAY36QaI6c6tNlEr72gZeiD7EhOHlAWfbv5S3qpSK3hE6RopaHszNdssqCOLxxIk5+9t1OwCKItHUdPJAZQqYgPIqeaaqhnD4m4Qz7zGkkBUVVQ46WRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160162; c=relaxed/simple;
	bh=Fdp6rbvVmSKJNdONADh28nJySpnkgwb4laFxOSZf9n0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PXD4YXzZVcFGFujs9+LMoEF6aKoD5taI42R4oin76QVpAjPvA9/GzEG4NwnqtxLVYedUofp6yxUPdMlNgCINXNgpIaX6ppmcnsidu5iJgMidtekhCg84ibpOIO5dxeholXZyynjugrPQ0uctFaBk0mwt8uLX6SWYXzU/mjX8+94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8yMhy24; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8yMhy24"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746FDC4CEF5;
	Thu, 10 Jul 2025 15:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752160161;
	bh=Fdp6rbvVmSKJNdONADh28nJySpnkgwb4laFxOSZf9n0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z8yMhy24R3aJxuvUmU/miYis0HrfYsg7vhHBm+vpcn7SRCY02STNAtJgUqdCgTyVW
	 XuxBCuVexF1Ioy2avJh1t1OTPNBgWp6nZ3wn9tN6vPFhFLFai63CPsFJaGeha0zdRd
	 5PdTMAK7RbXqEAXNukVPI+3umXdoPacR1aRSZY+/h6NlwJmocoUUlxb59sQsc/yTZS
	 EJjROmqSonaxdPhd7Fz4mFxbbB15W9sRkAZf7hzSeVLbURRHTj/HjtdQ+xCNsLsGYW
	 Lb5+UICVFXrVFywLKIF5civrXZF7F6OSu4g+m+aBuf2jRIOw+4UqBZNFQTqUZxYl6O
	 SQiVZRnDdIDAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB114383B262;
	Thu, 10 Jul 2025 15:09:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btintel: Check if controller is ISO capable
 on
 btintel_classify_pkt_type
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175216018349.1518208.18021776664258298180.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 15:09:43 +0000
References: <20250709191333.3374053-1-luiz.dentz@gmail.com>
In-Reply-To: <20250709191333.3374053-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  9 Jul 2025 15:13:33 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Due to what seem to be a bug with variant version returned by some
> firmwares the code may set hdev->classify_pkt_type with
> btintel_classify_pkt_type when in fact the controller doesn't even
> support ISO channels feature but may use the handle range expected from
> a controllers that does causing the packets to be reclassified as ISO
> causing several bugs.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btintel: Check if controller is ISO capable on btintel_classify_pkt_type
    https://git.kernel.org/bluetooth/bluetooth-next/c/1eea42b9d33f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



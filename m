Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3C123B628
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 20:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753390790; cv=none; b=Kcs6qpp/xfLrIqqE23D2OFhfLcnzLEMhh53Aa5BZb7qYSkZ+wGv4P2jx/14lsDmBjRvcBs2esXEHtoxqm4leP2WyJ01vwoeQHhrf74NEm2aFms1L+LdGmIYR0ufgs5rZTmFk5DKqDZgUutTMWDwxme1kWVXxBMtY1a65e8lyPgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753390790; c=relaxed/simple;
	bh=0iVojfIH8mEUJPUwEPGahkQZrx5SK02Bbg2AJullUxk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kGqKofFQ1p87+aa/voh95stSPVyC+lPtFtVr3u7widCv9MW1VV6qf1xAiBSCo4JvEE6sCG9kjrVNmI4u6XPzdb2Z+E4oDhjvq1ydbp+NJ7Sb/wXjnqeA0h/1K3l3faj2QczxK0ToGQ8xJtJeiHA9SbPVDTdej3n2IkKno89svxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smMy2luV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smMy2luV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCDBC4CEED;
	Thu, 24 Jul 2025 20:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753390789;
	bh=0iVojfIH8mEUJPUwEPGahkQZrx5SK02Bbg2AJullUxk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=smMy2luVKpjzXoiDVVLozBDatBhyHL2S/PEIqjHqR3sqDPNQeZkb+Ynfutho6DGQW
	 RslLzEGs3yHYdWxSIUuNOcARNgqF6M7vEDxA//lbUEhFNKBdW6ax+Ae6np8H92ZbSh
	 xfgziF5LL+1IBR6SQH+OcLyRadjK7V1wU3pu1Hm/iZbdq0Phcz6xzYhnDQ25bHGZPz
	 mSJRANPxrp7uYwcRnG+lk5BTDACi5DMSycTCuN5ySAjvK3Fx8ybbOh3R9uHH6o1Umn
	 UdgdTeVjE8CNeAPtP+bhVg7xHjviPhb3+PXj6kr6ktINEMsa7a1kjueQVvjsCGMr49
	 9l3X/h8Oa0Vbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BA7383BF4E;
	Thu, 24 Jul 2025 21:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: btintel: Add support for BlazarIW core
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175339080700.2527392.18206587638228778171.git-patchwork-notify@kernel.org>
Date: Thu, 24 Jul 2025 21:00:07 +0000
References: <20250724122824.1347428-1-kiran.k@intel.com>
In-Reply-To: <20250724122824.1347428-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 vijay.satija@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 24 Jul 2025 17:58:24 +0530 you wrote:
> Add support for the BlazarIW Bluetooth core used in the Wildcat Lake
> platform.
> 
> HCI traces:
> < HCI Command: Intel Read Version (0x3f|0x0005) plen 1
>     Requested Type:
>       All Supported Types(0xff)
> > HCI Event: Command Complete (0x0e) plen 122
>   Intel Read Version (0x3f|0x0005) ncmd 1
>     Status: Success (0x00)
>     .....
>     CNVi BT(18): cnvi (BlazarIW) cnvibt: (0x00223700)
>     .....
>     .....
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: btintel: Add support for BlazarIW core
    https://git.kernel.org/bluetooth/bluetooth-next/c/e74375b59a51

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



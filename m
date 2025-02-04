Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FA3220694
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Feb 2025 22:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738709411; cv=none; b=Dr9uY1fBlLqZ2dA8jjseG6n2KIfCam8aqwtFyi6b2+jTbZSupoYT7fKXEwwKc7a9OR6BZdrqG7MI5DmDDrIzo2p9g+qTJD2c8uVDUfyDLInIvkcELYXSG4TJGKvBarpfSYneoQaD4RDVTHcng5eizUDIwMs931q4Irlrdx4nUP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738709411; c=relaxed/simple;
	bh=ImK0i2EqakioYxW+OTh5Mw7X2EEA98RhjrPKmVbg1aA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bf4yRhYjMHaNNGTqFCNU6UvZJbEvudHydZFYdaBLMU0Z8dtDbsAXnYly0s7OEh1Xipgp84IVTgOWFBBiXAT2qGZO1MbSstY4CSGgeoqiRcusTGzZcPtAV+P1lZP+iyCipA/K1Dn4K7Uar7iA6RdWKNKtCAHRA/s9+7AZHfV4gno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8aLw+JI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8aLw+JI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A677CC4CEDF;
	Tue,  4 Feb 2025 22:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738709410;
	bh=ImK0i2EqakioYxW+OTh5Mw7X2EEA98RhjrPKmVbg1aA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z8aLw+JIK3Z/hiu8v9n32PDFaBMQehWlwo8IC/erd21wI5lBFqoUmJtwPj0iR2vYN
	 5wdAkDTLChwjTGW0M7d/Bh6pEkFsLTSBWn6TlzLalMngNn2HSK00X6ws/i166pVOJv
	 YngV3r+e/tVjE3jlas5rbImFYsy7M/j7pPULPchDXpKulybLwA9dROqnAVTLpWAVEv
	 x1guKGxgj6h+lysoeJAW0cDNJ92X79KpXsDjyyaSCC4Sa9OT2/1/5eoJZSXdsljUdj
	 ED02g89O9RDg7bDKQ/LHJ2XhqXFYVwv+GqqOhyu9V6mLoC7lPc79hj0GfuowgYOeS1
	 rx7eF6poHHVRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D8A380AA7E;
	Tue,  4 Feb 2025 22:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] mpris-proxy: Fix missing line returns
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173870943775.172153.3877155288225799107.git-patchwork-notify@kernel.org>
Date: Tue, 04 Feb 2025 22:50:37 +0000
References: <20250204155025.96612-1-frederic.danis@collabora.com>
In-Reply-To: <20250204155025.96612-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  4 Feb 2025 16:50:25 +0100 you wrote:
> ---
>  tools/mpris-proxy.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [BlueZ] mpris-proxy: Fix missing line returns
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9839799b505a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



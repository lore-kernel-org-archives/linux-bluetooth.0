Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2F619DF4A
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751556582; cv=none; b=YBSpA4wACN87Se+8NtQ0ROxBggmDiPTzoND2ZLFAoa0tXudiDqRHL+vzWnDDqFOaUgTqLrghT2p3TI7eqJXYjo4j1k1I87Y9qxYvke4ppXvaEtbpDpuwAxDkhwpt6mukwcDQdMV5NZBcMWdApR2JXusaFs7BnQaoGl1/jg4IVio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751556582; c=relaxed/simple;
	bh=Br/HJDHtK0lII2QOzL5LCy93XAFa8PCIMWj5/QsGejw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rzgSvzOmFSlcspNg74Pp+fiOLAuQjMIXenAkGVPJqELDwU+WeI1DQ8Mp0rFr7zZrcKHCKPkFDs5V6+LOaGn19AOLyvjH403TrDVApwFE6WFmZJ2gxkK6z30YaLeUmKgCuDeHWd1Ib0Zzq9wQHGp/o2xfEV+uHLAH6sodECte9g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuXLZg3/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuXLZg3/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6C2C4CEE3;
	Thu,  3 Jul 2025 15:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751556582;
	bh=Br/HJDHtK0lII2QOzL5LCy93XAFa8PCIMWj5/QsGejw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UuXLZg3/C6HNIQxx8RoVwr24GEFTfNXlDaGK9mfhEAlPq8FySzDcl5cb4YEhlGDmr
	 whW1lb0fAkBGo7COqc4f/3Z2ZSTH3hKGV8hQ5dffxDtK4bAHpNLeKsUK+vH/fWY2Fy
	 jrykeK/gC5J8MOkAGRu5qVgZK+hMbWcpe9fhBuL4lxTnobd/rasigTHiVwxgRxxZgR
	 TZO+xJ6kx72EN25G58PG7geckzsfB4C9jHXBMovvMP8aeNb0ukeI0OdkBfbtjoIJV1
	 SgR4vHtwhFEfvB4p5fa2EtqEhh2u/o8DV4EaClcKq1ux6ohdLK6fRvhbikYZDZs41h
	 JjWTf6+Rnow7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BE0383B274;
	Thu,  3 Jul 2025 15:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix attempting to send
 HCI_Disconnect
 to BIS handle
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175155660626.1527541.6100753282429862146.git-patchwork-notify@kernel.org>
Date: Thu, 03 Jul 2025 15:30:06 +0000
References: <20250703141543.1726566-1-luiz.dentz@gmail.com>
In-Reply-To: <20250703141543.1726566-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  3 Jul 2025 10:15:43 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> BIS/PA connections do have their own cleanup proceedure which are
> performed by hci_conn_cleanup/bis_cleanup.
> 
> Fixes: 23205562ffc8 ("Bluetooth: separate CIS_LINK and BIS_LINK link types")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_sync: Fix attempting to send HCI_Disconnect to BIS handle
    https://git.kernel.org/bluetooth/bluetooth-next/c/e8eced7eae5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



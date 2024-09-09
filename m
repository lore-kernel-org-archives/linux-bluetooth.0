Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A032125A9
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Sep 2024 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725897629; cv=none; b=XbyrN6Ov17jaGVkiw+sk2euyfw05FQzoYd+SBMfwLpstCq8vgXCpQ8NDksEGKWTmHqwh2HaPy8xmldbB9BDZBbL9xHl4O43AciykyVULkG+hq4cE+2EECeVe0qoejzwOVUwr2Umu0K1ztucT25SbuFCew8tEEFWDjzqQcLBFBYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725897629; c=relaxed/simple;
	bh=yu3xKLjf6DHq02KXZWQzKnFxNzBGz3QFnyqnPMP3TR8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nKXAT+0CfxvLzHNpIfgxHbfzZHeGt13VDesWCZZiWaybWV1wCrV4Jc+qRCbaywaXAbfBAsViqkpwSouMiU5wIWNYWpLyo/TH4VaHZ910RG235Bs53jS7t1Do27pP0uWImUZpT2YE7bhg5UywjPfUTteCJdBKdEZ2SGNRHmxD8Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKvjYfnY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKvjYfnY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FD4C4CEC5;
	Mon,  9 Sep 2024 16:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725897628;
	bh=yu3xKLjf6DHq02KXZWQzKnFxNzBGz3QFnyqnPMP3TR8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RKvjYfnYa6/UcKeNy38L4CFuhHRpgH/Ja90hvihpxzdxXdAxSVDCZl+kRCW25gSx+
	 ycsF1kqJJuzQf/8TPlrfINx6d49XCamVgxejH83t9z2w7Bsb+YAgGAi3YO+P4YYjAB
	 ZSxAw0H0Wx8njib3iZFWUykvIeKeU7oORlkh9p9nJL29JTFftZvESSiYjCMe7/OIdP
	 Za0HL4KmChUm0MwfQml1DvxNgEste0wSx1gnru2GJYhhFhler/GzSCa8Vgx0bfm9Ao
	 JMVJWg34HWJDKH9Ecesf+vMNRBRJPQMl0+dC9A68noEnBqkPRbofw2lLcY1u1bWmC5
	 JP4C8S40e8VKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 344143806654;
	Mon,  9 Sep 2024 16:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_core: Fix sending MGMT_EV_CONNECT_FAILED
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172589763004.3841323.4176027351597379207.git-patchwork-notify@kernel.org>
Date: Mon, 09 Sep 2024 16:00:30 +0000
References: <20240830213835.1267643-1-luiz.dentz@gmail.com>
In-Reply-To: <20240830213835.1267643-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 30 Aug 2024 17:38:35 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If HCI_CONN_MGMT_CONNECTED has been set then the event shall be
> HCI_CONN_MGMT_DISCONNECTED.
> 
> Fixes: b644ba336997 ("Bluetooth: Update device_connected and device_found events to latest API")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_core: Fix sending MGMT_EV_CONNECT_FAILED
    https://git.kernel.org/bluetooth/bluetooth-next/c/6efcec8031c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C1A1A071B
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Aug 2024 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564236; cv=none; b=BaNpQ25RDB32oI1KRD3jYw9mCHl2EP2LtWFcdFpSFMR+086u5pZTJemf6mqqk2aRSwOWJq8Im4aLRKKpsqjdq7x5IXlb/R+/CwARz+buBBjTgCEvPPPxGKGNxsQEp2qfL46Mun65HtIvRG1ZjAqXoJWbYxhAOYnaHGpt3nQP08c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564236; c=relaxed/simple;
	bh=Inr35dFKkEh7S6Q8IF+hI2GHRF20WHLkI5lVR1dGLXk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PrZc5wowW4znM5m5A03b/sLqbt6gUTokoj2GTSbKsMRmMNsFZ486oe0E211nQy3n2wJLt7Btwjv+2/D+c899wvg9N5H8Kb9nFNdH9ITYDs8xdhoEXD4aYe5o3oU4eWJBJcv6Lkg0WU2PHGCj9eWXNEz6eyHnDRKURZe0bjWxv9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTaum4xm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTaum4xm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E06C4AF0B;
	Tue, 13 Aug 2024 15:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723564235;
	bh=Inr35dFKkEh7S6Q8IF+hI2GHRF20WHLkI5lVR1dGLXk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eTaum4xmSpQh83BaHA7AiPZkfvdYv2hltp8krXTaRx5mMaT79o7gtOXR3E2uIjwTN
	 snOfN441kQu7DiXnungXUYvhZ9WTZJc1utgnDf0fiTGod0NXYzSWOpmKkvRkzTnvVf
	 aYH+m4TYHg8xNNLdzuuuo114ICZQPnbZVisCN+o9QEA8BvYKadbnMu/thF1rT2D/S1
	 s1Fcb7S05VRnZK2GsvOQWtOhd2YEqk4YkLJ6BesbXOeJ1sqBFbL5f/47pbSGxy3Vr6
	 bly8PG0G2OGaXl7Ud+ZbXNFSQ3WCAJrAfwY+EQr+nxZ9ecTfTgYr2maXq1thhjeni1
	 AXHAqrvsaWVBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE933823327;
	Tue, 13 Aug 2024 15:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] doc/doc/org.bluez.GattCharacteristic: Add missing
 link option to ReadValue
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172356423449.1679641.1972016115099754139.git-patchwork-notify@kernel.org>
Date: Tue, 13 Aug 2024 15:50:34 +0000
References: <20240809152207.989730-1-luiz.dentz@gmail.com>
In-Reply-To: <20240809152207.989730-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  9 Aug 2024 11:22:07 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Just like GattDescriptor.ReadValue characteristics also support link
> option which indicates in what bearer the operation is taken place.
> ---
>  doc/org.bluez.GattCharacteristic.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)

Here is the summary with links:
  - [BlueZ,v1] doc/doc/org.bluez.GattCharacteristic: Add missing link option to ReadValue
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5236809407c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E02202F90
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739396406; cv=none; b=pTYvXFY1M73JQ/+6aBqlSuLWwEDhzGl2Rh1VeHF3lf/s/uoM7DQzqt60ArRpkXaKKz6CDn8HAHLQt5EpA0KS0hP5Vdg4sTyjwpIrifRaLyCx8j5/ksR7+WR3EHu8wr8ZlmLXiXV7EePvy7KNOK0ibm6t4RDbbkp/ChibLDnDQow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739396406; c=relaxed/simple;
	bh=qeK6JsmGI/ls24hdjpp9vJh3MCGj7o7G/DH4GNRsDPo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WUnxQ0fw3oXd19LZxb9X+rKIW5CaWjd6in3k+nSHDgrtyOqoNZ8/JxvikPA51RS9skXb3eL1PYaVIq//pCSXlf/NblmFHwbvB1NTPxw9B7BtK0YGz3auvYUnxwri5A0bHdrWe6E4G9RSxfF8rntqC9pSF9pi92jiB46JDIbiZQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpyPSwk2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpyPSwk2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34058C4CEE4;
	Wed, 12 Feb 2025 21:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739396406;
	bh=qeK6JsmGI/ls24hdjpp9vJh3MCGj7o7G/DH4GNRsDPo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XpyPSwk2AoE3hEmdDktcR9ZViuXziNFF2Jw8nY38STcYNPTJFbhAzYCbh1aJFsI0b
	 CKQ8nHirJKXfy4tSYCIIjtX4yLs1vQsrGk5cFl6Ax6to5uvQD1xZcWhCedVzOcyOfb
	 n8fVleRIChHGdCbIbDY+sSelCNVrVOL4flV16dJnDD0Xe67a25Y32KOujYj238JUXx
	 MkSAeUgwqsBsvIZXkN75cEmqLaCEKazshd8snyS6wVztVVwVEUZVbn79A1/TQEyg2o
	 flEOfg9RJOEm3xRZxrZqr3fsJlSLYZKDBUwiocfUJPZhM6q5uN5V9Wthwp55FPN8KP
	 SURorzVI3epfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F7E380CEDA;
	Wed, 12 Feb 2025 21:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] bass: Register bap attached/detached callbacks
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173939643499.667348.6080977145685830613.git-patchwork-notify@kernel.org>
Date: Wed, 12 Feb 2025 21:40:34 +0000
References: <20250211141936.23372-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20250211141936.23372-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com,
 luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 11 Feb 2025 16:19:34 +0200 you wrote:
> This removes the bass_bcast_probe and bass_bcast_remove APIs, in order to
> decouple the BASS and BAP plugins.
> 
> Instead, since the BASS Server (BAP Scan Delegator) implementation needs
> to reference the bap session, BASS registers bap attached/detached
> callbacks with shared/bap.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] bass: Register bap attached/detached callbacks
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8fa5584e5632

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF9C1C68F
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 14:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777041045; cv=none; b=fi6YCXqY+MqMCACsXUNEcLjM7YLIXWoMMWiKhsslEFe0UsvgLSrvsfiATnHQdkV0w31OQMj9fTfRui7xbqh/FkjB4RKkzEi+HwL2mFR9FVtFUhBLIXJ/oI7NoPd71nm8osN6ST72+droGzT/0noGhO2kqTscaN3pEaX5azAK10Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777041045; c=relaxed/simple;
	bh=+HBLPih0D9TYCj4iEJC/SWLA+/XEQCh7GzNQBSjxGv0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VHh4yDbiz1onnSLSUMtVZi+6eZcJEEAieeNQHycLBuEgQMs5CWzzDjQaQ+LWoMcoTzxBzmDIwNis2o7KvVYRJVPbBYOapGROogKD3Tm5bXa/LR092cXrKXQ6ga/0Ip1r+tVDgBIWL3BxoJpCRebxZD5BfNVz8EP8e6147f4E4gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbLAGkJx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbLAGkJx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37ABBC19425;
	Fri, 24 Apr 2026 14:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777041045;
	bh=+HBLPih0D9TYCj4iEJC/SWLA+/XEQCh7GzNQBSjxGv0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rbLAGkJx92b/3vOB0EBovzek47qrSSQ9gw+tFlMm7YBhz6tRukQa7pUyBj4cxARAz
	 0dzD0bGTe7VFOeuWBHSnPMfdXrR2Atj/bltxMPLeayrdhWvPBdZR3GDm1sWA8dWC5y
	 cQ+I8dg46k9MOzYXPy1r9NqPy3dGZb2CrrneWIqAJaPudddnqXo3atlHh1AFeY+hBJ
	 5vuGFyvvtsZX6A8RYOHEAjobmmVqxiXYqj4G2krwasbm9jfsgpHfa/E1KmSyTMMlcX
	 KpbURcQIuw03M7BMusKkKNtJkdCiR2rDHphK+nNdq8YnyG+NHk/+fha2YbRoH3KFAc
	 gCKpI9YMVOYUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C7E381197D;
	Fri, 24 Apr 2026 14:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] sixaxis: Fix pairing Esperanza EGG109k
 controller
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177704100580.1564116.17907227393597169449.git-patchwork-notify@kernel.org>
Date: Fri, 24 Apr 2026 14:30:05 +0000
References: <20260422212045.1325603-1-ma.czerski@gmail.com>
In-Reply-To: <20260422212045.1325603-1-ma.czerski@gmail.com>
To: Marek Czerski <ma.czerski@gmail.com>
Cc: hadess@hadess.net, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 22 Apr 2026 23:20:45 +0200 you wrote:
> This change is required for Esperanza EGG109k ps controller clone.
> EGG109k looks like PS3 controller but presents itself to the system
> as PS4 controller. It does not respond to 0x81 command.
> Command 0x12 contains both the device bluetooth address as well as
> configured host bluetooth address, so it can be used to query
> both. Kernel driver hid-playstation also uses 0x12 command for that.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] sixaxis: Fix pairing Esperanza EGG109k controller
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=49e2a15adc79

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



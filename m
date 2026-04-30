Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1114D4279E6
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777560055; cv=none; b=kH0h81YQmul3etEqe8K5lS3Qq3KLlAmccEYhAcIiL+f+6qJgskMS/1wc5y/rTyk27QCUEzsMZQJ2XM2fhW4+GSkIsCty0Hf3uopIrRMlkdUvZtMsMa+MXLTEczYG+RtDP8ii+dDZk1GNo+KHb/e4px/FMYlIlKlB2h4ELybHLHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777560055; c=relaxed/simple;
	bh=sx4FsYNxWbLGVa4k63MfjmtbwBUhpUyO+5K6NE5mABk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UTvYfB3NUmc3PFLsx7voTrWT+eB3d1+7qmibu1VQ0Y3fZ+Bdf+medEXuJyEa3Pc3QiO5mJBLkOf9i+5kwQGvaQhYXnQxQK7YFoPRf7AQCl0XVYEha5hVUYUY2ShDw9W0BS18ZH263kd/XlhZgN4BXtXPNHQPzZYPwMge67grWEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVrWx96+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVrWx96+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE0CC2BCB3;
	Thu, 30 Apr 2026 14:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777560054;
	bh=sx4FsYNxWbLGVa4k63MfjmtbwBUhpUyO+5K6NE5mABk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lVrWx96+wo/JMxFbpnU9E2dDojxf7zxQRnPYf/vbbljW7dNA8DU8DQ2Uf24gA9DxY
	 1ZLW/hp73663zMwrXRyIgAS/oNVoxQWkYbGCO4cTxtqLWP4Ihf9JrgtVpmbRkxQcYV
	 qMfARY4VeYU40fZ1slE5GTsSNmqg+thIxcGTfTpErCn9yEALmIWgF42hhTypeSoepl
	 ZaCMLfAiLFTYtzkp1pgPq/OyCgroA7I8psxE2DdoB8xnBLBKxGMU6sQbNdzp9Xx+kt
	 OSBjGhvR2kLnJUZG0BUN5cSdoYex75CZQXqk3J+o/34fl2SlXzF1WCrqYIO9lZzC5a
	 O07z7Fjr17LyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD9F380AA5D;
	Thu, 30 Apr 2026 14:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v4 0/3] Add RAS Packet format and Notification
 support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177756000929.3037252.13217626033172541746.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 14:40:09 +0000
References: <20260427170007.1282289-1-prathm@qti.qualcomm.com>
In-Reply-To: <20260427170007.1282289-1-prathm@qti.qualcomm.com>
To: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 27 Apr 2026 22:30:04 +0530 you wrote:
> From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
> 
> Changes in v4:
>  Fixed declaration after statement in src/shared/rap.c
> 
> Changes in v3:
>  Fix for cs_mode_one_data struct members rearrage as per spec
>  Reading of cs_mode_one_data in rap_hci.c
>  Address cs_mode data struct padding in src/shared/rap.c
> 
> [...]

Here is the summary with links:
  - [BlueZ,v4,1/3] src/shared: Add RAS packet formatting and notification support for CS reflector
    (no matching commit)
  - [BlueZ,v4,3/3] profiles/ranging: Read cs_mode_one_data members as per spec
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5d4792dc2a20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



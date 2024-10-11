Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4D5193436
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728671545; cv=none; b=HWo8LQG4L1lDV/+78NocUkltge9fLOCgDjkIMTMEhNHsk1unjKsipdhISP/y2Ed0fhJ+2kxzkgf7obpMvGKZO0BMPd1bvbGWNE59Z5nKYhsFc4MvYk0fu1Eai1jnA/d7dfIFRTkQYPzaR2J2JUYAYvcDyZqB2FCXiV/ZHxXZaGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728671545; c=relaxed/simple;
	bh=qkNXACsxHNsEpuXD79bUysg6EHA5xbZpSUOB3KSpY2A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m738/cZBPkVlNdNod3knXoT7/xBqZAeapNY02w9yb/ck6yvXDwBL66CcSR1U26RgGwi5CNAXrAtS3MvjWOBERPoj18nWvVscJbCKqtS679gRBJRad416N3xJr35HoJkc//OVohG9FBKOVyQIhE1HFU5cxgQxpQ5RMivjRTDLw5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czTzHxrw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czTzHxrw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C65AC4CEC3;
	Fri, 11 Oct 2024 18:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728671545;
	bh=qkNXACsxHNsEpuXD79bUysg6EHA5xbZpSUOB3KSpY2A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=czTzHxrwgmJkFqXyRZGTa3iwimVyZbHSroCc40sl6Droz34puSRZ4hU08WrOFbJlT
	 kmrswq3xDCqUveXVWgxdK+EJUlMAtK9ZZ6enqg02HDrxVaB+IZFiNUaqHLkLz21FRg
	 IsY3YQtQkczFzwey7A43368hqOjFv7Uy5LghaG8mX9x8EP4mQpVVT4ysOWBxWDh/bl
	 xDX/hE+HrE6+BMJjMwXfu37SfnLsDTAIaIwjEWoU4w6LIG9PGfuM9ooQReqdmOUdEJ
	 do8RGnzl1aOuEgLYddddoGMQDJxZcIARNuCIYkYuwJgK52zIDlp599dl61tWCIfXkI
	 vKs57M2MTjhWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C38380DBC0;
	Fri, 11 Oct 2024 18:32:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/2] Bluetooth: btintel_pcie: Add handshake between driver
 and firmware
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172867154974.2893426.13679059675627500735.git-patchwork-notify@kernel.org>
Date: Fri, 11 Oct 2024 18:32:29 +0000
References: <20241001104451.626964-1-kiran.k@intel.com>
In-Reply-To: <20241001104451.626964-1-kiran.k@intel.com>
To: K@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Kiran <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  1 Oct 2024 16:14:50 +0530 you wrote:
> The following handshake mechanism needs be followed after firmware
> download is completed to bring the firmware to running state.
> 
> After firmware fragments of Operational image are downloaded and
> secure sends result of the image succeeds,
> 
> 1. Driver sends HCI Intel reset with boot option #1 to switch FW image.
> 2. FW sends Alive GP[0] MSIx
> 3. Driver enables data path (doorbell 0x460 for RBDs, etc...)
> 4. Driver gets Bootup event from firmware
> 5. Driver performs D0 entry to device (WRITE to IPC_Sleep_Control =0x0)
> 6. FW sends Alive GP[0] MSIx
> 7. Device host interface is fully set for BT protocol stack operation.
> 8. Driver may optionally get debug event with ID 0x97 which can be dropped
> 
> [...]

Here is the summary with links:
  - [v1,1/2] Bluetooth: btintel_pcie: Add handshake between driver and firmware
    https://git.kernel.org/bluetooth/bluetooth-next/c/5ea625845b0f
  - [v1,2/2] Bluetooth: btintel_pcie: Add recovery mechanism
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



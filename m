Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B21316CD0A
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Aug 2024 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722500435; cv=none; b=BudKZrL1+FWpljiBuc6fb6jgKHMIrhYBn2u2ZVFuW8nopl1O9RsiG0MZGyCoHIAeufdX5EcX2qAA3jIBNSS9VHACu2wqrrIe6xbQSpPtoDXKf2gK+ciU81u8+2hObpFp+oq+0vsGpX0Ib+ZbBoXs/KR+4k8nbKy3LhnPpwcJeU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722500435; c=relaxed/simple;
	bh=AP4quI6GxWZtRg2vXhA2aovuAj49mpN+kVXNIoxmvZA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V3YO6sQS3Bz9DKmbMXwqRi8S/RpWh6bWAwPX9pc7MZATrXMzBfAp4fMt//5JrQOPFVZ1UDSq4GM/OBSJYj8ZF7QKv0myzwDN1obrSCxGf9tBTt6xB/1qSEMrzLaiJN6OS3GX6j6MUydwpBfKrq/P2HlBqiskuBZWzcwIjymP8tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiVIAm9v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiVIAm9v"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14DC6C32786;
	Thu,  1 Aug 2024 08:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722500435;
	bh=AP4quI6GxWZtRg2vXhA2aovuAj49mpN+kVXNIoxmvZA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AiVIAm9vzKVRqdjqftoLYJu97xZ0RZ3J9IF0cbw3DCX+W8Mc6lR9icBcR3oHMoMbo
	 9q0Liv3piJBDNN4P991/5FVnugBHU3tPsW8u7HFt/Kdo7eiYh2r+JIeZNoGcd/VdQ6
	 QWfagTBA58ORIqjqo7ORqWadG1xZ0voscqrLND/H8Za2ql5ywaWo6c9VWdpRr5w+iJ
	 +/P3p5i2FdyQh1lwEsBVBUI8yJrZ3MbFn0ErnjGqRyGd5qAVG6s8F1PtWGn2gW9pM/
	 ceTnoKLvhdKVhguIWwPKEAMAKvU82XeObapfm+35o/ekvCfuXMGJfcASOVilpIwrHJ
	 itO+/Ja+7LpcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B3B9C43445;
	Thu,  1 Aug 2024 08:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_sync: avoid dup filtering when passive
 scanning with adv monitor
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172250043503.11616.3247724024892353101.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 08:20:35 +0000
References: <20240729195810.25040-1-anton@khirnov.net>
In-Reply-To: <20240729195810.25040-1-anton@khirnov.net>
To: Anton Khirnov <anton@khirnov.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 29 Jul 2024 21:58:10 +0200 you wrote:
> This restores behaviour (including the comment) from now-removed
> hci_request.c, and also matches existing code for active scanning.
> 
> Without this, the duplicates filter is always active when passive
> scanning, which makes it impossible to work with devices that send
> nontrivial dynamic data in their advertisement reports.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_sync: avoid dup filtering when passive scanning with adv monitor
    https://git.kernel.org/bluetooth/bluetooth-next/c/2360f368524b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



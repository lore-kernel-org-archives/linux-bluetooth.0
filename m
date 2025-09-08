Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D6647F4A
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Sep 2025 21:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757365815; cv=none; b=h1u7I1sxsDUT4t/kNHeMG97wIk26UwpG52P6J248Eze2C+ESwHTnNHfiFIMWzmLD/DOIQYFDNyflA5RBa1dvZeVevB0rBad5aSdhvyuE4ezy4dVz6vt+n96f4cucjZUSM5CFcwnixQs1N5XN9j2axqm8MTT1MwyalHUtx3NqsIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757365815; c=relaxed/simple;
	bh=l6XwXUPlz0UFMTgYR/TkTarO/YWo/NyM4hp1SEkWc0w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xym1kGolKh33XU2EWYKrx5/NfJI6WSZUaqGWyeF4en9mU27vIJ6fQmG3h8bnDjOEOYHlYqF+/nxdHzPO8dUdSPo2eL1i11rLpLns5Jjt5s6U4Qj0S5EFQ9roYM0I3wwKAJgK/T785PRQ3e3++0hg75hSxWo+e3z24UpGRlOZf5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uj83teUN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uj83teUN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE38C4CEF1;
	Mon,  8 Sep 2025 21:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757365815;
	bh=l6XwXUPlz0UFMTgYR/TkTarO/YWo/NyM4hp1SEkWc0w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Uj83teUNJmF0Md2bhp82nBc3+wZRi2kpa1f4wmcS2HMuqSA4utawYxAvN1uvEkaMn
	 qkSyx8KUas5gOKKhonHjJfxVD7NodWzQaGF3hK9hXMEOj3p8K4wl/HHAdD4xUlYyuw
	 zfQeFA/S+fI5lG92PiirnoafaaNRgfuE3Rj8XkqK7h1lyphreCCPjZfWDWb8ifs3RS
	 ObxK1YN4JlMzyRUPaSwYdV20alr7r3n7onNWbUgMevkA71hLzHmCf/RUlliepcwt5/
	 6MTTihtZPBYCRNeYFGjU/CDblNwdZbumOZvXRYHDh7jyB0+SlKeIpBoTfLJHdR3L9U
	 FlGhz7oG/Ui0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD40383BF69;
	Mon,  8 Sep 2025 21:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix hci_resume_advertising_sync
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175736581823.53470.3148274535105183249.git-patchwork-notify@kernel.org>
Date: Mon, 08 Sep 2025 21:10:18 +0000
References: <20250905143341.908473-1-luiz.dentz@gmail.com>
In-Reply-To: <20250905143341.908473-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  5 Sep 2025 10:33:41 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> hci_resume_advertising_sync is suppose to resume all instance paused by
> hci_pause_advertising_sync, this logic is used for procedures are only
> allowed when not advertising, but instance 0x00 was not being
> re-enabled.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_sync: Fix hci_resume_advertising_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/a0a2dcf8479f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8254B13D51E;
	Mon, 12 Jan 2026 21:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251687; cv=none; b=LNTHKFmTN46awvpDzfpSaIqKjn22cbXkpqmdkY6oNUvF8YIPTHu+940tGpeMMmm61d+2osp7Nc5HguJsQQ4IDEwq4onh9Xg/H81Q8w9FS5yh4nBh3yjc/NQIhWYvTODkj/f6n61YaiDKWVBtF0YMrQzYDkB/l5WWUpM6WfkGg/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251687; c=relaxed/simple;
	bh=a5tl32oQDWiyfGYxEpc4tuxagO3VmpCmESUmP6Zzm+s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JSJRZbgcBZc1s4JE70dV57EAr066SjiA56oXHYmAXmEqX/BPMcW9q1I6l+aDD3T7vKkI8hlOpb8ktcOfHY2sox+THO2mjaL0eHlbGVDNDtOVqJ+g8sXVkppenGqb1xhqKIpaopfmOWgs753aVvmXy0DSk0jcUl92CXxIxHKBPOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rqa8vDSi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rqa8vDSi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507AEC19421;
	Mon, 12 Jan 2026 21:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768251687;
	bh=a5tl32oQDWiyfGYxEpc4tuxagO3VmpCmESUmP6Zzm+s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rqa8vDSiRrfq82yWYr1Vis+FxH5w5OmIpAok0RR1Ak2754evO+tQgURexi86+uYiH
	 6QW1vMIeyBEkUHlHu8QAoCkgNku+40DIWOQvfMJcBDEGfji+fGAabNmdXBAwYgHgpp
	 qZFtf55I4Y9fnjZ6+zyJjP190r6Dyiog6ZP6Fwa9nzsNurifgGtQieTvlw4xN8Ycas
	 ZuY0o7+1p62d3xixzT1UPdJlP+K40i/eAhCE+2yDdsxG4PYKrWYJ9zTIPOsWMF4D5C
	 ExEeC0dm15Td9fbU6W6pOh2vfJ7jFjx6MzM2kfKaOYD/7N2PpH+g+hl6E2Wv+Y0BEy
	 ubX6vCEo0x2Xg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78A0C380CFD5;
	Mon, 12 Jan 2026 20:58:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] Bluetooth: btusb: Reject autosuspend if discovery
 is
 active
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176825148102.1092878.6122190385878576591.git-patchwork-notify@kernel.org>
Date: Mon, 12 Jan 2026 20:58:01 +0000
References: <20260109020538.2803094-1-lilinmao@kylinos.cn>
In-Reply-To: <20260109020538.2803094-1-lilinmao@kylinos.cn>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  9 Jan 2026 10:05:36 +0800 you wrote:
> This series fixes an issue where USB autosuspend during discovery
> can leave the HCI state machine in an inconsistent state.
> 
> v3:
>   - Export hci_discovery_active() in patch 1
>   - Use hci_discovery_active() in btusb in patch 2
> 
> [...]

Here is the summary with links:
  - [v3,1/2] Bluetooth: hci_core: Export hci_discovery_active
    https://git.kernel.org/bluetooth/bluetooth-next/c/e133883028d0
  - [v3,2/2] Bluetooth: btusb: Reject autosuspend if discovery is active
    https://git.kernel.org/bluetooth/bluetooth-next/c/2e5da9653691

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



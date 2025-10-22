Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608A226ED20
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761141028; cv=none; b=rBi2EhzLABFmboxgAb4X2gNugFQhvkFyAFZTxUCs98Ci8sKqHiQWtzmD6yXl0ODajlC/6EXZCcUIcOBw0lXc+VKge5QJDmpX0QOvmaOqMQ2tWJZjNepkaMfxYa6QAtAhObZQzQDwNTdvaDJa2KOdtw/5tjUQEYAKCqFnfCL1Stc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761141028; c=relaxed/simple;
	bh=5miAD+m11aLqjaPkkgxDCqeZZOO1O4JQ8MEtpLwf+BE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E7gimCoC7OHFeAseDLq3E5kJnfDde5ALd0/wY7jLAd9QcAsJpc9j4Pl2BRfOMST8i2shX4dGDVGKayiYlVL0C4Mo9vtW7lcAGGYbBkdNrlr5E9JDaXs82/an6KREvxhgHObfcq2jwlePaXEmUO2HDCd+5xsH9Cp1d4ZI8GqyAjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGJUq4Tz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGJUq4Tz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FBFC4CEE7;
	Wed, 22 Oct 2025 13:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761141028;
	bh=5miAD+m11aLqjaPkkgxDCqeZZOO1O4JQ8MEtpLwf+BE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rGJUq4TzILj7vlxI4F9vqqEnSv9ePUSp5ApPmLn0ZhucLPs9dBeRqghS7o22ikzX2
	 qJ6FiIqoZQ2rH0NvPHc5iQsqXr/4r566DpncgeWsrpOJ2aRvmTct6ObkqGhYJLxLQ9
	 QBbiW01l3COwiPOm/vACMHQn8779Ok7P9DO3H9JGnK+8PSOjCe5zPGTlkWQO4JZEjm
	 0WIUwEXfKKxAMicD9N0dZQpjXJXSl8auRgSv5NGu+HLTefG/c4eZuRdn7CH1Eai1To
	 d11lD+AwkWvVoCXx2oXidIAW3NWpXRO5YgCq6lzbJlYb6EBbrRak8KgFRZqwUly6Jy
	 +LpRBHIPvzA8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BAF3A78A5D;
	Wed, 22 Oct 2025 13:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: Fix event packet loss issue
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176114100898.1909224.9174915256157212223.git-patchwork-notify@kernel.org>
Date: Wed, 22 Oct 2025 13:50:08 +0000
References: <20251016043043.2582230-1-kiran.k@intel.com>
In-Reply-To: <20251016043043.2582230-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, aluvala.sai.teja@intel.com,
 pmenzel@molgen.mpg.de

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 16 Oct 2025 10:00:43 +0530 you wrote:
> In the current btintel_pcie driver implementation, when an interrupt is
> received, the driver checks for the alive cause before the TX/RX cause.
> Handling the alive cause involves resetting the TX/RX queue indices.
> This flow works correctly when the causes are mutually exclusive.
> However, if both cause bits are set simultaneously, the alive cause
> resets the queue indices, resulting in an event packet drop and a
> command timeout. To fix this issue, the driver is modified to handle all
> other causes before checking for the alive cause.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btintel_pcie: Fix event packet loss issue
    https://git.kernel.org/bluetooth/bluetooth-next/c/f9dce2067c2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



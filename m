Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DC2480DC5;
	Mon, 14 Sep 2026 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396281; cv=none; b=u/LSRwsDVL3xqheSkE2wN7Iwpeu3wu/3e9nzt/Sv0gxT7N2NFN/6mzqC9tbnnHsQp/w7OCwqlk4vEGmwZxjKuKI30pgOL3aAoSLQLGQvHrUf79EkJoVic7e89ptAHsFPTQrnLjnlpX+lvjHhW1PTcUH/y4Y8OA0WnIb8vzkDIhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396281; c=relaxed/simple;
	bh=bTN2l5ZIqKiJqWKlOiKKp2TQhRUJd/+y0OheEe4PP0c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=desWEmNfKLrpZ9d5pdrsnN6jDLEbadEftJJnOaKunYZtp01bRzvSBLHydXn4Q3QJ4PAtCX3ZC+BZm1nRef3uyZx4BA+tp5b4/rI7EZ8MKkhTRv3DO6YcQqr4SNlTW0CpTnDVdHC7tD9SvwH6dSowPdX32GgChb52Dk7MFhMlcTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3nRC8BU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3nRC8BU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E593A1F000FF;
	Mon, 14 Sep 2026 14:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789396279;
	bh=EFD2D4SPUxeBlh2KahNZJGsfd6oAGLjB0oeZGtqFbpE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=G3nRC8BUmc6wcIVIgTfqQ38RRfmqa0aSZIrNF9zmIcvHrs9JXDVLHgSu+qrGgjsu2
	 OjNqa5WwRU/j8jsQbzh0y3kjhsMe5hf6hiVX+dg8rgq/0C3XcBtYF7vV1oC4iuyvH9
	 Cc9EEb+DnFG1keqZOVaMFnqV5AtZTwzPZ65RzZVAaJA1jmG3WKw3Ht/yIZDjEeePGt
	 yH3znpn7jL+Lp1ilrTG+6PEsaO6M6rlFyoOcQNrKKWYjujDewF7+eCjGk/7mXa56q0
	 EaBC1WtP0yKz8Q62gLC0tn9VOzErm3Bb25pLNoQF0WgSbhzCj/dixeMWG1DHPkpNi/
	 MLXtQGokG+HQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56BA23924A67;
	Mon, 14 Sep 2026 14:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btmtksdio: Fix spurious ownership error logs
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178939621487.604238.1920363248100368230.git-patchwork-notify@kernel.org>
Date: Mon, 14 Sep 2026 14:30:14 +0000
References: <20260914094631.3222026-1-tzungbi@kernel.org>
In-Reply-To: <20260914094631.3222026-1-tzungbi@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 14 Sep 2026 09:46:31 +0000 you wrote:
> In btmtksdio_fw_pmctrl(), if an early operation fails (like clearing
> the mailbox ACK), it jumps to the `out:` label and spuriously prints
> "Cannot return ownership to device".
> 
> Evaluate the ownership return errors locally to ensure the error log is
> only printed if the actual ownership transaction fails.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btmtksdio: Fix spurious ownership error logs
    https://git.kernel.org/bluetooth/bluetooth-next/c/382fe279b7de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



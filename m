Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B3947276E
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791297017; cv=none; b=DcQOO8Yq0S0V6hNd/baQTAn/RyTO3yfj6Nc0YhkaaB+skFhvB4WY0nCln8kJnLLlxOMbzndJmy4pUD+nl44og1/twgWw36Co+keH7KUtGFwC1+TT8rmyBC3iLrEWQEnTi0esnqZ32s9gwggGvm5PbZN/KpoQ8+9q1vmL4qp/VpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791297017; c=relaxed/simple;
	bh=7I6UApENle9ejgjeUudENvj5dAlyLdI9Sa0aMW6fUjs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=apVy0+6MZlT4VZo/XhpqdZ8zX/PfV3+SXceLRqdes1SLMQXebUsKT4B92rOxyKKWkKM9/nKHmpU139qJkHWjJoyaMNuXgYAIbW9DYNZwKDAPepIgsnemF6zi3tIsuv8qnFpYwB9o+kRjsKTRlT3zrwTzf7BN+qxi2i+AXpmU910=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjVb+tQO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjVb+tQO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD4C1F0089C;
	Tue,  6 Oct 2026 14:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791297015;
	bh=0EKiIeajMykvy3jk40Qfvu5kWD2M9aaMCb7OLgXx3eA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SjVb+tQOqbAfmaSV8gNJOdXswdWSm54RXMYvdnWbL/ftCdS9Et+8UI9BaBxI93prU
	 7PVgYZMNtNAYoW2267ZDX2rfQdQgYQE5qdbbZPEMa7d3mJR5LW44Rkdm0psOixeCH+
	 VpmB+3dU346hBF9U6CrD/rKp8LaEArbGl3EfZLPXy/58fQO8RwuQ/Pux9B+xRtcVKq
	 FnW+PLrhhd7lTmSAnOwpTZ6aeUcdSnOQuECAzkNq2xpDIguPAVggwubfKlh/dOMFlK
	 mYc7+bYJt+qFd6dRdzpD9946ttYr/wzs9ejRYzr36Ryff0QrL2IuHhi+kWlXiaNjgF
	 E1F2z4p5TJkSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774DD39D5FF3;
	Tue,  6 Oct 2026 14:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] Bluetooth: hci_sync: fix mesh adv timeout units
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179129701402.2655967.18407429567239565101.git-patchwork-notify@kernel.org>
Date: Tue, 06 Oct 2026 14:30:14 +0000
References: <cover.1791223958.git.pav@iki.fi>
In-Reply-To: <cover.1791223958.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  5 Oct 2026 21:13:53 +0300 you wrote:
> For mesh advertisements = adv_info::mesh nonzero, the time units are
> milliseconds instead of seconds like normally.
> 
> This was forgotten in hci_schedule_adv_instance_sync() and
> hci_enable_ext_advertising_sync() which scheduled 1000x too large
> timeouts.
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: hci_sync: fix mesh adv timeout units
    https://git.kernel.org/bluetooth/bluetooth-next/c/87a49b610708
  - [2/2] Bluetooth: make hdev->adv_instance_timeout a boolean
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



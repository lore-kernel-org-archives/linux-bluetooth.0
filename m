Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EC14519A6;
	Mon, 17 Aug 2026 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786996014; cv=none; b=C25bes/B4b8UZ7h6KLY04xBPe4oASMLRmIf0mYyn5XkoaUwEFfPpKy3ha0wBh9Vi199PNRmLLFRYFcriqEhubL7CL8gGJl4e1ziLjdPbki2ODFdRGNOwZjAH6niaUesI9gg1PUxFR8BMQsQfYi3693icszwR30pJ8jAJfir83xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786996014; c=relaxed/simple;
	bh=4CRMSdf7Lpqq6C/a37gCgEtrEr/WfAafu+gUxWM/vC8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D1WGeUlGhJksIPk4rxAQ4W9wZycxP+cjAkXYvEh5vmZcNCWjmD50ugTKeaiASjKWTV+LfJyI6vcpD3vLtj6hldhi6PqjucHm6JxV1SkWpnD2Zg9TmWY2Z0SuitDyHhTRbqGF6JjVtpFyWumfT0JdGf5EvVmN8aPrL2e1ee+Blbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOSTYVlp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOSTYVlp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F99B1F00A3A;
	Mon, 17 Aug 2026 19:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786996011;
	bh=61TtIMsIEaRN2psi8pMxXtUA4/qPQ0s0iCcpkXjAxZI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oOSTYVlp4GNTa0vFQgvPMdbe3xz6kQfrl06TRv9LHRvMVqfZf4jLeIjTT8bnDQDQ9
	 AvmHWzzZ3ynkt9+gAlfJ6JuQ3fToTLNy7Zg470DOOJE2HV8Wbk5DE8A3zBT5hncu/M
	 zcKa/BvHuk12hU4FAXHuLWgPPnxzT1yOCT9yTb87zwPmpokqDdW8IwhCoViujLhYcP
	 4tp2J38jr3Buiii6vifnWyjNhE/3rqezrRfhIASsX98C22oL1LmXZeWfIB9o4HpuVN
	 r7S5TOXIy2eWRV2UM0/zG4L8OTyRI3M8EPCWkDyYXwfH69En/H2JBzVcsvMLAMEBPS
	 ckGb4jpYRALVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09563926262;
	Mon, 17 Aug 2026 19:46:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND v2 1/3] Bluetooth: L2CAP: avoid maybe-return-locked
 in
 l2cap_get_chan_by_scid/dcid
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178699596338.1691257.6779779933672558121.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 19:46:03 +0000
References: 
 <35f8d2856ef35e1c6314101ee60b16af39d88e78.1786871620.git.pav@iki.fi>
In-Reply-To: 
 <35f8d2856ef35e1c6314101ee60b16af39d88e78.1786871620.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, elver@google.com, bvanassche@acm.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 16 Aug 2026 12:47:03 +0300 you wrote:
> Replace the maybe-return-locked pattern in l2cap_get_chan_by_scid/dcid()
> by doing locking in the caller after NULL check. This allows adding
> context analysis annotations for the locking.
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> 
> [...]

Here is the summary with links:
  - [RESEND,v2,1/3] Bluetooth: L2CAP: avoid maybe-return-locked in l2cap_get_chan_by_scid/dcid
    https://git.kernel.org/bluetooth/bluetooth-next/c/a7b612da9059
  - [RESEND,v2,2/3] Bluetooth: L2CAP: add locking annotations for l2cap_chan_lock/unlock
    https://git.kernel.org/bluetooth/bluetooth-next/c/a3dd57c49564
  - [RESEND,v2,3/3] Bluetooth: enable context analysis for headers
    https://git.kernel.org/bluetooth/bluetooth-next/c/c519ffc1e2c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



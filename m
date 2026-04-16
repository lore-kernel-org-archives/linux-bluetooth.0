Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70716324B1E;
	Thu, 16 Apr 2026 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776356438; cv=none; b=ZA5EpuupnOS8Qt2MJcfLGdmVbU37z/DstEXikpKrXhhCqDTB4URBYwcqXcHDWsH+TISArNJbULVWl6OMPFc//0zmgbCLnwHqftzIx0HjfqOKYRtb6yyiZSUDlE2/LRBFja6sMdeowaiQa9Q2wCurcdiICjobWGvjlKo5cZM0OJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776356438; c=relaxed/simple;
	bh=i4QTJp6gfQ6MsI0r1QtFdih9ZbHFZKrzr7vv0eudWf0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hb3nNlekihYdeSr1wokWqSgy/5QMDPbW7O/g0mJlwfRKZj2rttFeYRJ6CahW9QJRxMTtkgt8BON6sxSxz8GSu3sePborSr1RHyAcU2qK1v5Ij0BWN1i6Kh6Fbe/lhkeac7CWuvBtvqpe6pOiDBVkTrWhibEfRHjPca7XHR1OgSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ee4GYH1O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ee4GYH1O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F5EC2BCAF;
	Thu, 16 Apr 2026 16:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776356438;
	bh=i4QTJp6gfQ6MsI0r1QtFdih9ZbHFZKrzr7vv0eudWf0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ee4GYH1OcRa7DsyCxEmZUvA84gGsjvS+gM93qvXBSXBNzKeyI5DZItZJaza6eMtkx
	 1QzPknArtBWexvc17KVia73PeybCnuQY2FNvfXUEgocVhE4j11xa8PvGuUMelVlsiq
	 aFOAyB6kPrdmvMMs6Pc+Po4d07L03DzN0WXI3hcBddXh+ywtYJUWH03AvyRNQM3wjN
	 2pwcqW1v9Me6INg5ycjmpuBuFfnjFPgRfPmMHHrEmTFNNRmKMOnPJdEM7K2aO/jtzs
	 twu8OjDojoTyEIgywS2fLCS0g5gcw8ip5oAET5UlaC/ttXEzWHkOADcgyyBFwHyC8M
	 XUw6DML1ZN1Pw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EC4380AA67;
	Thu, 16 Apr 2026 16:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: btmtk: add event filter to filter specific
 event
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177635640655.3303094.2277821963642028002.git-patchwork-notify@kernel.org>
Date: Thu, 16 Apr 2026 16:20:06 +0000
References: <20260416111607.3161032-1-chris.lu@mediatek.com>
In-Reply-To: <20260416111607.3161032-1-chris.lu@mediatek.com>
To: Chris Lu <chris.lu@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, will-cy.Lee@mediatek.com, ss.wu@mediatek.com,
 steve.lee@mediatek.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 16 Apr 2026 19:16:07 +0800 you wrote:
> Add an event filter to filter event with specific opcode to prevent BT
> stack from receiving unexpected event.
> 
> Event with opcode 0xfc5d is generated when MediaTek's Bluetooth enable
> firmware logs and is not expected to be sent to userspace.
> 
> Signed-off-by: Chris Lu <chris.lu@mediatek.com>
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: btmtk: add event filter to filter specific event
    https://git.kernel.org/bluetooth/bluetooth-next/c/b57b0f27cb05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



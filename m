Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB96047D927
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 17:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787850667; cv=none; b=aLNKfiYC8bKKnKO6IL2dEEVGaN1ZqLphLT6LcZvN2mHNg7wCxpJ/kzZVfcM6FKLdo8Wq3qbWmKvILk0Ys8u1ZhYTZfnw+gLx2s+k2g7u1Qu6XINSThr0gASaM9NPcZ09hcVLRkQMU7L9ZsUpZvGNfQ7fQPjdqYUxdQZJKnrp7hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787850667; c=relaxed/simple;
	bh=rFj8dwsc4GsvGWyx/8kHtmhpqKB/JZX2vg6MwFv3iW0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eyEV+qOnhMvYFwheAuSSOt6Hppr6NHkI1l762d0IWqbavaD7qeZFMwVohQZmP4eF1xso0/6VIfA0q3wShxBaARkjZDGHUBAh5cJEeAN5mV66tMQ1QKYhiFBys2q/z43QQbDUEE94ZcnN5tO5faAcp4qMnNLEbQHpI45lqj0QAaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQ7rGg4O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQ7rGg4O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9355E1F000E9;
	Thu, 27 Aug 2026 17:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787850665;
	bh=6b0iDLbiYDn4HWKuWp5rKXmOLkLKa/wZPwCLHPdB/kM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nQ7rGg4OZWHEMnJ/wquX8E6cVuP4cN98bNN4epk0HW1Th34VWTUUvSQtVzqnbClqa
	 XfSTcr+UrSZ71073UCEqxWfVYX8K6ErQBf3qyY1YAbhyAp0nQYY/XVgwpbcn+sUArE
	 Cqp9vkf0lKjVzBw5dShRndAuRxg5nGGuI1ZYXzGVSLdm3BlwlzbWl/NLopBDX9FLzA
	 mvwZnHoxho0xUXnBdKY13ISwpEBl2y49hioCYIxfUXj2vP1bvWata5Yudjqe5bv6N5
	 ctwlCaW3B684cSrJBaFOmpcbm5QcA+xLowl8Zk8eVqrLSQLyaW7KLkwgI+NQFDNJm1
	 KBpqIdLnnAsjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568AE3809A89;
	Thu, 27 Aug 2026 17:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] gobex: Fix ABORT response being discarded
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178785061088.1754949.3094431541422204268.git-patchwork-notify@kernel.org>
Date: Thu, 27 Aug 2026 17:10:10 +0000
References: <20260827083651.1355587-1-jinwang.li@oss.qualcomm.com>
In-Reply-To: <20260827083651.1355587-1-jinwang.li@oss.qualcomm.com>
To: Jinwang Li <jinwang.li@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
 quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
 shuai.zhang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
 xiuzhuo.shang@oss.qualcomm.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 27 Aug 2026 16:36:51 +0800 you wrote:
> g_obex_drop_tx_queue() in transfer_complete() clears any pending tx,
> so the ABORT success response should be enqueued after transfer_complete().
> 
> Fixes the following PTS test cases:
> - OPP/SR/OPH/BV-27-I
> - FTP/SR/OTR/BV-02-C
> - PBAP/PSE/PDF/BV-06-I
> - PBAP/PSE/PBF/BV-03-I
> 
> [...]

Here is the summary with links:
  - [v1] gobex: Fix ABORT response being discarded
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d094be10ff0c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



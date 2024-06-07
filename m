Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D69015B133
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jun 2024 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773633; cv=none; b=P2DC6qwXHHfLtwv6IH1eR0+M3PUzIak/OC3DCt7psKzfL61kHKaM1dpvz01o/vH7eVRkBnImll38FozpcOBGGw0BRusmYHPkhUxWDTcQE5w/WHNLrUPFL/0Zd7T0BZTdMRdBufCwaT0qTs0CT9d6qlMDjx6BlFafzjtturFrb1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773633; c=relaxed/simple;
	bh=Ip5kCnHSyZ9d9xJ3XFTuoSY2Q9znCNvTpZyrPxV2as8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NdAI6bQmhlvs/1HWDOE5IyywwADj+C8rZEibFaFXkP4V+M9+69w24jkk9zyvQcDd5ticj70MA9e042CWHuy0sFrz0pHLxO6HFG7MoNBGhqFZRyLzwaCckF5/d1Eom8apmGg5015TDtEQRRaNy3hJYmJixwm0tDKG3TAlRsN5zt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leVRN9q8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leVRN9q8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2F73C3277B;
	Fri,  7 Jun 2024 15:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717773632;
	bh=Ip5kCnHSyZ9d9xJ3XFTuoSY2Q9znCNvTpZyrPxV2as8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=leVRN9q8pckpFJFq50S1PEtsyETqLSeyqlpQInm3TfrhkpJqZIE0c60v2mSMoHYH+
	 +oRBxS+fO0cmUcNFHc5EjBcK0g76tDVcs3VMZ11VP94UKKmzaGh+dqTpHDI5U+YFQE
	 zphd3PhP6lV6UJ9Gs+mcgghDbHIqbQv9RLFpjR5OVl7u8TDDGl5VjqCwrM/xiVGGH2
	 juYbE/jB8EMHw9blxx+tgBnkSRixEEFmOv3mUovamwbAB8sfiu6pyW8fl38RMI2uJq
	 pzJqBMYN1MOeLwzcnFjpPRXHUSRwfXmskgzaiX2xDY7XYxJ+SkN4ge+BlXSQex8GPZ
	 7MCpJ22euZU5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A3EA1CF3BA5;
	Fri,  7 Jun 2024 15:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] isotest: Fix ISO send data rate
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171777363266.4371.5756145975216749092.git-patchwork-notify@kernel.org>
Date: Fri, 07 Jun 2024 15:20:32 +0000
References: <20240606162903.620906-1-luiz.dentz@gmail.com>
In-Reply-To: <20240606162903.620906-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  6 Jun 2024 12:29:03 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> We are sending data to controller at wrong average rate not equal to
> 1 packet / SDU interval, if Transport_Latency is not an integer multiple
> of SDU_Interval.  The calculation currently may also give zero, so no
> data gets sent.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] isotest: Fix ISO send data rate
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=272d8e8c9599

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



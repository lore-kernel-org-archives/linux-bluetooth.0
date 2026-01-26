Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7432FF643
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 22:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769465416; cv=none; b=W8L6XzTezgdN/FCExIyo12FknvehS5TJYdVR0KQXf9iWy6YdG1vH5AFVfhbeLjHx854ELRTYKif1GLyLilWUdHj+TcQM9DIVQhMPY1hUcc2S5+Q7af2Y2YB4W84JkkvIy7kP/8rSN+wjsra13LPIBQ4LvjHUuY945u+zasY4gu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769465416; c=relaxed/simple;
	bh=wD35OKcICYBDVNgzJZwJwIQbA+trXS/b0tg+yOcu49Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Yrp0zNCZppdUMUBUribgg/ztkVEuCkl7sTUxt9wS80Q5xf7k3o5YFanoRlvD33iKgGq0rXVZYUPiHhk0nVX9IxS3ct5wfUf/mQEk/cjn89Pt0UdcLGamm76L9AZgGZotC83vszhB7WzZBgMJ7ZQ0arTfT8r0ceGQZJHB02PumlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoO6Adoh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoO6Adoh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1B7C116C6;
	Mon, 26 Jan 2026 22:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769465416;
	bh=wD35OKcICYBDVNgzJZwJwIQbA+trXS/b0tg+yOcu49Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GoO6AdohevOP1hQDW5XMqZQ0D+7hAIKnx88g3KykCvFkV/qzyOqsptnO1t0haNtx+
	 jMjhuIOWCDsGuBvWneS6vzCcPFXOsCzd9q2wsyUxBGF/yzWF8Hu0ByFHXD+1WTu1CZ
	 eznbwme1Z33MiwCGVGvhPny2CU7lGz6Td6J3H9LD/W58rvB5RRtkuPT7QpDU2gj8WR
	 2aneVnG8QAIWQ8CnjlfxE6PPSi078DZJR9ahnv4llNFPTQ4F56kHIuAGppo86++iLN
	 T2wqNb83V5a5EthHvGs4k+c4lbl8kLs7CIvVp6bcgeak9HL3N60ntxBdTwiOsYdaEf
	 kAMOezJWd5umQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BA62380A958;
	Mon, 26 Jan 2026 22:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] doc/qualification: Add PICS and howto for the GAP
 qualification
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176946541010.196436.13226765282271636788.git-patchwork-notify@kernel.org>
Date: Mon, 26 Jan 2026 22:10:10 +0000
References: <20260123105249.677211-1-frederic.danis@collabora.com>
In-Reply-To: <20260123105249.677211-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 23 Jan 2026 11:52:49 +0100 you wrote:
> ---
>  doc/qualification/gap-pics.rst | 1642 +++++++++++++++++++++++
>  doc/qualification/gap-pts.rst  | 2228 ++++++++++++++++++++++++++++++++
>  2 files changed, 3870 insertions(+)
>  create mode 100644 doc/qualification/gap-pics.rst
>  create mode 100644 doc/qualification/gap-pts.rst

Here is the summary with links:
  - [BlueZ] doc/qualification: Add PICS and howto for the GAP qualification
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=76cfed12730d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



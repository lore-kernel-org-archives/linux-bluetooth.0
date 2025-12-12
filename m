Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAD5322B65
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765553596; cv=none; b=cVRUPCqrTfRJrgPf84LTUAI8EOarMH0JuLLlzp+N7B2VDc7pdOC5pYdM7N21Fc1FUbsuuSZLWS8WmmBk87Aefdyo81pihkRVz3c1P3ACkP+j3zo3b+6cOMbCEivOg0zRU25/2lMiODvPYCZmEuC1kEmbRVDlbngNL2yHiQ6mDr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765553596; c=relaxed/simple;
	bh=9zjmzU0C6rjUM5bvT2Ka397UW6sT+3hpKK2rbClxpPs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BwkRCY7uGoOWN5h0q1Wa5/03IJlJOImPhm1oYUXD6ftcKUudIqiNRhv2J1zE2EvOQvonN2nDz59qaeIy27+tszbTFhiR3yScQ8++vC6Luasjf4iulGY4d0l55umBCoEcoKwzMYMD0iKN3+jfr/l6yOJLPCwAfEN7z35k1W0zxKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9WwFA4u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9WwFA4u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB12C116B1;
	Fri, 12 Dec 2025 15:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765553596;
	bh=9zjmzU0C6rjUM5bvT2Ka397UW6sT+3hpKK2rbClxpPs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U9WwFA4uFnRWHaMn75G9GCug7SqvcSjojJYGOLSAdaPtbcBmBBHEBWItFKgeQ+hNC
	 Jx1e5VeTF55LHDu4x3Cg93Ibur90g+ovnQQGPyhNnEyrCXfdH7Dur4Um1oAc/xJnzn
	 lXmOQcRu2h/r5Uwpc8DyjGyL2ndcAUIDpgb62aoYRnbyCOuXC8C+yLXgKPgcvSWRrx
	 8LYQ/2ErfnsY/CyhayRO0lANmBZYyosnS/h2FrnlPB9maN+wl9XDc1XsIn/UdyoGi+
	 G3f3XbYi72E5vNJ5s3b6ppO8uOIYiDnturVypjxbAy1hahyz4qafmF54Lqilc1Qo47
	 kVtMXNO2GdfVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5998380A945;
	Fri, 12 Dec 2025 15:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] l2cap-test: Add tests for LE 2M and Coded PHYs
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176555340952.2197478.15968273682550198974.git-patchwork-notify@kernel.org>
Date: Fri, 12 Dec 2025 15:30:09 +0000
References: <20251211203927.527036-1-luiz.dentz@gmail.com>
In-Reply-To: <20251211203927.527036-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 11 Dec 2025 15:39:27 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds the following tests that uses BT_PHY to retrieve the ACL/LE
> connection supported LE 2M and Coded PHYs:
> 
> L2CAP LE Client - PHY 2M/Coded
> L2CAP LE Server - PHY 2M/Coded
> L2CAP Ext-Flowctl Client - PHY 2M/Coded
> L2CAP Ext-Flowctl Server - PHY 2M/Coded
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] l2cap-test: Add tests for LE 2M and Coded PHYs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=44a1d0c73ab5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC1414C5AE
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jan 2025 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737657011; cv=none; b=kEm4lVvsISprDchmpflSUeNPnIcaIhN7m+9aM7k84Qdlfr8DOLgJeowUIeqbT4aUQF32/x4TN+KfRtymsHPxQOYTtdKukiI9/fZuWjwcjF1JnCaCFFa6TafIBxGHl+hcoK70ooRSL94u5r9eqmcWcHW+lxR5rA3qhtVFVltWuLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737657011; c=relaxed/simple;
	bh=fCcI+a2c3P3BDSH20QhtX9qysRV1tVaOAptLgKDbO8Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T76Ck7anKZaLIBX/8whyMQfusFYGYTOwO7SWyptivJ4enTq5+ZwyIMyqBvjdrRaE5p6rDQ1NHt5J9o0vA6W9G+LbXx5givoOPpSNb3LXMX10esAvyrpFNbWIovPbzcMpHzoLsD9AEqTsy6nZXUIKLnLGyTEbg/RSA3u2tI7HbEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbFP5S+1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbFP5S+1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F02C4CED3;
	Thu, 23 Jan 2025 18:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737657011;
	bh=fCcI+a2c3P3BDSH20QhtX9qysRV1tVaOAptLgKDbO8Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tbFP5S+1tOTrQqsN2RyS/h6J3BfvK4hpsoptcWIVpdNZIhKCs81W9YRFb4DAMLB2U
	 OWvwFRj+QaN9PSIhZld3FjJBEUP+NAHib4kjml3msIwrZLIcPG6V0HSAYeBH6RP0JU
	 vDEefFHDRbdy9RijkldAmTxKFaMZx4OPD0HPSxQj3eMnJGn6ZzTru/ouWTg4Qpz+gE
	 Q4igTv+CoYuZFSh2l8egK2WfVI0ZD6qRqd5syy59K9W9cWIC8QRwaH1fCFq3UlDQuE
	 uSgGFk59Xzl77A9x6dsX3rOEuhimbvNjg8O5VnWHnI/CoxhvXehuvlEB8qOOJw0pkw
	 0illyZkoP/w/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBA71380AA79;
	Thu, 23 Jan 2025 18:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6] Bluetooth: L2CAP: Fix slab-use-after-free Read in
 l2cap_send_cmd
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173765703555.1459736.14426250151354866022.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jan 2025 18:30:35 +0000
References: <20250122212514.164262-1-luiz.dentz@gmail.com>
In-Reply-To: <20250122212514.164262-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 22 Jan 2025 16:25:14 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> After the hci sync command releases l2cap_conn, the hci receive data work
> queue references the released l2cap_conn when sending to the upper layer.
> Add hci dev lock to the hci receive data work queue to synchronize the two.
> 
> [1]
> BUG: KASAN: slab-use-after-free in l2cap_send_cmd+0x187/0x8d0 net/bluetooth/l2cap_core.c:954
> Read of size 8 at addr ffff8880271a4000 by task kworker/u9:2/5837
> 
> [...]

Here is the summary with links:
  - [v6] Bluetooth: L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd
    https://git.kernel.org/bluetooth/bluetooth-next/c/6ab54a717189

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



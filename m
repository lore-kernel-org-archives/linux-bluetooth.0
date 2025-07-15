Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFCD2CA9
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589791; cv=none; b=l2ZUwvXBkDwNAgrdojdOO7eqvkRgX5SrOYpXx6k3EzPTEgqqaEPEKFWuJB6bCB2kP2PB83yp5YEeYQ/erIsMiEorX/LhjP/dSPYQJd9AfpQrZcCo9WnmO2IpyOXYRk/5VxGETzFVN5Cs7A3st7VCrRceadFkggWfmgHDm/4hDnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589791; c=relaxed/simple;
	bh=zazgr49M+c93jaFwXYUVd9XMyEuUZuL0nzuK2q27EG8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pizDSr1kKVido5kTWQ4m15mxHSxiZObHc3hObix2vUB61z3Vf8AcU9Snu1piEd1dTihDgc29VVIZh4HMwy7DgvPsPZwNoS94YMuO83y4OJjHjdDTCEbSsqveEt1BlPieMxRA4v94jFRHgW6vbQvFWty+4bbsmDQV6t3Sm+dHcb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPbUBKZf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPbUBKZf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C92C4CEE3;
	Tue, 15 Jul 2025 14:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752589791;
	bh=zazgr49M+c93jaFwXYUVd9XMyEuUZuL0nzuK2q27EG8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IPbUBKZfHvDDBxUcNmI3sTeS0bmYB6y7uGh/rZJ3Zq0M6klIX5QhHx85bL60JMhjd
	 Gg5PJygAipuDJEO+R0DAjYlCfv498e0bpIAlZy0UTvJboMatjDiE65e8pgEMCj8cw/
	 U+WdjLVVDujHqcEVYO1PTCOYp+lMDYNmEpD35BvNgjUe7191VkUH/4EGpZ9CIEleoF
	 /ce4B8qdr4EmMjPIs7Uq8LqXhqhNQGchTn3zyjD4LJguRJpb6qax0ZNFM3+Lx02I4L
	 yAhArdXdyW3itcQ+a3C4gRMP5CEHmqeVPoFPGxIq0K/MjLebZNsdup+UU3nxvnQJM0
	 CaeOVwncUJt2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FE5383BA03;
	Tue, 15 Jul 2025 14:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] tester.config: Add missing drivers
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175258981199.461397.17429923164004702824.git-patchwork-notify@kernel.org>
Date: Tue, 15 Jul 2025 14:30:11 +0000
References: <20250715133201.589025-1-luiz.dentz@gmail.com>
In-Reply-To: <20250715133201.589025-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 15 Jul 2025 09:32:01 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds missing config options to enable all drivers which is required
> in order to catch build problem with github CI workflow.
> ---
>  doc/tester.config | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Here is the summary with links:
  - [BlueZ,v1] tester.config: Add missing drivers
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ddec3358fe5c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



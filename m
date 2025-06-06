Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5C91F0E29
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Jun 2025 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749236398; cv=none; b=TWpL5grvkgWai+GkQG4eNAvUsP3G6lVIFbBghtzyyKMWY4rvnIu/7i0KtQZ4gKS+VRl2YwrKb/F9ojXEi1W7AIJymhkUX3c8GLoUtZI2bVB2M8BwxB5vkoS5qdkwXrzJUE6equ6Kcet2qhg5Qxr71c8JuvhTpCLEahEPs9PyOKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749236398; c=relaxed/simple;
	bh=LNDRzx+ZpgMVunFfFr/QmlLhPrZRC3tBdqk05Xdh1p4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GKcCTNKVNFFX7p3VV0VGGP29Mu32NeokLAwksp+kNYaftY3Kxn4tlmf1Fsa8qkCFIUVGCFHrAiBv+4CYUHLiXULzlOo+V8dXgMUsLHNWiJtClR1bksxDPlLFZA0Si0urhxw+96JU9RDg8znsKTOkFSlj8bRt4nX0R1YR0A+P6vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIHBFiuc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIHBFiuc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2EDC4CEEB;
	Fri,  6 Jun 2025 18:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749236398;
	bh=LNDRzx+ZpgMVunFfFr/QmlLhPrZRC3tBdqk05Xdh1p4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aIHBFiuc9tMPWVFhYjx+14b4JPd0ZD2XxurHRAU6SGfU4OBpXBSq5GDWaB78NophD
	 Q7HDWSU0zgZ2KWJP3/cUcobpOAZJ/1kKc7Kox8Prm75VLsieedcdCqi8W7QOHafuwd
	 cbYZNn+UpRv1keG14JTVvDXBkjkWX5xqHRiSvH26mMJlUYdCLTBTaDX5gIxEvcnqdj
	 1foUNofuCWO6nt81y7DG6+G0MC40rJqjH0U4jwRgfsgSVo9xk9J7U5MT4U/glQwtwU
	 Tw+pwx7+m/2FAntWHL61miLlwkernzzITIIEpufq+MRYhay04pPjECiemyOUmsFwNj
	 2VfeAEDBiTe/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D013822E05;
	Fri,  6 Jun 2025 19:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/2] shared/shell: Add support for -EINPROGRESS
 to
 bt_shell_noninteractive_quit
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174923642999.3945689.12926721012930977900.git-patchwork-notify@kernel.org>
Date: Fri, 06 Jun 2025 19:00:29 +0000
References: <20250605192406.909397-1-luiz.dentz@gmail.com>
In-Reply-To: <20250605192406.909397-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  5 Jun 2025 15:24:05 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This enables commands to call bt_shell_noninteractive_quit with status
> set to -EINPROGRESS to indicate their execution is in progress and shall
> not exit in case of MODE_NONINTERACTIVE but it can proceed to the next
> command for MODE_INTERACTIVE.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/2] shared/shell: Add support for -EINPROGRESS to bt_shell_noninteractive_quit
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7d59391bb783
  - [BlueZ,v2,2/2] client: Use -EINPROGRESS with scan and advertise command
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5499681bc632

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



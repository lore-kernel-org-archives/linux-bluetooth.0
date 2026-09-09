Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F4D3B059F;
	Wed,  9 Sep 2026 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788984069; cv=none; b=AVDj68mSs9weboeMmX/+8cX2dvlbgC7M1gTxTaGw/pXtsn2hMDWLtRm0nHFoH4++oTBbcpsv2huGsghYsCOb3yZ0eCGu3gsHZialpatHPwsiGUylre5IwfHyzBoeRpn0mQLMyP4ZTGm73kZBY63nqC552lkQdFQ4yy5yHjbOHkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788984069; c=relaxed/simple;
	bh=X4O+lTU61F0JQOLgGAycaO9X0LJP/ZSP3MEnoKzBZjI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BH8iP/vJssz+/sFfZCZTEFinIe5mmBx1v5ELSLOHZvXfr2PjBIbo9qtZICUmdnHJnK9WI/SN3eKoE729Og4qCFtqINoft8cUgtiimDm0plAIeZ+sUUGC8Kg+R5EhUCBnHGvgtinh1HZJV6VyVuHMkO3GMOql8phsZ3CwB3ZzIoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEAKzrbK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEAKzrbK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DF91F000FF;
	Wed,  9 Sep 2026 20:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788984066;
	bh=3Lki2zKjYM+qNV6KC9xTZ6rVRofIMGvc4jF56clPzCU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WEAKzrbKzWQwAR5wCzrPuZSJ6r2WDK8LNobPcoIfcxEpL7iMfxoqd3TN4Dnr9OBNl
	 6796E1udklCJadLFQDQ+Tye12frCxA7GbQqLQfPv95wJU/T0zRu2Acx8Qey9bUWnQn
	 vIjYjSVqagu6twS11jdfZ+L3PvGEui7InJ2kuj5MpHAmIGH38/iyNloU1KwwqOatYZ
	 q4NIUR7ey+/0AFtLVAxcwOUuPPtKapzTU4G5RTx6LV8fWmWl7JrnU2/5Yvzhn59KFG
	 yc2CBh+3natE5KYqLHvs+5YYN6LoqKaEF8/hAeeWQDc3IEN4PvR61UlanHNiWjfxWv
	 SwxGeer0ac11w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0E9E2380AA74;
	Wed,  9 Sep 2026 20:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-09-08
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178898400463.1032931.8145913840198303606.git-patchwork-notify@kernel.org>
Date: Wed, 09 Sep 2026 20:00:04 +0000
References: <20260908212127.1022197-1-luiz.dentz@gmail.com>
In-Reply-To: <20260908212127.1022197-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Sep 2026 17:21:27 -0400 you wrote:
> The following changes since commit 38b6be101006d3e7af972999f45d4f1e8250587a:
> 
>   net: macb: fix NULL pointer dereference on unbind with fixed-link (2026-09-05 13:58:52 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-09-08
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-09-08
    https://git.kernel.org/netdev/net/c/bbee0759d363

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



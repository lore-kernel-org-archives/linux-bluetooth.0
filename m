Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ED9136658;
	Wed, 23 Jul 2025 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753286352; cv=none; b=QgcEs4H0wfEAgw83Cy97yJq0p+khsae4IcS0Uvyp7D18DgBVfjmH+15tIcayDywrhPC646nJ72OAZ14VucgakFNHC2wAbTtH+JMWB3cRUA8z52HLJM6dAYIvrUrmC0DJRbbb+2+j+QAh8yHfaiF9JttxNTdWKCa2YHa+DhN/3wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753286352; c=relaxed/simple;
	bh=yNqWKk4lc+au+yLspFsLwroejcsZ4p938VdwXSM81gQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D9GOgDQAqGLW9LER44ocSC5IXSKN32P28i3JNsStMNX/ltKC7tS00QET5LUcg09mo69pUinebm4F+2OuRK6+0K4RZVX3OR25vHbbvble3n+H8FrpswI//GQHiVNJaqRJroLpVy8mq1LsoWRGYxB/oAj5Pejf3+KTcMyQ5aFdPms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3FMsiC/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3FMsiC/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0818BC4CEF9;
	Wed, 23 Jul 2025 15:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753286352;
	bh=yNqWKk4lc+au+yLspFsLwroejcsZ4p938VdwXSM81gQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e3FMsiC/HrMdTMiUjWFW3Xpo2WmNOATAkDjwCAyCPfoA0wODvEp0LORYQOD8e3IGG
	 DDG8GiBculRvRqR/p+JeBqPZcICXOOzKvwYvh0LX8KmplGIdmXLvOOEbLNLi1LjF6X
	 0+7SwI0ADx8uatbvx2b+aTGNQiZzV7QrECHYPMKAyqSANgO91nlVI47FKAUETlNpzm
	 c+Ou3Fey8fkPeURX1t+sU4EQp/dT2wEsJao5hXRrZHqRwNMyzRGYkFAgbuyHpLEVv6
	 KxAYiJrGPLSJtlJwqM4EkLlfaQJv4nX2W43s2YKjXyERCqg84wIZjEBs2PXdk2M556
	 qSfWKSZta6tZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BFA383BF4E;
	Wed, 23 Jul 2025 15:59:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-06-23
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175328636999.1599213.16307621920522835604.git-patchwork-notify@kernel.org>
Date: Wed, 23 Jul 2025 15:59:29 +0000
References: <20250623165405.227619-1-luiz.dentz@gmail.com>
In-Reply-To: <20250623165405.227619-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 23 Jun 2025 12:54:04 -0400 you wrote:
> The following changes since commit e0fca6f2cebff539e9317a15a37dcf432e3b851a:
> 
>   net: mana: Record doorbell physical address in PF mode (2025-06-19 15:55:22 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-06-23
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-06-23
    https://git.kernel.org/bluetooth/bluetooth-next/c/1fd26729e013

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



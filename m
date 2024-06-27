Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204C019ADA8
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719513631; cv=none; b=dsjUODHHaOvkbRIWyrGifqlUL66TzW05rb1YBkgv/9XcNwpkoTK23y6j0vI5eWNImY/2wxfP0uKn6sYFIbJp3EB5EG32ALq7NuqywfXmuOuBpD/eWxZKEHMSn6BpPjYK467YeZbKq0q6GPxb6zeVb7CouxvwGUfZuHqJMMenIbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719513631; c=relaxed/simple;
	bh=icVyVw+iogV0h+952XnzkZz7O9ABT4SE9Xv+j8dL93w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JSBsUF+8BInsD4xuOe4ejdfkCRSdcUKMEMyOriR6K5hKjVR0TlYCKtIXHC8Z89y5snD4BSiMtEN14+6gvH26ZY6eVyu6/rjbtTbgLmdla3h483TBEL2Ti8Ea4m0eyBay76FHPvX2pJUbf7jGUSRgCg51zEqanB532j61S1UiEyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7Mkntc0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7Mkntc0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9669FC4AF0D;
	Thu, 27 Jun 2024 18:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719513630;
	bh=icVyVw+iogV0h+952XnzkZz7O9ABT4SE9Xv+j8dL93w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m7Mkntc0PoNyTEdvMtfUxae1gr7iJTJRzw+44ulur74clJIfB2l9df5JI9IP3Vi3v
	 jI9rzHL/TLZeiUXMnFRYeWY31c8o1q5kO8SlDbh3iP6T87/CFvaGx10OyEIdSzFtXt
	 90/K2L+tPjeP/+KIcZPDK4vd2sAfhwSQ6QsCMwulZ+7UTRpCJ4S1ulzQDJMNHunOTQ
	 1jYeTheJqSWfAql6pcgBvvbDFJJ7RJCw5eynKGuRFNM4lI2Wwx+lpTZNsGX4L+oEhu
	 tOW8xV2F+iKUGLlu3S8Biz3mHReCmNQ9s+TwuGcX6Ys/gLntUL+C01iIvL5gdK3LEA
	 +HuvWTxLu4j6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89431C43148;
	Thu, 27 Jun 2024 18:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] health/mcap: fix memory leak in mcap_create_mcl()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171951363055.21304.2509939165318729559.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jun 2024 18:40:30 +0000
References: <20240627133222.82707-1-r.smirnov@omp.ru>
In-Reply-To: <20240627133222.82707-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 27 Jun 2024 16:32:21 +0300 you wrote:
> set_default_cb() can allocate memory for mcl->cb but it does
> not free mcl->cb before exiting the function.
> 
> Add freeing mcl->cb before exiting the function.
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE
> static analysis tool.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] health/mcap: fix memory leak in mcap_create_mcl()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2ebb415b12c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



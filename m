Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986371B423B
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 19:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760038820; cv=none; b=M6RwRm0+NSE4g4GbxyEl7ujTvoC2O6KjamzklIePl5mTI3xok9e+9Gv1sD1tt9JR0XTJ0cZVbMa0NOPdZEbEbJl06L7rJ2rQXi0QwP9tw8A+UNBARZFLPvPVNT4qXrSBeLlXo8WoJ/dfy6NxinrtJtk2lbfB19zX/z4y5UYU33M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760038820; c=relaxed/simple;
	bh=BnQ26LLDu19C/pvd/qPWWbPv6QmF9v7aY9kKMVUCvxw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K32Mm/9s0b0A9w04no9+kGv9T2iV05ZiV6DqI80iAq4RsmN1wROOZKP94UIkU4EwjK+XWujrwXbCKEiVIRW1ziCpH4Owiq8txZpZ4AXPWqGH9YnwKr2IoD0z1p6baVxAf8dvvWC7LYeDXWrDIHizWw3auM3Wx5YF/BmGY0N7GC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNp3MvwT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNp3MvwT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D718C4CEE7;
	Thu,  9 Oct 2025 19:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760038820;
	bh=BnQ26LLDu19C/pvd/qPWWbPv6QmF9v7aY9kKMVUCvxw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SNp3MvwTfU7MEYM72mx/8kNIR32/JJQz2ix9Gv5p6LB8hvzjW6DAm2vAogaOd2mEH
	 CnYxPpd5JQseXs2W9SO3p9qHOxlAHNk/1ZeBeu571ZhYgUwgkhI3KZhfUP0B1hh4yk
	 aGSbAWlTNpq5MCELfu5tyAH7GczUExrcyeU9Ss7YdAdy+bMuroIWZni2AK5g++rJCv
	 PKeaKc7JdWjaKsucL/xtnIOlVkH2dMNOfYWG3D3u0c5RT6Y6kBE8yHS8Cs5PR782WU
	 eBf7s1jBrzt+O6uFL2n0IdLwk8ME2OnfeNA63X2iT1wiygCU70L1cVGI/7t6GiZpN8
	 Fl+S+2xsP4geQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C7D3A55FA1;
	Thu,  9 Oct 2025 19:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/hfp: Fix issues found by codacy
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176003880799.253496.18243950355038159229.git-patchwork-notify@kernel.org>
Date: Thu, 09 Oct 2025 19:40:07 +0000
References: <20251002161119.937608-1-frederic.danis@collabora.com>
In-Reply-To: <20251002161119.937608-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  2 Oct 2025 18:11:19 +0200 you wrote:
> Move debug string after check of hfp pointer.
> Add missing argument in debug trace.
> ---
>  src/shared/hfp.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Here is the summary with links:
  - [BlueZ] shared/hfp: Fix issues found by codacy
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=24c568a3b689

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



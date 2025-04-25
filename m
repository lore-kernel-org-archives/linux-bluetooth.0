Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC31821882B
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 19:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745607677; cv=none; b=NhCMCW2kqghE3d8UGaoQ4+IMz3VIVIx8BwRVnqfIOrb88tJNFYx1ZfB124bgTVlG/T4a4loDQ1Icl9udYMHYdiI/lnhZFvOVD+xcUlJi9MfDlfyrowGpfELTen2KLOc65dTJYPRe+Z8ZVApeCEQ8Xf53NgGXUEdc1zBF1TCEaX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745607677; c=relaxed/simple;
	bh=ZuoxXJSXM6he3mfS++ejMk12ZH/tENFrNb0GL8JzOk4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cH8N4A5jUtmP7n+Tpm3ShKkDEyuM0B6NyneFiNUHiQVxER1VQGwK2J2UMBM4/iezgNaCUlBfImXhNTagjp5x50nJpiPUdBJo5UjUr8jmOtG3BvLBi9VJoARYc26r8gbJcbENGyp2EsT4DKwZLT/ilCBZlIut9vdJsa0fVNjSe94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6bQTyuE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6bQTyuE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1EAC4CEE4;
	Fri, 25 Apr 2025 19:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745607677;
	bh=ZuoxXJSXM6he3mfS++ejMk12ZH/tENFrNb0GL8JzOk4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p6bQTyuE1BxuUNM5iXVSyZbu338wsOWhXb1JNoJiCBy7ZbL+nWOiIbcwMJtbLWoey
	 Ac2Rh5rZ5wHpO165I57fBFXJehBr9nRMrGDNK8laRelqo0pgVUYgIIOgx6ayfta37g
	 /A8oTazBL0jIGCtMx+pr+Jdy5lbesv+0M9j5Y2O0gtFH5a7VdiVImE7LWRF8Dnuqv7
	 l092eQWpHeq9ARnWC+7n+05X+5V5RvVT16MWhrMPAE87Lo3CVvDACD6cg1+XwENNTg
	 9GEWv6Gxe9HeE3LWcqHvLoz46rluDb2J32MSc3UKL5GTC1+agt0rcxwLcNMRHRuWvY
	 CtovKPqXxUfVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD39380CFD7;
	Fri, 25 Apr 2025 19:01:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] Add support clang-format
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174560771626.3803904.16628194840606766864.git-patchwork-notify@kernel.org>
Date: Fri, 25 Apr 2025 19:01:56 +0000
References: <20250425164435.1482617-1-luiz.dentz@gmail.com>
In-Reply-To: <20250425164435.1482617-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 25 Apr 2025 12:44:34 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds .clang-format (based on kernel) which can be used by linters,
> editors, etc to check the coding style.
> ---
>  .clang-format | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100644 .clang-format

Here is the summary with links:
  - [BlueZ,v1,1/2] Add support clang-format
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=42f5184b9882
  - [BlueZ,v1,2/2] Add .editorconfig file for basic formatting
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cb8f216f51b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



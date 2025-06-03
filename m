Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236F1239E75
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748962199; cv=none; b=O0RY1u+tPEz0+9Lp5DueakSO97oK/FEV+y9Sxm7nnWkY4xFUqEOfMF3GT5DJkQHJeBfjfZWpJPdxmi7Q5NU3lgpNaREFvKk8zg1t+5X3+zGLeB7suY9e8s66e/oVF7NNOEOzpuHG8nE4IC98MYYnFFD86Od+qFTVjtRWSC3UcpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748962199; c=relaxed/simple;
	bh=GzJwgSwCztqYP0qhP4TQHVgLyI50RRHS0+b+tNsi9T0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=er9GCku2cqFbrMmaS1SbDvakUcMweqNsiavg8PTgMicVi7HxTDxanficBrsjBDqJg3nMlS9ZfXAZlV3yai0XjDZjoPfI/3UMjv4Svsyb8XLE2KvO9aasLHyPPBIvLN5DP8KKVVZ7XisEwi4UvP9HAH0Onssa5M4KI/xpsNaIdos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQ0cAmVj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQ0cAmVj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8692DC4CEED;
	Tue,  3 Jun 2025 14:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748962197;
	bh=GzJwgSwCztqYP0qhP4TQHVgLyI50RRHS0+b+tNsi9T0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fQ0cAmVjTqKgAQm1ZBarem1Ro5l5ECAl/ce3n+PPcpMw3lVkKzKdmMc4p+Mw6DnBl
	 5ozQWQ1vgwIf/P+Hj+Kpe8Zmo4Up+mXQ0fTagqTzlMysygRez5lCGoVneEx2cui5Fs
	 CsQNkcYqYKw6cTpEiMYRSN6g8fmuzoXTg61SVJzneporuHn40C29q98ZrLIimAlCU5
	 cAYPqD3DxEM3eygYj2N0YfBgQVrm6ZZw4lG1SVP++1zIB5d5KQouD/9M2aBOuen6tJ
	 3QH3pneCnqgLrjBrUcMYMkUudi+0h5Q4Rf/QaCxQLALazatoUtfzQDx633XGdSy0sX
	 HryleDL7XIZ7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FC8380DBEC;
	Tue,  3 Jun 2025 14:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: btintel_pcie: Reduce driver buffer posting
 to
 prevent race condition
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174896223000.1544228.671221908563232029.git-patchwork-notify@kernel.org>
Date: Tue, 03 Jun 2025 14:50:30 +0000
References: <20250603100440.600346-3-kiran.k@intel.com>
In-Reply-To: <20250603100440.600346-3-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
 vijay.satija@intel.com, aluvala.sai.teja@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  3 Jun 2025 15:34:40 +0530 you wrote:
> From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> 
> Modify the driver to post 3 fewer buffers than the maximum rx buffers
> (64) allowed for the firmware. This change mitigates a hardware issue
> causing a race condition in the firmware, improving stability and data
> handling.
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: btintel_pcie: Reduce driver buffer posting to prevent race condition
    https://git.kernel.org/bluetooth/bluetooth-next/c/fa2c8bfe6794

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



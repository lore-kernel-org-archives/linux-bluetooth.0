Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F0827815D
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652798; cv=none; b=XiJ1Em48ozk7nmmpztVd4dXcDw4OYe5KrtdtWyTqJPua5OYWk+NdL4Y/kQCLO1iltRlkAqocJ8nK2YE71fbRNyH1VyzxOOG/dbiAoSzZPqq2v09E2YeZl9POAwhztR/yDzw81UpPTP1RCh2fq/9+sr+zCJtNP+BnEt+Ki7DHmYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652798; c=relaxed/simple;
	bh=El9nONPPk/HrbSoied1eZcfucg0ZYMQ6NXOIvA1X4pc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e5rwSAdjXJdmqzml7m6HxSZGN7B2/wN2X7gRc51NxyTvprxLA/erIeUfHuy/h/1QdFaBiG4MaUWMb1+aF4SD880VYBRTYAI5ctRY0eLOpX0PHJ1qEHbPWq7xzrkKiuCBcheaFlvGqSvmUxD+dzF2uHKwfKefgC56cYXyyVFEs2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyVh2rjy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyVh2rjy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D8BC4CEE3;
	Wed, 11 Jun 2025 14:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749652798;
	bh=El9nONPPk/HrbSoied1eZcfucg0ZYMQ6NXOIvA1X4pc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NyVh2rjyXrcGUMzI28tYPLJHvf6oF5p3uAazJmwIeNTywS+XOUi1dQz4yoIORGAjA
	 K+4YSTBMayqqyQgcSOhhG9HvgnPXIFeQvnYzhcopVDNZVMBXMjvu/ZOaD4g9Yu347l
	 hoqYa45qtFUjmyTsrx1kkFU1SuQsacdJQKdnjuVTS99g5kRq8ISeCTDpZG122FgvhM
	 tjpc+GfSzPcDz2W99jxGsUvQpVsdUJLtXnS3fpUc6c3nH57BQ6q6WSgS5PWacclntX
	 vc+1/KVulQgJ0ACbE5sJTniHYRXIHdBbqzr3rW5OtACXDVr5I7qwg4hLvuAUjKr0uy
	 MDCzm0RVgFFcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD9839EFFC5;
	Wed, 11 Jun 2025 14:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/2] Bluetooth: btintel_pcie: Fix potential race
 condition
 in firmware download
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174965282876.3348581.5179310634948609330.git-patchwork-notify@kernel.org>
Date: Wed, 11 Jun 2025 14:40:28 +0000
References: <20250610140038.696091-1-kiran.k@intel.com>
In-Reply-To: <20250610140038.696091-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
 aluvala.sai.teja@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 10 Jun 2025 19:30:37 +0530 you wrote:
> During firmware download, if an error occurs, interrupts must be
> disabled, synchronized, and re-enabled before retrying the download.
> This change ensures proper interrupt handling to prevent race
> conditions.
> 
> Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> 
> [...]

Here is the summary with links:
  - [v3,1/2] Bluetooth: btintel_pcie: Fix potential race condition in firmware download
    https://git.kernel.org/bluetooth/bluetooth-next/c/866fd57640ce
  - [v3,2/2] Bluetooth: btintel_pcie: Support Function level reset
    https://git.kernel.org/bluetooth/bluetooth-next/c/ba6b287d9f91

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



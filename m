Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D45556B96
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2024 19:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710185964; cv=none; b=FqXTJCUU0ZQbhZ3B0XE1davDsDZM425eFoKgsYdDLLbOblPXRt5Xrcp6n+Zo/hi1gEQn3mMCgC2+KJL5vxMP857RvZfAumOPENkIMEQg7thyFVUaWpnTYD12QHRRwvefrtijALxdIyCAs+/qCtLaz01Be0E3+eeNyeDCH8SOs4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710185964; c=relaxed/simple;
	bh=tpLT1JASMdUImDdpG+Pk/k3hXdlwyNPzZ4BULt21DSU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bDef7YiOm05rEGTrsX19mPvxG9cfNJrty/ExHjsplP9jbEfsfKeYQWp/p9gvd4yZ3MMeZjp7XxGG9FTJIpz41DOXdBGLDuK/2p6DYt+50jWaXfeI73O926Aj0WK9OQPaGX21zLfK0dRY1BbY+D8VT9du4MwktXsMO0dOSgiWkuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cr9YjMFF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cr9YjMFF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AE17C43601;
	Mon, 11 Mar 2024 19:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710185964;
	bh=tpLT1JASMdUImDdpG+Pk/k3hXdlwyNPzZ4BULt21DSU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Cr9YjMFFobFbTzKCgE/elu+avf3kPyeKthbs5JHyA8Po57AR9DkvLjtw5OA2WCFkU
	 p5swCRJN+0pWzwB59IoB76Vh686fol4bWer8ORhMJgCQW1HgHM3T+2FebmtYdXAXpr
	 eyACiAy1CVsibi/PFl7EVmbjerDV8XED7S13/r9+V7vDs8Ky3vJ0LWd/9ek69jKgLg
	 MDYQNUtsb21ZNbKP/O5TbxrjDxke1vwevJUBySSvOa3xQw0c1jJXIBYariwBQ2EacP
	 b5F7cKkbsj0NXDmKv3oizX86N7+DcGVMzPpVMWzgGeRkII16SjVD910kDx5fbQ8rhh
	 iBRzNhjen+atw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 097CFC395F1;
	Mon, 11 Mar 2024 19:39:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 1/2] Bluetooth: btintel: Define macros for image types
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171018596403.1144.11344921433461870149.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 19:39:24 +0000
References: <20240311084626.402325-1-kiran.k@intel.com>
In-Reply-To: <20240311084626.402325-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 11 Mar 2024 14:16:25 +0530 you wrote:
> Use macro for image type instead of using hard code number.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 12 ++++++------
>  drivers/bluetooth/btintel.h |  3 +++
>  2 files changed, 9 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [v5,1/2] Bluetooth: btintel: Define macros for image types
    https://git.kernel.org/bluetooth/bluetooth-next/c/cf53bd76851c
  - [v5,2/2] Bluetooth: btintel: Add support to download intermediate loader
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



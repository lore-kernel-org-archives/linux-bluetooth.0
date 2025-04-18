Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761481519AC
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Apr 2025 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744985397; cv=none; b=G06WZoBn9iPVdLvGTQAVo39mOGArEdLyZ0IUoyMjwsmiDztOc57uMan7PlHncz807sKqShTZ/rwm/KuhYqS8y4sX5ZKOZ7xtWxMDpVq2C69oRlCalwv5N06hDdyMSp0R7svv1STsmh3tQHQB8xIGA4SWb6nHB39mf+YNNP+bHTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744985397; c=relaxed/simple;
	bh=dqYVNidP0gFA5HgV3DeIKZIdz3JtlBy6cekiqzICmE4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B3x6cvmEkNVLJCX63iXWJsPn8UPbc96rfAaaV8wEnJSOIilAbH0KfcldTV5o2a83fLXZRELDgDA1DLTXhtMyNPCQtjiMttUrhQm2P+fmYFGrRFaaLsFAF+0u7IuhoGXpwGWDFUjUrqHo3J9SmxohYnf9Vuay3vgjSfYLwW0nOIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyRpG3Of; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyRpG3Of"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E45C4CEE2;
	Fri, 18 Apr 2025 14:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744985396;
	bh=dqYVNidP0gFA5HgV3DeIKZIdz3JtlBy6cekiqzICmE4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uyRpG3OfR7Qfif2QaSGd6ixhAFPNk6rNtlDouMM8PvE7590R7JvTBc1HxIC1fR+4H
	 Rl8Q4VHUZeBMD2MApSXDzDOPT+fmdKaWFmFbfZfvExE68osolYMxjdQeoC0WWJQBuz
	 fW5DDX7xlGVjYc99ID4l+8v5trGW7quFVs9cBsQFP+o3UsrSh7gVOOg9hFzwWSV65Z
	 CNy6VjZjXSqkky1+NVKdSiblZ9GBgsa/9H3q/b0Cf2QdLDn8IoYg+rTgwW2nYIC97u
	 O67/Du10nJgHVqxR8QsoKE8j20XSPVWs8iqqqXxpu5KBGpj+E01Px9a9KD9C8bNMGh
	 fXgpLpaQkrKZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 365E33810917;
	Fri, 18 Apr 2025 14:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] shared/shell: Fix build errors in fc42
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174498543503.225291.7790404171985405348.git-patchwork-notify@kernel.org>
Date: Fri, 18 Apr 2025 14:10:35 +0000
References: <20250417202113.80496-1-luiz.dentz@gmail.com>
In-Reply-To: <20250417202113.80496-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 17 Apr 2025 16:21:12 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following errors:
> 
> src/shared/shell.c: In function 'rl_cleanup':
> src/shared/shell.c:1429:20: error: zero-length gnu_printf format string [-Werror=format-zero-length]
>  1429 |         rl_message("");
>       |                    ^~
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/2] shared/shell: Fix build errors in fc42
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e501c8ab3023
  - [BlueZ,v1,2/2] mesh: Fix build errors when compiling on fc42
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2a569ec80ffb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



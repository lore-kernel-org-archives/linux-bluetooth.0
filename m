Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE9324EF8C
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267832; cv=none; b=sQQgIjRrS5LgsJaKQoBwgChRPMguyiMZSB/5h+fbFvwRe8pRjC8mxqhXAe45zgsF7VHrNUB855Z/JbJl6v8m5l9qUbqMxQw+P305zlJqOixoWdS3DkrjC4a9Ew88mMiyLN3AMYGxxjY+IXAJ3NMwuR+p8lnLVIYoFOK5Ha4fzl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267832; c=relaxed/simple;
	bh=9hwM6kO/OgAA7BYc93gfFNS3hzrNxQfjfIup6XHVkno=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LJT1kkMDTUzzShTBrZTfLOOLIZPfscLQxuazHBIrI/9yLNDvuLJTzrKkzfQxlj77f6O84HA06RhjxLe3iw+nF0qqOW6zipZsfQlo+HCOfQj0+SQ2awbFJMDdoKNlVyHXZ20rJgJcu7/c3EBaq3Xg/ODrJFFmEmvN3E4KE+tZQ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1fXuWie; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1fXuWie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC80C4CEF7;
	Tue,  4 Nov 2025 14:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762267832;
	bh=9hwM6kO/OgAA7BYc93gfFNS3hzrNxQfjfIup6XHVkno=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f1fXuWieT3tyepV5pxKCj7d5syGxNmPBO4uVX3bZFLb57W/txsQ2r822lB515kHVt
	 ySCUyiMWxpWGidMxKsQjQv7ujYPmjyy0XfN8BVkN6NkdZhb88i7I4xUIcCzMBBwGxV
	 T/hiS61WytiqUJdR2dBiK9lxGaLBMBVaOsyhkoEJrBflL0Q1cQVnNgF6MYYioo4BbG
	 +EoPQOc5VK8nEfA3uZNjDXME/NBjSnkSP119PqEbdE+beDRkdM/W3kJA/F4LEYl+AB
	 FIAEF9fSY9PG3wdScmIiprNhnweDKStwusPKqDFSPUDW0dXdnBXxvitbxWJktK8OH8
	 HJY+9gQ0qx03w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D56380A977;
	Tue,  4 Nov 2025 14:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/3] shared/hfp: Add extended response code enabling
 command
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176226780625.2881757.6104532259150504340.git-patchwork-notify@kernel.org>
Date: Tue, 04 Nov 2025 14:50:06 +0000
References: <20251104092808.128726-1-frederic.danis@collabora.com>
In-Reply-To: <20251104092808.128726-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  4 Nov 2025 10:28:06 +0100 you wrote:
> ---
>  src/shared/hfp.c | 36 ++++++++++++++++++++++++++++++++++--
>  unit/test-hfp.c  |  1 +
>  2 files changed, 35 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ,1/3] shared/hfp: Add extended response code enabling command
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b0db5e1c330a
  - [BlueZ,2/3] shared/hfp: Add NREC disable command
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f3904a8f1c2c
  - [BlueZ,3/3] unit/test-hfp: Add ECNR off test
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=654c4f5755e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



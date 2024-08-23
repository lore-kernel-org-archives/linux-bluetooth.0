Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8200D193092
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Aug 2024 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724444434; cv=none; b=W9S4ML8AJnGlwbiH0uizCx4Kps/Z9931cflh1iNS3D2VUdpcaoFmt0dUI+I1GP74FFPOv/8VwcmVxXhCsxJNteEqjfYscb+vszjOBlc8MC/QikqK4ZpCY4glJC3ynlDbffx3UolVaJqtz1ydSXvsa3e0TDwPO+PIKKmXxeB39Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724444434; c=relaxed/simple;
	bh=aeXTye3FSeDjzqGCv5tr/5HjWbNXt9vhzlM3aJKovFQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V90DQRpHAr6BNmH3P8Y38oSmclgaWb080O4d5+YnIBAANBvLqsdjkFBxblYCZmtJBxU4rtTVDfrmFJyAywAjeW96k/zfYArHR8Gbx9KqIi3aVT9qTqmwhwcxB4S/yPuLTMCKn9qrodbOUnLHzuLCizJO1uOP3kbv0C0WcNFHAtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkV6JL2s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkV6JL2s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33C6C32786;
	Fri, 23 Aug 2024 20:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724444434;
	bh=aeXTye3FSeDjzqGCv5tr/5HjWbNXt9vhzlM3aJKovFQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qkV6JL2sfxTaHWmF/hgteXVfA0jDQYtfebc2Jksyt0w7GR2hw7awxKPc6ACBQ7JdN
	 zn/IrszpNLRwJcSPewZp4tdIFUfCcbdX+dYItaZLRkv3da3RWA/LnI+sZktWd1J9I2
	 LJFkmKJn6mPY8f2Ks9EdqIAhTKtc0Enz4rwtBHPV3lV6vmckO+rVpH6TM5AyxAYnh8
	 T1DwstrNp+X8zLDc0vsNffUrDTSMG/q9/gQF6A3xuHO/RWFGbQG5RtfZup5hFkS2MM
	 PyrMHRGwo0P4Qo3aEdkQ9jsrsxAuYmUAcfs/LPn/d+5UjQzob9HoOkEgairvVWkSNK
	 s1XsXuMs/FIhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEF63804C86;
	Fri, 23 Aug 2024 20:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] test-uhid: Fix attempting to run when bt_uhid is
 NULL
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172444443377.3078102.11763197853201790358.git-patchwork-notify@kernel.org>
Date: Fri, 23 Aug 2024 20:20:33 +0000
References: <20240823152006.698937-1-luiz.dentz@gmail.com>
In-Reply-To: <20240823152006.698937-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 23 Aug 2024 11:20:06 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When running under root there is a possibility the bt_uhid_new_default
> doesn't work (e.g. fakeroot) in which case the test shall be aborted
> since it is likely a device specific test case which would require
> proper permissions to run.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] test-uhid: Fix attempting to run when bt_uhid is NULL
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4ed7060ca9df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



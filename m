Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC43321D5AC
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Mar 2025 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360200; cv=none; b=l29o/ATG1fwOatK0VV+4feFp0hMcYMgXAQNhfPZHRgR2t70cLSDJHH1EZZx5efWQNyvMVeTvcFSGhxijY0iGXQq5i5uKj5JwE3JrNIXsnMMACNdeY+R3T/DdbaI209wY3Q3F7tPXZs+qkKmOFWyoad1j82yshlIOL/xi+aRNIqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360200; c=relaxed/simple;
	bh=V5eWCsvz9s9354+dNAIkSCh+7RNCREuNsjl8ECGhc/w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qOZbbDoaIeYLKF6o8pQU++Cq/lcNh1PcjwY+nXNHt4SRaD7WBT7bRGIVpLUMI/jiF1VZEhEQM26REJw20qHRAWRMneTctd9ukyLntZozjv8Xhn5XJbsj9OLZfg1xNIcOSKUIjkMzNrFP6h/VyqFgZlzZhFlA1DO0QxJEGlIHetk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVNRIhYt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVNRIhYt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EB0C4CEE3;
	Fri,  7 Mar 2025 15:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741360200;
	bh=V5eWCsvz9s9354+dNAIkSCh+7RNCREuNsjl8ECGhc/w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kVNRIhYt2FANwBjHmQSD4/jj76h0AXvMo1CZTE9CbCcVeHx4h9iu4ssBQnS0ZjFx+
	 WCVqjp6mnZbb+ietF8YBXqJqqJWil2f6WZODjL73YU5guYBlhYyhj9E3jPlvQcOzeT
	 eF8GTfjjx0oVry9g5H9TS5k5gr9caEsampDhKlh7i5Zk1xv4iPogRYhcyuzjTH1Fdw
	 eQ3bf1fVjNxjIQvCbal3OldS+6COb9KOyLW2+R7JGW/otpoiciyS6Cb9A6z/BkJDJ5
	 marCBJtiqnnE7OFPNp68QrD00+ob0EbLdrf1U65xtIyTAY28C0z8TV6iG+mKESN2Km
	 LvLlEhg8UELcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB231380CFD7;
	Fri,  7 Mar 2025 15:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btintel_pci: Fix build warning
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174136023375.2373225.6575463785702713449.git-patchwork-notify@kernel.org>
Date: Fri, 07 Mar 2025 15:10:33 +0000
References: <20250306213846.704638-1-luiz.dentz@gmail.com>
In-Reply-To: <20250306213846.704638-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  6 Mar 2025 16:38:46 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following warning:
> 
> drivers/bluetooth/btintel_pcie.c:695:20: warning: unused function 'btintel_pcie_in_rom' [-Wunused-function]
>   695 | static inline bool btintel_pcie_in_rom(struct btintel_pcie_data *data)
>       |                    ^~~~~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btintel_pci: Fix build warning
    https://git.kernel.org/bluetooth/bluetooth-next/c/dfa48dfca48e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



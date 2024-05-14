Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBED1E487
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715698388; cv=none; b=kdevVSwMZ1MB6a+Vd5xkdEeuC8mCeufwhAvChLF8ueqcw4ajPpvNjyhUA8xxR7chW1Qew7+Na/CECan3sckCd+IBc5Su+UDUyxDneOZEVP81WyE1tsJP+enwvJkkDF7DjufGq+bWjQoVl5UCTT4gS/xnMFgGixAwpWR7b5joAdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715698388; c=relaxed/simple;
	bh=9BtJdI2/pPOJ4VtoObTEt+v7DjoiWjipMETEwt2IiUY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AM9jWh93gHylNyDT0hZ24vUZEm4FGL2pHrOjhdY1hM16MYdZVuU9L81FHva5j294rNTRzh7defr79mb2mIz/omUhJ6HY9bSgTPtgK5U26heH0ae3qBNmzlc5mQjGi4GPYi8qcWM40sryPx7NwBuKH8o4Ku8ZZLrALr1ol4GmU/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7g8SW1J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7g8SW1J"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F06DCC32781;
	Tue, 14 May 2024 14:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715698388;
	bh=9BtJdI2/pPOJ4VtoObTEt+v7DjoiWjipMETEwt2IiUY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g7g8SW1Je/9uk7IXWF3mTwjadLn3Sb393TRyNsZhwZyrHxGe9zEltGbeY5qvcEz/+
	 eRHeP7FHC0Oc1OqVHBaTtNRbeUIO1SZkirMZIyWiqpfsHiDhK4bKGAFdQoWon40fU4
	 T9LS7MflS/6smHZipaP08pB/7mUPBHtoxCsnqmsw8uooDb5SutGk2eh1ao1bHa57+d
	 d2e7GL/qrJ5+LmbPLdlU+h1geGXYgoM5ZIOyGGJ4WzTyryVlF5J1Ywm4KXKyaLLs6u
	 uRyeuB2HDkVt8XDV7cXd87I4uQYTfqTY0nNjnm2IYW/+Sz8j+dBCRJcnXQhxoDR274
	 bKJjI1Po5fgcw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2EB8C1614E;
	Tue, 14 May 2024 14:53:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/2] Bluetooth: btintel_pcie: Fix warning reported by
 sparse
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171569838792.3449.10440377454024129807.git-patchwork-notify@kernel.org>
Date: Tue, 14 May 2024 14:53:07 +0000
References: <20240511054059.349729-1-kiran.k@intel.com>
In-Reply-To: <20240511054059.349729-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
 lkp@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 11 May 2024 11:10:58 +0530 you wrote:
> Fix sparse error.
> 
> Fixes: a6c49bbb0b72 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202405100654.0djvoryZ-lkp@intel.com/
> Signed-off-by: Kiran K <kiran.k@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1,1/2] Bluetooth: btintel_pcie: Fix warning reported by sparse
    https://git.kernel.org/bluetooth/bluetooth-next/c/c5cbf4f0271c
  - [v1,2/2] Bluetooth: btintel_pcie: Refactor and code cleanup
    https://git.kernel.org/bluetooth/bluetooth-next/c/710dfef50bab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



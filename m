Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D483B775E
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778170256; cv=none; b=fwunQr8elU4w2oYun4ZaGM+n8xLzMsLF2cWVQgCHa0Yxk6+tvKPb6FLdinXOPJVnA/LofPvPA8YxSsIZkI+zjbOYns7BidF4ntDylc8KZem+809c9i9xV5UMq+7Znn9bw17NqQh7Yy5o7cLci0N66R1kL95A9lrLyNWGa+P39As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778170256; c=relaxed/simple;
	bh=p8NUDUwhZXyDb0Ew7LQurXrWkq1zuNSzyW6nTwCEK3M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K1mmwpcepB/9U4Tuf1hdxcVqdfZnDi78gMq92U4Jd/43rlZ+IDuv27NE0Alngd12gitZqgvtpHzm0dLfJasMJ6FG5LpsB+4tQQFOM/LvmVRltOz6s3NV0tL2LS//PHS/ODbKt5DURQAuthIBzAH8s1+OMAk9Kd9tWcNdg5dD9+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFnorWCn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFnorWCn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D968EC2BCFB;
	Thu,  7 May 2026 16:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778170255;
	bh=p8NUDUwhZXyDb0Ew7LQurXrWkq1zuNSzyW6nTwCEK3M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GFnorWCnJIooo4OucRmc+D1dq2heniUuzkfd2RGTjmyD2/w9k6O8zoWPHHSuMBykS
	 kRIOGzSTiCaF+RrEXqsVcL3gS1BWrB/XNnmYX38zUDUW4Md6K6ur5885vYsuruA4Q5
	 sjNFG2nafM5HI2vSHyENiM0B2W0wR+HOpxSX/gZL2CmE05ulqH2Ch1jew+yJDhx+Jh
	 JjpxD+qbu+KZOlLNxZC2dYxtfQhpHv9xSieayISTei2c291TMfYHp8pC0UCKxxZYD0
	 6kk7IxiB8ld1RNTAzrOhUMRls0ghJ/9qnyFyMGuLo1xxsFvV7jNPGtyqeEwaXcqdvx
	 sfv3hUD3CHrxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC673930909;
	Thu,  7 May 2026 16:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/3] tools/tester: Fix crash when hciemu_new
 fails
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177817020504.4060363.13006408594396299217.git-patchwork-notify@kernel.org>
Date: Thu, 07 May 2026 16:10:05 +0000
References: <20260506194150.1701855-1-luiz.dentz@gmail.com>
In-Reply-To: <20260506194150.1701855-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  6 May 2026 15:41:48 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When hciemu_new returns NULL, the mgmt object was not being unreferenced
> before returning from the pre-setup failure path. This could lead to a
> NULL dereference in read_info_callback when it later calls
> hciemu_get_address on the NULL hciemu pointer.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/3] tools/tester: Fix crash when hciemu_new fails
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=acd0a49506a1
  - [BlueZ,v1,2/3] emulator/hciemu: Add hciemu_new_debug/hciemu_new_num_debug
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a068db99c46f
  - [BlueZ,v1,3/3] tools/tester: Retry with debug on hciemu_new failure
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e3dec62da2a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



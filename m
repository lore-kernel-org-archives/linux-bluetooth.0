Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D14038DD9
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jul 2024 20:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720730663; cv=none; b=gU7zQL33dXyujeegTjBcnuUn/hZjzgMsVOwsxXfvMFBSy4hQmABJHCfBMeFhgPHuo0CeU9WhfbhqCFeOWvqNjtab5siski+smYxxLSRQ4i00zhrQGjeeeGoiq2LPYzTGqrKo3UcPTG4B3fTD8y4D3nAlHnEItDtNp66SBtzWctQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720730663; c=relaxed/simple;
	bh=x1ub7zscPcDgi9RZ6AvT5hPX/C9hh7OMJT09nbJ0vno=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MugFcfWDlZuAy5DPMLCYWV2d54CMsdakE7RawUxYY3rzyXcF2vefmlIPOIi6sjDEN7W8VuS1WX9j/kcC0n+gJkwWW5zpVRluELsc5LDFOX7BC7Mb3SoYhNUTJNRYzhjQ7FykDdz+Ei/Pcxzc7IrnbUNpX5WC5N5g3h36E5xG84U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anGuFNkb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anGuFNkb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C98D4C116B1;
	Thu, 11 Jul 2024 20:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720730662;
	bh=x1ub7zscPcDgi9RZ6AvT5hPX/C9hh7OMJT09nbJ0vno=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=anGuFNkbfQqi0tfNnE8xf6D8CwvgPUahaErmJXV1fWaylsrAFO+hkPhhc29gA/cSu
	 tO2hYn60zFOc09idmk1P7lQsaal0JoIgWlof6Em4SU/N2Y11ucLrg2Y14aafdf5/eK
	 zyWzES9bEOS6FuoS4NHx5D1hUuIEXPmSHYoLF2+BHrxFhvavgIBb2LIqj4efYFh2P5
	 9Z2n0KO91ymu6ij/PvKTsL7nyn93fTNxqeeci17/JqWt0fqmodAo6IXdkUJou2xr9E
	 UEG9xNcehu2CyUZIwezJVq7q769CBskTp/uQqtsTemEZ4rllO8jaFqZf0Baphb5gv7
	 OyB3U1nJh4Nkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BF255C433E9;
	Thu, 11 Jul 2024 20:44:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_qca: Fix build error
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172073066276.5052.14370492025338997629.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jul 2024 20:44:22 +0000
References: <20240711032252.3560262-1-luiz.dentz@gmail.com>
In-Reply-To: <20240711032252.3560262-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 10 Jul 2024 23:22:52 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following build error introduced by a887c8dede8e
> ("Bluetooth: hci_qca: schedule a devm action for disabling the clock"):
> 
> drivers/bluetooth/hci_qca.c: In function ‘qca_serdev_remove’:
> drivers/bluetooth/hci_qca.c:2501:2: error: label at end of compound statement
>  2501 |  default:
>       |  ^~~~~~~
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_qca: Fix build error
    https://git.kernel.org/bluetooth/bluetooth-next/c/f14c0bb78769

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



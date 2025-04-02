Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCF91F3BA9
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Apr 2025 21:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743628201; cv=none; b=Gf+GSKuskn0SxBhwKpt16NZnPcurDeyWFN+81kjgPOeeFjdM/sP7xWudR+TS32XxglDO/Jem8qNri41fop4MAS5Xe0C2r0y+Z7fiWRldRt1O3DUEe2SvPzAszC2MwscBi/k+BtizKcN2c+1Xmjlh0QO4OXsPO3aUdcfe5d36c3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743628201; c=relaxed/simple;
	bh=QT4Ezi2E9jqvnya610bik7X602iYyY0LjdcY7T07S6A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B3dW25j4qbF1PDLFBAT8gqeFCgKHpJopTU871BdsNexkgxZa+xTt1OfQew2SAkf2KP4Xv2RfQtfy6EcZElD7G1iteLgNDcCK6xmpA858JjydPs9c455b8wMUfUTGwKVrWkedy9e2TNj3n0FsNMCoo+Z4Ked0e4dGNXF+s0PoXDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbBtWkye; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbBtWkye"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D275CC4CEDD;
	Wed,  2 Apr 2025 21:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743628200;
	bh=QT4Ezi2E9jqvnya610bik7X602iYyY0LjdcY7T07S6A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tbBtWkyeZ8beQfCggNxqziJqgJCl2ygXhPP12/mcjLV9fX2kP4FKA8dqwE3/Zvbtj
	 n82YSRA5We8xwJqFQDD+ekzcP6TXhL171E8d3HWZMiN8g3H6jWEv1uqg+pDn5MfxAD
	 BRkI8DXmIGvL8GPMZCdQ2LrvWjsgmMcCwjA8c5/oqVWLepF5Szoo/F4Zx0Tu3iiB0t
	 lY3xdLpKgcyplTB3bWTR6zDepeV/fz3lMQm4QUHbCWdkveDA1go4LgP8qzuWHcc9vB
	 WuIpUxNOvBqoizib+chTQ9j4TvWCOd7rycYKUP986OeeCK7PDHoLkTBOyuZgXP32d6
	 YB8sCms+e04FA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB18B380665A;
	Wed,  2 Apr 2025 21:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_event: Fix sending MGMT_EV_DEVICE_FOUND for
 invalid address
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174362823758.1678044.14052016013453471857.git-patchwork-notify@kernel.org>
Date: Wed, 02 Apr 2025 21:10:37 +0000
References: <20250401171013.3785788-1-luiz.dentz@gmail.com>
In-Reply-To: <20250401171013.3785788-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  1 Apr 2025 13:10:13 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes sending MGMT_EV_DEVICE_FOUND for invalid address
> (00:00:00:00:00:00) which is a regression introduced by
> a2ec905d1e16 ("Bluetooth: fix kernel oops in store_pending_adv_report")
> since in the attempt to skip storing data for extended advertisement it
> actually made the code to skip the entire if statement supposed to send
> MGMT_EV_DEVICE_FOUND without attempting to use the last_addr_adv which
> is garanteed to be invalid for extended advertisement since we never
> store anything on it.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_event: Fix sending MGMT_EV_DEVICE_FOUND for invalid address
    https://git.kernel.org/bluetooth/bluetooth-next/c/32b70317f41c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



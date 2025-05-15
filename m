Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687E1253F30;
	Thu, 15 May 2025 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747328995; cv=none; b=uNHDdCCud8bN5i+gmb+rawam4jGq5vyNcAqnV7NsZf9YPknO7iAbFrwboGu+MbYhf0g/pUgut0NmG/Zv0FzmSMffruksZ8j/ABnrerlCmqA8BMD2A/NuyHzq8LI4Nf8knjRhbnYZMvLqPdZbjE2tVHjs9xqukYj8713+fe4/nC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747328995; c=relaxed/simple;
	bh=WJPhrJS7bKpAAcYU0a5v5FMEhSV+KH6e30MI0KJrJU0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cXBeb2X4iiBbuS3aUyWKjUty/PnqpKvQ3u+nQI6ysA5s3ZVBrBLHxOITCiIyKGoVG4+KM1MioFQ59p5HLWKx8igNrOUmMAtkdhILjWQObtunEB4g+6z/DJINZ+FYL5/E+wp+e4F4t4fBkUWaVBKS34+ZhTFV7di/hXf8bBn58Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgbzQqkG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgbzQqkG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E402FC4CEE7;
	Thu, 15 May 2025 17:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747328994;
	bh=WJPhrJS7bKpAAcYU0a5v5FMEhSV+KH6e30MI0KJrJU0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hgbzQqkGhdy153+zVsHjmfKR7cVa69yNHWaA/GwW1+nsDuPhxvV8uXKYTniirplMN
	 nkPgO9gItMdmnmDuGK8yli4loLsWs46OjT/sZxrj/a7lxMf6Re1R4jsvMaDIZmNqRU
	 +c5/US4x0Q/pZeqk+vBJgAsnPcpGVcL7LbmqJN4v6tlaVC8u56ozj+2nccfae0g1cu
	 dn5qvMMAf6spCRzeGwBOqGfU3O6VL4926YX9QtKu3yNDyNlOSzC94OI4SEEoyQZYRX
	 S2zhiSyN7amew6A/G+czXzRPROQZTBJkN0SPw0y/Jzx1aA5S43me9n2CU+f1G7OWJt
	 kNfYleQQVA7uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3418F3806659;
	Thu, 15 May 2025 17:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add new VID/PID 13d3/3584 for MT7922
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174732903174.3181810.10414962294011447453.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 17:10:31 +0000
References: <20250513061353.13521-2-sunliweis@126.com>
In-Reply-To: <20250513061353.13521-2-sunliweis@126.com>
To: Liwei Sun <sunliweis@126.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 13 May 2025 14:13:54 +0800 you wrote:
> A new variant of MT7922 wireless device has been identified.
> The device introduces itself as MEDIATEK MT7922,
> so treat it as MediaTek device.
> With this patch, btusb driver works as expected:
> [    3.151162] Bluetooth: Core ver 2.22
> [    3.151185] Bluetooth: HCI device and connection manager initialized
> [    3.151189] Bluetooth: HCI socket layer initialized
> [    3.151191] Bluetooth: L2CAP socket layer initialized
> [    3.151194] Bluetooth: SCO socket layer initialized
> [    3.295718] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20241106163512
> [    4.676634] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [    4.676637] Bluetooth: BNEP filters: protocol multicast
> [    4.676640] Bluetooth: BNEP socket layer initialized
> [    5.560453] Bluetooth: hci0: Device setup in 2320660 usecs
> [    5.560457] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
> [    5.619197] Bluetooth: hci0: AOSP extensions version v1.00
> [    5.619204] Bluetooth: hci0: AOSP quality report is supported
> [    5.619301] Bluetooth: MGMT ver 1.23
> [    6.741247] Bluetooth: RFCOMM TTY layer initialized
> [    6.741258] Bluetooth: RFCOMM socket layer initialized
> [    6.741261] Bluetooth: RFCOMM ver 1.11
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add new VID/PID 13d3/3584 for MT7922
    https://git.kernel.org/bluetooth/bluetooth-next/c/72d82f47a019

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E555416D311;
	Mon, 19 Aug 2024 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079635; cv=none; b=Fo5JMdWF20Zm52ByAU4lXzsG/mCchR9RyTnjMqHrQf/n3OOWhYqyClEBc0mH4B6NRLXkavpkWhYUehtVEPAznny3toMXSiSsxSCZ1VQNSCPy3DVJISW3CqmZEALOfA/JPGw9cdR51PKMsPIzkWibIqWarpLyCt2dOtiA42kynhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079635; c=relaxed/simple;
	bh=VQMfGzI+Es20dRcXkD0xfaz+G3XkMJqaCiT/e8gHrRo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JxLaDr+LimsVqBoHZHePfDlfsW8BCG036wUUTmG6bX+tj2ncr8Jg2I6NWNnPX3zk9kcorSxSHOXcFzDzp1OA6pcvVeT7Nnx7tbrJfqmeo+kRgm2ffAgXHDaWCNadzkpFehpgYrl11VjchOhi12LSj/jW3PvuSWakFTMePnOJ0vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fv/ZllLl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fv/ZllLl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B936FC4AF0E;
	Mon, 19 Aug 2024 15:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724079634;
	bh=VQMfGzI+Es20dRcXkD0xfaz+G3XkMJqaCiT/e8gHrRo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fv/ZllLl2n4HWQyM4b7hAnQ0/SaFErUXI9p+G/Uo3sI7VUL/o/N52d/Ik3z1kA0Og
	 L9jbsHfoga5ZYFtSSMmyVXE9GKenMlTO3mtbWJ5LT6f+0Mf9gg1lGAhUzRx7RBmrF3
	 D0b53YlqtgfLv0oBUxnGrRUs7Cl6MlBWoLw+q3I7mKkr5CZFLEQb/GQ8X6ID3rBxi9
	 nQxVdfAllQlc+MFsZUwXcv0lVr9sukIt9uf+k52Kw1iXdIonQ9+Dk936bHzlyDMHnm
	 G6jjjTyYvY70IM0vNkoaQNt5mNAfKj5aM1tKqeshzNsWqvbJX2mmUq8wiOqQ+DOlYO
	 AXmyBbZfutk7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E003823097;
	Mon, 19 Aug 2024 15:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] Bluetooth: hci_h4: Add support for ISO packets in
 h4_recv.h
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172407963429.558835.12880581051994294721.git-patchwork-notify@kernel.org>
Date: Mon, 19 Aug 2024 15:00:34 +0000
References: <20240816111309.287515-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20240816111309.287515-1-neeraj.sanjaykale@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
 ziniu.wang_1@nxp.com, haibo.chen@nxp.com, LnxRevLi@nxp.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 16 Aug 2024 16:43:08 +0530 you wrote:
> This adds ISO packet support in h4_recv.h, which was created before ISO
> packet handling was added to hci_h4.c and hci_uart.c
> 
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
>  drivers/bluetooth/h4_recv.h | 7 +++++++
>  1 file changed, 7 insertions(+)

Here is the summary with links:
  - [v2,1/2] Bluetooth: hci_h4: Add support for ISO packets in h4_recv.h
    https://git.kernel.org/bluetooth/bluetooth-next/c/ed5b740a347a
  - [v2,2/2] Bluetooth: btnxpuart: Add support for ISO packets
    https://git.kernel.org/bluetooth/bluetooth-next/c/da58f871fa89

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



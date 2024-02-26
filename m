Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE03130AE0
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Feb 2024 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708975834; cv=none; b=dCXp9d5Bf9EONkhRDD5r0ycqGXAYBySV6DADoYI6lP5MF7j6wcJfx7EBhAySBgS0SuSAqqlANnZedZoUQR4Nrk0Vxv8e3HOTbwMeOVOWpuMjtY+Ws6zXqmi2vz/Jal1u7NdATOWehq3ymMYuKFo9B+B2etgQ4MVEud1wXlMjvNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708975834; c=relaxed/simple;
	bh=ln2hl3BP3mOencGQyIrQO9X1OVPLAZzGiJDdy28TLIo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PXymtgbKzq9P3AonYynldP/VxgL5uo2ZMyWf7rpZpZiSxwzZ9gi0s6fBGZjODMoUjZwmqLUwpLA0HGBSF6w4xtOvC17PArFmuv3BsBbdLEFLvDbYU+WnOi8sp5T4shlOnliF9476onhf9u4Lh5NG0RQnvgFTIPRwLMhQJ451bGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6PifkrI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6PifkrI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AE66C43390;
	Mon, 26 Feb 2024 19:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708975832;
	bh=ln2hl3BP3mOencGQyIrQO9X1OVPLAZzGiJDdy28TLIo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z6PifkrI6Ze463pw+gJcRHB1mCkpaPc7jGNH5HXTaIQWr6ndaYlJUYrSCxfdlQu9x
	 YDu6T0MLTJ+ONVlYdf6/qXJs9/HDSvt+dMsurA6c3M7vtHuWnyLlp5qW7APhZq4XuY
	 AIRjHHFfXtHN7Twu5RQPnkx3bZDF5Whi/sVErn5LUGlUy64To0F2WXN4PkMNcqvLYr
	 a+jmYR1QFolL6y5W1x2BypgIMMaDXP4d7CDs9qpUe99HYS7o7X6piLVwJfryMMWT1Q
	 am3rtld/5GDFlr5hV7BNc/OJYKsDO446MXw7TFImr1deQajJOIvEAJqCyYmQWlWSAm
	 5kjVT1skvkEQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81AB4D88FB2;
	Mon, 26 Feb 2024 19:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [0/2] Bluetooth: ISO: Reassemble PA data for bcast sink
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170897583252.26224.17155179930977697040.git-patchwork-notify@kernel.org>
Date: Mon, 26 Feb 2024 19:30:32 +0000
References: <20240223131442.3077-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20240223131442.3077-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
 vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 23 Feb 2024 15:14:40 +0200 you wrote:
> This patch adds a hcon for a Broadcast Sink listening socket and
> adds support for PA data reassembly inside the hcon le_per_adv_data
> array, before the BASE can be extracted inside the socket. This is
> necessary in case the BASE comes fragmented in multiple PA reports.
> 
> Iulia Tanasescu (2):
>   Bluetooth: ISO: Add hcon for listening bis sk
>   Bluetooth: ISO: Reassemble PA data for bcast sink
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: ISO: Add hcon for listening bis sk
    https://git.kernel.org/bluetooth/bluetooth-next/c/7cecb020a33a
  - [2/2] Bluetooth: ISO: Reassemble PA data for bcast sink
    https://git.kernel.org/bluetooth/bluetooth-next/c/956f7a281807

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



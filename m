Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7649F176251;
	Mon, 19 Aug 2024 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079636; cv=none; b=JVrJ/18jm8bgkYDa5kj+2LlchNie3viSkLaL+oE2rdA37cgFa8JZA116yBzsUKjPd/fy2VcSHPfZol7uNgBBWvy6vto1r6tDjiRYlQJsoMeh3YRQmUJo2zCL8R6CrRldmTreYfyY4WggE4TtZzu9REPWjCuKuUe/lJhmYv7FmKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079636; c=relaxed/simple;
	bh=2NF0ZS51yLp1ybvfIwESGLLaSFUMEc52VBVk8K0ln60=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wvz1cmDQ+/teASllRi+GQ/vHYBYgErJvS+hm5CosyUKOZfYsbBab5AW01w60Vq+W5g3d7H1EoBUbeCg3Mn3Oga/Dp3QVvhWMom22qMd/95XUz7GeQmIEiKku0NqhhziDkzC0LBYi1uRvpVe4jEUBDZYdB12dNgJJA0USjU5/yaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9SrvUrI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9SrvUrI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF56C4AF12;
	Mon, 19 Aug 2024 15:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724079636;
	bh=2NF0ZS51yLp1ybvfIwESGLLaSFUMEc52VBVk8K0ln60=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F9SrvUrIfT26zeiDmYhIJgnS+jb8VkL4sFvWw8ctGnDyERssk4eA+xVNKQk4Qq/wt
	 xU8Al3htP6ZaU8k+JtF81IxIev/nsjUkzIZnA6xbPGyiyBzQ0XKbAX5DrUUz+p8Qpz
	 +OQtkXxBNK8lKjwUl2chJpmfOIVIl6eOY0jzdBUeKAaFLre9meobCLwhkVtTBGxKvO
	 1DKxBM6+7aYOgyqJTaMd7ZItUhGwO1Rgqk5op3rqn+XEUROyZfO82AYnQWl1IpnMT6
	 qGVCWSUZWF3ppZQDOhygZN6vnrgB5gKggB/F+KtVrDDvGOSZFFoSGAsu3M+CfmVyZP
	 s6ojmQzOFpHXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0D43823097;
	Mon, 19 Aug 2024 15:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btnxpuart: Fix random crash seen while removing
 driver
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172407963551.558835.1935854925816513438.git-patchwork-notify@kernel.org>
Date: Mon, 19 Aug 2024 15:00:35 +0000
References: <20240816102113.286531-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20240816102113.286531-1-neeraj.sanjaykale@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
 ziniu.wang_1@nxp.com, haibo.chen@nxp.com, LnxRevLi@nxp.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 16 Aug 2024 15:51:13 +0530 you wrote:
> This fixes the random kernel crash seen while removing the driver, when
> running the load/unload test over multiple iterations.
> 
> 1) modprobe btnxpuart
> 2) hciconfig hci0 reset
> 3) hciconfig (check hci0 interface up with valid BD address)
> 4) modprobe -r btnxpuart
> Repeat steps 1 to 4
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btnxpuart: Fix random crash seen while removing driver
    https://git.kernel.org/bluetooth/bluetooth-next/c/c3c0ca20d8f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



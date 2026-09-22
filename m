Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4A05519B0
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089278; cv=none; b=SuKfDCv3p+idjEf0IEieFVwWuOFcqgyvBlpFA1SK8BmKmg7r/22cCFZol2cu1eS73aXNdYQ7j9oHZjsGWAWwoBvRftoTbGEePrrxHFdhoyYlkSK59+58MxbwZxfUyctRnRj4VelNAayFbPrexPEobCB5k+MaDI7BApiZ8P+7X48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089278; c=relaxed/simple;
	bh=1bvbG2OK1apnae+LH/pwUBaAs0LT+80miD/QEREmozg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VMRQceqcpKpvnZvzYV3nPYVNbguMZUfV+fgePWEU/lj4XGjHZpjZFGjZiy6ehrYtE2zdeI97H5B1c5WoN+LOHKv9RjIhdVW67IISgbjLgm0ofIEsFtf1Q45x/fVu1XcKzCeZPMBJBjKbuI/ArRvJ30BSAhWVkV0keUJ7/YaVpTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqXTW7u1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqXTW7u1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A5D1F00893;
	Tue, 22 Sep 2026 15:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790089277;
	bh=+QxdWcBAGWhoIdHKcjrvHedzm67Lg+sipzrH6ca4B4o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TqXTW7u1PTr2AX6pKwkxa8nnc5U6AGF/4PYan60ICZpIpjdI95rJHzbSuYdFHswW4
	 pJZ7g+/OCjoGt8/t3iAPT8tH+hkw1G5zw2/6STiTFaWBQzHou34wm4yQYMjN+pwQ21
	 7JQQlgglvXfYI9CQx3fyE462/GbzHyLI2ctaVejzhq4ZljPf8Dm/b4sE2Pou4HclfE
	 Mkn2iItTww1UZmKdvN38Z3hUDGp5+juRK/iGAf5S9YAfYPn9d2iKQOcUtgg+SJpJba
	 6qZ9lRrilvahTow60S+C3Blgfe8CuO395yZctxFcQL4xG7PRRwHQ6M3GP8U/VG9CkT
	 nbyslE7wfryrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9D59F3811A4B;
	Tue, 22 Sep 2026 15:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/3] Bluetooth: btintel_pcie: Add support for Intel
 Draco
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179008920839.4126096.16030209434566087844.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 15:00:08 +0000
References: <20260922061744.20192-1-aluvala.sai.teja@intel.com>
In-Reply-To: <20260922061744.20192-1-aluvala.sai.teja@intel.com>
To: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Cc: linux-bluetooth@vger.kernel.org, kiran.k@intel.com,
 chethan.tumkur.narayan@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 22 Sep 2026 11:47:44 +0530 you wrote:
> Add Device ID for Intel Draco support
> 
> From lspci -v -d 8086:2731
> 
> 02: 00.0 Bluetooth: Intel Corporation Device 2731
>         Subsystem: Intel Corporation Device 0012
>         Flags: bus master, fast devsel, latency 0, IRQ 16
>         Memory at fe000000 (32-bit, non-prefetchable) [size=16K]
>         Capabilities: [c8] Power Management version 3
>         Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
>         Capabilities: [80] MSI-X: Enable+ Count=5 Masked-
>         Kernel driver in use: btintel_pcie
>         Kernel modules: btintel_pcie
> 
> [...]

Here is the summary with links:
  - [v1,1/3] Bluetooth: btintel_pcie: Add support for Intel Draco
    https://git.kernel.org/bluetooth/bluetooth-next/c/8f23c4275314
  - [v1,2/3] Bluetooth: btintel_pcie: Add support for Intel Draco
    https://git.kernel.org/bluetooth/bluetooth-next/c/3035e42eca50
  - [v1,3/3] Bluetooth: Add support for Intel DRACO
    https://git.kernel.org/bluetooth/bluetooth-next/c/2157da3f2298

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



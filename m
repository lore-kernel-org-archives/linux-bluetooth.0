Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEF22EC55D;
	Mon, 10 Nov 2025 20:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762807235; cv=none; b=LSEwy4dxN2q5MqBIw6Fol6UOw9U9Ac/6G0nN533FPkPuILJObsb2k/ZKcMKqo097Ysn+hVERMAIiKvdWZ7LDE4XUQwnwQWiSIYBXMda5vjgxOWEtU/3TQHOJ7kesU5XzrQMzt7AD8cXVl1f9Vr359Ri22mdWtYxMM5cU0TbhLbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762807235; c=relaxed/simple;
	bh=yvVuJ3S5UkHC9cGkQlDEFVd+dhhMdhpGK18ZQmNo1W8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EuRXnFmJWsvalziWpGAfe8JxjsuiP1FLN/lJWZ8Tt72Pk0FxhxAhAPym6r6kBeXab+eGxSwnxhzFFej09E8bi3XwVTVjVIg+g15z9B7yOkbVzgyTYbAPAJlxa27c4i4TTOqgXpGimVbvlBoSKy5XcF8pYgWQKadeuAYM2OSn8g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbBHDqQj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbBHDqQj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DCAC19421;
	Mon, 10 Nov 2025 20:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762807235;
	bh=yvVuJ3S5UkHC9cGkQlDEFVd+dhhMdhpGK18ZQmNo1W8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QbBHDqQj5JDcqA3B2b0VAo6xiGT3ExA51cg26u+GKZeRS3XS2/13AnbgjBVJqX+dt
	 Ze2G+dNCfuR/vvgXzkXvdAby5CXu4suWO6lFB4KITV5uMZvPpOyXIJQV5/zRdefmFz
	 uB+d0fBgzugVMY6llf64X5XR3F/q1zhaGjpD0deBvTFW1XTVws9t8F+MOUwK7gc4T2
	 zrLeWhvl27feTGlJpQ8yvJzNkj/1QMCfohTYXfErmZdR92czeMJihK7hux7Ay02r08
	 eKLpmznz8aNfEqNE+yNUxGanRoyP+IZgS7F4fp00Id8389cTk2TnNi2FuqcEu1t8mM
	 DV83Aifb3f+ZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF82380CEF8;
	Mon, 10 Nov 2025 20:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btrtl: Avoid loading the config file on
 security chips
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176280720577.2767842.12707890897825880564.git-patchwork-notify@kernel.org>
Date: Mon, 10 Nov 2025 20:40:05 +0000
References: <20251105120204.458231-1-max.chou@realtek.com>
In-Reply-To: <20251105120204.458231-1-max.chou@realtek.com>
To: Max Chou <max.chou@realtek.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 pmenzel@molgen.mpg.de, hildawu@realtek.com, alex_lu@realsil.com.cn,
 niall_ni@realsil.com.cn, kidman@realtek.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 5 Nov 2025 20:02:04 +0800 you wrote:
> For chips with security enabled, it's only possible to load firmware
> with a valid signature pattern.
> If key_id is not zero, it indicates a security chip, and the driver will
> not load the config file.
> 
> - Example log for a security chip.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btrtl: Avoid loading the config file on security chips
    https://git.kernel.org/bluetooth/bluetooth-next/c/9063119bdaee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



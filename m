Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1C829429
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Nov 2024 02:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730774421; cv=none; b=i/+OvKVe9lcTJK85Op/vmeQCLMpgfhPRdc/XJlsL9Me2Y5GCrCbOhV7LfiVS+OESAkbSuZ9Q5ik7bjYPmY+2Pgz2kxvcVnS6DX6ZtGDvm+Em7cQ4RHc+QcfvOeNlH1happBh4MJIji3vUx+Y9PH16V+ICxF3TKh54nAMyaF1t8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730774421; c=relaxed/simple;
	bh=bjw0abEBejSsrqbEEsij+K5YgqkB2cfCKmxm6eZO1mc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OVAtTe/bp+rjUCLygpRfEfWhAg3PabKO1q1o+JWZv1WBehbKySiRLJIp5Nky/uCdO2tJGFH8pQtkt5fJKFKkuzZIgQP2vPYY/hxSXanlkHXijcolKn9Lf07h+bSqeZ90sEWqcYEllZjlppsiiVSXNEAH/UWcMBjAZHscfv5pCFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSRXXJyT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSRXXJyT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD131C4CED1;
	Tue,  5 Nov 2024 02:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730774420;
	bh=bjw0abEBejSsrqbEEsij+K5YgqkB2cfCKmxm6eZO1mc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uSRXXJyTgZk6CBdRCTTRanJtIHZEueljohoaY7WNgf3tygKY/2h0henLwACvUtjbq
	 FL7d5UDvW5S0FYesGMFPif4BkBCnATnzoYWjyBlpagpW/kyJUAoVupS2G5h6hEjEYM
	 vkAaQfUhuixslSxhB+IHP51YPFHmOchKAwkf5Km3Og7YVuPxbUwyKMXB6Pzu0o/kTJ
	 KUxOIstAKbsxSPBYqTJJY+L0PLSxfyge9Qeg4mP4vDVGOIKjXxqpwp7Z7AIJbb212M
	 yEcK4RykpzcaJ8PNraULvSpWv9ivbvfCmDr230lecWpxXXRBgeN642k1bxLALcaDUm
	 ihxOZR1Nwm6Vw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B11323809A81;
	Tue,  5 Nov 2024 02:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] gdbus: define MAX_INPUT for musl
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173077442952.94328.12638972168323806008.git-patchwork-notify@kernel.org>
Date: Tue, 05 Nov 2024 02:40:29 +0000
References: <20241102161018.2518100-1-gudni.m.g@gmail.com>
In-Reply-To: <20241102161018.2518100-1-gudni.m.g@gmail.com>
To: =?utf-8?b?R3XDsG5pIE3DoXIgR2lsYmVydCA8Z3VkbmkubS5nQGdtYWlsLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  2 Nov 2024 16:10:18 +0000 you wrote:
> This is the same solution as was done in src/shared/util.c
> ---
>  gdbus/object.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Here is the summary with links:
  - [BlueZ] gdbus: define MAX_INPUT for musl
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9d69dba21f1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



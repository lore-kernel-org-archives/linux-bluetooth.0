Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A998E3A759C
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780596607; cv=none; b=dUgjbDgVrJnENnFairKQSgxABSbBKvzAxi3uC8G9TucqJuFlDjfqAL7LLlK9OnKj0Zz8MVa9ozd2StaxRm+n3c8o5DLVn91v7gxd3JKuMrGDLr3Jw85xmWZzKN4p4lYDG2UlVi9qPhs3LVXBocFcXGxNJUjIZVPb7aTxW0Jr3rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780596607; c=relaxed/simple;
	bh=IBTWVnsQ7YuZWTPdBAZEzKRKYtSe4P18H/L15ryM8hc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sfOFWIEybgybMWUU9Mrd1ww77xUzwudCmi/Uy9oap0Ha1tESmGez5z6U7V9EJ/hbQWTKKZcXjkWxp42XA4EGCcG59OLFIPtDep/kvWiZGh6R6HkxMcbHdDGPIHUdetZy3DeOVYg/RkS8cTvmcD04hQRqWnJ6op9ejs/UVnZHfI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TENybSJy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TENybSJy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83ADC1F00893;
	Thu,  4 Jun 2026 18:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780596606;
	bh=UoRts0FylQhTN7o2uaZxve1O27BHpDNqakzCsFFWxj4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TENybSJyBI3YFn24smnCO/JwNlv0LK/YZuLGBdvhl0DUqU1dwWTIbblv5iRcHvTwg
	 Pq4SsizIw5LLJb9rUHoondOXbWsCScRi/INpwiKiAdpgQcBPjvCL2f6TRwnmgjrxdk
	 HV7IFveWQeYZh2Z9Z8GUcPifym35tXWhywxH1p1MDCbq/8RdyZMxoxSRVyrrFpOIi1
	 Q1GQBZspuotU/AEaIP9q9i1FBrd+A0gZZby7UBQjSnBZfWb4T62JAK1DT3KnuLHkcG
	 pSaCQGw0Ym7Iu+K2q6EfBMg83/OlXUF5zK56wj4UhkI2xFkr0hG5GlYrLovDvoXa9Z
	 g6OXYnNGmYqYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9395D3930A14;
	Thu,  4 Jun 2026 18:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] profile: Set L2CAP IMTU for OBEX profile listeners
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178059660738.2966613.14116596268653434566.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 18:10:07 +0000
References: <20260604093024.3594022-1-wei.deng@oss.qualcomm.com>
In-Reply-To: <20260604093024.3594022-1-wei.deng@oss.qualcomm.com>
To: Wei Deng <wei.deng@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com,
 cheng.jiang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
 shuai.zhang@oss.qualcomm.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  4 Jun 2026 15:00:24 +0530 you wrote:
> The default_settings entries for OBEX profiles (OPP, FTP, PBAP, MAS,
> MNS) have no imtu field, so ext_start_servers() creates the L2CAP
> listening socket without an explicit IMTU. This causes the socket to
> advertise the L2CAP minimum of 672 bytes in L2CAP_CONFIGURATION_RSP,
> limiting the peer's outgoing PDU size and degrading Rx throughput.
> 
> Add an imtu field to default_settings and set it to 32767 for all
> OBEX profiles that use L2CAP. Copy the value in ext_set_defaults()
> and apply it to the listening socket via bt_io_set() after
> bt_io_listen() succeeds.
> 
> [...]

Here is the summary with links:
  - [v3] profile: Set L2CAP IMTU for OBEX profile listeners
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=646014a6a246

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4481ACEAC
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 21:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748380795; cv=none; b=tuRarRnL4SoPaIiuwHrm4o7V4lbOas5pzWAOS96j8RxGSIl7ATYCqI6mE7kUJ0VZl91DsN4zBfKObJzzG+RLsH6NDZx+AzTt8ghETiii7LYrxH6qwxkSf9BIq4Do3TKj1Tqna4kZxD1wK9UxwqdXp0424S2/4P+F2NqwQ+k/Psw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748380795; c=relaxed/simple;
	bh=OgkRTEHNdaxO2g3l43Ej+X8r2MqHJ5i9xs5VP/9YYYo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I/glyxrPwOANAh4WzX/6lm+yangKF+5X2wmE+m/fA3hNnYVGUF44ffZtKpUUHmzNArm/VoYINvBs0SEjuC78EMt3QetesySHnDI+NzuwP2rE4CPWa0cB5YY/EmOi2eKv3E0P/3m3rPxMlBr4EBQaGf73RkopTCBNRjWKWG5Qdk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgnhxNmA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgnhxNmA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A81C4CEE9;
	Tue, 27 May 2025 21:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748380795;
	bh=OgkRTEHNdaxO2g3l43Ej+X8r2MqHJ5i9xs5VP/9YYYo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FgnhxNmARE/4byy7tN5QbArIpTW3rQx3ulnGfI4pVM1DMlrJd3D1YnryL9yPRncNl
	 AHailwNZMk93oZodOENsmed5UwpnFhYgjnAWz3eHXxnTQkmnvLIIo0UsjkYJb0MJ2X
	 cm/YtxldvEwJs8hOgJF366Ap7+oQjPEduDt32YUurFMM4tEM8jUDxdS0C8s66aouCN
	 TZnnCxogrKnHDTJPaykuVN5kX2FD2kAsUsvOyxrknnKp+9C2PO0xvxlpeeJewwLRv6
	 tNqnBWfG49k8HqrWvBpitATegfrRmCSOey3faRCrxpL7NfmUIPBQXkoEEzGlNr07YM
	 nfHDZTvSo/WHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C9F380AAE2;
	Tue, 27 May 2025 21:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/bap: Fix not handling read offset
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174838082899.1782235.3898516272529033323.git-patchwork-notify@kernel.org>
Date: Tue, 27 May 2025 21:20:28 +0000
References: <20250527132831.232633-1-luiz.dentz@gmail.com>
In-Reply-To: <20250527132831.232633-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 27 May 2025 09:28:31 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Some attributes may need to handle offset other than 0 in case read long
> procedure is used, so this properly handles that for PAC_SINK_CHRC_UUID
> and PAC_SOURCE_CHRC_UUID.
> 
> In addition to PAC record this also uses
> gatt_db_attribute_set_fixed_length for attributes that are considered of
> fixed size so gatt_db can handle offset directly.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] shared/bap: Fix not handling read offset
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=088de118d17c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



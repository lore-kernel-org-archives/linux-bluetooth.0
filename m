Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D9C18E37F
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166635; cv=none; b=udlwTAmRE77wIYIL8kUc4V82yg6kx+B6XU6AvNeX25Oshcv8l9ylm7b9llbeGx3WJH7tODdpnAHHMr/WhXGphIiOpEfrEUZjEE8Hzdt7ao7mmBliFpXtNU1c0L7oPaUYkyGYt9TRFEjVeHowH2ClE78GybFfC0TMWrZyfT/1UPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166635; c=relaxed/simple;
	bh=ZGWwKc7Xl1wAURNm9v4SToyOWn1DvqErqo1tIt5kTPw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iPibVbWyu+qLVyInQhQY9vcc6lodge8rW9878mmP+GzOBOfsLI1mGstMfbsJm0w7nE399yfMSRIuHM5/m0BhPIoUGSOV3eY/LksaGSqxaKgYkpJXACiFL7z0y3fKBXznGzxkXBpLsYTllalxXPtjUMD21D2dTqh/KtiVRZZSimA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKDG1Idp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKDG1Idp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4BAC4AF0F;
	Tue, 20 Aug 2024 15:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724166634;
	bh=ZGWwKc7Xl1wAURNm9v4SToyOWn1DvqErqo1tIt5kTPw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LKDG1IdpVTOTNBrC8A7pgw88bFD7pFRqmhfCde/zcgASSelHi14U1JboI56bj0bo8
	 VZBqYkQ6eB86JPfcXGhtdKtICnOLY7WBt/hv3DtjGiXLrHpbEEWvodrLi4gUrecSUv
	 GLWdYBF4qwG/XxOcBi+5hGJDcwKgSJR6GNgCvcLF9AQof32F5JWkPxpiPlsPO5uRRM
	 QoExr6PHTsInP8Kp+5kYlLOMrxhhZRIVRkjpfoGf6JYVaE/mDijk/URW6xIF2Zv7DN
	 /rrTpKALcJUfKdH3qvyV5ohoQI4lcyArG4nQfUJK9QySiOmWy/R88gw3E+UiMmvbAy
	 ons8cSdVTvBXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710003804CA6;
	Tue, 20 Aug 2024 15:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] hog-lib: Fix calling bt_uhid_destroy with
 invalid instance
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172416663427.1167792.9706817781376720312.git-patchwork-notify@kernel.org>
Date: Tue, 20 Aug 2024 15:10:34 +0000
References: <20240819205304.60594-1-luiz.dentz@gmail.com>
In-Reply-To: <20240819205304.60594-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 19 Aug 2024 16:53:03 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If the hog->uhid cannot be created then it is pointless to call
> bt_uhid_destroy as it will likely just produce bogus output as in:
> 
> https://github.com/bluez/bluez/issues/529#issuecomment-2297350805
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/2] hog-lib: Fix calling bt_uhid_destroy with invalid instance
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1cc3cf08c493
  - [BlueZ,v1,2/2] hog-lib: Add logging when bt_uhid_new fails
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d5c68dbed1ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



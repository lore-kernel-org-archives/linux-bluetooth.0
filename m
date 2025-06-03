Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA741E5B8A
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971800; cv=none; b=ctCU0EgiEB2gbJJt3aRNKREQjbCVOhc6nBRtIy/TpeGhwyU2hbO8Erl8hM0kbfFkfZiMYX4+Boz65n3jI5IsszDmLIkUPEtdwXb841R9P5fOjpkoAs9+zvqXnH8CcS9kDoIGtMtxsWOFpX8i7/tlRqHYpoMeA5aPWD+zMSPDONY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971800; c=relaxed/simple;
	bh=Lv5M6iuDXtOFndgAGymF8QO1EzXoHOAUs6R1Y81cVP4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hb5HM1G5Ju4FU2bGCR3AQiQ8IETKkOOujvUx6cV2TrbIKaoEiXGopMzDTw3tR4urRNzytG3LCx6pEDM4hoBqPlrZdaHnKGLATqWF/WwGJ8RgmpDyJUwQB2ot4CqKEfoay+mKzMAxVn3/z9DNdgbhKqjgQ0bzi69vO+J7Cuo5LII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYObwUt/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYObwUt/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DD9C4CEED;
	Tue,  3 Jun 2025 17:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748971799;
	bh=Lv5M6iuDXtOFndgAGymF8QO1EzXoHOAUs6R1Y81cVP4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CYObwUt/qupy3//nk1Sc9GFmNHC2T34b71xyEgd2lMFIjdwt+xnfE0J7Hplo+hViL
	 oL61Pq9rhRdBikOLph/Y3RKPZ70CZHi6twO2rOSrxJyobd8aYIaHfsP1WjmRCS8kxT
	 f31IX7wbatTVo1hDutnokW6DXgpHXZB4xMxEJlKmwv2yI/qTPbmKrJxKicI2fahWnF
	 CS5czQmkPciOor1o+eR9DblMZ3LRC2WF9mCbqVjunGsaY6kL6wPlRmCSzAr5gNGg7A
	 DEsVA24vODuLW8meTdd5N8rkzah/c4m5iwIg51tZ4Yn27R9gKDqds/fmsp++oAWxez
	 wCrf27zO0ksYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CFF380DBEC;
	Tue,  3 Jun 2025 17:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Do not start mpris-proxy for system users
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174897183199.1598265.1883181146579603180.git-patchwork-notify@kernel.org>
Date: Tue, 03 Jun 2025 17:30:31 +0000
References: <9d7984b8-79c6-478e-95c8-28a6d4a7ba9b@aerusso.net>
In-Reply-To: <9d7984b8-79c6-478e-95c8-28a6d4a7ba9b@aerusso.net>
To: Antonio Russo <aerusso@aerusso.net>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 kernel.org@pileofstuff.org, luiz.von.dentz@intel.com, carnil@debian.org,
 agx@sigxcpu.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 2 Jun 2025 21:37:20 -0600 you wrote:
> A default installation of bluez results in the systemd user unit
> mpris-proxy.service being started for all users---including root.
> This unnecessarily exposes system users to any security
> vulnerabilities in mpris-proxy.
> 
> Inhibit this default behavior by using ConditionUser=!@system.
> 
> [...]

Here is the summary with links:
  - Do not start mpris-proxy for system users
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=99861c249c86

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



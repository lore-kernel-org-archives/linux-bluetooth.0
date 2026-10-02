Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F99F4DDB38
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790953209; cv=none; b=htjOt5OVa9R1LVE+VmI+nt7mB55P3bzrUH7VnnVStUfv7Oe/qPG+1ButYh7+VbaIPbdQoPv2GwrMugIC35+2a3StnrDQg2HPVQX1uVMzmtcYNQYwJmvCIKW86huw+UM+ai+Fs+k+hh0QSaes0sa2p0NweLtHKb34qt8iBiE7p2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790953209; c=relaxed/simple;
	bh=ULHTcULBXs6Gjwc4yLky5UkLQ0nSnjBKj/tSrvwon2o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AsgwFpwQ59yviqTeW2Ynh4fdPDgGM+lKHseo4WQqzsGc9FpFT3fu8wGeLYWE7DT6ulOX1khasloGnh8lIBuK8SxjZq2zvI7AyF05nkI+MPbLLhkKpJSQRSgl3cvP5prfkLiHruVEBhyT/60MdDcm5ST/1unHS3xYC+r5s4rKucI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXrtqcA6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXrtqcA6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86471F000FF;
	Fri,  2 Oct 2026 15:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790953207;
	bh=VqdOtH6GXQ9RrhzV5Gk5MUEWvgiu1L+6axL1d85yIsg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aXrtqcA6x8fFwkiBqcTzTZJKL8JWG2ukWj8I7nRUIMSUgGoN55Ma3tp9SIajr8UO6
	 mtMXjZozkyku4BBAOts+UtdQR3NKtYgSrtdqhOjpvjh2j0ApCPJiiw9wRI6uDg/YmU
	 BhUz+h4oqKwiiBK4JCrLALm2xqDVdBRl2OrxJf99BqU5IfcODAm+YWpiPVKq6ziXkO
	 xhUZUa+pCdQsXOZ0U0GlpO505ZIhe8yv8QWimPxzPQJoVnnlA8wPiIgRRA/V+RwlJq
	 Fzm+fSu2pHnFiX3gjhyzKsaTuNOLLuKy9GPTnwm8BTwHYoJoc/VsotBzXwXaZz9CNg
	 ABFRC8EqeE+cA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B43913811A55;
	Fri,  2 Oct 2026 15:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/6] Add Connectable property to org.bluez.Device
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179095320641.3455312.4778781139268053078.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 15:00:06 +0000
References: <20261002054618.30994-1-kevin@simpleble.org>
In-Reply-To: <20261002054618.30994-1-kevin@simpleble.org>
To: Kevin Dewald <kevin@simpleble.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  1 Oct 2026 22:46:11 -0700 you wrote:
> bluetoothd records whether each advertising report was connectable,
> from the Device Found event's Not Connectable flag, and uses it
> internally, for example to pick the bearer to connect and to drop
> temporary non-connectable devices when discovery stops. Applications
> cannot read it over D-Bus, so they have to guess, e.g. from whether the
> device has a name, which is wrong for named beacons and for unnamed
> peripherals.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/6] org.bluez.Device: Add Connectable property
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=75a778e17f49
  - [BlueZ,v2,2/6] org.bluez.Bearer: Add Connectable property
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f890d4b660c6
  - [BlueZ,v2,3/6] device: Add Connectable property
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6afb6e729270
  - [BlueZ,v2,4/6] bearer: Add Connectable property
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ab50d5e88fb6
  - [BlueZ,v2,5/6] client: Print Connectable in info
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=82f671c83429
  - [BlueZ,v2,6/6] client: Print discoverable broadcasters in red
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4dc15be8ee3f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



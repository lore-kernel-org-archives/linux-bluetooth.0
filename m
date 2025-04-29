Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0CB21ABBD
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 18:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950189; cv=none; b=swqgOTkDvPsDf7nGO/G4lZeg3mlrRwd5GQwX7BuiwRmOARNoBbBPDjiWu3TS1Kev1n4qA7zrr/CU/DOVPLf6Xf8Uguuv6W5qSFk9lWk7LAE2o8md8nsDSZF5uMJdaIiTcy3bxDO1PjREYZeQIq4HJmE0kx5xYNfp7hs2mlA7j9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950189; c=relaxed/simple;
	bh=aTg0J4DibgpevXvy6GzRTD7y+hmOCNPvitCbkHzHjd4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Whymo4XYWRVhKdgqcTeZ/iBFXAGM2QgwBbdX8jTvEOSy0h2FK1/TvFycF+SHbY6phoOcg2ntTvjFs65lm7wR2J53NoMVqtQgWLu8gF26zixWeKF5d7EP49ecr80C3BVxO6qvb9oHXLl7wFzUJjTfD/oioRjV/cKbLx9KYSj4rUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8e49UNx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8e49UNx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCB8C4CEE3;
	Tue, 29 Apr 2025 18:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745950188;
	bh=aTg0J4DibgpevXvy6GzRTD7y+hmOCNPvitCbkHzHjd4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N8e49UNxmsWWYwEcRvYWXs0rqQ+alNv1sc8XMJ+J+Cggj3N0hIDfj9W8TzT/kcApB
	 QlSw8u3ImZHiPrBuQANQwEUXWNXEwWzChi8oY/EM4T9V4KWnGRWQPPmBX1hxMm0eef
	 s11ngoUZC4bi2J3mtoUuVxuo9AbKhWCYgRwFFE6f7PJYkaekxa2oAGoanmRoKcdFeQ
	 B71vOibRLUNSShPpN3zWp4aQKg821MxTyvyR9LBNs/TyWAO2F15s2kTMWhX+aDsR7h
	 K77tDBAOhclhmU2DouSarhrUislsswaSRjgt1jojKKj8hes4F2+H+RcXGvaX388r/m
	 SGr1ElFBRFpRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE503822D4C;
	Tue, 29 Apr 2025 18:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v5 0/6] obexd: unregister profiles when the user is
 inactive
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174595022774.1757079.8232614301525449852.git-patchwork-notify@kernel.org>
Date: Tue, 29 Apr 2025 18:10:27 +0000
References: <20250429141533.803295-1-kernel.org@pileofstuff.org>
In-Reply-To: <20250429141533.803295-1-kernel.org@pileofstuff.org>
To: Andrew Sayers <kernel.org@pileofstuff.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, pav@iki.fi

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 29 Apr 2025 15:14:10 +0100 you wrote:
> This is a follow-up to "obexd: only run one instance at once".
> Instead of refusing to run parallel services, it unregisters
> profiles when the user is inactive.  This avoids the need
> for tmpfiles, and avoids issues where the user with the
> obex service logs out, leaving obex disabled altogether.
> 
> Luiz previously suggested moving this to systemd, but I haven't had much
> luck getting the systemd devs to accept changes, and Pauli's mention of
> elogind (i.e. logind without systemd) suggests it's probably better
> to avoid the dependency anyway.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v5,1/6] pbap: Support calling pbap_init() after pbap_exit()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9bf6bb654ff7
  - [BlueZ,v5,2/6] obexd/bluetooth: Support calling bluetooth_init() after bluetooth_exit()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=29f3c07b8dc9
  - [BlueZ,v5,3/6] obexd: Support creating private system/session bus connections
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=237d818ef294
  - [BlueZ,v5,4/6] obexd: Unregister profiles when the user is inactive
    (no matching commit)
  - [BlueZ,v5,5/6] obexd: Support sd_login_monitor_get_timeout()
    (no matching commit)
  - [BlueZ,v5,6/6] Revert "obexd: only run one instance at once"
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



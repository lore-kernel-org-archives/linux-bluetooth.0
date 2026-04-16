Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D000022541C
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776355835; cv=none; b=XSA750n5M3zPKdOuv0b3SiJdZWLbrbRNI/Cb55SR95r/ChYPXoBSipyZKCVOYIwp+KSXuK+JpfwZJ9LbBuibJ14EoDGj2yMG9J9ZIKZKEiBL4rH2hkq3BzFtV+T0NV69G9FCxVvytDRekar4tvd9guJhzxqWmp2L6ZfZjNEIDXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776355835; c=relaxed/simple;
	bh=L0mfc0b1CzaWk/QHTKhkVOH5BiArkeroIBsZ9xdOQDk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uXHf/OFGGSlrEocWisimHHyA5NWyot/c86ix+IK3bIxGMvM/ru3qXPGX9hbgplJYoDi68XD3BDiby1ie07ZaUhhqV8MXBEp8hyECWfdHqCItTUOSeSBimzhOikyL7/Bj64S/L8o11KQ7+Ks8r1zL25WwaeyseZ7qLKnb788/gOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4hxhQqX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4hxhQqX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAECC2BCB4;
	Thu, 16 Apr 2026 16:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776355835;
	bh=L0mfc0b1CzaWk/QHTKhkVOH5BiArkeroIBsZ9xdOQDk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P4hxhQqX9sfW68tw8dZW6Avq41vWBGEhCjEcgSWl9oTK11Jn9rjIgNR9kbz4q5RKR
	 N3q/KHeicps0DIKP4bPdH2LqEFVRx1yc1A6Le+gmq4BktfU/B/MuQKfMv43C8a8iT6
	 2WLjf6lPIFzlNVVqWY30w8h2h9+9P0Icwck7XPpvEAV8NyvlYat8L+3Yv5CobtBXU4
	 nSzh/x5io4Tw9S6fjb9XqDV6GjNwC0FO9qYt9RbHUT1TMDQZV9Lj+GR1RIKAk8a5T3
	 PFVTAop9KbLSUdAv2gO9dwAIe7UZQFV1cPN6oYghLfFh3UKwq2++dDHymh4WwhGPiJ
	 /9SnWnVbuh6kQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE1B380AA67;
	Thu, 16 Apr 2026 16:10:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] client/btpclient: Add GATT read and write value
 supports
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177635580405.3299139.6040204220940361931.git-patchwork-notify@kernel.org>
Date: Thu, 16 Apr 2026 16:10:04 +0000
References: <20260403143631.545312-1-frederic.danis@collabora.com>
In-Reply-To: <20260403143631.545312-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  3 Apr 2026 16:36:31 +0200 you wrote:
> This stores the characteristics proxy and handle so we can call
> org.bluez.GattCharacteristic1 ReadValue and WriteValue methods with
> the "handle provided by PTS - 1".
> 
> This will allow to pass BAP/CL/CGGIT/CHA/BV-02-C and
> BAP/UCL/CGGIT/CHA/BV-03-C.
> 
> [...]

Here is the summary with links:
  - [BlueZ] client/btpclient: Add GATT read and write value supports
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=15080642a414

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



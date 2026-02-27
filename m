Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2BA392C28
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772217601; cv=none; b=XYCEC8PeKLj+4GfYr/YCPCG1Pp4BUye0Jl4htWhztOxwA906n2CrM9+VtIMy3LTrXGeQ/NaZbmkgKnN9+QVEGaRqbkhAhzE2/8tEe7QpbwK+Sq6xhe9NlDNdIWY4+HRzlD3Ft1+w1z6Dcy26Nlwqr1O5u3tvZIAbBTBEkRLbEVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772217601; c=relaxed/simple;
	bh=FMD+bQKGCC3rI7hqw5Vppj5a8376D0GQWvtuanoNIsc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nvXes3SsbUIxYl1nQZ3h5Z3cFuO43rZGJhFkXdZZnzQBSQx9kxDlh9dEAC8R2Lb4f6hKce9F5GJTFiZbA35c+3JEeDSbHmbROIAZX4rtqqXiBXE8OPOGQA+UWv378T7FMiTiV78oAYmxWaXpp6IOliJX3FcPmPUKgmu0U5F04X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkXtIEOs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkXtIEOs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8786DC116C6;
	Fri, 27 Feb 2026 18:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772217600;
	bh=FMD+bQKGCC3rI7hqw5Vppj5a8376D0GQWvtuanoNIsc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gkXtIEOsMFuK6kMRLea4npeIdWTiJWDxazhZn6dB7ogwfMObdHqzGt22a1A0pxcLe
	 l96SkYJ+fWrot3oHmcTTYVP3j4MSzn4fqP4V2sDSSrZ0uHBy/vGmzxAKbdxVTglR3H
	 JsvpWAEAnNk1AfTMUGMEovpw9fQVUNsbL+YmG3z/VGcoe7qOuMYcr0ZBjmf23KUD/e
	 yebGOSfy0s6rG3W1NwESf4KOdP2NqEUijhOFJsQ2RofJd7JLHEze1KiTgZ821aQKCk
	 nTiXRSuJ6F7+Enpsgf6DjAVBsrvLqZG0kZ43nPFktO92KL40hm3RzLbwE2/7TdZLDZ
	 bOhHMeI9PFtuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE7B39E9614;
	Fri, 27 Feb 2026 18:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: L2CAP: CoC: Disconnect if received packet
 size
 exceeds MPS
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177221760429.2708334.15032717992066352331.git-patchwork-notify@kernel.org>
Date: Fri, 27 Feb 2026 18:40:04 +0000
References: <20260226204357.361000-1-luiz.dentz@gmail.com>
In-Reply-To: <20260226204357.361000-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 26 Feb 2026 15:43:57 -0500 you wrote:
> From: Christian Eggers <ceggers@arri.de>
> 
> Core 6.0, Vol 3, Part A, 3.4.3:
> "... If the payload size of any K-frame exceeds the receiver's MPS, the
> receiver shall disconnect the channel..."
> 
> This fixes L2CAP/LE/CFC/BV-27-C (running together with 'l2test -r -P
> 0x0027 -V le_public -I 100').
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: L2CAP: CoC: Disconnect if received packet size exceeds MPS
    https://git.kernel.org/bluetooth/bluetooth-next/c/cb75c9a0505b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



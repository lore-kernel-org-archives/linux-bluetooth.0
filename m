Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BD91B947
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716235230; cv=none; b=Pvl+V8jkoGLIUcCAaFAE9BwUSElGN3NglCAhcoqg9Bnjm3ck+mmvgLPKpqqV4Z3YNYOpqkLoju3vuCfJRnpNaDWut2E9XThVDSPkVnOs7wr8WDEyFyV17p9ilqCeJsxznDzSUzfYlKLFCWhG4zEIWD2Jzve1zKkEGdPkzzabEoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716235230; c=relaxed/simple;
	bh=Mvtp5W0CFCY5/nNJIuC2BAd1klCZhacco9vGGMqnRts=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XhZVjIRQmqHFTMfNfgYnWveaifmfokvdWfwAu+fwLATk8EpkAqugxm7tHcrsh6OXpq/hoUzjAz7jPR5rCeC9z0a9ZYOi2JgklO5n1ZkM5v7Rrr7mrKXPw9mJDcyYKiVqN+OwlG4j1oK+BK+pusuiSwpL8P6niHVuI5pLcdA9dR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXKTkWcB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXKTkWcB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 316B8C4AF07;
	Mon, 20 May 2024 20:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716235230;
	bh=Mvtp5W0CFCY5/nNJIuC2BAd1klCZhacco9vGGMqnRts=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HXKTkWcBlXsdq8sZnMPMT3SFW3lEDUzPhp06mO95bWoH//LbboqbYO0NAqqYOs/oj
	 NC/UF8g5TYC7EWoKsEKDUslsQ6UT/1Fu+WUCbfUv9u2gcWnWBszPjXi0yPRaASk083
	 MWm9QDH9YAclj9SwrTCW9rYFcRrpqByBxMNUxniGeacejohn881bQHDfdkfLT8I4in
	 plseixz37q0gKnkPD5h/9eQYf4ABi61aelOcGlmqklDwlxlNOhSakW6+mUXCfRuXqj
	 ks+ESdMpGlV9cy5841i1l6ah1ti02mNQnxM0bFfPcwLVcB2flMT3Sl8mJW5GrM7wh3
	 KpHzj6SKyw+kA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22494C54BDA;
	Mon, 20 May 2024 20:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/3] device: Add btd_device_get_icon
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171623523013.22228.15466448160017910242.git-patchwork-notify@kernel.org>
Date: Mon, 20 May 2024 20:00:30 +0000
References: <20240520181439.1407634-1-luiz.dentz@gmail.com>
In-Reply-To: <20240520181439.1407634-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 20 May 2024 14:14:37 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds btd_device_get_icon which can be used to retriev the icon
> string of a device object.
> ---
>  src/device.c | 12 +++++-------
>  src/device.h |  1 +
>  2 files changed, 6 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [BlueZ,v2,1/3] device: Add btd_device_get_icon
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=25d3b629e4df
  - [BlueZ,v2,2/3] hog-lib: Add force parameter to bt_hog_detach
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=db383a5b4a8d
  - [BlueZ,v2,3/3] shared/uhid: Add special handling for non-keyboards
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e4f6c68f2a4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



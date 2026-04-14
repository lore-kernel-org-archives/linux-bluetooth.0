Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB9135E921
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 21:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776200439; cv=none; b=Bqpst0A7ojPrzn7rMnlJe3GGfECrUK5bgfv5DodtLLRifLrl1rhEfsHdTTwg+swuV7rq5BpBRFGFmO+fKfsStk5j+ghIl4NmrdkIaN2F5/MHvff5ggZuKWUG3O9dTuIeAYCi58Xdpc5tu/FDsPMkesOoW7loDgnUnsaInjXZ3Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776200439; c=relaxed/simple;
	bh=sz40yqYG+6U4+z0HnK8bFhxFUftTvMhfpq4gUCVG2xs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y+A0Kgo3s5sSODsuCmSTKB/Igi++UdEqFelXjfnhnRkstKKvxYjIXeYMUqZ8tbBG+s5GqblQ0G7LMbAC3KDEzctEP++0OKa3pkjjeKgJQhv664abCuUDhszCw0iTh1tTCaCeNYViL4AvFazM9YUZAp8M6DSX1D/03p7VIWB600k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXhGh/UV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXhGh/UV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754BCC19425;
	Tue, 14 Apr 2026 21:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776200439;
	bh=sz40yqYG+6U4+z0HnK8bFhxFUftTvMhfpq4gUCVG2xs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LXhGh/UV3rI4ICrffKmY3+t2xHmFctrKCfI9L/r3GZfSYzLwWSgmMR8WgajqN5aos
	 ykWr3TJ12wDdkIAqpwLjnK3gDdyn9FUixWGpzC5yDxi7DVmARokHKKQv1w7oQdn88K
	 G9TIDsFeA/6eikFrzmic54sgjtNsHthprJlJ6iauxIpnE66QQFdApWXG9fTqM1lKEA
	 5sd34a7I46B6Kijoq41pWDSZgT8w5egReLC+9975Qa/WZGNdk8Ifl3h1Z1Qp1Ul5uB
	 uD45Kgpid4zTvvhewdEDzkk/jha5L00/jJH1M7b5cLH1rOPxOtjBubTskyU6stXuRG
	 bt8Ajhc0Su54w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C453809A0D;
	Tue, 14 Apr 2026 21:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH Bluez 1/2] monitor: define manufacturer company IDs
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177620040979.1468596.8665372680347270723.git-patchwork-notify@kernel.org>
Date: Tue, 14 Apr 2026 21:00:09 +0000
References: <20260414111307.3725821-1-apusaka@google.com>
In-Reply-To: <20260414111307.3725821-1-apusaka@google.com>
To: Archie Pusaka <apusaka@google.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 chromeos-bluetooth-upstreaming@chromium.org, apusaka@chromium.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 14 Apr 2026 19:11:10 +0800 you wrote:
> From: Archie Pusaka <apusaka@chromium.org>
> 
> Define company IDs to make it more readable.
> Also remove an unnecessary if that could cause uninitialized variable
> warning.
> ---
> 
> [...]

Here is the summary with links:
  - [Bluez,1/2] monitor: define manufacturer company IDs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=babc5699226b
  - [Bluez,2/2] monitor: Set msft_opcode on read_local_version_rsp
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=510623fb53b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



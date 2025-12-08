Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB9D2BDC01
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Dec 2025 19:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765221792; cv=none; b=T+d0LtmeG59aH9qq00810ScUSXXUGivFA+zqI+SAjlJhGjYeKllXCvZywyT2TDl5z5ECVg3lqkT/49OyqETXztQ6L3BgYs8xCcHCV0IPWVmDUddJ89D77GE751uegR0QPzz1P8lGA3wVz2XkNabu2Ww8wfVkKqYre380awP+wgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765221792; c=relaxed/simple;
	bh=LlIo056RnbWTkRyhlo7zL4mdXSXH6+FAOWFJam79EII=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hv8DBSXl2lqYZ5nGN+d/8jvptdTsMofCZpg5UQXnsfbU/g4EwwJNIdbd8B3joCdtYVmMcHy9qyiBMaGrmxMSfBZAAl8Z7g4bPOkhZQNOBEVSGnVXTjukNcL8oU+vQl5ahBhJ6l+YGXrixaZmUISYE00SkXZlBKqlkxqwhGPVR5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TC5K2hCV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TC5K2hCV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26CDC4CEF1;
	Mon,  8 Dec 2025 19:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765221791;
	bh=LlIo056RnbWTkRyhlo7zL4mdXSXH6+FAOWFJam79EII=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TC5K2hCV0NbB8Vg1LVIhkCIEhnbUlyRkUpKU3pB1UAzjUh55Xkz6VVpx3E5jwFNAw
	 GW5dN5zRja9poXMjWslGmHhv/725hDC8ZJvW3svjoXm1cYWL9Jsx0iUsQBpPTH+oQS
	 5/iDe7I2gNV8wK0id9UUKHKPiw/h4niAL5VmeuHFRADuWlh0O99fBEhfBAf9kX9Cav
	 Ba2Kp2LLk0nxHcji6KH1eQd4O/fYJEkeNue+gapuukaA13UiwNCWfGtGDjy45fKzVW
	 bjcM1+czblrEHwt/9LX3aPjaC049QoB3HRGF9hzzQcUbhGWcm+zlpm0HpezMaYFg7v
	 KewwsMfZRVG9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 788E93808200;
	Mon,  8 Dec 2025 19:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 00/11] Add local TMAS & GMAS servers
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176522160728.3263133.6507468362496372245.git-patchwork-notify@kernel.org>
Date: Mon, 08 Dec 2025 19:20:07 +0000
References: <cover.1765018766.git.pav@iki.fi>
In-Reply-To: <cover.1765018766.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  6 Dec 2025 13:01:16 +0200 you wrote:
> Parse TMAS and GMAS features to expose from
> MediaEndpoint::SupportedFeatures
> 
> Improve handling of changing TMAP & GMAP features: set the service
> inactive when there is no Role set.  For GMAP, we must also remove the
> feature chrc if a role is unset.
> 
> [...]

Here is the summary with links:
  - [BlueZ,01/11] lib: move VCS, TMAS, GMAS uuid strings to uuid.h
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0e5f8b6431a3
  - [BlueZ,02/11] shared/tester: check size before trying debug print
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d3b7f5324ebe
  - [BlueZ,03/11] shared/tmap, gmap: add macros for feature names and listing
    (no matching commit)
  - [BlueZ,04/11] bap: use tmap/gmap macros for listing features
    (no matching commit)
  - [BlueZ,05/11] shared/tmap: deactivate service if setting Role to 0
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=814e54ba288f
  - [BlueZ,06/11] shared/gmap: deactivate service or remove feature chrc if role removed
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b8d21420af2b
  - [BlueZ,07/11] test-tmap: test removing and adding role
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ef6477828392
  - [BlueZ,08/11] test-gmap: test removing, adding, and changing role
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=60d707514295
  - [BlueZ,09/11] media: parse SupportedFeatures from registered MediaEndpoints
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e4b968ca4f28
  - [BlueZ,10/11] tmap: remove service on device remove
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8dcfe76b1b39
  - [BlueZ,11/11] gmap: remove service on device remove
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f1bcd84a0fb7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



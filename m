Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAC82DFA34
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984390; cv=none; b=ZchO9VIg/b6ZyauwO06o/IwUkQvE+x+SR5O07dkmCWckSOqKRZzRg2fZzVNhLYScY+FhzTgqZ7jTgKi+vVSS4mFuWTuMRZwvt/d18rHLafsxclWE36S5HJaiiOyMp77AZEDb81cpzgIkUkxBsNQ3OYQ7Sw6xgmxA1tTbF1Bpui4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984390; c=relaxed/simple;
	bh=1whSn3u4ovOBpNlWwj816JPDXbmwepQ/YVmMgJIr3No=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iUWezl+X0BsD6tzXwe3Js3N9Y4TmfYmlWFNEaxJkcLInHjoxi7iMFto37Jqnp87h0mvvE7LuVf8hGHnK9nTZ+vrRwU6LAbs3IsuVQ/Jctp2vJXBlWa8R2y0X8gbDDVhkRPuTUFCMoJlStj82K+J0iFIbRsBbtfancrMXyk7LOOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mf3F8E1U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mf3F8E1U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B34DC4CEED;
	Tue,  8 Jul 2025 14:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751984389;
	bh=1whSn3u4ovOBpNlWwj816JPDXbmwepQ/YVmMgJIr3No=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Mf3F8E1UQo8gPHrmfPDZh+BXWsoO97fJSh61+C3e5MKc/3sRxdYu5zJs7BJLxNi8z
	 +x4r+zWBh4IsBqr8n4a1RWMHr0HOysbDI4zK/PTI8xfs0krVRNQSo5MBwiPMiYBnIa
	 35ooLVO7VRqD4jXyfB9QeS4QpThggEGgzxcMkBTf/Z3rWee7Xc4hJhEVA9+GjP8eQs
	 sIeWyqzvhPmaIPEpnRPwgcZQRI3/ht7i/PoupxPXwlICseu62y1aEoMl/01zvE6yd6
	 /VVeFJp5En7aM3ydKuWNhU5gv3uOf0DMvXNvvxAQQ1XVZ37W5rqUWhhzbGy7L5SqFB
	 0tPnQEwaiOw/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF6F4380DBEE;
	Tue,  8 Jul 2025 14:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] doc: Fix extra word in doc string
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175198441225.4082479.12486760916280775346.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 14:20:12 +0000
References: <20250708083948.1822604-1-hadess@hadess.net>
In-Reply-To: <20250708083948.1822604-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  8 Jul 2025 10:39:36 +0200 you wrote:
> ---
>  doc/mesh-api.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,1/2] doc: Fix extra word in doc string
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9fb0e002fa04
  - [BlueZ,2/2] midi: Fix debug string
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=18cbebbc7252

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84A217C205
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Sep 2024 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725903037; cv=none; b=N8BhXWqKgdb4IXZotfSvjo40NFxARLAlb8cI/ZPmPKLya6eyMiJzdoU+e2Ns8R3lC2ugFifWCO8RQVOGGzorT7aMuXlUu6nWNOHPlx6hU7dxhIwBlyxxl8ZozoUsn55LZTxfiQB6EavHYTuBOV7pyQCSTw3VKu83vW+JxPs0VK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725903037; c=relaxed/simple;
	bh=S5+EjS18f+DJOczQgrFIkjcM0WxfUrY9Pp4V9gmeWtI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QhnwHbg176VohxKuTyIGoDsW97TpU7Bpy3okBDLj3eA5xOhUZZ8VxeK92H43Rwns3p5cDkUTfVdleqdJ0cnkaE0P9pkA0IGZjKqenxE1hykaJ4iL8fg0uMEz3kZfPA2KwU0JrMFA5Z7Xw1Jq56qf67wy4U7aW3SWCMpH5tGde9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnC/elGP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnC/elGP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74553C4CEE1;
	Mon,  9 Sep 2024 17:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725903037;
	bh=S5+EjS18f+DJOczQgrFIkjcM0WxfUrY9Pp4V9gmeWtI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZnC/elGPLfWGBJnQHNzkq+6QgZVKvFeHAWw/0Q8AO7NzIbz7XZYsxeMRluUcd5y1D
	 FzqGRZAe9oDfpuGDGcP2d78mH0Zkdvec1tdW4wFuscoWkxmE/Y8Zyd4wqYDaqrEKBf
	 TfKzsBGDc0C5bsrKXsYNJYYG+OqF6ppdhtGYRFmRTIf2/G2v8dwKDfLi7YRkc6tUBO
	 IWvHyDLotkJFJXpFXZ29yIp/uoObA/MeokJbbSGvOSWN0Av0738OBzvks6aNxblxJP
	 h77J0BBOdBhagUDlV114h22PM/vPbOXCvGdqZQkwL0WzwQTR38jIqgleLJfPHIBlqm
	 /rdx2sL3/qycg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE02F3806654;
	Mon,  9 Sep 2024 17:30:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] transport: Fix broadcast sink check
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172590303849.3870513.11045093016032310184.git-patchwork-notify@kernel.org>
Date: Mon, 09 Sep 2024 17:30:38 +0000
References: <20240905141340.65495-1-vlad.pruteanu@nxp.com>
In-Reply-To: <20240905141340.65495-1-vlad.pruteanu@nxp.com>
To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com,
 iulia.tanasescu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  5 Sep 2024 17:13:39 +0300 you wrote:
> In transport_update_playing a check is performed to guard the path
> which contains the TRANSPORT_STATE_BROADCASTING state. This branch
> should be taken only when the device on which the code runs is a
> broadcast sink. Thus, the UUID check is wrong, and this patch
> updates it appropriately.
> 
> Vlad Pruteanu (1):
>   transport: Fix broadcast sink check
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] transport: Fix broadcast sink check
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=54866cee3fad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDDC53E34
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 21:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMabFPFN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BECF2C433C9;
	Mon, 11 Dec 2023 21:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702329023;
	bh=WUP/w4foPV72LNL4T2ldRf1xA/Gu4By8mwgYXjkC4ao=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YMabFPFNnA2/phZ9Kko9IoxT7EuWishBTGz+kdmToJXy9FdK9hWCGFNVgzHsHnuGV
	 woVIc5HzsL8mhaLa6lWBTfi96Hn1KTwygieXqBttUOKaeVxsqU4wTgkPPxUKsEvIPd
	 COvADyYLX6dPzWFqoRdThIHFpWwI4c+CUIE0agt3VXq/6ck8cutuL4dcW6Worc8l8Z
	 R6IT/mFZykJh9Zs3ZWHLfy5hsBQgaxJG0Y4WRdhzcL8eRaV8dJmOqNmwT+BRBmh5xV
	 PKgYcmIyko82nB1wOz38E0d49S90eRVFsXCzcE+Iizi4lnHEaWNX4RMqDFUVQQDWYn
	 5/tBlJTpPKgVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6B34DFC908;
	Mon, 11 Dec 2023 21:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] bap: Don't attempt to release if old state was
 releasing
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170232902367.13252.3467344920515041557.git-patchwork-notify@kernel.org>
Date: Mon, 11 Dec 2023 21:10:23 +0000
References: <20231208221219.54529-1-luiz.dentz@gmail.com>
In-Reply-To: <20231208221219.54529-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  8 Dec 2023 17:12:13 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If the old state was releasing there is no reason to call
> bt_bap_stream_release yet again when IO could not be created as that
> will likely create a loop situation when the remote stack caches the
> codec configuration.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] bap: Don't attempt to release if old state was releasing
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=093d00b47ee4
  - [BlueZ,v2,2/6] shared/bap: Make bt_bap_select match the channel map
    (no matching commit)
  - [BlueZ,v2,3/6] org.bluez.MediaEndpoint: Add ChannelAllocation to SelectProperties
    (no matching commit)
  - [BlueZ,v2,4/6] shared/bap: Make bt_bap_select select a location
    (no matching commit)
  - [BlueZ,v2,5/6] shared/bap: Fix stream IO linking
    (no matching commit)
  - [BlueZ,v2,6/6] client/player: Use ChannelAllocation given on SelectProperties
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



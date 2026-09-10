Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6D739E185
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057875; cv=none; b=nR+bZ2U3qqWqz1nNJJxBJizciSqDuFJJ8kMU0qsTU7j/olZvj862/S4pjJcNLyolYJYymIuJyHJbrNTEaRjBGkqx4L158d+0zb/DAqGQNOzzgiSjZJZmi21n6Sy5c+RpLgYpyosZNXPQ1GPxlk8u7l7h7AQuW2szkSFRgjqHxm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057875; c=relaxed/simple;
	bh=3Q2VrQ08pA4YmX2CQKsiE7toEEzqtIYxnXkJJqIoAVI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kcfVDTjt6srb5UOnDkaBlTRgGJZ2d7GoyQvpWw8K/lkhnOmu3BYMVeRDofMva2P29MQ0aP1H72ZBn+cDkCHhf509lEx6V54sD8IFN3oAHtNk1Wmprcunic43mydkeiy4WrEp696OjTxK8E28mtWUTfuhPZZWjvKMdmJVnc2ot+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlxqVJqY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlxqVJqY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E613E1F000FF;
	Thu, 10 Sep 2026 16:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789057872;
	bh=CUdXCF3yGbCkNdmc5hJ0ie9q50kpuVMkoImmRiLnqak=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FlxqVJqYgoZsx+Z2ukNZppOXnNGwGzzF5kByXVJ7ZhbhD4vcQJWcXD6CtEpKxboRu
	 WZb4rK6l+d1N5Rx44GS7Cx0sUF7GWRhLJ2pCeG4MfF99esh0yPShCfAnfy0s4BOCBI
	 l+ZnorKo5M7jDrUp4079bbxuklHe20i4EYyAZ5C29PXCj5MnFvNeqaNSG0Q3jpTHNq
	 U6JbmY8KcWz7Ux+ztF91UzWSGeDSFDIIh+vWZ3IrIFIMqEFQ5vvtztqiILNQmrJetX
	 048HXsfjMldaXP+CjdBon9ADxJdiSSf3b4fhqKB3YkbOo/NWxNTYy04S6cDszx0OEm
	 TtAeudiWKNRJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9396D380CFFC;
	Thu, 10 Sep 2026 16:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 0/8] client/btpclient: Add BAP/ASCS/PACS support
 for
 auto-pts BAP tests
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178905781038.1735972.6039510848479561946.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 16:30:10 +0000
References: <20260910084917.23512-1-frederic.danis@collabora.com>
In-Reply-To: <20260910084917.23512-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 10 Sep 2026 10:49:09 +0200 you wrote:
> This series extends btpclient with support for the BAP, ASCS, and PACS
> BTP services required to pass the auto-pts Basic Audio Profile test
> suites (BAP/UCL/*, BAP/USR/*).
> 
> - Patch 1 adds BTP_EV_BAP_ASE_FOUND, needed by BAP/UCL/SCC/BV-004-C
>   and BAP/UCL/SCC/BV-019-C.
> - Patch 2 fetches Codec capabilities when replying to an ASE.
> - Patch 3 introduces ASCS BTP support: audio endpoints are registered
>   via the VENDOR service's ASCS setup command, and the
>   SelectProperties() D-Bus reply is postponed until auto-pts has
>   requested the ASE and PACS characteristic values, allowing
>   BAP/UCL/SCC/* tests to pass.
> - Patch 4 adds BTP_OP_PACS_SET_LOCATION support to store the expected
>   location for a local endpoint.
> - Patch 5 adds BTP_OP_BAP_SEND support.
> - Patch 6 extends ASCS support to cover the BAP/UCL/STR/* tests.
> - Patch 7 fixes CIG/CIS id assignment to be deferred and based on the
>   Unicast Client/Server role, matching what auto-pts expects (0/0 for
>   Client tests, 1/1 for Server tests) instead of eagerly assigning
>   CIG 0 to every discovered ASE.
> - Patch 8 adds automatic stream acquisition and data sending for the
>   BAP/USR/STR/* tests.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/8] client/btpclient: Add BTP_EV_BAP_ASE_FOUND support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=06638a3983fd
  - [BlueZ,v3,2/8] client/btpclient: Get Codec capabilities on ASE reply
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6679d89c7c6d
  - [BlueZ,v3,3/8] client/btpclient: Add ASCS BTP support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1f4dbf07531e
  - [BlueZ,v3,4/8] client/btpclient: Add BTP_OP_PACS_SET_LOCATION support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0aa5118f4c87
  - [BlueZ,v3,5/8] client/btpclient: Add BTP_OP_BAP_SEND support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a0d138b16027
  - [BlueZ,v3,6/8] client/btpclient: Add ASCS support for BAP/UCL/STR/* tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2a0cee7a5af1
  - [BlueZ,v3,7/8] client/btpclient: CIG/CIS assignment based on Client/Server role
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b2d128190799
  - [BlueZ,v3,8/8] client/btpclient: Add stream auto acquire for BAP/USR/STR/* tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6cf877bf5a61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



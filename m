Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC18231BC94
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765553594; cv=none; b=NGrpQmVlSlnCBJLQ6/YOFbCl28XISVt3aRLmuunJJM2IiETtZzej7SL712m69jbj4RGcaB3NDKDWNSYUatlAN1nMC+i7zHMhwaP+0ccPSkbRjUV5wKOYzCveMsxBAFg5+Su+1g+B9Yq7D8k9qTixJDXI8nXV1PVVB5KFJez1p4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765553594; c=relaxed/simple;
	bh=HG7QqH2/8H4wYIo/H4JM35pvUXwoRSTsrudEPiz99UE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IteKnnCsPReM5z5gwLnMuTWDOnFnwwHR7G8FAmFux/zK7hAotHNl3H5nCZNbwzmtpR1LWshAkxz2kkY+iuTwaQKF22wD4o2UvlgoDnGo45viaPgzlUqq53Se60RdD8BUhiJy8av/soawdV3CjfEe7mYVoRiNtSXNCBVcYu+yqDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6ov96Ds; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6ov96Ds"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3013C16AAE;
	Fri, 12 Dec 2025 15:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765553593;
	bh=HG7QqH2/8H4wYIo/H4JM35pvUXwoRSTsrudEPiz99UE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E6ov96DsGTP9OHzhq/TNlcDDB+zJxDFQuOiF7T9pOIsS0yM8Bg4d+d4CIKopt4fJL
	 X6PIqVoIA7Myu/skkciqN/iD05ZrcL4bydFDc6uH6gev4Q84CiOtdLV3TBGxWainaB
	 EaOypwWG6IZ/b9ZkPV3tlu/6EbK2i52wYC9JO/cGMpdnU49KWnCRIWvIclNHUDC93X
	 WVSWel9JgyFSCE2GIGHIjmDryUBFQRQXSCSVRTkcFMn2nfA4xOUEAUSDxXS8xl1DSX
	 36Ejzg2UTK6JIPli7//IHSzOe7z2ACTCLVl0urnH5wI9+23q76peFhYAmdUNieF3m/
	 IhdQZ4C4+gLVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3C3E1380A945;
	Fri, 12 Dec 2025 15:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/5] doc: Add new telephony related profiles
 interfaces
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176555340704.2197478.17460749133700260525.git-patchwork-notify@kernel.org>
Date: Fri, 12 Dec 2025 15:30:07 +0000
References: <20251211183429.419619-1-frederic.danis@collabora.com>
In-Reply-To: <20251211183429.419619-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 11 Dec 2025 19:34:25 +0100 you wrote:
> These are interfaces are meant to be generic to the telephony related
> "headset" profiles like HSP HS, HFP HF, and CCP.
> ---
>  Makefile.am                 |   4 +
>  doc/org.bluez.Call.rst      | 140 ++++++++++++++++++++++
>  doc/org.bluez.Telephony.rst | 225 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 369 insertions(+)
>  create mode 100644 doc/org.bluez.Call.rst
>  create mode 100644 doc/org.bluez.Telephony.rst

Here is the summary with links:
  - [BlueZ,v2,1/5] doc: Add new telephony related profiles interfaces
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=270b899e9630
  - [BlueZ,v2,2/5] audio/telephony: Add shared interfaces implementation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7204618e59ad
  - [BlueZ,v2,3/5] audio/hfp-hf: Add skeleton for HFP profile
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cfc372d4f21b
  - [BlueZ,v2,4/5] audio/hfp-hf: Add HFP SLC connection and event support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5c7bb3096021
  - [BlueZ,v2,5/5] client/telephony: Add new submenu
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b3677421feee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



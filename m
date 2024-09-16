Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3610B2E646
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726509034; cv=none; b=lJCbU0EQNTZiLkbsYgog6CCYfRpw48wbgPQHKU/x55jb3xcG1TkoB2oKTDZOyq27Ym9v24cL3uwxqZ7I2SY4fUpNhXUp9ANi19sEd/SWq18p+JsrSsGSqLB7dnGwerJ0Q1U3KN+C2+nchd67vnuLFvD7qHNv6Qg8PplTynHs3EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726509034; c=relaxed/simple;
	bh=ItwJAhgZdeqOpBvno+NF2xZOh4nFWbuy9H1RyIVJK5I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V8K2w9drbQdWP+llznDOfA06mBTLNfFHJvfwqlM848nWnAPAozkTd0MSFn3M/C3y8vgBAs5bl/gF8b5S82bEtxj8CeFbxTfhnstLYQThAqCkubJBzQTPVU5L8j3RgFKApEP3KVCmjVRQm9gnOHyDbRpwvJxFo4yFGNbVCsdEQJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNAu+/08; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNAu+/08"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E9EC4CEC4;
	Mon, 16 Sep 2024 17:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726509033;
	bh=ItwJAhgZdeqOpBvno+NF2xZOh4nFWbuy9H1RyIVJK5I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MNAu+/08/jJVH/FIibTKMi3geEuza2AmRWM5oxTjE8CsVycy5V4cloq9vrQgKM5lx
	 dfYwbh/JnL5mUoZrbhScUuRAOIHa+V3Fsrks9O4uLpBDc4/uc0oWo27D8WwPTqyqac
	 IiHDMGa4IlOrsigJEJSmI/Eiftvq5d+eKsaI34AFF8l9ssRAJEm2hg37uY2LMs1I6H
	 H3ErzUaBNog68rCPspRFYwsPI9EVgIGeu7TBL6Xc4fF5Z4upG4gHTtCB0Ipr+XxsOD
	 ecNKMh6Lq7rOndS068qXWMXXAWhrsmBJ912YdNP5XQS3huksShlEwtKB2ev1WESSNp
	 R+e41hhmDuPBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710803806644;
	Mon, 16 Sep 2024 17:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 0/9] Add BIP for AVRCP covert art OBEX client
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172650903526.3772607.372385221396717448.git-patchwork-notify@kernel.org>
Date: Mon, 16 Sep 2024 17:50:35 +0000
References: <20240916132813.165731-1-frederic.danis@collabora.com>
In-Reply-To: <20240916132813.165731-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 16 Sep 2024 15:28:04 +0200 you wrote:
> If AVRCP Target supports Cover Art download its SDP record contains an
> additional access protocol for OBEX with an LCAP PSM on which the OBEX
> client session should connect to, with the specific OBEX target header
> 7163DD54-4A7E-11E2-B47C-0050C2490048.
> 
> Once the OBEX session is connected, the AVRCP track metadata will contain
> an Image Handle which can be used to get the associated image using
> GetImageThumbnail or GetImage with one of the description property found
> with GetImageProperties.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/9] obexd: Add PSM support to session create
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5d7d3ac25bd5
  - [BlueZ,v3,2/9] player: Add OBEX PSM port for cover art support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4c05a0ff41c8
  - [BlueZ,v3,3/9] player: Add image handle support property
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5cd301e888a1
  - [BlueZ,v3,4/9] obexd: Add support for specific headers in obex transfer
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8562d0e3874e
  - [BlueZ,v3,5/9] obexd: Add BIP client for AVRCP cover art download
    (no matching commit)
  - [BlueZ,v3,6/9] obexd: Add GetImageProperties to bip-avrcp
    (no matching commit)
  - [BlueZ,v3,7/9] obexd: Add GetImage to bip-avrcp
    (no matching commit)
  - [BlueZ,v3,8/9] avrcp: Update controller SDP record with cover art support
    (no matching commit)
  - [BlueZ,v3,9/9] doc: Add description of org.bluez.obex.BipAvrcp
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



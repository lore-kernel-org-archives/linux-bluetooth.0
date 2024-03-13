Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EC9523C
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710343232; cv=none; b=WqI3igXk2qapSPV2dFtzpcdT7arT7Jpv9BsbZ/nPnR18vjOo2jfpgv9Zr8VqzINswqKxCiI7pZFcquRO0cIVJVWVxRYG6ZLN/35AX2sCJPbQoMejWLIv31eyTz0VXye0n1VXK+yEyQlf9OFM2BwJPGhXTgTsNFATHDEhTCOtx0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710343232; c=relaxed/simple;
	bh=PFu4WzBjUmqptacNnEUjCvRmxowGdkZFlJTpQMJAr0Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JmWLNF7+ugVFqdvURCMkQyyPvgOCjASX3u7+KZ+ezh6/L43YsCSTyPVlj1YIPwzMLjWrR3D+aFUVm76OnHvqrQdsN8dbv8v41U1/nwMrNkqddXFRtil01+TsqNZ002jBr5uqY7YSQleJDJv57Tme+c9oG1GVKd7lf++FnkYtRIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJN6Ry+s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJN6Ry+s"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA12EC43390;
	Wed, 13 Mar 2024 15:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710343230;
	bh=PFu4WzBjUmqptacNnEUjCvRmxowGdkZFlJTpQMJAr0Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TJN6Ry+sQnuu23FIYEogld1uwmByovDs2XkPiqTN0An7ux7MvNeFaxDwTnERWIMxK
	 yhlTJQCA8VyggvT4yYhoT4cKJebUfZYVHKH23GWcgTdZYyypfvTO5tDAnFsoiqz20Y
	 SDhuwhl3Yj1+ZEsEUScrjoXhKphSzAJ7s2EHIot798gLciGRBNnVeWzNGWN4cGdVaW
	 cRLENOwFpBy1p0btGk5q+JX0qQ39owAQEYkqVuVxFrksRSKt53+mxI74d6UZahin/3
	 qECL+wrg1wcwXZAqrB3jITXck5Mng+gPmEsedpwHCL0sWK9+9/Ekei1PSnGD0bDtIy
	 OaYUbVSjj3jHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92E3ED9505F;
	Wed, 13 Mar 2024 15:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v4 1/4] shared/uhid: Add dedicated functions for each
 UHID opcode
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171034323059.496.16490811193100411222.git-patchwork-notify@kernel.org>
Date: Wed, 13 Mar 2024 15:20:30 +0000
References: <20240311224327.1023070-1-luiz.dentz@gmail.com>
In-Reply-To: <20240311224327.1023070-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 11 Mar 2024 18:43:24 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds bt_uhid_create which uses UHID_CREATE2 and tracks progress of
> when the device is ready to receive events and in the meantime queues
> them while waiting for UHID_START and other dedicated functions for each
> UHID opcode so users don't need to build each command manually.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v4,1/4] shared/uhid: Add dedicated functions for each UHID opcode
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=92ed637ab2bc
  - [BlueZ,v4,2/4] hog-lib: Use bt_uhid functions
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=256d0b594d04
  - [BlueZ,v4,3/4] input/device: Use bt_uhid functions
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c0c9e462be46
  - [BlueZ,v4,4/4] test-uhid: Test bt_uhid functions
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f5fecf037b1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



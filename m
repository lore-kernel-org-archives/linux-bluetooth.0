Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B3910F1
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710363632; cv=none; b=gmigWzjRtciYXDpkz4tWxsSudvvy+91JK2nGPFofd36Ww7MSICJsxNOoEe9inGxEDO9p5E6fXVIQaeoEi4BmwNpV+2ZzVu9/V6zt7cAZ0s7BjgRBrqhYjn5wO+wC03WmGOXRNmsntmBG+HIHqZDH8WhfFrK7uyMIcR193i9aX9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710363632; c=relaxed/simple;
	bh=LhhbSEDsgXPEJU2Zk60SHCNO+Vjgnm/0hyELhDV95rk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IfVKIwB84GZVLw72LmCDadcQuacn8XJ2EL6Nb34LYlnZ7iXkw+z9qjpy3ji/6MKuq9UfhOp71umr99T+s9vxO9NApeCetLVT7SkpTs63qeX2c1pg5jX7vQICwnr+0Pw3eBAs5GpFgAu0UJ43PEPbUgghRSm/uCOPmz/ExJWMxEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cf0BTkUJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cf0BTkUJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D597C433F1;
	Wed, 13 Mar 2024 21:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710363631;
	bh=LhhbSEDsgXPEJU2Zk60SHCNO+Vjgnm/0hyELhDV95rk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Cf0BTkUJROTxxT82UJZ7TXJFjQbWXUrdwiCJTyJc10fV4LbZRWqoJowEc31c7vEmb
	 9zxDj/zwtyokPNbeFD5NlSa4urpo1fkGjOSSSXQONt+eWk5yVHf3Dti6zUXutom5bX
	 5l++/0pjvrMfXliJehmp/OJAcetURlcW14tlv5or3jcJPblXMIzMuIcQS8oARgVqeJ
	 akH26NcR6ZcMI7a/UxNFNOrO7YVDuyi2SgVY3wcFTKZRppP4foLgORXV5sJ6q7EJFh
	 WGQ4al6PYdbkGynhmZ8bpABVeq0DFEBYRLjtwULsgNmTgXh7puDfBpjYiWqN4A1Nsw
	 9zu581Fnp3mCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6BCFDD95054;
	Wed, 13 Mar 2024 21:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] client/player: Use macros from lc3.h to define
 presets
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171036363143.351.4951157273036805278.git-patchwork-notify@kernel.org>
Date: Wed, 13 Mar 2024 21:00:31 +0000
References: <20240312155901.1118469-1-luiz.dentz@gmail.com>
In-Reply-To: <20240312155901.1118469-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 12 Mar 2024 11:59:01 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes use of macros for for lc3.h to define preset configuration
> and remove existing macros since they were just duplicates.
> ---
>  client/player.c | 294 ++++++++++++++----------------------------------
>  1 file changed, 82 insertions(+), 212 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] client/player: Use macros from lc3.h to define presets
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cae922c63bd5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



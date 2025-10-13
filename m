Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC2A3093CB
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760371227; cv=none; b=MSuYsKc44JAxeaoyvGUscZQRbYK+vOPUnnEh0lcfQZfp08tJBeIp6OZ2BvwPBKRAYxhfbLvOgWpjTEWcY7bTUALoqxHq/44GZ7GW3Cfj9I6bS/0fJ4PqhZ/FKjHsxMS1u2/hyac5L3Mo1APPXbEhP+VHz5m5bFKJMB+wqe/P55w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760371227; c=relaxed/simple;
	bh=mT8lI8GWwU07piLoI2MNHxI5vTscNzrtLwgUWJR3q3A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jY19a/PClG+/Llw1joLEvkjkng8QH0GxY3sg9aibDKAnbzyp3VOba2ROpFywgwVSSVBKdL0jkPkG8HVmuECGiMlGx/82Yf2mk24VhY9MIluCOAE7PBxuT9SWRoLErznhRITCR5Ryjv44slzrod8mwGETnneXmoDNxob7aBIiMIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fb/LHHpN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fb/LHHpN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263B5C4CEE7;
	Mon, 13 Oct 2025 16:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760371227;
	bh=mT8lI8GWwU07piLoI2MNHxI5vTscNzrtLwgUWJR3q3A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fb/LHHpNWoQxZdRQNIrmUI2kFFp6OllkLOObPkPebENA1U3LFjsGa6djleSP13RCp
	 CofTyLFURz0/w7uU3eAB50wEMCVBuOUuq6LBVcTlBpnzyVexuIsDUw9sDROFHQKIUb
	 4CueYQCbAafxUL+DdJIQPufLE2vVuVGb8xPic9Y1DesITjGezP0/cVygXNFNZg+R8v
	 PxsqRrSaPMeLVCBPkpp3AynIgAO5kEdNxQxnJ/FbZAJwU/XmE1umAAb36vy6u9euFQ
	 W0KT5mJsIoW9V9RV1290DBHvYvmFxpKtaRtSXQAWktllpqh5q14RTBLuwpQOPQjdOo
	 zwc+CKOQ8+Fdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34420380A953;
	Mon, 13 Oct 2025 16:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/bap: fix crash when setting initial metadata
 of
 a stream
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176037121299.3108925.14561811476672040383.git-patchwork-notify@kernel.org>
Date: Mon, 13 Oct 2025 16:00:12 +0000
References: 
 <a2c50d6cae8f2c4a092172ac7dee870405954a7e.1760225372.git.pav@iki.fi>
In-Reply-To: 
 <a2c50d6cae8f2c4a092172ac7dee870405954a7e.1760225372.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 12 Oct 2025 02:29:39 +0300 you wrote:
> bt_bap_stream_metadata() when stream is IDLE causes IDLE->IDLE
> transition and crashes due to UAF. This occurs if SelectProperties
> provides a Metadata.
> 
> Fix by not updating state if stream is IDLE.
> 
> Log:
> 
> [...]

Here is the summary with links:
  - [BlueZ] shared/bap: fix crash when setting initial metadata of a stream
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b3dd59987455

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



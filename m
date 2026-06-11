Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE4F4BCACA
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200700; cv=none; b=TqGywn3UcPPVo9cCngq6NELm+rVhGjJa3wmC29qQNwb97cAd+HkKbDWeG+0feGZJaqLxFu1EbTluQvaPr2cj4gACM8QjCRa0316zmNEt4Zfc+SSlXOjIG5rbcLmmZk+qYl97LoYYgHNFfNUbPuAFMT+I+/EEK21ZbyyFi4zVLnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200700; c=relaxed/simple;
	bh=QuuyoOxniEY2fik8I8LAKc6X425glqVOyVD8pPYHU0Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qmNthfb5TbL+bbW6dpnhxMk45+ot9ClSYE7CvNk5J+CmKno4xIDHPZRuPS9tEwW8IMipHJonOOBfjpbfSd9T3pkGbH4TRrA6YdVDUsJ8mMGygngb7U31MSbIWidb+PtYl/TGY0yMwYo1Ylc28U1tker0SYL8zm8qL68aEAoEo9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQSZ45SO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQSZ45SO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1393E1F00899;
	Thu, 11 Jun 2026 17:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200699;
	bh=1D63zEKwhHEKRFjkUmeB9YgaeBmjabCO5h1FxMDKe+w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hQSZ45SONfEE7a/RneJczkCrdt7xc6wg3hhveDBL+pg/gtyHvc2fb+UbjbUe4bxbx
	 uLH+p4l4l2OVUb/rYpgJC4+gm5r8waBNGAuRTtH3ASsa7M7spPoBOAjVrde9Zo/5Zn
	 VrfY/sWzQNjLO5rRsXAZ+1StaTnIJYOH/6x5IWP1tuNI5T+Km7RYZTtBNfdDi4l27W
	 ulwdXlNr2xr2S9Kfam6Vlz+hqxu9O/QmIJpIp0RmZUaGnTqmHsgDzArfPhoNfYUA9H
	 ZhJfE4UCJ7wDaDo0La73wgUwtv3gO2X9W4o19egcXiHJcAdFEGtylslju679dbsEic
	 YMLFYOmHyvWEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9384C3930F87;
	Thu, 11 Jun 2026 17:58:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: MGMT: Fix backward compatibility with
 userspace
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178120069613.286318.3554840742958501594.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 17:58:16 +0000
References: <20260602205659.212834-1-luiz.dentz@gmail.com>
In-Reply-To: <20260602205659.212834-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  2 Jun 2026 16:56:59 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> bluetoothd has a bug with makes it send extra bytes as part of
> MGMT_OP_ADD_EXT_ADV_DATA which are now being checked to be the
> exact the expected length, relax this so only when the expected
> length is greater than the data length to cause an error since
> that would result in accessing invalid memory, otherwise just
> ignore the extra bytes.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: MGMT: Fix backward compatibility with userspace
    https://git.kernel.org/bluetooth/bluetooth-next/c/149324fc762c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



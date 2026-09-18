Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890003955E3
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789749116; cv=none; b=RFhmnKe6c2Nbd0E1FXCYqqQmG+jEbWxHLz46oJ65+DhdBlLW2a4eHmwXNK/eggS3lpENPz4GWn/a46D22t1aKDojE1wbFd6G99ekat9oD8dKhPlVpt5ddfwhLGBJEAV66Um04lFWqHcDVHrxnYfVOCa0/Dc0BingqdVzJLLarBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789749116; c=relaxed/simple;
	bh=F9eiycObOPA1fJdiDrbH5FjZNknmcOBXsPHpSUXEE5E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rl+O77CIztiB4Xiyrl5S46h5ojMMJkdTvkIFWHB/Ks48laPAgo1SWFM1UE/aIJbPPuRrsG89w3s8tRBlo0SFzSSYuS5UT9tuWYw9AoHRgDkxovO+jEK2KSJJEAKpo9xAzGVV2m3Lt8pTqdcjF1dv3JGjG4f/QpXpV60Yx8dUQQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knjKdBLA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knjKdBLA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4541F000FF;
	Fri, 18 Sep 2026 16:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789749115;
	bh=ZvsEGUDgR1/D5JvJwHjuVdY+KzATEShkkSNMVOhSwvQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=knjKdBLAFbCa9UOp7OagcDFY/1W++CSQgNoG7oDybhdom9WroOiEMDpXwHD8WgXFQ
	 9cldBSUsXeRptT7aK0tO+W/lMu59yFEsjunB0MBU2e4fHu2pj0+aQNAJFNnBYlJVNQ
	 IP+Rfa0M1W0DXNh54cq+9+qVpyBkBDVxwwTAOvAX4KTLwaCdZLIYqdxKmCxg/XAZQ4
	 H5X/GrQo6E4UVlQgSw5ZlbLm5rq2JM8PPEmELuRqft/kot8dxNFhw+3dOQiafiMRB2
	 omOtPzrzyfWV034pdKHb8/Yg5lUwSqDxAVLUBidLXufp4uMVr0wSquE8knNkzdu9O7
	 sUDdQyl7VOH/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A59380CFE4;
	Fri, 18 Sep 2026 16:30:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/4] device: Fix resolving a coordinated set over
 Secure
 Connections
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178974904814.1035983.12606949586547695456.git-patchwork-notify@kernel.org>
Date: Fri, 18 Sep 2026 16:30:48 +0000
References: <cover.1789689632.git.pav@iki.fi>
In-Reply-To: <cover.1789689632.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 18 Sep 2026 03:02:25 +0300 you wrote:
> CSIP coordinator was not finding its LTKs with Secure Connections, as
> the fix in 9251e630efdd to make legacy pairing to work doesn't work with
> SC.
> 
> Fix by keeping track of what kind of LTK we have, and not distinguishing
> between central/peripheral key slots for SC, which kernel doesn't do and
> AFAIK the role difference doesn't exist in SC.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/4] mgmt: Add defines for the long term key types
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=37e483b0687e
  - [BlueZ,2/4] device: Remove unused central field from struct ltk_info
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a82606b8e1f8
  - [BlueZ,3/4] device: Fix resolving a coordinated set over Secure Connections
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4d97be27a1fb
  - [BlueZ,4/4] test: functional: run CSIP test for Secure Connections & Legacy Pairing
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c67833ce2ff8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



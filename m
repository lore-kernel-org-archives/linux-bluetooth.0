Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78EA3AE1AF
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321807; cv=none; b=Yp7ygelSojhfWlZ83KmpvDgIHUtKPq/drht4utAMpxZPXn3iDGsKiFXBvTr0NtjU/bgJjUEMXlegX1yndXABFDId3Sz2ldkteLGM4HGGTyX4AAFvYyNqUSr6YSnSaaeh7dOEgrv9u0K078meZHVuBozZnD6YRKRSc4Gw8/kcUdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321807; c=relaxed/simple;
	bh=cQR6+vTvxim3zzuGTtvJ05obnQibb0yxNG3afq9hzy4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XEMzIEliX/HF+S7qRn1oxMDsIaLaCNRoHdEKSqqEHKrEFRYPfwpLXEdRQfR4bPx6bearAowwK+R3HEKAtmQ4EFRO/vj1ODIvUGBz/vcMqOTylAojseLLTnrZVDr05MWIpjekwy07FDp59yxGZuWwe/buZ0B58Y67x+Ksn2/z9dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bO2Fs/Dd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bO2Fs/Dd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC3E1F00893;
	Mon,  1 Jun 2026 13:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780321806;
	bh=iIKQKnliyxp4+H6fN59W2D+ujaP9YejXm7anDap4Qr0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bO2Fs/DdPEISZOo2gjm1sYg4Tj/88370w5yE7qShbv9OzIBHJTt25fF65VWWVa3Ka
	 38T8WLKDryJidlnkuw9TJ72/7Won4ykNM3MotXO+z/nySy7ZflxdCqM5cvRZ8qb4S1
	 Fp/1e/xetwuu/fFGjNf260sO05f2SVBLZHnqxFCM1oGI1JEbzSm6s9mT1dnft6Ifdp
	 ZZoFdTwfqpFHBHQdLIpv6l82Sxxjg7Zrvsy6SZe/cuTzYRCT+mvU0ZtMmAZq/5cLdh
	 ihi5jva7JBAbU7p2zqCCQRa67IUHXfNUQvIV2Xj+PQkpi72W3e9gmq+SVYa3ZFbsVF
	 vv1GXiRmFpcgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5956438119D5;
	Mon,  1 Jun 2026 13:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/2] advertising: add property with advertisement
 Instance
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178032180913.3687626.10038079212335500385.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jun 2026 13:50:09 +0000
References: <20260531101754.3325247-1-michal.dzik@streamunlimited.com>
In-Reply-To: <20260531101754.3325247-1-michal.dzik@streamunlimited.com>
To: Michal Dzik <michal.dzik@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 31 May 2026 12:17:52 +0200 you wrote:
> I renamed Identifier to Instance and added support in client
> 
> Michal Dzik (2):
>   advertising: add property with advertisement Instance
>   client: add advertisement instance support
> 
>  client/advertising.c              | 38 +++++++++++++++++++++++++++++++
>  client/advertising.h              |  1 +
>  client/main.c                     |  7 ++++++
>  doc/org.bluez.LEAdvertisement.rst |  6 +++++
>  src/advertising.c                 | 13 ++++++++++-
>  5 files changed, 64 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v2,1/2] advertising: add property with advertisement Instance
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b55c0559bda8
  - [BlueZ,v2,2/2] client: add advertisement instance support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e2874db00a40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



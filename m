Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756DB1527B4
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Oct 2024 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974230; cv=none; b=K3JH9EgoWdd2ydF9xClUZRwMjMNvKTc1wcgIinbAPHycHVfwwYCZqVzAvT+x6oUoOahQ+8TZ+IAKeao9WIvMcvYOEXmRSQm6gCSWDC1VHZQe+Foel8D1Ccad8fBZfPC+ZYjipLxAdIly/NiveheVxq9/HlaxLSIjryct1EPTT8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974230; c=relaxed/simple;
	bh=Vwfk1jUnY6UGYyePLCokrXrT06gxmkAv5tD9ID6hEMI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eO+4OOg5NZJz5XsY1TnFBrnn/h6BBo2pfLlai09tifJelg6mRNPPZ0chtqu+On0v3Xbpbr15qB2ogy3agrDzB/RqeiQyN+201VhFf69hz9MDi8afApvylmdQ9YnzZLOFzTt+Gz1OArEQQaK0/wsAFp+M/H+giwQ0+ekUDQR02gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b96LANwD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b96LANwD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15042C4CED3;
	Thu,  3 Oct 2024 16:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727974230;
	bh=Vwfk1jUnY6UGYyePLCokrXrT06gxmkAv5tD9ID6hEMI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b96LANwDkrZD1NMC5ZT91+blaf3UCRGQgsb5jTbBVUElI5KelKidqJo5mEmrExUdN
	 Xpr0H2ltQRbV0DsWm/bEaxNlSytko4OOQg2XmSA5Dkh7DKA6+uDpcvpG7WFTgfY0iK
	 XXgMtdDauzq1R4RMnlwxGHHep0phnh/ZhcwjFikbkpV6GjMpZm16wuJ0oNUYI4Ukqo
	 CPURK86XtYZ1Egvq2p56i/a8aGkKU327NxjWH94o2Pr7Ju/rePL+RHkXLbdYS9wOFK
	 pS0cE8IVTVt8Q8qMtaLXmy5OKjcQKi8ouZ2dkGdn8UvqbneYeawBMSd83xTNQjBiVS
	 NPeRNwb73zOnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCEC3803263;
	Thu,  3 Oct 2024 16:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] shared/bap: Fix load of misaligned address error
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172797423349.1920089.17597415228671448408.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 16:50:33 +0000
References: <20241002133506.16834-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20241002133506.16834-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, vlad.pruteanu@nxp.com,
 andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  2 Oct 2024 16:35:05 +0300 you wrote:
> This fixes the "load of misaligned address" error that appears when
> parsing PAC caps:
> 
> src/shared/bap.c:6497:7: runtime error: load of misaligned address
> 0x502000063639 for type 'uint16_t', which requires 2 byte alignment
> 
> 0x502000063639: note: pointer points here
>  02 03 05  04 1a 00 f0 00 02 03 01  02 11 00 00 08 00 00 00  a3 00 00
>               ^                        00 00 00 00 00  01 00 00 00 01
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] shared/bap: Fix load of misaligned address error
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8146d8f7dd67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



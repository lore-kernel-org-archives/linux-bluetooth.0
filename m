Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4D322258C
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702020; cv=none; b=etayXpBqnUcwq9XliikJqoQHmO0IS94m5TsA0CxpTc44MCs7zK2IV9OF0LiBjrkugv8pmZWMl5g7xAKS7Z2Nd9OXmGU3DYakAlqa8YZRmw2gdlXcskiQkYMH+ThS/1k/nrEn9bskNCRMIpC+vSM2FrZFvmJRc1aCKWjdJBtH/A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702020; c=relaxed/simple;
	bh=jXi9uRP3ltlpn1pcCxE73MEv5Pb0VD0YvN86/RKuwyE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qaxv+DZBDTpqyLUBwA8rs0KKb1okmycDa+dVIzJ7MbYyrplIi9EKQY6c9vW8jX4g6s7uOhv/8t+BX8jxGDU8cZOKUsfcvXQztwoMAcXdP03by/S03BVK+Qx5JXVamXYZFo6gP8yb/6xQxODFE2y1axTax3vX88LHOLWPYbsXRh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIWzIu79; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIWzIu79"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E6BC4CEEB;
	Wed, 20 Aug 2025 15:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755702019;
	bh=jXi9uRP3ltlpn1pcCxE73MEv5Pb0VD0YvN86/RKuwyE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JIWzIu79n5yLYj+Jfizu67gBz//pSLV1T5BiEAulQVGQVbaYsQqfAf4YhFbYlec0v
	 5Bo0+dcjvTFJaEitPFSBd+2ha/MdQIvBuKe0tVjCUW52CBlBGn3JKlG7k/ntFkJalu
	 GMYTc88CeUOFUYzerIkrlcYtweo4ffwFW7Qb92/0f4rR7+O6Ac549Ur6b30+OP00yY
	 MHnnK3rkq1/hgSbR1m64ySeGkgnMd5efbxUNr8Gc/Nwoi3bySO2w20LnCy3iqwWcm7
	 UNEkTSwZrGCJNP0x5ILo7doF11/Ns0ryynLDYDqox0IO5iL2lqe1MsQZu8/KsJSR2O
	 62UDLOeGfuPqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E21383BF4E;
	Wed, 20 Aug 2025 15:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/4] shared/hfp: Add HF SLC connection function
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175570202924.267477.294820890801345540.git-patchwork-notify@kernel.org>
Date: Wed, 20 Aug 2025 15:00:29 +0000
References: <20250820133338.1158203-1-frederic.danis@collabora.com>
In-Reply-To: <20250820133338.1158203-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 20 Aug 2025 15:33:35 +0200 you wrote:
> This implements the minimal SLC connection exchange, i.e. AT+BRSF,
> AT+CIND=?, AT+CIND? and AT+CMER=3,0,0,1 requested to complete the
> Service Level Connection Establishment.
> ---
>  src/shared/hfp.c | 508 +++++++++++++++++++++++++++++++++++++++++++++++
>  src/shared/hfp.h |  69 +++++++
>  2 files changed, 577 insertions(+)

Here is the summary with links:
  - [BlueZ,v2,1/4] shared/hfp: Add HF SLC connection function
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=56b483c7f869
  - [BlueZ,v2,2/4] unit/test-hfp: Add SLC connection test
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fb9b5c04fc3c
  - [BlueZ,v2,3/4] shared/hfp: Add +CIEV event support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bcd94e3e327d
  - [BlueZ,v2,4/4] unit/test-hfp: Add indicators tests for HF
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ed2da1a3786d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



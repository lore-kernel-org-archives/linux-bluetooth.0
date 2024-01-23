Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C985FDB9
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023828; cv=none; b=gf7dh2ATxbDcyj98Of0oFSdtJdU/GwNp0a+nHrdY6RXiJbu+3i0Vmz+x/a2Wr6iFUTQwD+p3L8VqRSwP+OuhOX55F4ElNV8fJFIPDxvMWiXq9EcTen8XuG+ue+7AJ1TPJ0c4ZxcaVBH3ebaN4wmRvemPmswDcQhywqd5sNjUz2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023828; c=relaxed/simple;
	bh=UIYyioXStdzRXEcymKCpAdnKNrUjDnYTX0dPptcj9a0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bufSMlJNygOZIIgmYpJUki22Tq7Y/cp135WMAcNa9JBFO9abLbCT3VuJ/C8j1EArxamqs2Qx0vfWQSzTQ/FwJSs54YpXvMv9Iu6vmxg69s2KwvfCOb2DIL6scEU1Z/OvzQA4r3HAzBHWPRyYDPHPdn4hWChF31aTWLa3qgv+zxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRfp/icw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRfp/icw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67C34C43394;
	Tue, 23 Jan 2024 15:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706023828;
	bh=UIYyioXStdzRXEcymKCpAdnKNrUjDnYTX0dPptcj9a0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dRfp/icwiVeBms8rETe4hxnIXRiWpNxwnb5V3ObgyLs1zVH7prDG8CdVWQ8GoCHNY
	 xcH9xIIgtpE13I++N1r4x35isJufPRYY9RKPnczI0QodUsao1EF+5pyb0Cy3y3l7+f
	 91M3Nq716lNlA/rvoIjAebmQFFTyRQaJ9ykM0GInCqRJJmK0ESLabxFca2uQaP1xaI
	 s24FB3MdXEKcGlQFC3fyu5gL5v5/wyPXjEaddlm1l8QJKg/jGzuMAHr5lHLxE+srSU
	 Uusfsdo+r//X10QnXp4WREP0dUn5kpxdps9xiV00hms+CZoU7p6BZ5PkAqa2g0hYWx
	 +HDdjr1l3HJxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E03ADFF762;
	Tue, 23 Jan 2024 15:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: mgmt: Fix limited discoverable off timeout
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170602382831.6570.11756683923966827620.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jan 2024 15:30:28 +0000
References: <20240122165955.280126-1-frederic.danis@collabora.com>
In-Reply-To: <20240122165955.280126-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@ci.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 22 Jan 2024 17:59:55 +0100 you wrote:
> LIMITED_DISCOVERABLE flag is not reset from Class of Device and
> advertisement on limited discoverable timeout. This prevents to pass PTS
> test GAP/DISC/LIMM/BV-02-C
> 
> Calling set_discoverable_sync as when the limited discovery is set
> correctly update the Class of Device and advertisement.
> 
> [...]

Here is the summary with links:
  - Bluetooth: mgmt: Fix limited discoverable off timeout
    https://git.kernel.org/bluetooth/bluetooth-next/c/53ddef135d3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



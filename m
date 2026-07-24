Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9B14534B3;
	Fri, 24 Jul 2026 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784919667; cv=none; b=FzhHppNK31KPZxHMri9q98IOvLGJkJ2+MpsuaI7JfWZ6mSljZaaGFv1b9RH5N1NhkT3pwYCEh+kmGuIDUK9WPGGQ1UKWesq1BMUO01Bro2EHKT0wNqhyjnsXIcLhwlUrmLW35nS42McaVU/AN443wQSbO+dBeQzvIoiwj6IT3iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784919667; c=relaxed/simple;
	bh=O7U6UuvgPM37RFbIE4Bv7S/Op4g+ZVmtDVHotejccbo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TOoE/mZQPyc5AC5kn4ByOmrKstOwwoU2Tri+JBZ3SmVUKPFAJnmEsfDGqjFKHoD/4FsBoeLYM7P4AhL2Hvxq7unTCJISydKMnvsLmcrCvsjreIWG/zu669u91R8Kv9HzK03xons2vyz2AHMtsadI89m9AS07XeA5v+hV1HHltlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcfXknic; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcfXknic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69461F01558;
	Fri, 24 Jul 2026 19:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784919644;
	bh=39jcuhaHSAFEdeNiQvYEddZegCpRasmGQxj1oRWIaGQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LcfXknicqz5xFyt9aro6u5e41UtyfGbGbpvJMSUy72uANZjHIq/c6RKWmKwiYZv4H
	 5M+EsFGEu8KutY2+KTwjBlDOucvXoBu+NItwMj/W3erblVU0Fg53E2scywJuFjpFrq
	 KCzrSHyvJQ2fBcUcKXslfqO8tqfeazuvPHZzu4HA/b5VDWSiSxC3QeabhJM3vwcodS
	 6vme386ZGy4C49Ia2WhaQ8P7zm+DUmlFEkySFGZ6WHQZl9kx4P+SZRY6sLjYf8gEMK
	 Cs6TrnXhXqubS+MObiqIMpc0ceLcU80RZlbH384FXA5nwhaCvPcNwTJpl0gE2S0AqB
	 w0cksyzMLhosg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A14380CEF6;
	Fri, 24 Jul 2026 19:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btintel_pcie: Remove unreachable break after
 goto
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178491961188.3273549.631267596087912276.git-patchwork-notify@kernel.org>
Date: Fri, 24 Jul 2026 19:00:11 +0000
References: <20260722074315.166919-1-chenchangcheng@kylinos.cn>
In-Reply-To: <20260722074315.166919-1-chenchangcheng@kylinos.cn>
To: Chen Changcheng <chenchangcheng@kylinos.cn>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 ccc194101@163.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 22 Jul 2026 15:43:15 +0800 you wrote:
> In the switch-case block for hardware variant detection, the
> default case has an unreachable 'break' statement following
> 'goto exit_error'. Remove the dead code.
> 
> Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
> ---
>  drivers/bluetooth/btintel_pcie.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - Bluetooth: btintel_pcie: Remove unreachable break after goto
    https://git.kernel.org/bluetooth/bluetooth-next/c/10b4f44f2dbe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



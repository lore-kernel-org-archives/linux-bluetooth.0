Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35D9439F89;
	Tue, 18 Aug 2026 18:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787078304; cv=none; b=hnWj+q2W3n06gnRzkpl2g81MPMwqyxdzsyRu8Vqycw2KaFdiFtJdj11mSAN5Tb3oYJk3+w1dOphGh0VSzhYCY9EClOgu0h031nZfuEnTuU84Ylyo/DatnTDrhWJR8HMJESgeHczlUGkY/+7IU0P54d0zc1kqMhLzoKrFQbUTE24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787078304; c=relaxed/simple;
	bh=9Et6U802MAJ3VBYDma8Je64T8dimNfOPxEopntQKyLc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hN4PQjE2OZbIJ5+UkAIwtPHhscX2dcdO0EbyDOtzMnueLLYjLxodIriy2a9U4A7TwxJTG43XwvFPb9k4opjy5xVLO+ZRJ/qewuSrhrZfA/66LiGjL4hh33epammK+sPiIrL+c9h4MbX27BQygPUrpSAYmVeRRYzXH/4QRGQ8vUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InlbM970; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InlbM970"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEB61F000E9;
	Tue, 18 Aug 2026 18:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787078303;
	bh=8jKWle75SXBkx/oOCKHK5NlLaRBVvcq9G3i8DHlFWVI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=InlbM970mGuCPY03IdKSw2B/poS4Z9OLK+XUIg4MDOgv8tgiZ8dcxhGRyfM3jIW+h
	 ooM5R0aplrU9Axm9He/BxhRDlFJWjjLp6tgK6IYhU0qlDR+inLxK/blr72sf7KcpwY
	 3gzOHX5kotdAUgDuFiBgn3mdcHdTW/oZzFvybuUB+zRY5aHGofZqrrYc+2rzv7BwTd
	 ynvi9FmmTj2FO0sXvNLdzJE/zP/xzWUE9NqhhL3lOpuXbv3UzYD0BbEMs9dgfIkzvS
	 GylOu2lO3idneZPKkDl7L1pEgNiBtTKmKo39UKndSJ3CtlPJ+vzChUkt8kXM36+pFa
	 77PogWsSmFiSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5692D392704D;
	Tue, 18 Aug 2026 18:37:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] Bluetooth: hci_core: Return -ENOMEM when the sent_cmd
 clone fails
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178707825486.2194892.5994990121854718172.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 18:37:34 +0000
References: <20260817205017.56524-1-johannes.goede@oss.qualcomm.com>
In-Reply-To: <20260817205017.56524-1-johannes.goede@oss.qualcomm.com>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, iabdelka@qti.qualcomm.com,
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 17 Aug 2026 22:50:16 +0200 you wrote:
> From: Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>
> 
> hci_send_cmd_sync() returns -EINVAL when skb_clone() fails for sent_cmd,
> which describes an invalid argument rather than an allocation failure.
> 
> Return -ENOMEM instead. The only caller, hci_cmd_work(), tests the result
> for zero, so there is no functional change.
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: hci_core: Return -ENOMEM when the sent_cmd clone fails
    https://git.kernel.org/bluetooth/bluetooth-next/c/57f558cf1a3d
  - [2/2] Bluetooth: hci_core: Handle skb_clone() failure in hci_send_cmd_sync()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



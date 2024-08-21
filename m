Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5D279F4
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252439; cv=none; b=OQ9OB1+3/d9pib0Jlgyrv/rCS1hemBbiQ2FnUgMvtpbjse/lL4YCBXWvxR3MVq6/v2PBUXObyX1/CleYwzhZMWNV/SV60QA8hk5U6+t0rWHTOmaIV1JvIl/cIFRBAP/mlyRR/MnWvOZO9KMdE3bI18jhZ6LsGXlNFGOKV5fZ2Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252439; c=relaxed/simple;
	bh=G2iAvbumuD8tNd8uk13u3brA5FCViIxT7Q6GbknCMtA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qejBch3p3mtFuLebkBg2N+fRntu9zmWnovn5MhhrHXAVFl9E0Ela1kZ+dwhWtf7lYwUs0d4NFNC2RSjcieC7hwcwOhAJBm20HvbyV081AjnHlvr4XRzRpXfagwsfNzBKtDhjALfUlUVjmkPzrqsN1CbITR5+ObXE9sRkRE2kySk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ml2+1e6l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ml2+1e6l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0ABC32781;
	Wed, 21 Aug 2024 15:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724252439;
	bh=G2iAvbumuD8tNd8uk13u3brA5FCViIxT7Q6GbknCMtA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ml2+1e6lXPSHluM/Pl+Rtxv5qlPUiOaX0/Vxqly66X0FDsjCJ+buvJj5NLXrE9rXQ
	 k9qSKhvq3N3IZfJAvIpYnopCMf1LNqmPPvH9z9KWyB0O+nbU7a3BzEXAVuIYsu7u7Y
	 bcqoVQBzlhQ2ajC/Ut86Mws0G3Q0rJg74yu8kBh/2LJE+7WqtUxaKHQV4mAhBwa23e
	 ipgHuAF2lC4rhemM1QRaSifffvveljbTPA+Dlljwebf0MsrMgxAJWhkOIIhWxoMfRP
	 xLfDIbjkZnLfHfkx3uof2m7R3LIFKZoXRKdQK3WePjP8irqtPVdEy3odcSXb3aPbcg
	 MLb2ffSOVfJQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712E13809ABF;
	Wed, 21 Aug 2024 15:00:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] a2dp: Fix connection error message
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172425243899.1748278.5312320617574034093.git-patchwork-notify@kernel.org>
Date: Wed, 21 Aug 2024 15:00:38 +0000
References: <20240821075714.357691-1-frederic.danis@collabora.com>
In-Reply-To: <20240821075714.357691-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 21 Aug 2024 09:57:14 +0200 you wrote:
> When trying to connect to a phone which has removed the pairing, the
> DBus error message is:
> - if A2DP only is supported: br-connection-key-missing (EBADE)
> - if HFP only is supported: br-connection-refused (ECONNREFUSED)
> - if both are supported: br-connection-unknown, while the trace shows
>   ECONNREFUSED in avdtp_connect_cb()
> 
> [...]

Here is the summary with links:
  - [BlueZ] a2dp: Fix connection error message
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a6ac17f0e393

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



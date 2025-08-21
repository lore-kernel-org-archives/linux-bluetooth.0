Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3632DFA21
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755797400; cv=none; b=rjioZURiWuIgBwrbeCBJpcHyvSJCYYeImCKfgROo8Z3XUAbwZjMsN5n9WfP6IVZfzBwTJK3PqhSnTU3S9HB8PkR8QhvydGzZVspDSV+JnRmyMCEcVN52KqLsEX9CpnBpF9cher8n52Npx4CeTKXHjL7ZciEQqHDNvayfQ9281LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755797400; c=relaxed/simple;
	bh=w/++ImkH858NQPDUXMydkCSXygqkgCTnn4xeJbT6DxM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BBgAr6DBJJwxw80blRLUxQqLxZR+ulxa2fBbSipRMF/xrRxVCdO9r37RBiAq5qRDTiRNXmZ3sT8DUdzYQsJIqF/IJI/TMQiCtJM8F5LWy20bRYiYqM2ynN03pqrwvB1m2hvUpl5AwJeaj3wE4FIFcaa2J9eOiOuzWTg3l8xBSaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDtlAAdF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDtlAAdF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0594C116B1;
	Thu, 21 Aug 2025 17:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755797399;
	bh=w/++ImkH858NQPDUXMydkCSXygqkgCTnn4xeJbT6DxM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nDtlAAdFBF+zaKEJN4aivfogQXd5L9+aA1D6YXiX9SiMtzkFalPKWyiN2GjnyGhfA
	 SXKrGQ4Ju6sxr+D33pWcZOwV5eCUYRyM9CkEeix++dc75O8ad4kxdQ6k8bpU0X1av+
	 iin4a7t5cIiIWohlclLtP7s0i64OZZsQmSxjPx/d4P1Tfqagm3MLN43jTfLQkFyA1h
	 PRVjLRxJ96FQrLbValrUP2/MlTlg/HQY5QbJvuNEbRNgQswBaXe0iGC26qfM523EmM
	 JJcV04FfMgGFj+4Q3mzPOJ6al2hrde67rrjdh/ACuU5TGCH+QxPDNcVyb21SLDvUVy
	 3zswhR9yPUoUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FD9383BF56;
	Thu, 21 Aug 2025 17:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] monitor: Print message if the frame information
 cannot be found
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175579740905.1124304.14670838621219866067.git-patchwork-notify@kernel.org>
Date: Thu, 21 Aug 2025 17:30:09 +0000
References: <20250821150352.2043419-1-luiz.dentz@gmail.com>
In-Reply-To: <20250821150352.2043419-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 21 Aug 2025 11:03:52 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> While processing Number of Packeted Completed event the code attempts to
> print the frame information of each frame being acked but if no frame
> was sent it didn't print anything, so this changes it to print
> :#(frame not found)
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] monitor: Print message if the frame information cannot be found
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4167e89d8fbb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



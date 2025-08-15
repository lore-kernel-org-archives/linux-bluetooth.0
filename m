Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB2A14A0BC
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Aug 2025 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755264599; cv=none; b=VSfCysMtuR5qgJGNZNyci4dkVuq4gfqeuzS/9SLSrpntVdw5wmmfBshiHKfsdjKO5w6h1f8vhJPzFsrwwFcpf2iHwo+buXJjQ0wBgO2ey596y99LPoYTopcMPDcKBM/bZENLj0aCPPqW24usElctnOkMged80z2LsjuACQHn8nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755264599; c=relaxed/simple;
	bh=tQCUiDdYJDS5cWZJ4DgfgTyz7LSCGcdtJmnHhN9V6Go=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F5KpEXJQkrjS+HY/n5xTHpTfOYWP+TVbq54RqHoHTz33RQdIP0hc3Ylz/YqOh8p+lB7yHwnuWxd+3fxZRemFyzc47y3tM+ZfEDBEsptuSagjcXe5n64pZtAHQrGzhzByZr46zxT2Im1Igs1cRm9OeeJMgVuYy1/wjkKXsawwuy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N97HBgCq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N97HBgCq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A97AC4CEEB;
	Fri, 15 Aug 2025 13:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755264598;
	bh=tQCUiDdYJDS5cWZJ4DgfgTyz7LSCGcdtJmnHhN9V6Go=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N97HBgCqVT/lCy4D29YayZE+xluL+RHwUrtP+3obSgtK2mfIDMQFhV3qrrUTQOp8P
	 A4EfuWq8Jk0Wv275Aea7a+hr4V+I5AArfVhBZiqK5k1Fw82gv2HGpMgDMPl/kLPAzD
	 9d8pzPp4jz8hhDHuDwm1H/ekNID4MGKfAjtsZsLzayRQs7ay72KzdiQRpIfG6L17Vn
	 7qYSJHWW+EzCbu9pmzgbQDl3TZOSfIR8zdb42X1xn1ZhWiJ5p0FiBnXBtwxDIKN+ud
	 amS8PLA50dw9FDvFrzKMVludUGYDfF9UBtvlZ1asc8Hz19e1zIEZxytXXe+ZHmDETv
	 iN37A08qxR1KQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACDA39D0C3D;
	Fri, 15 Aug 2025 13:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 1/5] Bluetooth: ISO: Don't initiate CIS connections if
 there are no buffers
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175526460949.1071141.16885217477096558598.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 13:30:09 +0000
References: <20250814154208.8433-1-luiz.dentz@gmail.com>
In-Reply-To: <20250814154208.8433-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 14 Aug 2025 11:42:04 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If the controller has no buffers left return -ENOBUFF to indicate that
> iso_cnt might be out of sync.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v4,1/5] Bluetooth: ISO: Don't initiate CIS connections if there are no buffers
    (no matching commit)
  - [v4,2/5] Bluetooth: HCI: Fix using LE/ACL buffers for ISO packets
    https://git.kernel.org/bluetooth/bluetooth-next/c/bd32dcfede57
  - [v4,3/5] Bluetooth: hci_conn: Make unacked packet handling more robust
    (no matching commit)
  - [v4,4/5] Bluetooth: ISO: Use sk_sndtimeo as conn_timeout
    https://git.kernel.org/bluetooth/bluetooth-next/c/2ecd48de96ba
  - [v4,5/5] Bluetooth: hci_core: Detect if an ISO link has stalled
    https://git.kernel.org/bluetooth/bluetooth-next/c/64a73bcf8b27

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA6F258CD0
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 20:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751400582; cv=none; b=hcaKRCoHbpu97qS5uAImdLa/ciMPaJxJ29W1rBKx/LhApVZ50xxCLMoc0PeOnnyQvRkd/j+QVjYkY5U2+UiNNBpRX44HyovuJwqM3NtODZGCee0zhsSxbxwW2GgYRGm3fL9THyhVcpGIuhF7X4NyFuvNLWSiDn/MCMvBssMpThA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751400582; c=relaxed/simple;
	bh=zDrZmlp+sR3uln13d2OkOQsjKetciXX/9dJSRfzzy9U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vCoSUuQZq9rm3eiUV3MB2QCinR82WlySSK5kb4euvH6RlkE9c1VCtZ8EVuwOAnCmv0s3sHsO8HWbrI7V2EWTh65klquKyYOO7Fnxoy3m3F4qtAOmVAjYB3ABKVQEIk4Dd4R0gREAIzd07UcZ6Mwfx31sSsbA5IOcTCU611bBBuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaDzdDis; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaDzdDis"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1899C4CEEB;
	Tue,  1 Jul 2025 20:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751400581;
	bh=zDrZmlp+sR3uln13d2OkOQsjKetciXX/9dJSRfzzy9U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LaDzdDiseWkSHz83WnZGuS7WwDjcpm6PUEiwcjRsy1Ff0XvPtmYw8ryADsadtdwnB
	 n6oY3cfJwo6BxHSh8jsVzEccupJMdQVr4hI+Wmd5qKQLDWI6H1fkcmmRQjFSdfdoav
	 LsfGst1wJRMGx+QyKXAnjX7fwtgmaPInalBaO2RILOzfJ6+LAl9JU1YoqTIbmUfuOJ
	 Kv7tn+02e5OWLyv+8VLSGNMHQfBMAHbbvQQHDkveKWJECElgXAxtRVc1BS/Ij97JTI
	 IAt4a6oGjTuxL7SfJzXU7MfxFQpdNtHTEE9tECrVShshuiOiDIiG1Dwc0TsEAL8H9a
	 BWpqi9mvlTnRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE29383B273;
	Tue,  1 Jul 2025 20:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] gatt-client: avoid UAF after acquire notify
 failure
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175140060651.104274.14105034226094335996.git-patchwork-notify@kernel.org>
Date: Tue, 01 Jul 2025 20:10:06 +0000
References: <20250630143933.1658224-1-andreas@kemnade.info>
In-Reply-To: <20250630143933.1658224-1-andreas@kemnade.info>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 30 Jun 2025 16:39:33 +0200 you wrote:
> If a disconnect happens during AcquireNotify dbus calls, a lot of
> debris is left over. Subsequent calls to AcquireNotify will return
> NotPermitted and StopNotify leads to an UAF, crashing bluetoothd.
> 
> Fix that by also clean up the socket stuff on failure.
> 
> This was provoked by putting the device into some RF shielding bag
> and open and close it quickly.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] gatt-client: avoid UAF after acquire notify failure
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=476ae809a27e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



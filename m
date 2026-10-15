Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3064FD27E
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792093212; cv=none; b=CM+QprH0rwZeFaqM+ueE1uIqTAx+YvS3KELJe8fMoEbu3fG4DIn7is7F7sWOOegTZr472Q0p4YdfrziZvpJ8Phn8uCeeAmlnIt4mcZDFIx11HHgKXTCXmJ+JTL3KySAsg7jGmTPIJxnOAQCAbbWmH73jpeOVn2S5dQrBnMpSHvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792093212; c=relaxed/simple;
	bh=sGrUzh7tVBAu07x3sOJ1W+XZiBfvTO1oiO6X5Wa4shk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q/aGvdguOtDeDpD6oHZ3XV2hgppXNskgjMyH+41rPfnsLBnaPWK11jZp2Bx8EcnBqJHpNeMxZT+aakPa23qFhWhbeflxWEeMx4ebqUHVAUfZF5nS9BbDf/2yYJe04J3NmIQwcnYjn9EnIBtbVB/7zXJdf4viiiE6g7jvfGjR/Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJ4HR1qY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJ4HR1qY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441411F000C4;
	Thu, 15 Oct 2026 19:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792093211;
	bh=2Pp13HtTXWkHiBCo7jzruFwz5MXoK+V5x72H9ANvH7g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VJ4HR1qY+WYcuoDxzy/M5thZIJQjb7QwDJxD33IcUFlcP6lZqgKBB45xHb8m6Uhfk
	 cdvNgIt+kh1R2LQ7u8kp6Xwocsd5ejxAHrvQE9Aq1oeKKs0TMWnKVaK7T0/UXaqzqJ
	 R94BqFDh+ivhEOVUDmsKFLNDQ1XCj4s1VY7jYZRypIfVlossJbDVCFZld3D4naeGL7
	 ScToYP+m9yTo622M18dkCFEfxSAQfEs73fIW832f5Uv0OoJELZfflAfj3XnzEWRc3l
	 kRqitm9tKm4hTcsh9Ucwu1uhHzS5CcU8AMX5ImHcEx/dr9uERlW42kxZoKArKkgk4Y
	 QtB3fdcRtxScw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A38C3808209;
	Thu, 15 Oct 2026 19:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] mgmt-tester: Add LL Privacy host-resolved RPA
 scan
 checks
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179209320976.4073732.17798114015654671478.git-patchwork-notify@kernel.org>
Date: Thu, 15 Oct 2026 19:40:09 +0000
References: <20261014181153.1559666-1-luiz.dentz@gmail.com>
In-Reply-To: <20261014181153.1559666-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 14 Oct 2026 14:11:53 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Controllers with LL Privacy resolve RPAs themselves, so peers with an
> IRK can be kept in the accept list and passive scanning shall use the
> accept list filter policy.
> 
> Assisted-by: OpenCode:claude-opus-5.5
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] mgmt-tester: Add LL Privacy host-resolved RPA scan checks
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fa6ba55020de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



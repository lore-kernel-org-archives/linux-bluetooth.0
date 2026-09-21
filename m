Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A810F31B10B
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001076; cv=none; b=e0ZmV3d+SWKTOzVVt8aouuJ+OtJQ12xWQglXz9i8yTgaGaaWX+o+qddsTXYUm0yuk7DPabp+dZTB++vtqDBD4r5UlhzOJw0zr+0Sii0zSJCvk9efFV1/dK4rL+YTSQocv8QY30Z27VHss1Hy7Yvh2CzshAAcCFKBR/v7UN722uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001076; c=relaxed/simple;
	bh=q+dW2DXV+AXZIRYMLGQi1K1q6lTsESxyx+hWOB5KV+4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HN5nwoTjIny+eygZ0fcHxQF9e2cE+CSqBQxjrGU4zc2vHjQS5m6avUV50mZTknS7+eXWMJerA1QlsWoWR6s6ozCQKhVb2YkyNZUAyRqqRMHyOgyRUEsye6okjpv3qihPFgLa7j9/ZdAKha+kBOKOiSE1+HpX1IdyhnrPDruvUdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiNW+iga; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiNW+iga"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F421F0089B;
	Mon, 21 Sep 2026 14:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790001075;
	bh=pKASToRvzizHL3q/QIgKRQMg3AJ1QW3yWWQ7ah0SGJI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hiNW+igae4sC0DlxhH8F0hWc74U0paX+1o+3LqrJdbacrgvIsLRIDP1FqX3PZmlNQ
	 Y2bVt85mJezW51fPwufC1n+S15FcM3g+b1qGzXYQKbLvx8gtjfmC1WD90X8crEiU1I
	 hv/al0DI3mRs2L66buQ1MtWXdOewR4jZEUo9OTqd5rJHm4w4tG2UyGg1Q+eXL4A9aD
	 O/g6IKurycVso+DvvX1cnvN/e5f9kY6oIBvtCz9pAJcBHOSh8xUc05xty0iyLStcjx
	 l2e+3BJ7qI6sPbbVrF6wq2WVMlYqwtF30CvCGPDoxS85R7Vw/WYvhAACabnyLKkIkt
	 283P20FDYqGlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1975E392665C;
	Mon, 21 Sep 2026 14:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] bap: Fix use-after-free of device referenced by
 session
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179000100690.3057876.11406423888764084551.git-patchwork-notify@kernel.org>
Date: Mon, 21 Sep 2026 14:30:06 +0000
References: 
 <5610cdd036fde69fe30b0df2023875dae8d709ae.1789776622.git.pav@iki.fi>
In-Reply-To: 
 <5610cdd036fde69fe30b0df2023875dae8d709ae.1789776622.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 19 Sep 2026 03:14:05 +0300 you wrote:
> bap_attached() creates bap_data that are not bound to btd_service, and
> can outlive the device (eg if ATT POLLHUP -> bap_detached is late).
> This then crashes when accessing bap_data::device later.
> 
> Fix by having bap_data hold btd_device_ref(). This is similar to what
> avdtp.c etc. do.
> 
> [...]

Here is the summary with links:
  - [BlueZ] bap: Fix use-after-free of device referenced by session
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8a1c53517399

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



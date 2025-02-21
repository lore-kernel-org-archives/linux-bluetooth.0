Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA4F1F8ADB
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156602; cv=none; b=lPetcq0xPbTjymVB3aVdVau5oXQllKOUYbZ8svvaLMoPtdmoawWRtfz1EakzZ290wxrMqT7aztDB2qr0b0H/A69cqqjVqaABka6hM4Z93jTJ7FCG3jzxTIhR9beW7pJjEiTK0J70Ok8dMG+4TLvM4HDG4kdPhBCvT1JTZ7Utq9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156602; c=relaxed/simple;
	bh=t/s3Efvjh9RRMORgMm6lxuI2eLQcbpCkiykqrTve56g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N/oqfaRfx2vU2hK9f/Evd/SmfFn9GIoRRhllZXZIFG4SzgOo3Qz2pyjdiXER0W86h5x/9XMWnb3dLZQbxrjUFOjRRE28kdpYDthrDKFdDUlSX3zCQr5RkSVHiwHnFKU9E5l4CFllr3dAmWdLuj5Ei212Dis8qY31v+N042/B9RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F30S2UHt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F30S2UHt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D984BC4CED6;
	Fri, 21 Feb 2025 16:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740156601;
	bh=t/s3Efvjh9RRMORgMm6lxuI2eLQcbpCkiykqrTve56g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F30S2UHtRLFPqER4WtvnMOw6Foc65REGBXjymnhX8irrknYYfVKYQbZGP+l6H2d+V
	 GQKzYHZYSutIC+YlwOFna5/f17r1pxzlKBt9TnpVofJ1AVU5M3ytbaDDUryr9ZnS4E
	 L9y3Cew/LBHrQSMY8tqQF9azPtHpXOR1rVkoiPMwfqXc0shOl1Ci2tsz7eew2j0u+r
	 XStNwVGt+llAFCyjNUn/MMYDcCqpoGYNihqzVA7Cb+u9aadJpkUCpGNvAhjV35FjYs
	 KFJL04hkkiEos1kaw/HMYAtEp+6Tj0yTfpUP4bFmnXiVwJgVdKGFFWWvCCrC/oiOu6
	 bDPmup+GxrKSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB9FE380CEEE;
	Fri, 21 Feb 2025 16:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] tools/avtest: Add AAC configuration
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174015663277.2112364.3323748412087717454.git-patchwork-notify@kernel.org>
Date: Fri, 21 Feb 2025 16:50:32 +0000
References: <20250220072235.189814-1-frederic.danis@collabora.com>
In-Reply-To: <20250220072235.189814-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 20 Feb 2025 08:22:35 +0100 you wrote:
> The tests A2DP/SNK/AVP/BI-01-C, A2DP/SNK/AVP/BI-02-C,
> A2DP/SNK/AVP/BI-05-C and  A2DP/SNK/AVP/BI-07-C expect the IUT to
> provide an AAC configuration.
> 
> This can be used by adding '--aac' to the avtest command, e.g. for
> A2DP/SNK/AVP/BI-01-C test:
>  tools/avtest --aac --reject setconf --reject-code 214
> 
> [...]

Here is the summary with links:
  - [BlueZ] tools/avtest: Add AAC configuration
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fc7be1e86771

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



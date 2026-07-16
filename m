Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4A5313E17
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784215240; cv=none; b=uUGvK77iwmYmSM9sTi02ppOIXtnCTY0FGV44UbXMLYX3fwva2powLGLZujrQV2rBwicruETlw4cG0bgUcaXyu4i+cAeescqdXker017wbADiMJXFGHiUsu+a2Y//bCwOujtybZtqj/S4ArYMyNuKYUxAKlsPtcLvo5/FMdc6rfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784215240; c=relaxed/simple;
	bh=5KkXPHIxUlRBJQyMstzgkZ3Dd9ED3BccQql2KCBhCZI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KRw69r4DEGicoQ0WTomFmxHYq2n49UciNEDYlnQsC3wjoQ2tAQwZUXgWC7udazKAqG8IXDWXfZWtABvgrs7CRcvH4DaoDI8g8zyBpmDxuwQxPi0xgGgz2Pgl1fTVCk/+D5Zkp/4s/DL2Klqwo7823AZRnypixyve9ySdLpp5BHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbbZZhsP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbbZZhsP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C5A1F000E9;
	Thu, 16 Jul 2026 15:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784215239;
	bh=x8mFNnK2sbQ9M4kMgv/KQyXQ1SXxi2KnWuHR0R3pYzA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bbbZZhsPwo6/QRVqRJnXAayjV5hC8rHg87kn0RflHZ1uKTZ45nHkeFOa70xJcnomp
	 tLDvaAAzzilfybwo0bh/jvcayGKOrZe3IJ04BqxTvTSsd9mTAuj0IofIgeeIuqSRvN
	 Jg6vYyrwq/dTTA6z4GLA+cJPJePKZQv7S3vgHPOlzUseB6FCR+OBE8Q9IH7IOURDGs
	 VEP15Wsi36oZ/KRgKrGqSPPq7lwP7/gTwK5a2SpdSblY+Zr0CEb2ojBSvjWYUS365d
	 /h49bB5BVuSaSpbuRpHVNDWwU9qE9qiU3T1SDecC41x6nI4Lj9UVlCvX5TZ66yuWT7
	 4R4ko5Ik+s4LQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5690F3808205;
	Thu, 16 Jul 2026 15:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: serialize reset_type with
 RECOVERY_IN_PROGRESS
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178421521189.862995.16187217090027119655.git-patchwork-notify@kernel.org>
Date: Thu, 16 Jul 2026 15:20:11 +0000
References: <20260715161754.213393-1-kiran.k@intel.com>
In-Reply-To: <20260715161754.213393-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 15 Jul 2026 21:47:53 +0530 you wrote:
> The reset path had two concurrency holes. Both are reachable in
> practice when btintel_pcie_hw_error() is invoked from the HCI rx
> path while another reset is being requested or is already in
> flight.
> 
>   1. data->reset_type was a plain shared field. The hw_error path
>      wrote it BEFORE the test_and_set_bit(RECOVERY_IN_PROGRESS)
>      guard inside btintel_pcie_reset(), so a second hw_error could
>      clobber the type chosen by an earlier in-flight request:
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btintel_pcie: serialize reset_type with RECOVERY_IN_PROGRESS
    https://git.kernel.org/bluetooth/bluetooth-next/c/bd8bee79e1fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



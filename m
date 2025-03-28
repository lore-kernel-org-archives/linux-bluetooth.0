Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A431DF267
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Mar 2025 17:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743184798; cv=none; b=flLyE3SjcV4gz2D/jdTIECDUIZ72S8p/BDQlCMkMgvmN6I4KGyTxed7pB1W1721/lrz/1K1e7f1UEuWsl2fa4iQnTcVRnyxu0LwgrCW5+daOT+wZDdyGSS7pecuOEsycuhPk/rQebDFdLLNIVSkyholN2ySZ/o02dkf31RH+THk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743184798; c=relaxed/simple;
	bh=whxit0KRITDfGfu7xY8jrLlx/SMGemiy4C5dYiJxf2s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QRzoCCqpCyynV+8Vuw8GWrCLgwEfYcBT4eDRR+u8GN7z4ull6nOHN61Qe/4jyi7sqoSDX19CNm5amL4JmswE20KEUmwbNCBMQHmvw9BNiDGh3u39bm9+xN9EkvsUprCzquLHoKtqFBSW7taE2f7pDWztdkuaHA/iKvA/ELj1BNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvbd8+Nk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvbd8+Nk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CC7C4CEE4;
	Fri, 28 Mar 2025 17:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743184797;
	bh=whxit0KRITDfGfu7xY8jrLlx/SMGemiy4C5dYiJxf2s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bvbd8+NknW5mzHS7QAzb1CNrtZC2RX9ExxsGfnrzz0KtxRC2Dmr24+wZVAzw+mueB
	 QY9c+ARcZV+JmTwSfV1C6Yg/IencrxTxFTtFuXpO2GZn1X7ew4ujGv0mIvrheNM3HO
	 clKBJDfMgi2RtP7EH1kBFIqm3jCHCoEdCNZG8aRI+VPROBmTE6hPrOASESCitMbNKj
	 o/OBdVls+m8aadHYCV9LCDePGLb/9Eao8PMmJYxsoKBOkBzEglERHCFqHNV6GHXYQI
	 QoTq/vsSemTmbpIfraZ5CsSqycPiRkXZzWgdOgAZylLg4BLSqX7hVmVhgykyRI+kLi
	 0AbxbPoO3vpgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B03623805D89;
	Fri, 28 Mar 2025 18:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] a2dp: Fix removing local cache on restart
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174318483352.2915158.3815963589814513281.git-patchwork-notify@kernel.org>
Date: Fri, 28 Mar 2025 18:00:33 +0000
References: <20250328144406.3122778-1-luiz.dentz@gmail.com>
In-Reply-To: <20250328144406.3122778-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 28 Mar 2025 10:44:05 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Endpoint cache shall only be removed when the device is being removed
> not when just because the service is being removed since that is also
> done when bluetoothd is being restarted.
> 
> Fixes: https://github.com/bluez/bluez/issues/1146
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] a2dp: Fix removing local cache on restart
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=78aabd896dbe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



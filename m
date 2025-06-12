Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B0024337C
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jun 2025 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749735601; cv=none; b=uTZ4Yol2VbcPq7Cj5wgv3EvwvfQ3o4IphFKkSr+XXeYZ3iI9eL0sJRYg0XhMDF8s4G6+wLSKvYb0VcTogeh4c3ZfZhLzSK9SblFiqVizr+xn9UBnmJet175n9DPVjOyaEc4K0SGd/tCCjpcMdh8TTFywW7RYw7PISYIvrytZFX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749735601; c=relaxed/simple;
	bh=DuRwdUmIgZT+uRqOTBbjkxMlqXrPFe6jT3TNenNNjxU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PRe7i45oYjsrHmGaw47b+oRDaGjlUolhakK2MGyx0g5b1Ld1YfhMlzOiw6uz/SXDiLth9Cfnip7gNyGg251SrAyP5JHBS3Q9EQHZWtaCsDYgZKtaatmRfZiXqGHOJIeS8Fz/EkmcL+13Www4yqDVMB+UEzsTCegv9/PirSw6GZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeGC+gNY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeGC+gNY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48AD2C4CEEA;
	Thu, 12 Jun 2025 13:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749735601;
	bh=DuRwdUmIgZT+uRqOTBbjkxMlqXrPFe6jT3TNenNNjxU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HeGC+gNYr2uecTFRi3GxK1PV+X/9szG9Ron7tAp5y7M47UEGw2BpuqNd+sCz9fW+f
	 dDfcjVY9VFnc4VvB31E7YelXq9p2nKV2vBLeCKqgQ/7VKjFWq2iecGQTqKyOcplyj+
	 9jLRgQugiZFOrUPqmrR4lLgy1MdSMi1HBrNEgxTsNutMGq98sR2F2X53CiPFCKU4da
	 rV/b4KXxscvGathEF1JiA1hHaPLOuJUFZiLyB/M87WUHfUocSd1F7y52OdgZHpIsnu
	 wXQqlIKGL8umc3SSM8vRsRENuitYiHF3vpyQvlG86HoCSETomO6bapXHGZpiLCm1+L
	 KiALggjDPfycA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70ECA39EFFCF;
	Thu, 12 Jun 2025 13:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] driver: bluetooth: hci_qca:fix unable to load the BT
 driver
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174973563123.4138205.9026768139110053277.git-patchwork-notify@kernel.org>
Date: Thu, 12 Jun 2025 13:40:31 +0000
References: <20250609105500.4083963-1-quic_shuaz@quicinc.com>
In-Reply-To: <20250609105500.4083963-1-quic_shuaz@quicinc.com>
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_bt@quicinc.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  9 Jun 2025 18:55:00 +0800 you wrote:
> Some modules have BT_EN enabled via a hardware pull-up,
> meaning it is not defined in the DTS and is not controlled
> through the power sequence. In such cases, fall through
> to follow the legacy flow.
> 
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> 
> [...]

Here is the summary with links:
  - [v1] driver: bluetooth: hci_qca:fix unable to load the BT driver
    https://git.kernel.org/bluetooth/bluetooth-next/c/6c31dab4ff1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



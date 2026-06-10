Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6904F439000;
	Wed, 10 Jun 2026 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106025; cv=none; b=ct09pz1+b0tt7Pt6owJS16/d7CLAhzWTFXLnuw2IVhiZx7+tZXAJF9ZWohlZWVed8iY1br92+K7DOAtupLaQJ8CKAG2THcNLUKuUybA/+SqrRxnUGzEzVne96pkizjk2kLDQNvn9wDVsvcDYG6dWR9MamIHV2WAvCNTmoChJAvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106025; c=relaxed/simple;
	bh=NwYg9ZUuNXV2dXRekcNyipa2o58oFrIzNQol53BTcvM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JmPvT9C1mt4RK5JHMmzFScND/DdnFQV44u5iJkqiv9Q6Y8MnNJ0c5Pt2dSgbm9XSvhkm6gXQKxoRsCL6l0NY70LIXVZkiqpzvoMlejwzEudOzXM3W2fDyjTfM9NuYOvvRkm18n38tjHSBPS8elIqyDMuXTLyl+3GYP4W+RY65Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c81kVm5S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c81kVm5S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446431F00893;
	Wed, 10 Jun 2026 15:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106024;
	bh=EuAoxZwmj1orii30EF5ZWGnKYWY3Pi/Q/Oh2i7MYuB0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=c81kVm5SOhkXc5nqJpDswKI4gPD6RZj3d+NUL7AXTN9wDGIHQvHh+aSGGeh3WUUfX
	 DbFg5bAqSHApHvbBxoyBDCEQALXXyV0C5tQhA+nsQhKzj1HDSYJdqJT4zJ1ZpsldnX
	 Wva2ioL9xJ/91D1bM244hppilfYsgky+0C+JnF0irA2cyyagSRp28Z/ZlmuOyB+LcD
	 9uqg1P2l6b0tw4Z6IdjnY5LNkd0Zi5MMsNXUWHLowYvFSk/jJb+nBycszstiPMpogX
	 aRP6EvqVBmXlHMRZ3V83hp+Hl1Y5+Skv9XusHJbqubrfEf9wrSjwDQG64WDxONGHox
	 ldTRCwYo+LvAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5687A3930D7A;
	Wed, 10 Jun 2026 15:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: qca: Add BT FW build version to kernel log
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178110602188.3101197.17530199714271809056.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 15:40:21 +0000
References: <20260610064232.2385866-1-xiuzhuo.shang@oss.qualcomm.com>
In-Reply-To: <20260610064232.2385866-1-xiuzhuo.shang@oss.qualcomm.com>
To: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
Cc: brgl@kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
 quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
 shuai.zhang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
 jinwang.li@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 10 Jun 2026 14:42:32 +0800 you wrote:
> Firmware version is critical for bug triage. Users reporting issues
> typically share dmesg output rather than debugfs contents, requiring
> extra communication rounds to collect this information. Log the FW
> build version directly to the kernel log so it is immediately
> available in bug reports.
> 
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: qca: Add BT FW build version to kernel log
    https://git.kernel.org/bluetooth/bluetooth-next/c/559cab24b04e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



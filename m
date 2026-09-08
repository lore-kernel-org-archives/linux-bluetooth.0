Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F1357EDA7;
	Tue,  8 Sep 2026 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885091; cv=none; b=Nk6mzCm9TB56pcmaVmm4IfLJtaeW6czGJl76Mt0RneRTY8gE4Uxwd9sDWpb4wXiOm++XMNE2N+Bl7iqThoQawHYE30KWwHYOlj942Q1SkeizJWbYgJqpDPNPzJy2DE7j35WzML2lApvBup6JDSl2QnwUmKbXD5C/dClyhyHQjuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885091; c=relaxed/simple;
	bh=n2RcnFnchhCRlpVHCmqCIwmg7GSJrpeg6Py12LWCwBA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j8sJRiRLeyR3+tVVho8QpfBfXFc5bRZdYHInHb7MPEpRLqaHTvgqS02qrXRJthveiDzbB5wV3k2rG2tx40NlJgXmf7Xr/iPTfbeXZOaf+U50DjDCx6jTG0DZAxsgGCXGE5Fx0N0rQTg2HwZyy15xfl/hBVN8mpJbs3br9Qjef40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WufSi6F8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WufSi6F8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD77A1F00A3D;
	Tue,  8 Sep 2026 16:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788885089;
	bh=ECRWI7gOaSCLrqW+6FLNIAqDLm9R6RrsMVu/GWrNsbY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WufSi6F8kTSx00a2gMmcSJEicFaSTP2+GXIT0Q5wC4cwu1H2AEFpP5YIF618gQImz
	 1Vq/VoBFWc1+oYZGvGzfMgrEDwpdB0HVW5kIHVExrNsPT6JP+96F9EmFlWL08XWy0y
	 kKrLNPEj9IQiWRegVQR42w4jvBE5Dqjku0Tw8YSoYHsJJhSJHQSllk/czW6x5NJToC
	 fqkHItJbRtIJhpQG1GTF24UvZ5rh78eWPUL4ThABFhZaHFTy5dU6OSBewXRDyr2nnt
	 yjE7TXCLfcMW3usECOrZPYRRnWOdo8X1kzsrC1nG/i89ccpwcApEtahrfrTYKk2CKn
	 KX4gmCvE2OfTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939B239EAF6D;
	Tue,  8 Sep 2026 16:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_ll: Sleep while waiting for the controller
 to
 power up
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178888502815.3627954.2543217288175652376.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 16:30:28 +0000
References: 
 <8A1A2E77C277A87D+20260907151245.13609-1-zhangxuhua@kylinsec.com.cn>
In-Reply-To: 
 <8A1A2E77C277A87D+20260907151245.13609-1-zhangxuhua@kylinsec.com.cn>
To: Xuhua Zhang <zhangxuhua@kylinsec.com.cn>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  7 Sep 2026 23:12:45 +0800 you wrote:
> ll_setup() busy-waits for 100 ms after asserting the controller enable
> GPIO on each firmware download attempt. With retries this can occupy
> the CPU for up to 400 ms.
> 
> The setup callback runs in sleepable context and already uses msleep(),
> gpiod_set_value_cansleep() and synchronous firmware commands. Replace
> mdelay(100) with msleep(100) so the CPU can run other work during the
> power-up delay. Keep the requested delay and subsequent CTS wait.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_ll: Sleep while waiting for the controller to power up
    https://git.kernel.org/bluetooth/bluetooth-next/c/1d978753498a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9AD6E5FD;
	Wed, 26 Jun 2024 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719432033; cv=none; b=Q2qyPXypl1j9PMlc3EKdLdM50k6u0TJ7SC3Ak7Yl+t4r/ywXIT2GJLOXTShjb4hlzvcVMiee7XvoAidEVqiSKkQ51uboSMdPCw3DozeF+Qv4gEERdTXfTlrBE+H3y84hspMRNSWJuTbDFWh6G99iIPgkOAjNXTUxa4/M8TB1bFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719432033; c=relaxed/simple;
	bh=s0Pjw5exodtUQISQqUDHdgSMGGpzR11AeiENJJCvE9I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u2gGkAz8iee1kXiYxe2SHn0SmcgE0J2ff/oC7yXuchq+w0PrhNfzoE59jdPPpfhuA73+7cOEfe16F3EPcTaPWjXeM0QsmnuoQQZijB1ZvMLa9+N1yhGQYcrJHigAVk4BPAXoyfakp/wOAsXSuIsDfGgBYy9OxAHxa8pOmowZJlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJThQgOn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJThQgOn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B50C5C32789;
	Wed, 26 Jun 2024 20:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719432032;
	bh=s0Pjw5exodtUQISQqUDHdgSMGGpzR11AeiENJJCvE9I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dJThQgOn03+H/m24EsKmMrw7Ch+zCHkyNtSYn6vt13tfLmKadrGH3TCYI6Q9Itd4p
	 AxRA8WhY+h3mYN3u9kmlb5NxvxKj5+uwSzxe2NCSC5j7R4K7h9HUe7F+0PiOXXkxYP
	 84du66nlkYo4Ksh9LGjJlbIkVMUnOsxlIQ+DLMlFidhT6b8768/8GG7czsVRV6uPMm
	 egEuopfE9xdCc/EbQ1beuTF3B+Wr+LEKMGkorUuT8B3xbdBojqBnkqr0JfbkVwrrnX
	 of+Qir7enkY0IffQNTd+eH4s+J4ykmJPDllu3xPeIzKriXDbDx72Ao4VpS9h9e2V2u
	 hklSkWYrLHdnQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4B2AC43338;
	Wed, 26 Jun 2024 20:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: qca: don't disable power management for QCA6390
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171943203267.19782.10434982501955892840.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jun 2024 20:00:32 +0000
References: <20240624194518.37458-1-brgl@bgdev.pl>
In-Reply-To: <20240624194518.37458-1-brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 bartosz.golaszewski@linaro.org, dmitry.baryshkov@linaro.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 24 Jun 2024 21:45:18 +0200 you wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We unnecessarily fallthrough the case for QCA6390 when initializing the
> device and hit the condition where - due to the lack of the enable-gpio
> - we disable power management despite using the power sequencer. We don't
> need to look for clocks on this model so it makes more sense to just
> register the hci device and break the switch.
> 
> [...]

Here is the summary with links:
  - Bluetooth: qca: don't disable power management for QCA6390
    https://git.kernel.org/bluetooth/bluetooth-next/c/561cb4e9a238

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



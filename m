Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D3046C84A;
	Mon, 24 Aug 2026 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590267; cv=none; b=YSHoOr9Wk5FJO/7Tq0iPsTbRo0Zi5YlQtXN0z2SILXlsQSMc/dGrj4WJipaCQfGs2x7VGp7f37JtfAfMQfOlqA0sJIMMhf+UXs9waSKb2eQjsmtart9muWSp9ETN6wbPWUscxLLs5ITFDCsfIdfG1DzPYjwdrfeekmgis1XkOa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590267; c=relaxed/simple;
	bh=VcPF6Zr2h7xLkPjZo5bOOb17YCnoUOZLbwOCyb6Cwpw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k1Rs43B7HSMiW6TadWwPIJ9ALamIFubVRDH0RlqnUg+l5a2Jsy2BK9fVFhrlZhkT4hcij77P7DXGy3DLpafWWpXSlH/5dOA5bcKPVxn9ITAhw2PjicfrlSi1LBm6fPc2Jtjx9gOlZWvpsxmy0wTzh2nOlc4sDyBCchXMmlW3Pgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+GqnKnM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+GqnKnM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66B41F000E9;
	Mon, 24 Aug 2026 16:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787590262;
	bh=rJStwZRbP99TYWbbAHbc3tE4EIKFHDtlxRh14wfhlS8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=H+GqnKnMnAv3ysTMHpNn665+7WpzLFHlI7xXFGmnpERFQF4lJ/UnhffVbbw9f12It
	 YVFfti/NHFnJaAbPbdfP/auSA4fg2uLBHHpwM7/9IB8IkQj41rD3jz6V/5Y7qc/ZnS
	 0Ce3lroCK/sU1G5YlA3+OG8pIn44p5zzP/23hRub6UXaUTxAlMyP4rCTap2nkmP23s
	 yJ7cSl86ejVtGegflUJWs9ovhfnY72w202hjSQ5EuVsh95uUoC7cubAItHgbHbuwX0
	 SJOtd6VFeCskmzGw+PH7d546iKsavpTIp4aX4Spo/D84h0NpOuTyLmUYKU16KLmW3t
	 odkAVkomB9Gow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938F53924478;
	Mon, 24 Aug 2026 16:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RFC v2] Bluetooth: mt7925: trigger reset on WMT timeout
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178759021014.3014491.17750649359199343822.git-patchwork-notify@kernel.org>
Date: Mon, 24 Aug 2026 16:50:10 +0000
References: <20260822-mt7925-rfc-v2-1-c88e3bcf7eb8@gmail.com>
In-Reply-To: <20260822-mt7925-rfc-v2-1-c88e3bcf7eb8@gmail.com>
To: George Maraveyas <george.0xfff@gmail.com>
Cc: stern@rowland.harvard.edu, marcel@holtmann.org, luiz.dentz@gmail.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 acelan.kao@canonical.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 22 Aug 2026 01:37:33 +0200 you wrote:
> From: George Maraveyas <george.0xfff@gmail.com>
> 
> The MT7925 Bluetooth USB function can enumerate successfully after a warm
> reboot while the WMT function-control command remains unresponsive.
> 
> When that command times out, btmtk_usb_setup() currently returns
> -ETIMEDOUT without entering the existing MediaTek reset path. The existing
> USB reset and recovery machinery is therefore never reached.
> 
> [...]

Here is the summary with links:
  - [RFC,v2] Bluetooth: mt7925: trigger reset on WMT timeout
    https://git.kernel.org/bluetooth/bluetooth-next/c/a6491451f8b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



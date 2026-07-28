Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A349E4570CB
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250243; cv=none; b=CUDN0/oyQuFRGmEFcJuwLGA8MTQTsYjNY9jly/u802pKyi5E3PTF5W08qPyA5wJilTxMq26zTtqjbJSFW15qK0TKMASRvv0mLM/eE/fLWHOocn0aEt6p5dXaDIXCFhVriuSUp6n93PpSsRmKeDIAm8udvq/dKZDYKQWEk9oLaX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250243; c=relaxed/simple;
	bh=tHeUzejOzZ6QWghAkj+/bKWUneVNJ+SjdzMCLKF2KrI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DZn/KiyP1w3sEAuxve/vrhn0X57qTEQhy6TmblLzOke0mZwH/kz2eZNXHD+x65AyDxZnhhQXAARzu7UI7jWVNGaarBtY/W1Hl9sO7x4Nzz6v0Vk2FMoWKx447prQ33q+gckdk/IStU8e79S6UbqIamKTpig37yb5hJbn/1U76XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImBj+ZDR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImBj+ZDR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066DB1F000E9;
	Tue, 28 Jul 2026 14:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785250242;
	bh=2uFXkcFWR7mCvVIKtqIZe8VdHZOtDTejPWTjHbJFeiM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ImBj+ZDR3Q1VEs1fLKnGqkkkQanj3p9xWxDMLWA2nMjMyPHlwa/zotYNmrBqtRaao
	 2qz4xkZ5rUISF+f0Kh3kLfJcHawjOZqg7EKDi/g7mRVERy+zdFYTz/50vZmJTbjsaW
	 Ahd+NIKyWCh0v9HzXOho5enKFQMM2FoDum3VEAiHYSXYhKUEa2ihOgabKaZT62hQVu
	 N5W8GU3mkMQwxLx7PqjLLhj71tRn7M82wEGe34N7fNNLvhMW16HL4ejCbPcYHSXMd+
	 +iNvwz6ehlYj6SdVdBGdVOASP14+PlDZh2Bv/2dKCHAmnRoLnoZZ++ZnQt2Cnnn/dm
	 jhUNqcmNQKvTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199053924445;
	Tue, 28 Jul 2026 14:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ bluez v3] bap: Start BIG sync after receiving
 BIGInfo
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178525020663.1763279.9677499412602336092.git-patchwork-notify@kernel.org>
Date: Tue, 28 Jul 2026 14:50:06 +0000
References: <20260728-big_sync-v3-1-c2da19f3c00b@amlogic.com>
In-Reply-To: <20260728-big_sync-v3-1-c2da19f3c00b@amlogic.com>
To: Yang Li <yang.li@amlogic.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 28 Jul 2026 14:26:42 +0800 you wrote:
> From: Yang Li <yang.li@amlogic.com>
> 
> The current implementation starts BIG sync before receiving a BIGInfo
> report. According to the Bluetooth Core Specification, BIG sync should
> only be initiated after BIGInfo has been received.
> 
> Starting BIG sync too early may cause unexpected controller behavior.
> 
> [...]

Here is the summary with links:
  - [BlueZ,bluez,v3] bap: Start BIG sync after receiving BIGInfo
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=322c39a64323

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F3A134B6
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jul 2024 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721663204; cv=none; b=P5wmH6evJkVcVRlTNQoLpJjwU6VE/0aZO/FhbODzZIYCHXnyLpbifxHu71znx02aHpkx77nZkBgP0LALYfRWprcPym202OhTTzWqpzTQjo/fgxB1iCRPbWla4BTwdcHsNdJceKlsDkXIXWVZYAI+97dwf0Cw44lHpS2qUYYxnJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721663204; c=relaxed/simple;
	bh=pShGMNtY4hbvPIbcmjNkGA9YS8I9H2IcEDiK4GA+c+Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OsR9el1YrnoHEJhjHWLQAdK5xiypPCeTSRyhTX1DWp9oZyzTf0dwHAhCIb6IVCXl5SvXqPOGm+gIZy/4vzIuKwPw7EOGaMbMybvB2yy19FawbyVsbHI+sxGyTHpEbeLGTuHA3o9byJo3o//WT1DFKvSm7mCGcNnBpfp5y9QILF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yle6r8ip; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yle6r8ip"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F931C4AF0B;
	Mon, 22 Jul 2024 15:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721663204;
	bh=pShGMNtY4hbvPIbcmjNkGA9YS8I9H2IcEDiK4GA+c+Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Yle6r8ipWkYbBl6PtuB0fM6TNYhrbBPEuDLmAaOZdmpVGdRZeXdXFA/2NSnzBE0NZ
	 Qr1dmlD0Efio/fOgGRnwwrNio8eqFe7rj9aDeRyhu8tQqSNJTb9m250wpxeT6dXCb6
	 eVYYYZi1yEVxqf63t7Kcv7Q9Z99U2cW11PBKdl+/kALXLk/YPJzbAvItWbElOkZaz/
	 XNc2Kr66il3vpLWCUcyAVDDHstmKTnWYQQC8sD1k6gtcKwEICUpSibLmqPZu9MtCnB
	 LYU+ZS8VDwQRnUvm2wH1KmhQa2YA1fzq1gV9c1mpKLgh8ne4zwmJEyINZhQ/OqDVcD
	 ZFtxNkkLo7fMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7CE94C43443;
	Mon, 22 Jul 2024 15:46:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] Bluetooth: btintel: Allow configuring drive strength of
 BRI
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172166320450.31131.13915346153008786408.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jul 2024 15:46:44 +0000
References: <20240718144804.3953833-1-kiran.k@intel.com>
In-Reply-To: <20240718144804.3953833-1-kiran.k@intel.com>
To: K@ci.codeaurora.org, Kiran <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
 vijay.satija@intel.com, pmenzel@molgen.mpg.de

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 18 Jul 2024 20:18:04 +0530 you wrote:
> BRI (Bluetooth Radio Interface) traffic from CNVr to CNVi was found causing
> cross talk step errors to WiFi. To avoid this potential issue OEM platforms
> can replace BRI resistor to adjust the BRI response line drive strength.
> During the *setup*, driver reads the drive strength value from uefi
> variable and passes it to the controller via vendor specific command with
> opcode 0xfc0a.
> 
> [...]

Here is the summary with links:
  - [v5] Bluetooth: btintel: Allow configuring drive strength of BRI
    https://git.kernel.org/bluetooth/bluetooth-next/c/c707097a446c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



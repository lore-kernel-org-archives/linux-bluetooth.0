Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F2E250C1F
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 21:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747775994; cv=none; b=ZGDRpTbdYXY1s1PL4lQsQ73MZe97sP5l/nVLegLDD8Rm8QwB4uBvQ8OOGGSGuJfGrPtXFa28DKYoqXif+m9dpmmV02W6w8liVgfecbdxXXuXmwJoPfvhAOTZL/IuuttoZkbt9MYud9S+pEByllADQH/baZImlRKtTS+am8XHAdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747775994; c=relaxed/simple;
	bh=E9jBD5X1blu7EvtsOPEQJMoDbDoQ8q04PZIC//29RNA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z19SX46N0TjrMcyRpbmNOFhfARJMYIs1XJlZ9vs3lF/jR0DPZaJJ5iXbFQwbnjBQ8X5+d+eR6bTMigOmVzmzXLIZc5hcebMcM3J2DfSX07HpbF/mnPqM3CtMzcuIQFHG4f+XeL5BBHB2qn8TAvsQV57eeIXfw2bSQuMQ/cQMZJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvZEtW2Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvZEtW2Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B5FC4CEE9;
	Tue, 20 May 2025 21:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747775993;
	bh=E9jBD5X1blu7EvtsOPEQJMoDbDoQ8q04PZIC//29RNA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GvZEtW2YS5hBO1B9Ipq0GC5cy7Vw9T9j2UOdBiKxf80aV4R85Clus446BOAiFvVu+
	 5V+ILIAtRyVIgOtb/pYIb1AgdeTKG2o9DuA3sQreu2o+UlKNy0+dS3lzTgpQ63amsp
	 hI9nG8rtSsKeI/KtX6uPb6o+fMy3/su7e8+gyCpIfykLMypeKSElBa9+n3/SxL2x/2
	 uNLU9z4mPf5Aui0oQAarkso4RFOPlR2Vs/gZ1rFEZV2wtHptNSbCepfVaPxBPHAAVK
	 xAauGXM4N8Nu39+LIhA9e8unWYR2Z90jAZ4njXZL5d6pTgTHaJKVl/T4U1uNTjttuN
	 Pe3LKtOTNMzlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2EE380AA70;
	Tue, 20 May 2025 21:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: MGMT: iterate over mesh commands in
 mgmt_mesh_foreach()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174777602975.1466863.8569630509676710432.git-patchwork-notify@kernel.org>
Date: Tue, 20 May 2025 21:20:29 +0000
References: <20250520084230.502667-1-dmantipov@yandex.ru>
In-Reply-To: <20250520084230.502667-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 brian.gix@intel.com, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 20 May 2025 11:42:30 +0300 you wrote:
> In 'mgmt_mesh_foreach()', iterate over mesh commands
> rather than generic mgmt ones. Compile tested only.
> 
> Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  net/bluetooth/mgmt_util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - Bluetooth: MGMT: iterate over mesh commands in mgmt_mesh_foreach()
    https://git.kernel.org/bluetooth/bluetooth-next/c/a8f011879811

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



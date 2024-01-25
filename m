Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59769135416
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706215826; cv=none; b=mY15sWezw7nJnSXrU87nK35jE8NKpVtHK1W1ktkJEKXt7kWAWO6FS7kVJvIE+KeAzw+4Vh6kRNXvDFbiacuka7K2/9/8gzrQio6+u1Kj5Ho3P5UpoMLvPf+e/Kicn8Esq9S5xDvyhxFn8kKZk8JVps8LY0uO8pKieOg3VzNarQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706215826; c=relaxed/simple;
	bh=KLiFTi4NnJKvTuZhcaTP/nBN09YMRGsHleEngewBbTE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jTbGdCKOieOB7DvlY5+x49dKF7Z7+t1OZtUfq5tW867PZ0TN6tT0CIF7mvbmQ1qN/NaNm3eGqtrklt/XaRON4+h0TPDpvQlhsfAp/Uh26AufjHofKBS9z25FX/J97tqpjrRoSiTKw7xMQyABlGfTGFJgBlQBZOmZUENCHUdvibk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jw2zSDk7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jw2zSDk7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2419C43394;
	Thu, 25 Jan 2024 20:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706215825;
	bh=KLiFTi4NnJKvTuZhcaTP/nBN09YMRGsHleEngewBbTE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jw2zSDk7TSnx5csOoh1hfVKRhgM0HtogeYQLMBW9o0INqPSmjZ9lywmO/2RU4KgaE
	 M9YS8FMbNaCguPdfAULhUT290z803iEJXGFk15itELBhciQAOIUp2yTc57ZHWwy2Qm
	 rQC4WjUHWcXnR9f4ZyY3JFOK4JWuBIzUo4mZ3Nv4xga921bLheGOLlFGJb0ZDHO1Yj
	 wp39R/cdUYO8htvXnc8gngU7nuZGOH70yoMhtE12f4AKRzBaJapDpeAVm+sY4LmTNK
	 0SX3yDurKnTJoPqBOnnDjxz3NGahnmvuNGd/rIQThzEC+DU0GxcRNeTOZWOsJsFzAB
	 iOaFVP4ox0iiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8C3BD8C961;
	Thu, 25 Jan 2024 20:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: qca: Fix wrong event type for patch config
 command
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170621582581.16174.72441742691687427.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jan 2024 20:50:25 +0000
References: <1705657530-17975-1-git-send-email-quic_zijuhu@quicinc.com>
In-Reply-To: <1705657530-17975-1-git-send-email-quic_zijuhu@quicinc.com>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org, johan.hedberg@gmail.com,
 quic_saluvala@quicinc.com, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 19 Jan 2024 17:45:30 +0800 you wrote:
> Vendor-specific command patch config has HCI_Command_Complete event as
> response, but qca_send_patch_config_cmd() wrongly expects vendor-specific
> event for the command, fixed by using right event type.
> 
> Btmon log for the vendor-specific command are shown below:
> < HCI Command: Vendor (0x3f|0x0000) plen 5
>         28 01 00 00 00
> > HCI Event: Command Complete (0x0e) plen 5
>       Vendor (0x3f|0x0000) ncmd 1
>         Status: Success (0x00)
>         28
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: qca: Fix wrong event type for patch config command
    https://git.kernel.org/bluetooth/bluetooth-next/c/64692e12507b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



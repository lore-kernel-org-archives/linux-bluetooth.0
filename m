Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDBF19B3C3;
	Fri, 23 Aug 2024 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443831; cv=none; b=DesK0N5Vgrn1nZABMepbhcA5q2J1g3tnZmvlTEemsIwduSErV4/uo0gBYQWSI/Bv0iEQWhtJTHAOv206ybtM8q6Z99myXlJ3y5LvAHhd22TrHnKqmr010lhfiKfJFbJ5b4snivod7e9Niff0xBxe3MqLIbYUTFL3q8XVJMaLsbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443831; c=relaxed/simple;
	bh=lcz14trCuLOJaC4+18sMdfiYHLkThfIvWwpfCzhfeDU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uifsbNalWYWi8f6gFIgEBBBUXGbo4fssZHiuy5+eFMadCoRZl8upsjmK/Dyjm6JjVL14h0bDTtPDtXg3JZzYEL5DVDSneKDqQgxHxUDc5WXzrnOFZHhV2sv9u6UYHBa/I7i9GwtBkmxe/3dNvO2cwLu7gruX7qIL/UorTLixTJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcDwINt9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcDwINt9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44289C32786;
	Fri, 23 Aug 2024 20:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724443831;
	bh=lcz14trCuLOJaC4+18sMdfiYHLkThfIvWwpfCzhfeDU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OcDwINt9Hhmt/hRhRBn3JOh3+JCMDnB2Ypb/dsWj+PWv66ZNZefvndQkAm4kAeCFL
	 4M3WegNmAEe1FuXFy1IV2/VZu87ihy1ZbdKEy2poRTkOk/zpJAGXZc1JbB7V3wadsq
	 T1BUc9TB4XymjPkpi8axtlcKHLxNEYt5KIgtE806YHj2M3bqZZBMctiZYMZ7tZnqKJ
	 6ykgvlztzB1pcVvUE0GtFp3F+jBLjQATbH6RcgXzIuItPTOFJKGwcx05Km3CySvgqG
	 V1tKDvRrOu7qWtjPeco7NENpjghWRXNzSjM0DfkQORM2SYf/sQ35AkTD82e7cyCT+w
	 4Do361H61NaMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 349283804C86;
	Fri, 23 Aug 2024 20:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [REPOST PATCH] Bluetooth: qca: If memdump doesn't work, re-enable IBS
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172444383104.3074025.5017578776237520440.git-patchwork-notify@kernel.org>
Date: Fri, 23 Aug 2024 20:10:31 +0000
References: <20240821154339.REPOST.1.Ia769fe5fbeaa6aca2edfb01b82eb7df0c6955459@changeid>
In-Reply-To: <20240821154339.REPOST.1.Ia769fe5fbeaa6aca2edfb01b82eb7df0c6955459@changeid>
To: Doug Anderson <dianders@chromium.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, groeck@chromium.org,
 swboyd@chromium.org, johan+linaro@kernel.org, bartosz.golaszewski@linaro.org,
 quic_saluvala@quicinc.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 21 Aug 2024 15:43:40 -0700 you wrote:
> On systems in the field, we are seeing this sometimes in the kernel logs:
>   Bluetooth: qca_controller_memdump() hci0: hci_devcd_init Return:-95
> 
> This means that _something_ decided that it wanted to get a memdump
> but then hci_devcd_init() returned -EOPNOTSUPP (AKA -95).
> 
> The cleanup code in qca_controller_memdump() when we get back an error
> from hci_devcd_init() undoes most things but forgets to clear
> QCA_IBS_DISABLED. One side effect of this is that, during the next
> suspend, qca_suspend() will always get a timeout.
> 
> [...]

Here is the summary with links:
  - [REPOST] Bluetooth: qca: If memdump doesn't work, re-enable IBS
    https://git.kernel.org/bluetooth/bluetooth-next/c/61bea6923172

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



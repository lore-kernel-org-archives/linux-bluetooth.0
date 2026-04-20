Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0293859FD
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776722435; cv=none; b=H2hnpW+9LZZ9SBElOLT1vleHj7b1qBUZdSfNDcBSDy8mQApXKZzPImfvbJnDekvnKAeJOB+yGwbdPlrcDftRFuzvvYX6cJO0/SUt1C5f6arUuuSu0yXcq0PpApPg39HVbCJUDM5/aqxouAWDNmMOWFuPzI2QHdiT97Uh6hj42NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776722435; c=relaxed/simple;
	bh=Yzum1S2W6uE7KXQgEV65xIpQZcN8PKNkeRTfDpQaZk8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WgEJhlUjUTMmizJvwla9Lie1FijNSupCaVq8kmaY97o3/M75rBE0kSJ8FSZ7cj7cEW6sYPANiVecdgcmdp8gidNNpvAcehOgyvLizS1cY2j0wgubLvQnUC6LjycVV+4FCEaxsyGwlYYBUgm+ZM8+oClbSa7s6bHYj6pnNwEUUb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecrZMtIL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecrZMtIL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF10C19425;
	Mon, 20 Apr 2026 22:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776722435;
	bh=Yzum1S2W6uE7KXQgEV65xIpQZcN8PKNkeRTfDpQaZk8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ecrZMtILYrPnHPq7MrmXKlE+FCVroQIxqTXtS9uEOGTCvcPTy9EnkIz9AJjGh8fR6
	 WWpQK53ls2Xmgue+gHSBF2y1JujKKMlcDyRdErfQOsMiUb+SfZOXKwb7h3PWXLUsmf
	 qEzzn+9XJqhOzPfZygUTjmGIrTBWHAHSJIWy2DSodYA613ZNZmq+z7Aft9WlWV+rX4
	 /oes5XyFfUuT4iiglAInDVmdjaiMwee+tDfQApEHjC5waQ78gNIaYnXTzFN4/Za3t6
	 YIDXWSOCGnvMeeMLNB9jgX6yBVNDaXRaR7s6nRRVD60FbShnFqCefjFakYQ0iuZHXi
	 VpXq+KW/8N2PQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 454823930024;
	Mon, 20 Apr 2026 22:00:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] client/btpclient: Add GATT discovery supports
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177672240005.1802062.1330187896440623963.git-patchwork-notify@kernel.org>
Date: Mon, 20 Apr 2026 22:00:00 +0000
References: <20260416184929.145224-1-frederic.danis@collabora.com>
In-Reply-To: <20260416184929.145224-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 16 Apr 2026 20:49:29 +0200 you wrote:
> This implements the following BTP GATT services commands which are used
> by BTP BAP service:
> - BTP_OP_GATT_DISC_PRIM_UUID
> - BTP_OP_GATT_DISC_CHRC_UUID
> - BTP_OP_GATT_DISC_ALL_DESC
> ---
>  client/btpclient/gatt.c | 226 ++++++++++++++++++++++++++++++++++++++++
>  src/shared/btp.h        |  62 +++++++++++
>  2 files changed, 288 insertions(+)

Here is the summary with links:
  - [BlueZ] client/btpclient: Add GATT discovery supports
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0fdf34b17d41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



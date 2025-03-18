Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA9B212B3B
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 18:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742320807; cv=none; b=G4EqjHXZT9u/lKDgESBuCWGS3YMQqRti5KLMrlYDsWQcRMTlDlYggjYddWHyNHjbgRa4tupZw2KO3/A8cQz1GAt/tEnONM3PWVvZZm7+zuMRpBaYzFeozi02ytJt9OJyBjo+k6RIYyGXAgfiwMcpvAORg6runk4LCTQ4379sLtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742320807; c=relaxed/simple;
	bh=gsttDXgP42V6AljGFfDdk9OnHsUF8RVzPRQQ7oKrbVg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HNnwGTQ+8N0iZ9myH8YHmm3kOdJ9gw6TlkU+YFcYuvmivoTlytxh0BCCCO8Lusvy4ebm0OUv5bIi6zerBfS64f0K7yncav4tNQOVX1yOZBti7rmaCoSD5EN53J94BAc4xVdrPh2LMfo1a6WcvSqQ6Blb5UvFRq7Fs/XlDSAjayQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8FBNgQX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8FBNgQX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E4BC4CEDD;
	Tue, 18 Mar 2025 18:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742320806;
	bh=gsttDXgP42V6AljGFfDdk9OnHsUF8RVzPRQQ7oKrbVg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k8FBNgQXJMxuR8FOctVu+ZCL31hGoLRUTK985ui4sxhMi/tOmP6KEDtH5YMRxB0FW
	 IH+dcyd84DzV03yvr0ZoQXnBaVhElW8ROTU+47rcAMMSGyBWSDzcw1emw3rNzr6qdW
	 gVNL0VYbpWw6yO2VotBy5nn9QAcAaFTEo+pDGHojkbJuvjdpP9MSdPgIowRhltQpfC
	 vzmy/aQDI4dFv8ydEM3fcHDWafVSa+y2VTXpDbSgDCGYV4BSXlqlubqRSR+ZhXM00X
	 15VqzfYk4Au0tZvaT5WNS3WzBTSYaS8/+2Y/qTdo2x8B0fJD6nsA2DcXgbSJn3VNUa
	 hzmeTh+HzIuBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3462C380DBE8;
	Tue, 18 Mar 2025 18:00:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] obex: Fix typo
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174232084178.406856.5220288085541554659.git-patchwork-notify@kernel.org>
Date: Tue, 18 Mar 2025 18:00:41 +0000
References: <20250318132147.91774-1-frederic.danis@collabora.com>
In-Reply-To: <20250318132147.91774-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 18 Mar 2025 14:21:47 +0100 you wrote:
> ---
>  obexd/plugins/bluetooth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] obex: Fix typo
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2eba5b6e9155

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E30319D093
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779467397; cv=none; b=JdeXLp/+I4VuoVEmsko0cSmEf5ePG2xOeWqxTuHrYF35sAMNI4V1VfcbMbIeeQWbTZzSXVJO9TfpGSZTiKKzKZIEOnSHyVuyi4N2gmWt5Ti2sHM1NmxzNPkCQ00TU71dUaY/M7JxCh0u2XzxD+Ijv6Z7Qo5SIdHt6wxgg+IE9uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779467397; c=relaxed/simple;
	bh=ID6iXKoHTPcumi3iTagkq7T5Bx8DTfg5nv9cTw1ewIY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g7RNNQl4wFaeLjP/VMJU1wlC/quHTqSEGY8rrW+92hRb10fAuoHkICJ20oyIXYN1xgguo5Kor28umkU7CfuhWWLkadNwRf2RCXClufAEEH1C/Uxq7JQNL/QA+55Kaz0WgkFTTKgMTQzqZO2b/q3puv25PB/DZKIl54iAUQAx4rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhPHmzwi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhPHmzwi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B8A1F000E9;
	Fri, 22 May 2026 16:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779467395;
	bh=CFPsIq9QvG2jKaIFDZkaChnyCVnHOHQpyHvU0DboavI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RhPHmzwiYIEokYTSTFxEAfP4hol+b6F1n7vrt/mxXpACklAhNvleBe95SSzQBawkr
	 zyAXXZIQ71EFKBFPowRkraZDhiPfY2drUHfc9UsRukRjVGB5xiR7KfADyCxZTDx0U/
	 WysRM7V3QD5MmOYBja9DsWO69CtLngUuIX/m7Kd7ALWSoka7FZ1bwbTMbkPxq7dsh/
	 M4KIGceWDILWcczdIEqB5w15RVR45btArjCbb8RDLBJYHVlScFgKcdNYbTQzi/DfzV
	 blSR7TvsE4HQ3x9jl4DIBPZPeWfz8/SZata1LreXSyMu24nEP3rsa296iXy03u3/wZ
	 IoRXTmLrxC9aw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56C293930FAA;
	Fri, 22 May 2026 16:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/1] shared/bap: set QoS state when CIS is lost
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177946740515.1283301.14377729161583626182.git-patchwork-notify@kernel.org>
Date: Fri, 22 May 2026 16:30:05 +0000
References: <20260514100545.54572-2-raghavendra.rao@collabora.com>
In-Reply-To: <20260514100545.54572-2-raghavendra.rao@collabora.com>
To: raghu447 <raghavendra.rao@collabora.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 14 May 2026 15:35:45 +0530 you wrote:
> From: raghavendra <raghavendra.rao@collabora.com>
> 
> This is used to pass PTS tests BAP/USR/SCC/BV-167-C
> and BAP/USR/SCC/BV-168-C.
> ---
>  src/shared/bap.c | 4 ++++
>  1 file changed, 4 insertions(+)

Here is the summary with links:
  - [BlueZ,v2,1/1] shared/bap: set QoS state when CIS is lost
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f818e9d0c9df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C088924A08
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Oct 2024 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729260622; cv=none; b=kX4qmjoznmIw/902pAGuUDusZNhH1SonJXhQqYo5PXFrjv2kHT8dzechlLST5j7LUMsLMGEENTvNPD8Qsn5tzgOgzLu/h3XNvc7K5A1ZCP4HnGv4V9XZB4i0xni7AEXHJaewEqnEYw4gD30awY31J/mJdzBZjQkJsXTZOwYCJP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729260622; c=relaxed/simple;
	bh=IANJg3+T42gv5MoUSi8CYtN9/GYoCtVEhM5iVnpCB6Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RyFc0xAFFPK1GObMW8IvqoFjUAe9dhBhkbjqwtFHKJbtoowiuKa814GUapN8H73Xl1fDpuzTpVRhbvy9E1zOdXwpHeLxR7tN02FYRVxJ7G8hvoFHjqGcvQ9lTIRFhGxQNL8vxJPc9WEUGblkOKRL8V/PrDvGle4ogl96Aov317Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxNvHTdk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxNvHTdk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65012C4CEC3;
	Fri, 18 Oct 2024 14:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729260622;
	bh=IANJg3+T42gv5MoUSi8CYtN9/GYoCtVEhM5iVnpCB6Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VxNvHTdkiNLCK8ihPSdvpXjxskKBEKryF+ES8STdKhma7neHWJt41fDAxprKPaGuh
	 zL7CB5shkzOjCcvsyGyu4bePsiO0DE0JxsYCLAEIAYPukE6lfFcRiit65J5/km1Trl
	 Tja7cxoYFCqZ9NPPsPchUcxTWRFNmQvNxEcevqDWjKXvBsWx5X+4bd8VCsNQClgmZM
	 hMidJS2KCmp8K9+m+sa7d64/24zCvNDQ3cXgGZpXdaqDl0+4tH70y1dAQHuyMa/p2g
	 XsC03d2kH7TFBHlZRaCA3b9XpbkIw3bBDralKwju/5QNssEgH7HROJjqTi7osmJj1I
	 Y7p7KV0Rmtigg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E6C3805CC0;
	Fri, 18 Oct 2024 14:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] obex: Move size emit signal to plugins instead of obex.c
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172926062800.3127332.2808917966746254540.git-patchwork-notify@kernel.org>
Date: Fri, 18 Oct 2024 14:10:28 +0000
References: <20241017061331.2097436-1-quic_amisjain@quicinc.com>
In-Reply-To: <20241017061331.2097436-1-quic_amisjain@quicinc.com>
To: Amisha Jain <quic_amisjain@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com,
 quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 17 Oct 2024 11:43:31 +0530 you wrote:
> Instead of emitting the property "Size" from obex_put_stream_start(),
> Call the function manager_emit_transfer_property() from plugins/*.c
> wherever plugin has transfer object present.
> Remove the code from obex.c which is generic for all profiles.
> 
> This change resolves the type mismatch issue when calling the
> manager_emit_transfer_property from obex.c. We are passing
> 'os->service_data' of plugin session type but the
> manager_emit_transfer_property() expects the 'obex_transfer'
> type, therefore size is not set properly and might cause
> crash/disconnection.
> 
> [...]

Here is the summary with links:
  - [v1] obex: Move size emit signal to plugins instead of obex.c
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b5b51017ea18

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



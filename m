Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486B139ADB;
	Fri, 24 May 2024 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716580830; cv=none; b=WvVRH5mMMaq2PtIMbFkyh3cZC1VU09ZLgz07JNgCImM9S8PvlsAojqLiQl+N71hCdHvE74bfgQy5FDDLjCwekh144zw1RV6tQikT2p26W2qknS/cvQzfaXijzVSGR2ItEw0FoQ3Za1IXyryrgRfyaJN3pX0HUTyL9mdKslXL3XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716580830; c=relaxed/simple;
	bh=pyAGi8octoMcFhKKOiNrCFOsbeRCbTUlZAwIwrRUJx0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b2jhjEvsUBrVVbz5ftfOZqV05sHlitKmu0GZTMKxJzyVXey5Lg3oQ8GCn8YHR7Fv7sFPPileCRHwrhgHglYlKR6pBKQt7Wlf0mC2sb09ooE5koBVU/4VuM+9ubHVB9tzse0ovqlP4xje8voTTOJ611e8RCy+XjkigTHEvRecLys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1MAEQ6B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1MAEQ6B"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD8D2C2BBFC;
	Fri, 24 May 2024 20:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716580829;
	bh=pyAGi8octoMcFhKKOiNrCFOsbeRCbTUlZAwIwrRUJx0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T1MAEQ6BgEbJ0/8OMoz8FvtdPnuSPCSHHZYYBn1yhfp9t1+1xosA1Mcdvolb9nPpD
	 qwo2X2HOXkJ1qeJJHdawSFS56Bn1IZWXaAyFzA3AMYlFJFgD6fovUeAqOKJVJyjUoR
	 ETP1EoYmFdW8V+5Ai4Vcp0Cs4G3KW3dc0X5FtY2aoMYBiaOhD7vnhOhk66UOOpzDNz
	 ImLIwsJcKG5Vr1vI0UY2kaXQ5TLKJBkkxMSGLY6Y5OsqTpSsbS7Jz3tqOQpr/XKzbR
	 nM6s/E83iRmnGxJpiho5NhiPXm6TV+bTx32hfGGLB23jPE5S8Ir+djqPqxIggMlnMD
	 ohm4n+qDgA+/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9926C4332E;
	Fri, 24 May 2024 20:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth:  MGMT: Uninitialized variable in load_conn_param()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171658082982.8511.1384944537099920085.git-patchwork-notify@kernel.org>
Date: Fri, 24 May 2024 20:00:29 +0000
References: <819ed9b8-8790-4d15-b2a0-20929328d582@moroto.mountain>
In-Reply-To: <819ed9b8-8790-4d15-b2a0-20929328d582@moroto.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: luiz.von.dentz@intel.com, marcel@holtmann.org, johan.hedberg@gmail.com,
 luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 24 May 2024 13:14:02 +0300 you wrote:
> The "update" variable needs to be initialized to false.
> 
> Fixes: 831be422f3bb ("Bluetooth: MGMT: Make MGMT_OP_LOAD_CONN_PARAM update existing connection")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  net/bluetooth/mgmt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - Bluetooth: MGMT: Uninitialized variable in load_conn_param()
    https://git.kernel.org/bluetooth/bluetooth-next/c/8e8f72ff2710

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6083237473B;
	Tue, 17 Feb 2026 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771354218; cv=none; b=GM9mPzDNpVkzitfP44txwjchCTvrZxphCr4mAWSYwuccLr5GYzjizx3vhkmqgzN1E3R96cYqIIi5ykxwj8RsailVqcCbVtfjoG9GMamGMxrL2+i8aNm6sp9bo8ROKe7nlf6Txf8j67ksEiwfNMqCOLQpZ/lrJBao0gCAJo5qZDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771354218; c=relaxed/simple;
	bh=aK4vF1gwg4WA49Ll3gY0b3EmhQ4Ty2kNCS8Xc1t9qU8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kN0I7N7e0M9NZXaZZCK1Z5RqE64FeIRR34uG3w9DYGJIrox7UCgfBv5KZ/Y9jxAeOZV8XzHz4I5O9rkIcflvnwc2QNtR5DG963IBQ+ZEJJB+zZcfk7xwfDi6cAYGU8TGGGv6iTf/U0cc9gYnRu1AUgTat3XVs27H86ziGXvNlwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2278aTL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2278aTL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4393AC4CEF7;
	Tue, 17 Feb 2026 18:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771354218;
	bh=aK4vF1gwg4WA49Ll3gY0b3EmhQ4Ty2kNCS8Xc1t9qU8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q2278aTLlxl1YXVGvDl/GR9gf/LDcYbHoMDa8GYOyh1fmpauK9/ZnmWfc6qJdNAv1
	 WuEJe209vdY7SMr4j02yicVw2Eh2zLpLcJdO9lD7ozQoMfTud+t1hJTvBxz+dngRdF
	 zAVTd6yBwcAycN5kvdnrzuC4a+jWLB55lZc5LiwyOwb5BdBSlG1mbscrq5Eolw0rdm
	 JjsboRo6Gc/3SZH+nmtcFmlRlQfojVzRIMzfmUESv3/4GLIcdw1VxojBiYDH4g3HRx
	 tvvyvmbKn6i2aezq0wfn81qke2R+MHIqmmidkxiBdRwxpei5sT/0lCRuCakFoQnp2v
	 ptnSoNCC/VVfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 483A53806667;
	Tue, 17 Feb 2026 18:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: Fix CIS host feature condition
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177135420982.600961.5386631441162259721.git-patchwork-notify@kernel.org>
Date: Tue, 17 Feb 2026 18:50:09 +0000
References: <20260212134646.430396-1-mariusz.skamra@codecoup.pl>
In-Reply-To: <20260212134646.430396-1-mariusz.skamra@codecoup.pl>
To: Mariusz Skamra <mariusz.skamra@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org, stable@vger.kernel.org,
 pmenzel@molgen.mpg.de

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 12 Feb 2026 14:46:46 +0100 you wrote:
> This fixes the condition for sending the LE Set Host Feature command.
> The command is sent to indicate host support for Connected Isochronous
> Streams in this case. It has been observed that the system could not
> initialize BIS-only capable controllers because the controllers do not
> support the command.
> 
> As per Core v6.2 | Vol 4, Part E, Table 3.1 the command shall be
> supported if CIS Central or CIS Peripheral is supported; otherwise,
> the command is optional.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: Fix CIS host feature condition
    https://git.kernel.org/bluetooth/bluetooth-next/c/caa53589f0bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



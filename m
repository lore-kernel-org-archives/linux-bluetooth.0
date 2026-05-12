Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A10F9D9
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 19:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613667; cv=none; b=VsSI2mQobwo5l74xStqTIYsgJBHszYbdgvCJK8Yb9OLTjZ2NHT7hNPqJoTwZK4sw4tneFpKmonhgP5zuo7FLFNKdZxfw5vuP/QxfO9eW9FLaMA9GHPye/f7G/VRN/zuqoiArPlt1lkLLWSEVKWFXwGE4t/5M3fQgEoXYsqAdur4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613667; c=relaxed/simple;
	bh=0TrJpL7LCiW5P+OJghIPhXlj+c+pvx09h1XjVNAvcj8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TVovxIyfOP2gFgvSFVj9CTK1zq1//pr+/hoPdo1IYh2JhtdIbgsilOvYikyCYJ5RzXt3DapY7RTTfl4BSLujMl+aTA/N+4jTCg6e1Zd5WSJJhf+UnkIHUGD+lLmRC9rkZYyCXwd+hdVL5P91GHYKbdswdJGc9DrhOpKG3L2pMjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImAg95Ok; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImAg95Ok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448EAC2BCB0;
	Tue, 12 May 2026 19:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778613667;
	bh=0TrJpL7LCiW5P+OJghIPhXlj+c+pvx09h1XjVNAvcj8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ImAg95OkpIWg77Vuk6n/uKzYidoTrTIi5BT/6y+TaHrM+AC2yTsAOYrBQFSmvm0Di
	 +qEl5VVQnSIh6PHabo4fhM2bbV+jZB82/H1VcY34wo6jo86vRtju7w5cVGhhjnCqYJ
	 c1jwjv56gZoN7rnVsgwJbNZ2vXnmBKNhRxf8tYfxUkj8mlPIXEt78VZXxgza/hwB3T
	 nfLYhldf5fgvOBlotnELu650b1BmWkonjkq4VhvXc5RBJPtZoDaMG0blzmyL6130T9
	 1FiV+Ko9zZwOIZEb5N6iRgyJQUfrN35aLELYIDg4caoFPCgDs0mbakWIc+QTNOj2ov
	 ZpKH2hkTLCjEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDBA3811A59;
	Tue, 12 May 2026 19:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RFC PATCH BlueZ] monitor: Fix RAS CS step mode parsing issues
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177861361304.3045511.2195942943532353506.git-patchwork-notify@kernel.org>
Date: Tue, 12 May 2026 19:20:13 +0000
References: <20260508191728.428868-1-luiz.dentz@gmail.com>
In-Reply-To: <20260508191728.428868-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  8 May 2026 15:17:28 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Fix double space typo in print_ranging_steps signature.
> 
> Fix ToA_ToD sign extension using proper cast via (uint32_t)(int16_t)
> instead of unconditionally OR-ing with 0xFFFF0000 which corrupts
> positive values.
> 
> [...]

Here is the summary with links:
  - [RFC,BlueZ] monitor: Fix RAS CS step mode parsing issues
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4cedd8f9b886

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



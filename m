Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17461DF268
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971798; cv=none; b=tPjGmwy01Q3d6Yo2YbuZ1l3LW9bU4eO2yE8cQIoaMlGLcJMihUS6AYuCwf+FZlljWtFdq4xRB8M7Shc/ERjVyeEUeRHSQ+UvjauzZSVFsOoTLl6pPpaWWEfl5Lj1bNwFqClZ2dA9uNPv9/qcXdrCV9QsJ8Xfa9+Qb5/h0wlM11s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971798; c=relaxed/simple;
	bh=6FobbCZHVu1s/QOj96jr+3mlvjNgbRaIr1POkOz9OBQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sRZ6bYwsc5eRCNy143k4XRulSEE4AdaYTJWDn0+l7r14l5+7Da+qlWgKi6CnigwdrKs/B76+vNJtIxGyZlU8aYEJENadciL4CCp6SJ4TB7vL9/FnXel4eLSHK1hpYU+HqFEHGQbPm4sXxobv0M7E8Mkx8uMbqFUtWQKg2JtDj5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1MWghb8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1MWghb8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B150C4CEEE;
	Tue,  3 Jun 2025 17:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748971798;
	bh=6FobbCZHVu1s/QOj96jr+3mlvjNgbRaIr1POkOz9OBQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G1MWghb8RGWUMMS1BzlTuXrDbpnGhCKDCqmloBsCPraYRI/2VxloG7ClSA6zXRMOZ
	 GqmodY+yEpRCDwgzU39yu19QM0BbqPgeybx5bGJU3OITtrKy/wFXaFLOxx7kgXvZue
	 0Ur1mpI+iXtM9rXWrQnVN2N+fjoFshjpvM+ZPVN0pOUjFb6VcN0Atbe79mmMnyCkPX
	 jU6so5a+dOMdmaLq4YuSh/i97ABfEoIUrUVZLrg2NPh2ozWt1TDDM1jZjTfQeSFwHw
	 RkaR7cTZ7OJZM66gf5cLuuAZN4DjDGjbnR0ly7D/AW2hJisBouOskQ0MkfOhQKtOWg
	 RCbmqEp41Yftg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB36B380DBEC;
	Tue,  3 Jun 2025 17:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] monitor: Fix bit for
 HCI_LE_Read_ISO_Link_QUALITY
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174897183048.1598265.6595469605333869932.git-patchwork-notify@kernel.org>
Date: Tue, 03 Jun 2025 17:30:30 +0000
References: <20250603085352.1297099-1-magdalena.kasenberg@codecoup.pl>
In-Reply-To: <20250603085352.1297099-1-magdalena.kasenberg@codecoup.pl>
To: Magdalena Kasenberg <magdalena.kasenberg@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  3 Jun 2025 10:53:51 +0200 you wrote:
> Hello,
> 
> This patch fixes the bit ID assigned to the HCI_LE_Read_ISO_Link_QUALITY command to match the value defined in Supported_Commands table in the Bluetooth Core Specification.
> 
> Best regards,
> Magda
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] monitor: Fix bit for HCI_LE_Read_ISO_Link_QUALITY
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8ad12fe7b4b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



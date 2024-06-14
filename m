Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EC815FA9C
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jun 2024 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377232; cv=none; b=FZaG8+w2J1awGl4pARc40155jHj/lZM87eiJ00Zq77gJPgEJIpiQPaK+34GHHpLlRnUSvpUJFlfPIH4hIybirlwFuotRij5/sB/rikhXT3Gu7pcEe4qIdjvyYJ56A2m6TJnVEvvSJIis0JWyQKrJPVmNt68ymsbgvhFAMgUdnbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377232; c=relaxed/simple;
	bh=QXnrKTQNOSkpOoaoAQeyZRaitoRsolNEYqg8dBN4ODs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QBzCRsCOIaV+IS3MBj+n4C6DHOPC1+46CjC0nHXhM07PdYOp3OOSgq9osNI0B7JJcN2Oj2F3X5AY9p3I5V9uUYcjcHs4jY+ad3R2uiEm9PeM4q75QxduZxgLfMl54ev+Zx7M8xWjLeXe9nOhTVDupjKValXGiYcUskBDjVJCNus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Maw327Hy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Maw327Hy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE3F8C2BD10;
	Fri, 14 Jun 2024 15:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718377231;
	bh=QXnrKTQNOSkpOoaoAQeyZRaitoRsolNEYqg8dBN4ODs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Maw327HyfrvsgjedE3vKBgEfBacyUpGzqb953QhTTlsi4BaOH09QMyMyIVwccKBJa
	 wtHY71+pFoorn2vHYNzkf4m/R6vv38oZVD2++lL6+sasqyZMNg90gnpplBFrU2oFE6
	 5ZCSJfN01dapB2QEZF7dC9Nqo1CvoVtzPx5ILiqLyk9RV9fdKA656Na+7hCuZO0Omj
	 0AszEfMC3mxnjteRPt0KbuZ7zhRDPVI2qE0WJW//vWbgPSB8d0qUSt5rGtObiE/d9x
	 2Ki8eGvDOiQx2YV3f5v22DYa7Gq3Lh63gJQTni78lPltBUTrirjxTV/M/fPxZLCqNr
	 2tnIpqz56te4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC2EBC43616;
	Fri, 14 Jun 2024 15:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] device: Fix marking device as temporary
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171837723176.23725.12152128225919133175.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jun 2024 15:00:31 +0000
References: <20240613170313.1596181-1-luiz.dentz@gmail.com>
In-Reply-To: <20240613170313.1596181-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 13 Jun 2024 13:03:13 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If bonding has failed but there are other bearers connected don't mark
> the device as temporary.
> 
> Fixes: https://github.com/bluez/bluez/issues/856
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] device: Fix marking device as temporary
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=48b7f7e5fe53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



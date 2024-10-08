Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A9A1DF995
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Oct 2024 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396030; cv=none; b=kU3SPbSY73oATg6f8voEjBuWySlpOOJkOn0IXHZzCutMg6OlqI6z41jCpPNkLe9kRXmG7qxPudaEMkFaMjDk8Nh0C6zCV3qQnTiKjgXTVkL7Kq22Ltf2wqFmeK09DJhFp0g0U69VlgfmjNnExQOVS8zGb/RV2kRPYoZpnM/MvZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396030; c=relaxed/simple;
	bh=yFqwqBTumc75dj3ukLSVavlgDuh1bqJCEvCkVg9SVRE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JKtFa/Pbzt8Ow8p3efJF1DikOpbuaNSAp5FFwvYH3nx8uzL7dMRFIZxmkTGfg4SyVP9v02ndzoAsgSIuxu/AMi+zZyOxljcUm1leDgO19BEZTK6g7E4RjmSR/bcXD3vCvoMaxlFQNAYc/f3l6icJfxOwFKfmYMenH/MUQL2Ef1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfGo0gL9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfGo0gL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED91C4CECC;
	Tue,  8 Oct 2024 14:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728396030;
	bh=yFqwqBTumc75dj3ukLSVavlgDuh1bqJCEvCkVg9SVRE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KfGo0gL9OukEJMBjh4cBe5J4nemdkCN7QBrIiEIeV+GYN1PRftdwsJuPxK9dt4iqA
	 iOdJtbPD1oObRd+FUD6xwBEGYqeasw+0bBtx4PMrDFxSAJ3tTj8vtFOOB9AC4eOwH0
	 HXqyOzBBoG8nJrJA1J3hkK82ce/dnw5vbUdVbV6oS4+pzCPwlVcPobEmsZuxEFIFH4
	 WWlHy43qtdWukBdw5T6wDrBrE/6F8+eQw6DrQkF7497m3cTsOHKkx/qwM7EQ8f7BC1
	 VN9gqB9JBsc2C0ArAh9dg8pCevFz4Yvw13nGJaW04U2emFhyytvzez11OfrN96xUKC
	 KDcuV7uh0c6tw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE883810938;
	Tue,  8 Oct 2024 14:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] avdtp: Fix state check before sending delay report
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172839603424.554899.10556191913371360336.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 14:00:34 +0000
References: <20241005211510.409471-1-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20241005211510.409471-1-arkadiusz.bokowy@gmail.com>
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  5 Oct 2024 23:15:10 +0200 you wrote:
> The function which handles the incoming delay report command was fixed
> in 2fd62cd. However, the function which send such command was not
> updated. This commit fixes that.
> 
> Also, indicate that the stream does not support delay reporting with an
> appropriate error code.
> 
> [...]

Here is the summary with links:
  - [BlueZ] avdtp: Fix state check before sending delay report
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bd7d49d54aa3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



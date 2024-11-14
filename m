Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80C11A2658
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 20:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731616220; cv=none; b=ky4B4bRMi9eSSyIEvEJqPrDTCi5a2v+kp8xug2I48d/CGUrAP8EhwXURD+kcaY/R3GioEuP3aY0anjkCLhUQI9Bwr1O+nAKu+CMeQOjUdQqbkgwQUIGfn+Mf+O24bkm4upyM268BS0/XbYVjwdvRHqa7+f+7YizVz9ik0qQ5AYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731616220; c=relaxed/simple;
	bh=H6QCcP3zttMeSRGTcPBnmWG6l+XZ8+1MT9lNDtaFaZQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OKWEHGqb5/Z75RA/i7kx2KivDk5IWKCwT/UKN/btQMaPb0rlijYQOULmyDWsxwM/MYO8gyJy6uP+/FooVIq1xueQUtw30trWiOAjN7IL3QTpJucw+fga5qfZV/Aq6uhjisVpSb8h6kLaJQdl6zntLjuLIjGwNiOfxm+1Pfi2WGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kianx2Ej; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kianx2Ej"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284FFC4CECD;
	Thu, 14 Nov 2024 20:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731616220;
	bh=H6QCcP3zttMeSRGTcPBnmWG6l+XZ8+1MT9lNDtaFaZQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Kianx2Ej0CAMe3O0SpJMVjE3cp6VxwNqZJgukFj/oCVcqgVLYSaKynlyqR4gnFcdz
	 4fD6Pa9j5t84SFJs7drQoUsJjmSqDzON4jq2zqs4/fnbiKKRhktDFFMsMJTYZ3GU2k
	 XqPrR+D7WPy8mg/qmVIEEYbiS5Rd0gOI/dtSskOD0EUO2gp5G1Zb6ZtP3a2W7+x446
	 V4EdBpO3/JkbaAR28UT82TXltSIFapoPkrHNJPb4tgF8+vHsjqeK1l3OCijA0WSrUT
	 jA1NJGdPhjxOk6NseP1u+PbZCC6pZ+DjVItlj4/xcrCK83f0pn2Ehka9oEwyhRxEau
	 pnRxGake/1BAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACB73809A80;
	Thu, 14 Nov 2024 20:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: MGMT: Add initial implementation of
 MGMT_OP_HCI_CMD_SYNC
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173161623075.2046657.8844918237861888751.git-patchwork-notify@kernel.org>
Date: Thu, 14 Nov 2024 20:30:30 +0000
References: <20241114184046.1690311-1-luiz.dentz@gmail.com>
In-Reply-To: <20241114184046.1690311-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 14 Nov 2024 13:40:46 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds the initial implementation of MGMT_OP_HCI_CMD_SYNC as
> documented in mgmt-api (BlueZ tree):
> 
> Send HCI command and wait for event Command
> ===========================================
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: MGMT: Add initial implementation of MGMT_OP_HCI_CMD_SYNC
    https://git.kernel.org/bluetooth/bluetooth-next/c/f8e802a53b3f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



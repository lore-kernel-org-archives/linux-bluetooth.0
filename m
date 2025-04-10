Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5C61EFF97;
	Thu, 10 Apr 2025 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744304998; cv=none; b=NUgb2IvQU/90VqNYXiQE5PJOzlOvQeBEsuXXf8yVRMFsrAQ8jRsXjAqqHRCq0dL52y/vg4YYG3o0Rp9jUsilgTx/6bL2UHBjXtPZuV/Nl+3DD7pB8qGs4raeZwDwYcOj8yM1EUt/apr/xEvbo0ETuuIaUj1YhMQ+b+SCkS+HPD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744304998; c=relaxed/simple;
	bh=9pVxLXv9jgr3EZk1y5pl6/E/9gwYXcGjSrA4i8XB6W8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JTD5Gwj7kL5Yqiohh+jOQrkay4ExnXJww3wQxUD1pOhTTEKPn7pnQJh6NHjh0Fu4N2xPyKnSXPHjycOeH/dGg4/eYG6suGwJa137/MX+SycLVEWfOf1/vGTcq1VXptCQ7ItPCAootX3IlrTvLNkVt5XFTEVZv3i7rHlcH8catjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGcw5QGO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGcw5QGO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96B4C4CEEA;
	Thu, 10 Apr 2025 17:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744304997;
	bh=9pVxLXv9jgr3EZk1y5pl6/E/9gwYXcGjSrA4i8XB6W8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tGcw5QGOE5g3xy6L/HZRmY4ori10cI85weEqP85ec0xua18l7eS4Qf+R8k7qU3VZz
	 4RV/HnBgj3DpBaYPkqJjFpuoBTehqJDO8sUqpNb0fHLfNcbbzmVqqyh/nYYqsV+xuR
	 iB06XjH6mqBTCJ8IwgQzoJlTiHZdG1O+HSUV5WVRZgXrlAcZy0d8vvAiRqwDifYTA4
	 IGidS8GC4GClchh+d8X0suEIqr0xoiiObcXYzLKZxAi3WJ1RKGiiLRj3YbgEpbtj9z
	 w59q0UuH81IUracQnJcD+ZKVhk+rs5DgMQ4ZKBM++xjUpma6eIVLplCtAxD3thmg/2
	 8FTswIFB6xwsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DF8380CEF4;
	Thu, 10 Apr 2025 17:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_uart: Remove unnecessary NULL check before
 release_firmware()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174430503525.3757803.14280506503586570075.git-patchwork-notify@kernel.org>
Date: Thu, 10 Apr 2025 17:10:35 +0000
References: <20250410073456.3558507-1-nichen@iscas.ac.cn>
In-Reply-To: <20250410073456.3558507-1-nichen@iscas.ac.cn>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: yang.li@amlogic.com, marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 10 Apr 2025 15:34:56 +0800 you wrote:
> release_firmware() checks for NULL pointers internally.
> Remove unneeded NULL check for fmw here.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/bluetooth/hci_aml.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Here is the summary with links:
  - Bluetooth: hci_uart: Remove unnecessary NULL check before release_firmware()
    https://git.kernel.org/bluetooth/bluetooth-next/c/b53b259e34e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



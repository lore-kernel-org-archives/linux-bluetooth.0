Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1286B372B49;
	Tue, 17 Feb 2026 18:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771354220; cv=none; b=IvEv1JVNQ3ZkWaeXV8YhgbQMWDVy0IrDw4Mcr/Sd9y+E/zM8gIJA2wUblLO+1WNlXu0uDXq7NiEkq3bPVvczwVzOEcPpYMlMHolu2JzOFk8cbAsx+KEfTOJ+qjopPVI798z0FN5JX3rF/2D+Ak9eXamyzoQwXW/N7CnMsRuuFkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771354220; c=relaxed/simple;
	bh=h6Y5DVA9NR4IMdCCV4WgryNHjhqftZp+49NwJewYS8g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DsJx5YnurbhketAHIDK7NHWFKIcvNsg/+6s+3WAoz88hzfz+T9Y/fP+l4zorT9zFueOvbuvUNM55vag01NVmQPd+Ejhrp1D9iGel9F5QVMHB4uq+zDN2ZSkkpIotazlK48XoKbUS1SFGJua7sHjDXQ2qAD5SWOSZ333ECqP0gRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnRTNirK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnRTNirK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DF9C4CEF7;
	Tue, 17 Feb 2026 18:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771354219;
	bh=h6Y5DVA9NR4IMdCCV4WgryNHjhqftZp+49NwJewYS8g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SnRTNirKxgdakGAKVmhPrNUJETKXQFhc7B9LhjwC0OHN3vAXKEp5XwO9LiDSR2dME
	 2Ksw4TXHt8bKSVsUoetOu2z/Vuplsr86MFtqazUIXTRT1tUs/zYKOb7O9XjHtE28by
	 QPW21GSmzO7JEFrrfV9SKrD0Io+SQSso4bX66xvY/1EA7KofCwPQ6ck+0W3cpKQc50
	 fohKfsN5q/5ByAAvoz7W5i6cKutJ1Y8B6rsNvkDQ5DFDvD245M8wF/1D3x9nzMI2OE
	 HXc6pwoJi0g+n9ioFpuflm6aJJsHPkRb/EQm07kOr4v6X3d4Z+5+EqHUjKL+fGB/1k
	 yurGkD/6hMgIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C25E03806667;
	Tue, 17 Feb 2026 18:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9] Bluetooth: mgmt: Fix race condition in mesh handling
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177135421132.600961.11662077069092767066.git-patchwork-notify@kernel.org>
Date: Tue, 17 Feb 2026 18:50:11 +0000
References: <20260214130610.68236-1-maiquelpaiva@gmail.com>
In-Reply-To: <20260214130610.68236-1-maiquelpaiva@gmail.com>
To: Maiquel Paiva <maiquelpaiva@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 gregkh@linuxfoundation.org, marcel@holtmann.org, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 14 Feb 2026 13:06:10 +0000 you wrote:
> This patch addresses race conditions in mesh handling within mgmt_util.c.
> 
> The functions mgmt_mesh_add and mgmt_mesh_find modify or traverse the
> mesh_pending list without locking. This patch uses guard(mutex) with
> the existing mgmt_pending_lock to protect the critical sections, as
> suggested by maintainers in previous reviews.
> 
> [...]

Here is the summary with links:
  - [v9] Bluetooth: mgmt: Fix race condition in mesh handling
    https://git.kernel.org/bluetooth/bluetooth-next/c/003ca042a386

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



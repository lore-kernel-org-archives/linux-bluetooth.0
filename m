Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16349186E54
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729094428; cv=none; b=QKyYQnCgYCiMztTovWldeANbcOZCgyvXhGi1cOVE/8GmlIHCkR9TmY0zkjVJTjtYjFetXkB9S56+FvLhXMu9UlDMxmTyD5szkhMNO4NAD8K78vHuNw+MX/t9uoBQmpnMLFDuaBVj/xVDQ7gd34TKNPDvrWFHX0jByvhpAkwz0y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729094428; c=relaxed/simple;
	bh=CYQIqXSapne0SrF8559hvBQJuvSxbQsowGJGBoilNwk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nL4n6yDFuBT0+KKN8y3ap+9Yz+0VAe73/oLJONOgkSa6THYNHPzR0h4Q4rbOXPXCWYh8oN3bty5ShhsgRIYt9gfEH+VHh/kUkM+C8vK+sdlxlZKz8ueGAwAxEK6GV+83fbF8XSSDtdzJG4SBeYam6zdNk+mP7XzKWb3RPPFiTRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Akb6Lfh4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Akb6Lfh4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BC2C4CEC5;
	Wed, 16 Oct 2024 16:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729094426;
	bh=CYQIqXSapne0SrF8559hvBQJuvSxbQsowGJGBoilNwk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Akb6Lfh46Ik8yVzmjm3BxRCGVV1S4mw3gJ+35yQIUmd2j+k4ryfYMvwEtu2I5PopE
	 pKMnJDGdZhLUE5tI69PWvqsZeinZXWwQr+V0n+jG/0M9VdfARKmG02ieKDHpg5i8Wr
	 gscJJoaIwiLTVHqgQ4h62nblVnpxz05j1FHvKBjoZbsU/abXY5g+kaNzPPhDtML6IT
	 zbFDl/dO+/EIZb6uYl+Vdm3Y6MfAFlRGDS7xtxSH4m0Bal9/wsFG6SwMp1xP00CXyu
	 TInp2/V0TfwMlx5Io82vhyu4TjdJ6Ti4HfjyyjbWdWwhvYWUMwnO1kqbsnl1HGadvJ
	 CCiGMMd2qlqIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCE63822D30;
	Wed, 16 Oct 2024 16:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: bnep: fix wild-memory-access in proto_unregister
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172909443152.1863747.16466588010493150746.git-patchwork-notify@kernel.org>
Date: Wed, 16 Oct 2024 16:00:31 +0000
References: <20241014090708.3818916-1-yebin@huaweicloud.com>
In-Reply-To: <20241014090708.3818916-1-yebin@huaweicloud.com>
To: Ye Bin <yebin@huaweicloud.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 ricardo@marliere.net, linux-bluetooth@vger.kernel.org,
 viro@zeniv.linux.org.uk, yebin10@huawei.com, zhangxiaoxu5@huawei.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 14 Oct 2024 17:07:08 +0800 you wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> There's issue as follows:
>   KASAN: maybe wild-memory-access in range [0xdead...108-0xdead...10f]
>   CPU: 3 UID: 0 PID: 2805 Comm: rmmod Tainted: G        W
>   RIP: 0010:proto_unregister+0xee/0x400
>   Call Trace:
>    <TASK>
>    __do_sys_delete_module+0x318/0x580
>    do_syscall_64+0xc1/0x1d0
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - Bluetooth: bnep: fix wild-memory-access in proto_unregister
    https://git.kernel.org/bluetooth/bluetooth-next/c/7902a76b54e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



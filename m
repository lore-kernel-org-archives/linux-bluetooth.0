Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56C417C98A
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Sep 2024 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726582833; cv=none; b=f3q2o77sbqAJ+jinfnJm+WvZKWEnfU90lIKrq7XLFdQTs4IcAJBgzsTANM0+EkFulJUDoCc+HLf6cLBS4+fjASXUN7h+1FIaLgGSkPcUSwkCKt9vESHN8BT0qjzQVjMh0Rg008GbSHcvcZUeMugrYlGaiGvmyXq3gPK9AEhHEOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726582833; c=relaxed/simple;
	bh=lNlY97kZXpT69sd1M5X6wkm+CMD699UFndZmUiVk1Ho=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M8V5lssICiiRDSYmH3KYuSPbQ0n3M8MBUOfN40dpA/YaD09RwxVZbVlNZQcrQ2izdCAB2Vgcl2XyTg2WhBhdVQ9yCP8kCMsJcntTb8LLmKf3WFaKW0HDCbPMuMCFRtkF6Q41J3e70kiL7u7QhzOpr0NSZcJxz7C4/UJ/UKXK1QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0BqMWXx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0BqMWXx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB84C4CECD;
	Tue, 17 Sep 2024 14:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726582833;
	bh=lNlY97kZXpT69sd1M5X6wkm+CMD699UFndZmUiVk1Ho=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P0BqMWXxoL6UYhc7oWyOlgn98/xG9khQ9xXPDjAfqaRq6B0eznto4il3VFeurNsn1
	 8Nm0QICFb5VVkO4Kfg8FJb+NbGhhE+rt+21tk+0OcaLmtha+XOznFd5ajvCEVHN7gb
	 Ny0Z8BfLfAbLmfzRkyunh934LhWtVAXBBHhDmAlKYXSKqykdKaOXMikk0LJofoWTLv
	 g+BGXUWBtfn+ECS7pukkcmm1y5vhlfaGEKPKPJoXTv5UlkIZRdf8zEnM6QQUjEJIzv
	 3WeY0s9MERiq5V8agWgLc5bJKThILVFgCNSGI2YhS4oBmggXnKDiCZvX86HkyvTtFB
	 4oTcjoYXPSLpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 354F03809A81;
	Tue, 17 Sep 2024 14:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] shared/uhid: Fix not crash after
 bt_uhid_unregister_all
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172658283503.155805.10142338830265397613.git-patchwork-notify@kernel.org>
Date: Tue, 17 Sep 2024 14:20:35 +0000
References: <20240916202232.231417-1-luiz.dentz@gmail.com>
In-Reply-To: <20240916202232.231417-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 16 Sep 2024 16:22:31 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following crash which happens when
> bt_uhid_unregister_all is called from a notification callback:
> 
> Invalid read of size 8
>    at 0x1D9EFF: queue_foreach (queue.c:206)
>    by 0x1DEE58: uhid_read_handler (uhid.c:164)
>  Address 0x51286d8 is 8 bytes inside a block of size 16 free'd
>    at 0x48478EF: free (vg_replace_malloc.c:989)
>    by 0x1DA08D: queue_remove_if (queue.c:292)
>    by 0x1DA12F: queue_remove_all (queue.c:321)
>    by 0x1DE592: bt_uhid_unregister_all (uhid.c:300)
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/2] shared/uhid: Fix not crash after bt_uhid_unregister_all
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9a6a84a8a2b9
  - [BlueZ,v1,2/2] test-uhid: Add call to bt_uhid_unregister_all
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f9f98c0b2aa4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



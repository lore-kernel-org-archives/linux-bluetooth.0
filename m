Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F13113FD69
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720450232; cv=none; b=oLCws+t7LnDGvq057QY6Nkh34Bho+qXSQQfh1avEGdC0S9DQ/yHd0Ga2eutz+G2pIUyUQWR7IH9En5dDSXwLhEiYVymAsIazmxY8Kx9NDYDQw43YGfazMNVNEkDrAyww4k/bqPB3XBXiMqunU2n9LNOm7Ws7cAsGmtqRvjUvrcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720450232; c=relaxed/simple;
	bh=eYrAuriSoMqpfaLEQWBhRAQr6WrfFRMcsfbPcAaEmmI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hasKmFoVDNMeCyzx11i/iYESuYi781LlT9uFcbiTbPxAwxX7NArabb6cxPMB75x5DjhavXPf2o0iEyRDFHbiEYq0Jmtz1dnm7ekUOUaEglkPn9y+G1ZxwEShh2L4fM8LA/Pv4lj/1kzW5ktsTyA428CL1QvahzQU5NakITGxKNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4Jerc1v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4Jerc1v"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1A42C4AF0A;
	Mon,  8 Jul 2024 14:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720450231;
	bh=eYrAuriSoMqpfaLEQWBhRAQr6WrfFRMcsfbPcAaEmmI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H4Jerc1vowZsUaQqfoQzCcVuhct6/rCKlPCGAiEpOKCzLWHQ2cC9n0wWbMwlCgZwm
	 TA5MjDhF9VQGpAX51ewxACUdkvpLvUKyBOZX2lYDTr0vvnDplRNe4TcvPORjanU9jV
	 xYCWAK5P11vxbk0mCJeTL8zzH+x0TuMQgM1K+18tUbEUd+j2xg/F4jzj0XT/6zeXqW
	 arsqjRPZvnXRQmbFRPHFSSOVXqzCeSZzCDxwOonsaQmooHwgk0CY3CiioWB022ObK4
	 dt3Ye09LnVPC7izP5853PzJx7JhF/D/8dS7Wd01f2t2hSLkvY+mUByWDsjgq6VH1mg
	 Vk/sYWkzGmmBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB128C433E9;
	Mon,  8 Jul 2024 14:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ v2 00/11] Fix a number of static analysis issues #5
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172045023168.5742.15061982471514672720.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jul 2024 14:50:31 +0000
References: <20240705085935.1255725-1-hadess@hadess.net>
In-Reply-To: <20240705085935.1255725-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  5 Jul 2024 10:57:28 +0200 you wrote:
> Fixed review comments in:
> gatt-server: Don't allocate negative data
> shared/shell: Free memory allocated by wordexp()
> tools/mesh: Fix integer overflow due to cast operation
> 
> Bastien Nocera (11):
>   gatt-server: Don't allocate negative data
>   shared/shell: Free memory allocated by wordexp()
>   shared/shell: Fix fd leak if -s is passed multiple times
>   btsnoop: Fix possible negative memcpy length
>   sdp: Fix possible null dereference
>   sdp: Fix mismatched int casting
>   emulator: Fix integer truncation warnings
>   gatt-server: Fix integer overflow due to cast operation
>   mesh: Fix integer overflow due to cast operation
>   tools/mesh: Fix integer overflow due to cast operation
>   unit/ringbuf: Fix ineffective guard due to signedness
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,01/11] gatt-server: Don't allocate negative data
    (no matching commit)
  - [BlueZ,v2,02/11] shared/shell: Free memory allocated by wordexp()
    (no matching commit)
  - [BlueZ,v2,03/11] shared/shell: Fix fd leak if -s is passed multiple times
    (no matching commit)
  - [BlueZ,v2,04/11] btsnoop: Fix possible negative memcpy length
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8de21f74c5f3
  - [BlueZ,v2,05/11] sdp: Fix possible null dereference
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0de4b9f71eb9
  - [BlueZ,v2,06/11] sdp: Fix mismatched int casting
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0b52ecca60ea
  - [BlueZ,v2,07/11] emulator: Fix integer truncation warnings
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1d73dc6a1a9a
  - [BlueZ,v2,08/11] gatt-server: Fix integer overflow due to cast operation
    (no matching commit)
  - [BlueZ,v2,09/11] mesh: Fix integer overflow due to cast operation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=249d2120bd90
  - [BlueZ,v2,10/11] tools/mesh: Fix integer overflow due to cast operation
    (no matching commit)
  - [BlueZ,v2,11/11] unit/ringbuf: Fix ineffective guard due to signedness
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c44a2a233d1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



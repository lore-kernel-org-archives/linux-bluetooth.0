Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBB4CA6B
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715355633; cv=none; b=QoyFvNhJT/FzhGeLqO7e9EvQCtMq/SJJ2RNlnKtQPTJO06uJg5dtd27qWUfsyidI05imjQKW+nbb7EFXh9JIWWnTYvQazlIy+qZrgrNCOizgQWxYrLFxFIo6pzdlv6TOHt9p/Ucykjdj7cbJJ2CuvkCv6pXxA+Oyet4VXsgXTd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715355633; c=relaxed/simple;
	bh=QmNnbdnViwuzY2V9Y+Eo4zNA2dxsqD8JVwPyR+wd1cQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q57Cp/N/MPfDst3pf3Qtdt2RycTB7cbGjNNRF+LMGKjqJsOrO/tDGkm4/PhW7nLtRhGTqZkhN1WKptEloG8hxXeiDO9cwy/VxaHfJo6B/PZFQXlA0D+6zD4PL8ToKGHVCr4l17wILUC+V6TFi7dW+gHk/rLsKXZSx9LQDOns3aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VX+rmF6z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VX+rmF6z"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDB1AC2BD10;
	Fri, 10 May 2024 15:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715355632;
	bh=QmNnbdnViwuzY2V9Y+Eo4zNA2dxsqD8JVwPyR+wd1cQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VX+rmF6zH0DfGG+t4SCPeKzzEm2i4fBqQDsdNY4LtyBoDiiqqAiX7Itcrw7MQXoQK
	 fi7NmWro7eKSsGjcsY0j9Fc5y1GS0DuaA8RFx8ih6IjJoOSt/IpbNo9XMr8/H00bHB
	 MiqSpQqb/JyrnM6y/SQNDLYHwobeu9dzUtiBYvtNkoDHM/ctOUu7k4gLYEkiu7Yw+r
	 0GbAF4cmMCqE9mevFRp8ZQXwxxixfb9JGasLpgdKvPXtEwwsesoL7FLswn2iOQAjBM
	 g3tiN0P1uR7paU4poEpXnbT7DvLC0xatwUG+q9WvSb9o4FMb6zqKSFzVa94/icZkGP
	 K/X8GvVeWY6DQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CBDF7C04E27;
	Fri, 10 May 2024 15:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ v2 00/20] Fix a number of static analysis issues
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171535563283.2819.15014215823661998089.git-patchwork-notify@kernel.org>
Date: Fri, 10 May 2024 15:40:32 +0000
References: <20240510121355.3241456-1-hadess@hadess.net>
In-Reply-To: <20240510121355.3241456-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 10 May 2024 14:10:10 +0200 you wrote:
> Changes since v1:
> - added 6 patches
> - Fix syntax error in "client/gatt: Check write_value() retval"
> 
> Bastien Nocera (20):
>   adapter: Use false instead of 0 for bool
>   attrib/gatt: Guard against possible integer overflow
>   client/gatt: Don't pass negative fd on error
>   client/gatt: Check write_value() retval
>   client/main: Fix array access
>   client/main: Fix mismatched free
>   monitor/att: Fix memory leak
>   bap: Fix memory leaks
>   media: Fix memory leak
>   main: Fix memory leaks
>   isotest: Consider "0" fd to be valid
>   isotest: Fix error check after opening file
>   client/player: Fix copy/paste error
>   shared/vcp: Fix copy/paste error
>   isotest: Fix fd leak
>   iso-tester: Fix fd leak
>   sdp: Fix use of uninitialised memory
>   monitor: Work-around memory leak warning
>   avrcp: Fix uninitialised memory usage
>   main: Simplify variable assignment
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,01/20] adapter: Use false instead of 0 for bool
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d3fcc77f99da
  - [BlueZ,v2,02/20] attrib/gatt: Guard against possible integer overflow
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1e22fd9adbb3
  - [BlueZ,v2,03/20] client/gatt: Don't pass negative fd on error
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1ba9e5f21ca2
  - [BlueZ,v2,04/20] client/gatt: Check write_value() retval
    (no matching commit)
  - [BlueZ,v2,05/20] client/main: Fix array access
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f3f762b77b58
  - [BlueZ,v2,06/20] client/main: Fix mismatched free
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ab325450b0c2
  - [BlueZ,v2,07/20] monitor/att: Fix memory leak
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0b842fe9b1fe
  - [BlueZ,v2,08/20] bap: Fix memory leaks
    (no matching commit)
  - [BlueZ,v2,09/20] media: Fix memory leak
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3652e98d2bb6
  - [BlueZ,v2,10/20] main: Fix memory leaks
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=45d151ec8a0f
  - [BlueZ,v2,11/20] isotest: Consider "0" fd to be valid
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d30dc38b0425
  - [BlueZ,v2,12/20] isotest: Fix error check after opening file
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9a36f191aa78
  - [BlueZ,v2,13/20] client/player: Fix copy/paste error
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6f041df23ecf
  - [BlueZ,v2,14/20] shared/vcp: Fix copy/paste error
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=856353b254da
  - [BlueZ,v2,15/20] isotest: Fix fd leak
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3e03788ba80c
  - [BlueZ,v2,16/20] iso-tester: Fix fd leak
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c81f9320357b
  - [BlueZ,v2,17/20] sdp: Fix use of uninitialised memory
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=dc60ce0b460a
  - [BlueZ,v2,18/20] monitor: Work-around memory leak warning
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e5925dbb84fa
  - [BlueZ,v2,19/20] avrcp: Fix uninitialised memory usage
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=af2634ce0a62
  - [BlueZ,v2,20/20] main: Simplify variable assignment
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=87edbabf3956

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



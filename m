Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D7822092
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 20:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715892634; cv=none; b=Rv037pJMXN/biHR9iakXglCxMHoqCSK9HMgw1rU09UJMojk1Td8dy1tMnn3jclGwWpt6+f8ScYwRwGbGFuyQImA6sMyXN3m/2S2VmKz11Gabqk9oUhM1CI93c+t5yPjRVCSAfi7UkVz2MuiVgB9S9x1hGF+MLG0sq6rGjpGPvcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715892634; c=relaxed/simple;
	bh=JJdOe+UqqY5i5nGSpE4bBZ5UqPOLoecQQcxEQwqDmTk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R283MwFVLPHXjcAbmNSB4u4syuhhR+cU2GC3z7oFKcyL8W9hIsgEvava0QTf9PPnoxzsKOt9Pc6QkAEI6Waa99UPLEVUTWdxfZplb7ewz6SVdp82Xlhzvdou8GvbzCvRfJuTDK3Gjs1W8ihGPrXFgqtqbsRMEXkkz6FRtYknO2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPwd1Hz6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPwd1Hz6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC396C32782;
	Thu, 16 May 2024 20:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715892633;
	bh=JJdOe+UqqY5i5nGSpE4bBZ5UqPOLoecQQcxEQwqDmTk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VPwd1Hz6Fsk7VZhRDnYNe9JpMKZHG4WQWE/qQLZQC0o4wcsOz3RdXKZ4Sk1CkuoV4
	 Y0B03cPn06fd5M9F4dXENHCRstjdF+DnGTUTjMz687tGUwhNqk9hUo0IthoRjL5IyO
	 SL4Hd1UHeqdYEfZ1xF0p7+K3eSXvlz/di7CBMK3/RrhZZiyN4Jcs4hQQqQ1Ozz62rm
	 lDQBkpfz4BaFqMSDJGQoFsy06isMYqWPX9zOUdjqD/fwqMbDIxWooJhTrIr8omlXOR
	 7z6rXyPP4+/jVf1tN4Totsear/oaljlZg3SQdAMjyQAr6P9yBuPjXxu6bt1Hez4tIT
	 bBmC1e46e3lgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9F94C54BB6;
	Thu, 16 May 2024 20:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ 00/15] Fix a number of static analysis issues #2
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171589263382.16065.450653433983934585.git-patchwork-notify@kernel.org>
Date: Thu, 16 May 2024 20:50:33 +0000
References: <20240516090340.61417-1-hadess@hadess.net>
In-Reply-To: <20240516090340.61417-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 16 May 2024 11:03:04 +0200 you wrote:
> "main: Simplify variable assignment" makes a come back, moving out the
> single special-case out of the function.
> 
> For "shared/gatt-client: Fix uninitialised variable usage", please verify
> that this default value is correct.
> 
> Happy to iterate on any patches you feel are suboptimal. Note that the
> only patches that received any sort of real-world testing are the one
> mentioned above and the gdbus one.
> 
> [...]

Here is the summary with links:
  - [BlueZ,01/15] main: Simplify variable assignment
    (no matching commit)
  - [BlueZ,02/15] shared/ecc: Fix uninitialised variable usage
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0a1159dc1055
  - [BlueZ,03/15] shared/gatt-client: Fix uninitialised variable usage
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=75eda690c4af
  - [BlueZ,04/15] tools/mesh-cfgclient: Fix uninitialised variable usage
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c63b7b0d732e
  - [BlueZ,05/15] test-runner: Remove unused envp
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9f4b2d0287ef
  - [BlueZ,06/15] test-runner: Fix uninitialised variable usage
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0640d99ebfae
  - [BlueZ,07/15] test-runner: Fix uninitialised variable usage
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9672cf410f8b
  - [BlueZ,08/15] shared/bap: Fix possible use-after-free
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=52336ad64548
  - [BlueZ,09/15] isotest: Fix bad free
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7a6385570494
  - [BlueZ,10/15] test-runner: Fix fd leak on failure
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=566af9c2f5ef
  - [BlueZ,11/15] isotest: Fix string size expectations
    (no matching commit)
  - [BlueZ,12/15] mgmt-tester: Fix non-nul-terminated string
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=49d06560692f
  - [BlueZ,13/15] gdbus: Check sprintf retval
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=20a0255b9e5f
  - [BlueZ,14/15] shared/bap: Fix memory leak in error path
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=377f2ec0721f
  - [BlueZ,15/15] android/handsfree: Check sprintf retval
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c9fe888793e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



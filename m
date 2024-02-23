Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E978289E
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699758; cv=none; b=kk2PY1mbH16PgdbrPrHLoNZ9G5uznlS8SG7Q9VD5X/rpjC98r4Z7U0D4xETBxpJqE0ZmNS8fuROpRv1N7qqKBb4VpTdTiSP0YARBLv/VjWIthS3ju/uInrghuD/oS/ClA6Vb1miK7HzdV1LSnCnlZ5sWwusMtuZ3QQv9Ig+hrNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699758; c=relaxed/simple;
	bh=//YRyxWz+GVUVxy1pgiK92r/2PyMjTq/8xZ5rUfMC6s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W5wX5FcOLZNIBxnN4Mf0GR/EjfM4IHKQ2yGNLLayDR6SEubnWCdxr212Xif+PLqR5HLmdf9mf5IeVQzvarn4Py9oGJoMkK9CIw7dd2bSOvXdgVxgMz15cNguKI1dr6UWvzSLLkwTp5gyYXngEdf7kZlso74D+N2zeNSKEUQDZWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePbUpoWi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePbUpoWi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5327C43390;
	Fri, 23 Feb 2024 14:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708699758;
	bh=//YRyxWz+GVUVxy1pgiK92r/2PyMjTq/8xZ5rUfMC6s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ePbUpoWiN2VQ0C+O9n1k/PEQy+V6ks324BzyYbdB05MNdih3tNLM1Zvljk0iN90L7
	 fSAs0eryH92NISibpjciDb8IEqfj5BfQOeJbn+GouNQfmEgAS0j+pCAL54aQ4H3Z/a
	 eCfZSlNcqCukziCSDy991vAgqW4l1Ub412e+sO5z+u8VXhwbIdxTQIHRWj7DJEG8oZ
	 txyqkFktXyNej+H9k4JnDNxKtH7dTeaFfq+PtbkxUHAKJZZ9UqjUCFyHVSevMC6I68
	 hgp8o5I+Q6MEt+scetgrVAeano2ew27gtw3cgJRFPA+s7FQLm6oG+7T877O8U6U2iW
	 YAgHgklF+5o+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90BFDD84BBB;
	Fri, 23 Feb 2024 14:49:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] Fix crash when unregistering bcast source endpoint
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170869975858.4728.3060324332171674384.git-patchwork-notify@kernel.org>
Date: Fri, 23 Feb 2024 14:49:18 +0000
References: <20240223141609.27181-1-silviu.barbulescu@nxp.com>
In-Reply-To: <20240223141609.27181-1-silviu.barbulescu@nxp.com>
To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com,
 vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
 iulia.tanasescu@nxp.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 23 Feb 2024 16:16:08 +0200 you wrote:
> In bt_bap_stream_release stream is accessed after free
> ERROR: AddressSanitizer: heap-use-after-free on address
> READ of size 8 at 0x60d0000001e0 thread T0
>     #0 0x556602a14ce0 in bt_bap_stream_release src/shared/bap.c:5423
>     #1 0x556602981292 in queue_foreach src/shared/queue.c:207
>     #2 0x556602a0712a in bt_bap_remove_pac src/shared/bap.c:3572
>     #3 0x5566026ca846 in media_endpoint_destroy profiles/audio/media.c:180
>     #4 0x5566026cdef9 in unregister_endpoint profiles/audio/media.c:1708
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] shared/bap: Fix crash unreg bcast src endpoint
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8f262a27bdf2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



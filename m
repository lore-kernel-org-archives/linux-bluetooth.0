Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BF11C2324
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587430; cv=none; b=bila95i6WtkniR+suAVDeXVbl/t2UiXwCiklDQ8LluU+eWaGs1Aq8MBw629dR+3NGzuGKrESwESmaEXrWrzd9obwB2CcSyG1ywdovANJ2Mbs3gPSBL3GBFDjIQ0AfrAQ8umuPC7JfloxcDc7ZbiIu1fC91bMPcnI+rCOcGrgZxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587430; c=relaxed/simple;
	bh=rBfBPcDxj9Y0Bm3ju89E3w3Qhq785UgR/DLboAy+ElU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=krXwSUOL18IFlAINth+O7P94c6px9WGoy1Mp3yBY4PQ3CdL1x+BXbdI8PSc5XzsdhwWrlzW61t87/3qBQNQaVktc4+CSR8v8jnZQb7YRsPQTBaN+up3YkAzTQs0caqdsByzi7Bu+MhqOPD5mnnMHYsbYhvp5MkLt9AEF9dg/AeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJ1JXRhi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJ1JXRhi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56E05C4AF0B;
	Fri, 28 Jun 2024 15:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719587430;
	bh=rBfBPcDxj9Y0Bm3ju89E3w3Qhq785UgR/DLboAy+ElU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gJ1JXRhi6lvbGNDgvqf1d8iwRgQQ+Vw3lzG/9VDmPYRN4R/jQX9IMeT/BkL12w2vi
	 5nWdPy9DslIY0SZd2/vj96PyI4+slY65+UT77aekEF3R52bXJMr+5qDolPP6YZ+AeT
	 Kzmkw9Hi9QqYKYh1rdleH9JjRP9TKt94Dkr2WiVMRl4oC0Y4IuQguS+i3B9mOtuz8O
	 O02+lx8u1QZZ9rrQ+k8OhPDDInITu0PqS1dHbN+nCN+F5iqT66am2wdWq8atDu+Yzn
	 XhdlqiTdGHZFqx/WORps+F/BVHnEIGESAfcIiEZpwCE8ryza1AuUeUQ/MR53RKXZ1H
	 mOV+p/HPy0wxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43A1BC43156;
	Fri, 28 Jun 2024 15:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] gatt-server: fix memory leak in
 bt_gatt_server_send_notification()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171958743027.13318.2098555433836327141.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jun 2024 15:10:30 +0000
References: <20240628075719.42796-1-r.smirnov@omp.ru>
In-Reply-To: <20240628075719.42796-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 28 Jun 2024 10:57:18 +0300 you wrote:
> data-pdu is allocated but not released when an error occurs.
> 
> Add data-pdu release before exiting the function in case of an error.
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE
> static analysis tool.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] gatt-server: fix memory leak in bt_gatt_server_send_notification()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0ddcfaeafad6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



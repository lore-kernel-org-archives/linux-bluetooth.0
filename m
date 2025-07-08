Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE9820766C
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 14:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986785; cv=none; b=rKpBXTIccOvG7VOP11x0pJh6BR72xUZoF7fvccsiPOaukvMIiBqXlYZS2Eil5cIPtCNNNkx/VKVOoqvfOivAbuBu9+LugMM+5Q+/ya4w8YkXdX6nix9MA6duOPl8PGCAkZNAoedFtk5Bn0f2rVT5J1ueWtGeivGdUEzn9GDjrgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986785; c=relaxed/simple;
	bh=3ljWh/G8TSySe8NLlHi4mOR7Du/zrsdD4SbRPQkGyb4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tHAiFsC+LOZt385dXYZaJ5RvUuVGWX0O8jvyrpaPlHMhTLtXmyJpwViPDYYdpGExhdWmbmf0vYFnVe+S2zzojHrNVHeNtluG4440GSleEC9vla8Jca3c0ARGqpANDaAeYuSDPxouL67Yo/FkKqw8+paDxjUefoh+coYmqJciEIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1WrgIYd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1WrgIYd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66A4C4CEF0;
	Tue,  8 Jul 2025 14:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751986784;
	bh=3ljWh/G8TSySe8NLlHi4mOR7Du/zrsdD4SbRPQkGyb4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y1WrgIYdqXXcIWz8yjTv5yQlH4uWVkEusDsuY5yOR8SdjNvZ0xLel+NserhrSv/0t
	 TC/fJzO+OF2C3Y97jSXrz7R5o6XwNCcYR/ST6Vow6IeGTZDtf+8H2YUvDUwiWYucfu
	 p/AfOrclRiB3B1penQLkcfOslMiAup4X+3PIdmeAKi39HFQp+Yjr+orKvopTpve/Lg
	 wcCxgMctte7PVYqzrq9JhNamCJCjBnGFJaeE0LsU+8v19ltCAGKz4Ndm+H0vaYN4cS
	 AO3D0RHZyTxsdzvj1Fw8uX8j2mFT9jz+gNOzwRLgTdA4aoJm6/h9z0GQgMZoI7hMZ7
	 vc35DB8javUNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBDF4380DBEE;
	Tue,  8 Jul 2025 15:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 00/11] Fix bugs found by static analysis
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175198680674.4096274.6120139061940819347.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 15:00:06 +0000
References: <20250708110909.2626286-1-i.iskakov@omp.ru>
In-Reply-To: <20250708110909.2626286-1-i.iskakov@omp.ru>
To: Ismagil Iskakov <i.iskakov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 8 Jul 2025 14:08:58 +0300 you wrote:
> This patch corrects some of the bugs not connected
> to the functionality but to memory management etc.
> Two exceptions being about fixing the arguments
> order, which also could've caused some trouble.
> 
> Ismagil Iskakov (11):
>   btio: fix range validation of security level
>   profiles/audio: add nullity checks
>   src/shared: add nullity checks
>   isotest: close fd after sending when nconn=1
>   obexd/client: fix err condition causing memleak
>   profiles/audio: fix memleak of bt_bap
>   src/shared: fix memleak
>   src/shared: move null checks before dereferencing
>   isotest: remove repeating conditions
>   profiles/audio: fix io_unlink args order
>   src/plugin: fix args order
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,01/11] btio: fix range validation of security level
    (no matching commit)
  - [BlueZ,v2,02/11] profiles/audio: add nullity checks
    (no matching commit)
  - [BlueZ,v2,03/11] src/shared: add nullity checks
    (no matching commit)
  - [BlueZ,v2,04/11] isotest: close fd after sending when nconn=1
    (no matching commit)
  - [BlueZ,v2,05/11] obexd/client: fix err condition causing memleak
    (no matching commit)
  - [BlueZ,v2,06/11] profiles/audio: fix memleak of bt_bap
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c1d4c478c40d
  - [BlueZ,v2,07/11] src/shared: fix memleak
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f6dcd1d2bd71
  - [BlueZ,v2,08/11] src/shared: move null checks before dereferencing
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=47ffe6086f37
  - [BlueZ,v2,09/11] isotest: remove repeating conditions
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a2d7be18ace6
  - [BlueZ,v2,10/11] profiles/audio: fix io_unlink args order
    (no matching commit)
  - [BlueZ,v2,11/11] src/plugin: fix args order
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a7e0747e21de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



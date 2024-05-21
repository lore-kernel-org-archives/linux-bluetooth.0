Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A2F4C66
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 May 2024 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716308437; cv=none; b=UgUXusNOgWQskyHxVqW3Q0apW0PMvbLspBKM7sejayeNvZo2dBSnylSAHT+fnA7EPNaz/SAUX0QTNeoCBuSb+pSDAeNYcdH9AGxtNSQvc3QWr76cOH6EBEos2Gf0N0s/otEo6NpJOmLJBM3gX95zzJVWC+Li3iRcA40Qoc/bx/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716308437; c=relaxed/simple;
	bh=7mLsqAsJuy1DhaLW/0/MJ9tEFX+9TZa3cZe7ID9sXhM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZEbD/QlL4TKLIIW1AcaOeNymnCvEzsvOzBJsDUZNkn7DYXoVZv84QexgcJ6LsThvVQ5MiU07PE5547fdvnBHbZSpyRVD/+gVpMFjEV3+DNavSHvcM1GeB/MV9MG/J1wDcYEj0ejQ0oOwxTbgsvUvCK9qFd+EnhFf0qGuoGqyLE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgDv4CC3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgDv4CC3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB81DC32786;
	Tue, 21 May 2024 16:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716308436;
	bh=7mLsqAsJuy1DhaLW/0/MJ9tEFX+9TZa3cZe7ID9sXhM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rgDv4CC3ChAp3VF9d3Ob5uiZcZaMEXvkhVwBjZcA2DTRiZFWcuqVWp7lgYvJOy2cN
	 EVCMw+qr8Q1X4NEwbblRcDN0CPMxn1Ufk7amp1HdhbPQwun1gS60hDEcTkhPv2ZlnC
	 a7zI6sDZxW3aMZlvjZeU5FvxJYmo0nWp7QLMHTlSvgiP5FRurKPzXcVG3nbx2MicDR
	 JWa0tEuFnWxTFEdNQF+E69y3vfx7mLt5jqHRO38NYMOLrEnvggVaTtax8pWMpEOjzi
	 VSmnfc09JeIrvCpsWy1Yg4ieCUL9l7OeD0AMcd8w9fdeYXXdWc16lQ6YSKRvfu4DNp
	 arX1RlzUu16Tw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9624C54BB2;
	Tue, 21 May 2024 16:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/3] test-bap: Add Broadcast Sink STR MBIS tests
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171630843675.15669.5662032800185803998.git-patchwork-notify@kernel.org>
Date: Tue, 21 May 2024 16:20:36 +0000
References: <20240521105515.103972-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20240521105515.103972-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
 vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 21 May 2024 13:55:12 +0300 you wrote:
> This patch adds BAP unit tests for Broadcast Sink Streaming with multiple
> BISes (4.14.4 Broadcast Sink Receives Audio Data Over Multiple BISes -
> page 193).
> 
> Iulia Tanasescu (3):
>   test-bap: Keep streams queue in test_data
>   test-bap: Add support for multiple bcast streams
>   test-bap: Add Broadcast Sink STR MBIS tests
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/3] test-bap: Keep streams queue in test_data
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=41340a74bf83
  - [BlueZ,2/3] test-bap: Add support for multiple bcast streams
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=25eaeeb7e1bc
  - [BlueZ,3/3] test-bap: Add Broadcast Sink STR MBIS tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c41943fe392d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


